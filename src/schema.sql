-- Towerrunning Phase 4: final Phase 3 Stage D (3NF) schema.
-- Designed for MySQL 8.4 (enforced CHECK constraints).
-- MySQL 8.4 fix: FKs whose child columns participate in CHECK constraints
-- use ON UPDATE RESTRICT (the Phase 3 identifiers are immutable).
-- Warning: destructive on the towerrunning_phase4 database only.
DROP DATABASE IF EXISTS towerrunning_phase4;
CREATE DATABASE towerrunning_phase4 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE towerrunning_phase4;

-- 1–8: independent strong entities and the normalized FORM relation.
CREATE TABLE RACE_EVENT (
  RaceEventID INT PRIMARY KEY,
  RaceName VARCHAR(180) NOT NULL,
  OfficialWebsiteURL VARCHAR(1024),
  Description TEXT,
  INDEX ix_race_name (RaceName)
) ENGINE=InnoDB;

CREATE TABLE SCORING_SCHEME (
  ScoringSchemeID INT PRIMARY KEY,
  VersionLabel VARCHAR(140) NOT NULL UNIQUE,
  SourceURL VARCHAR(1024),
  EffectiveFrom DATE,
  EffectiveUntil DATE,
  CONSTRAINT ck_scheme_dates CHECK (EffectiveUntil IS NULL OR EffectiveFrom IS NULL OR EffectiveUntil >= EffectiveFrom)
) ENGINE=InnoDB;

CREATE TABLE COMPETITION_EDITION (
  CompetitionEditionID INT PRIMARY KEY,
  CompetitionName VARCHAR(180) NOT NULL,
  CompetitionType VARCHAR(80),
  SeasonLabel VARCHAR(40),
  StartDate DATE,
  EndDate DATE,
  ChampionshipLevel VARCHAR(100),
  GeographicScope VARCHAR(100),
  SourceURL VARCHAR(1024),
  CONSTRAINT ck_comp_dates CHECK (EndDate IS NULL OR StartDate IS NULL OR EndDate >= StartDate)
) ENGINE=InnoDB;

CREATE TABLE ORGANISATION (
  OrganisationID INT PRIMARY KEY,
  OrganisationName VARCHAR(180) NOT NULL,
  OrganisationKind VARCHAR(90),
  CountryCode VARCHAR(3),
  WebsiteURL VARCHAR(1024),
  ContactEmail VARCHAR(254)
) ENGINE=InnoDB;

CREATE TABLE PERSON (
  PersonID INT PRIMARY KEY,
  FullName VARCHAR(180) NOT NULL,
  BirthDate DATE,
  INDEX ix_person_name (FullName)
) ENGINE=InnoDB;

CREATE TABLE VENUE (
  VenueID INT PRIMARY KEY,
  VenueName VARCHAR(180) NOT NULL,
  VenueType VARCHAR(80),
  CountryCode VARCHAR(3),
  City VARCHAR(120),
  Region VARCHAR(120),
  VenueNotes TEXT,
  INDEX ix_venue_city (City),
  INDEX ix_venue_country (CountryCode)
) ENGINE=InnoDB;

CREATE TABLE RANKING_PUBLICATION (
  RankingPublicationID INT PRIMARY KEY,
  PublicationLabel VARCHAR(180) NOT NULL,
  PublicationType VARCHAR(80),
  RankingAsOfDate DATE,
  WindowStartDate DATE,
  WindowEndDate DATE,
  PublishedOn DATE,
  RevisionLabel VARCHAR(80),
  PublicationStatus VARCHAR(40),
  SourceURL VARCHAR(1024),
  ArchivedFileReference VARCHAR(1024),
  RulesReference VARCHAR(1024),
  CONSTRAINT ck_rank_window CHECK (WindowEndDate IS NULL OR WindowStartDate IS NULL OR WindowEndDate >= WindowStartDate)
) ENGINE=InnoDB;

CREATE TABLE FORM (
  FormURL VARCHAR(512) PRIMARY KEY,
  FormType VARCHAR(80) NOT NULL
) ENGINE=InnoDB;

-- 9–13: dependent entities and specializations.
CREATE TABLE COURSE (
  CourseID INT PRIMARY KEY,
  CourseLabel VARCHAR(180) NOT NULL,
  RouteDescription TEXT,
  RaceFormat VARCHAR(80),
  StairCount INT,
  FloorCount INT,
  VerticalClimbMetres DECIMAL(9,2),
  ConfigurationStatus VARCHAR(80),
  VenueID INT NOT NULL,
  CONSTRAINT fk_course_venue FOREIGN KEY (VenueID) REFERENCES VENUE(VenueID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_course_stairs CHECK (StairCount IS NULL OR StairCount > 0),
  CONSTRAINT ck_course_floors CHECK (FloorCount IS NULL OR FloorCount >= 0),
  CONSTRAINT ck_course_height CHECK (VerticalClimbMetres IS NULL OR VerticalClimbMetres > 0)
) ENGINE=InnoDB;

CREATE TABLE ATHLETE (
  PersonID INT PRIMARY KEY,
  NationalityCode VARCHAR(3),
  Gender VARCHAR(20),
  DefaultCompetitionDivision VARCHAR(80),
  CONSTRAINT fk_athlete_person FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE REGISTERED_ATHLETE (
  PersonID INT PRIMARY KEY,
  TWAAthleteID VARCHAR(32) NOT NULL UNIQUE,
  FirstRegistrationDate DATE,
  CONSTRAINT fk_registered_athlete FOREIGN KEY (PersonID) REFERENCES ATHLETE(PersonID)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE SCORING_MATRIX_ENTRY (
  ScoringSchemeID INT NOT NULL,
  Factor INT NOT NULL,
  PlaceFrom INT NOT NULL,
  PlaceTo INT NOT NULL,
  Points DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (ScoringSchemeID, Factor, PlaceFrom),
  CONSTRAINT fk_matrix_scheme FOREIGN KEY (ScoringSchemeID) REFERENCES SCORING_SCHEME(ScoringSchemeID)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT ck_matrix_range CHECK (Factor > 0 AND PlaceFrom > 0 AND PlaceTo >= PlaceFrom AND Points >= 0)
) ENGINE=InnoDB;

CREATE TABLE RACE_EDITION (
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  PublishedEditionNumber INT,
  StartDate DATE,
  EndDate DATE,
  RankingDate DATE,
  RaceFactor INT,
  WebsiteCategoryCode VARCHAR(12),
  EditionStatus VARCHAR(40),
  DeliveryMode VARCHAR(60),
  PublishedRaceCode VARCHAR(40) UNIQUE,
  WebsitePageURL VARCHAR(1024),
  SourceObservedOn DATE,
  RegistrationURL VARCHAR(1024),
  ResultsURL VARCHAR(1024),
  PublishedMaleWinnerName VARCHAR(180),
  PublishedFemaleWinnerName VARCHAR(180),
  EvaluationStatus VARCHAR(60),
  EvaluationEvidence TEXT,
  AdditionalInformation TEXT,
  ScoringSchemeID INT,
  VenueID INT,
  PrevRaceEventID INT,
  PrevOccurrenceNo INT,
  PRIMARY KEY (RaceEventID, OccurrenceNo),
  UNIQUE KEY uq_predecessor (PrevRaceEventID, PrevOccurrenceNo),
  INDEX ix_edition_date (StartDate),
  INDEX ix_edition_factor (RaceFactor),
  CONSTRAINT fk_edition_event FOREIGN KEY (RaceEventID) REFERENCES RACE_EVENT(RaceEventID)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_edition_scheme FOREIGN KEY (ScoringSchemeID) REFERENCES SCORING_SCHEME(ScoringSchemeID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_edition_venue FOREIGN KEY (VenueID) REFERENCES VENUE(VenueID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_edition_previous FOREIGN KEY (PrevRaceEventID, PrevOccurrenceNo)
    REFERENCES RACE_EDITION(RaceEventID, OccurrenceNo) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT ck_edition_date CHECK (EndDate IS NULL OR StartDate IS NULL OR EndDate >= StartDate),
  CONSTRAINT ck_edition_factor CHECK (RaceFactor IS NULL OR RaceFactor > 0),
  CONSTRAINT ck_edition_occurrence CHECK (OccurrenceNo > 0),
  CONSTRAINT ck_edition_status CHECK (EditionStatus IS NULL OR EditionStatus IN ('planned','postponed','completed','cancelled')),
  CONSTRAINT ck_evaluation_status CHECK (EvaluationStatus IS NULL OR EvaluationStatus IN ('unverified','approved','not evaluated')),
  CONSTRAINT ck_race_code CHECK (PublishedRaceCode IS NULL OR PublishedRaceCode REGEXP '^r[0-9]+$'),
  CONSTRAINT ck_edition_prev_owner CHECK (PrevRaceEventID IS NULL OR PrevRaceEventID = RaceEventID),
  CONSTRAINT ck_edition_previous_pair CHECK ((PrevRaceEventID IS NULL AND PrevOccurrenceNo IS NULL) OR (PrevRaceEventID IS NOT NULL AND PrevOccurrenceNo IS NOT NULL))
) ENGINE=InnoDB;

-- 14–18: course metadata, weak data and multi-valued attributes.
CREATE TABLE COURSE_RECORD (
  CourseRecordID INT PRIMARY KEY,
  HolderNameAsPublished VARCHAR(180),
  Division VARCHAR(80),
  AgeGroupLabel VARCHAR(80),
  RecordTimeSeconds DECIMAL(12,3),
  AchievementYear SMALLINT,
  CountryAsPublished VARCHAR(3),
  SourceObservedOn DATE,
  EvidenceURL VARCHAR(1024),
  CourseID INT NOT NULL,
  HolderPersonID INT,
  CONSTRAINT fk_record_course FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_record_holder FOREIGN KEY (HolderPersonID) REFERENCES ATHLETE(PersonID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_record_time CHECK (RecordTimeSeconds IS NULL OR RecordTimeSeconds > 0)
) ENGINE=InnoDB;

CREATE TABLE VENUE_ALTERNATIVE_NAME (
  VenueID INT NOT NULL,
  AlternativeName VARCHAR(180) NOT NULL,
  PRIMARY KEY (VenueID, AlternativeName),
  CONSTRAINT fk_alt_venue FOREIGN KEY (VenueID) REFERENCES VENUE(VenueID)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE PERSON_CONTACT_EMAIL (
  PersonID INT NOT NULL,
  ContactEmail VARCHAR(254) NOT NULL,
  PRIMARY KEY (PersonID, ContactEmail),
  CONSTRAINT fk_email_person FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE ANNUAL_MEMBERSHIP (
  PersonID INT NOT NULL,
  MembershipYear SMALLINT NOT NULL,
  ValidFrom DATE,
  ValidUntil DATE,
  ConfirmationStatus VARCHAR(40),
  PaymentConfirmedOn DATE,
  AmountPaid DECIMAL(10,2),
  Currency CHAR(3),
  MembershipEvidence VARCHAR(1024),
  PRIMARY KEY (PersonID, MembershipYear),
  CONSTRAINT fk_membership_registered FOREIGN KEY (PersonID) REFERENCES REGISTERED_ATHLETE(PersonID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_membership_dates CHECK (ValidUntil IS NULL OR ValidFrom IS NULL OR ValidUntil >= ValidFrom),
  CONSTRAINT ck_membership_amount CHECK (AmountPaid IS NULL OR AmountPaid >= 0),
  CONSTRAINT ck_membership_year CHECK (MembershipYear BETWEEN 1900 AND 2100),
  CONSTRAINT ck_membership_status CHECK (ConfirmationStatus IS NULL OR ConfirmationStatus IN ('pending','confirmed','cancelled'))
) ENGINE=InnoDB;

CREATE TABLE RESULT_SUBMISSION (
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  SubmissionNo INT NOT NULL,
  SubmissionKind VARCHAR(80),
  FormURL VARCHAR(512),
  SubmittedAt DATETIME,
  ReceivedAt DATETIME,
  CompleteAvailableOn DATE,
  CheckStatus VARCHAR(50),
  SubmissionStatus VARCHAR(50),
  SourceURL VARCHAR(1024),
  ArchivedFileReference VARCHAR(1024),
  ProvidedByOrganisationID INT,
  PRIMARY KEY (RaceEventID, OccurrenceNo, SubmissionNo),
  CONSTRAINT ck_submission_no CHECK (SubmissionNo > 0),
  CONSTRAINT ck_submission_status CHECK (SubmissionStatus IS NULL OR SubmissionStatus IN ('pending','accepted','rejected','superseded')),
  CONSTRAINT fk_submission_edition FOREIGN KEY (RaceEventID, OccurrenceNo)
    REFERENCES RACE_EDITION(RaceEventID, OccurrenceNo) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_submission_form FOREIGN KEY (FormURL) REFERENCES FORM(FormURL)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_submission_org FOREIGN KEY (ProvidedByOrganisationID) REFERENCES ORGANISATION(OrganisationID)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE SOURCE_ROW (
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  SubmissionNo INT NOT NULL,
  SourceRowNo INT NOT NULL,
  SourceSection VARCHAR(120),
  RawRowText TEXT,
  ResultStatus VARCHAR(80),
  PRIMARY KEY (RaceEventID, OccurrenceNo, SubmissionNo, SourceRowNo),
  CONSTRAINT ck_source_row_no CHECK (SourceRowNo > 0),
  CONSTRAINT fk_source_submission FOREIGN KEY (RaceEventID, OccurrenceNo, SubmissionNo)
    REFERENCES RESULT_SUBMISSION(RaceEventID, OccurrenceNo, SubmissionNo)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 19–25: associative relations.
CREATE TABLE OFFERS (
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  CourseID INT NOT NULL,
  EvaluationSelection VARCHAR(80),
  SelectionEvidence VARCHAR(1024),
  PRIMARY KEY (RaceEventID, OccurrenceNo, CourseID),
  CONSTRAINT ck_offer_selection CHECK (EvaluationSelection IS NULL OR EvaluationSelection IN ('pending','selected','not selected')),
  CONSTRAINT fk_offers_edition FOREIGN KEY (RaceEventID, OccurrenceNo)
    REFERENCES RACE_EDITION(RaceEventID, OccurrenceNo) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_offers_course FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE INCLUDED_IN (
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  CompetitionEditionID INT NOT NULL,
  RoleLabel VARCHAR(100),
  InclusionNote TEXT,
  PRIMARY KEY (RaceEventID, OccurrenceNo, CompetitionEditionID),
  CONSTRAINT fk_inclusion_edition FOREIGN KEY (RaceEventID, OccurrenceNo)
    REFERENCES RACE_EDITION(RaceEventID, OccurrenceNo) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_inclusion_comp FOREIGN KEY (CompetitionEditionID)
    REFERENCES COMPETITION_EDITION(CompetitionEditionID) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE ORGANISES (
  OrganisationID INT NOT NULL,
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  PRIMARY KEY (OrganisationID, RaceEventID, OccurrenceNo),
  CONSTRAINT fk_organises_org FOREIGN KEY (OrganisationID) REFERENCES ORGANISATION(OrganisationID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_organises_edition FOREIGN KEY (RaceEventID, OccurrenceNo)
    REFERENCES RACE_EDITION(RaceEventID, OccurrenceNo) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE AFFILIATED_WITH (
  PersonID INT NOT NULL,
  OrganisationID INT NOT NULL,
  PRIMARY KEY (PersonID, OrganisationID),
  CONSTRAINT fk_affiliation_person FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_affiliation_org FOREIGN KEY (OrganisationID) REFERENCES ORGANISATION(OrganisationID)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE ASSISTS_EDITION (
  PersonID INT NOT NULL,
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  PRIMARY KEY (PersonID, RaceEventID, OccurrenceNo),
  CONSTRAINT fk_assists_person FOREIGN KEY (PersonID) REFERENCES PERSON(PersonID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_assists_edition FOREIGN KEY (RaceEventID, OccurrenceNo)
    REFERENCES RACE_EDITION(RaceEventID, OccurrenceNo) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE AFFILIATION_ROLE_TITLE (
  PersonID INT NOT NULL,
  OrganisationID INT NOT NULL,
  RoleTitle VARCHAR(160) NOT NULL,
  PRIMARY KEY (PersonID, OrganisationID, RoleTitle),
  CONSTRAINT fk_role_affiliation FOREIGN KEY (PersonID, OrganisationID)
    REFERENCES AFFILIATED_WITH(PersonID, OrganisationID) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE ASSISTS_EDITION_RESPONSIBILITY (
  PersonID INT NOT NULL,
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  Responsibility VARCHAR(160) NOT NULL,
  PRIMARY KEY (PersonID, RaceEventID, OccurrenceNo, Responsibility),
  CONSTRAINT fk_responsibility_assists FOREIGN KEY (PersonID, RaceEventID, OccurrenceNo)
    REFERENCES ASSISTS_EDITION(PersonID, RaceEventID, OccurrenceNo) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- 26: ternary result. Extra composite FK to OFFERS enforces the rule R4 => R3.
CREATE TABLE ACHIEVES_RESULT (
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  CourseID INT NOT NULL,
  PersonID INT NOT NULL,
  CompetitionDivision VARCHAR(80),
  CountryAtRace VARCHAR(3),
  FinishStatus VARCHAR(40),
  VerificationStatus VARCHAR(40),
  DisputeStatus VARCHAR(40) NOT NULL DEFAULT 'none',
  SourceURL VARCHAR(1024),
  SubmissionNo INT,
  SourceRowNo INT,
  OverallPlace INT,
  FinishingTimeSeconds DECIMAL(12,3),
  Points DECIMAL(10,2),
  PRIMARY KEY (RaceEventID, OccurrenceNo, CourseID, PersonID),
  INDEX ix_result_athlete (PersonID),
  INDEX ix_result_place (RaceEventID, OccurrenceNo, OverallPlace),
  CONSTRAINT fk_result_offered_course FOREIGN KEY (RaceEventID, OccurrenceNo, CourseID)
    REFERENCES OFFERS(RaceEventID, OccurrenceNo, CourseID) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_result_athlete FOREIGN KEY (PersonID) REFERENCES ATHLETE(PersonID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_result_source_row FOREIGN KEY (RaceEventID, OccurrenceNo, SubmissionNo, SourceRowNo)
    REFERENCES SOURCE_ROW(RaceEventID, OccurrenceNo, SubmissionNo, SourceRowNo)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT ck_source_citation_pair CHECK ((SubmissionNo IS NULL AND SourceRowNo IS NULL) OR (SubmissionNo IS NOT NULL AND SourceRowNo IS NOT NULL)),
  CONSTRAINT ck_result_place CHECK (OverallPlace IS NULL OR OverallPlace > 0),
  CONSTRAINT ck_result_seconds CHECK (FinishingTimeSeconds IS NULL OR FinishingTimeSeconds > 0),
  CONSTRAINT ck_result_points CHECK (Points IS NULL OR Points >= 0),
  CONSTRAINT ck_result_dispute CHECK (DisputeStatus IN ('none','open','upheld','rejected')),
  CONSTRAINT ck_result_status CHECK (FinishStatus IS NULL OR FinishStatus IN ('finished','did not finish','did not start','disqualified','unknown')),
  CONSTRAINT ck_result_verification CHECK (VerificationStatus IS NULL OR VerificationStatus IN ('unverified','verified','withdrawn')),
  CONSTRAINT ck_result_disqualified CHECK (FinishStatus <> 'disqualified' OR (OverallPlace IS NULL AND Points IS NULL)),
  CONSTRAINT ck_result_verified_evidence CHECK (VerificationStatus <> 'verified' OR SourceURL IS NOT NULL OR SubmissionNo IS NOT NULL)
) ENGINE=InnoDB;

-- 27–30: remaining dependent published information.
CREATE TABLE ADDITIONAL_PLACING (
  RaceEventID INT NOT NULL,
  OccurrenceNo INT NOT NULL,
  CourseID INT NOT NULL,
  PersonID INT NOT NULL,
  ClassificationLabel VARCHAR(120) NOT NULL,
  Place INT NOT NULL,
  PRIMARY KEY (RaceEventID, OccurrenceNo, CourseID, PersonID, ClassificationLabel),
  CONSTRAINT fk_extra_place_result FOREIGN KEY (RaceEventID, OccurrenceNo, CourseID, PersonID)
    REFERENCES ACHIEVES_RESULT(RaceEventID, OccurrenceNo, CourseID, PersonID)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT ck_extra_place CHECK (Place > 0)
) ENGINE=InnoDB;

CREATE TABLE LISTED_IN (
  PersonID INT NOT NULL,
  RankingPublicationID INT NOT NULL,
  PublishedDivision VARCHAR(80),
  CountryAtPublication VARCHAR(3),
  PublishedRank INT,
  PublishedPoints DECIMAL(12,2),
  PRIMARY KEY (PersonID, RankingPublicationID),
  CONSTRAINT fk_listed_registered FOREIGN KEY (PersonID) REFERENCES REGISTERED_ATHLETE(PersonID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_listed_publication FOREIGN KEY (RankingPublicationID)
    REFERENCES RANKING_PUBLICATION(RankingPublicationID) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_listed_rank CHECK (PublishedRank IS NULL OR PublishedRank > 0),
  CONSTRAINT ck_listed_points CHECK (PublishedPoints IS NULL OR PublishedPoints >= 0)
) ENGINE=InnoDB;

CREATE TABLE NATIONS_STANDING (
  RankingPublicationID INT NOT NULL,
  CountryCode VARCHAR(3) NOT NULL,
  PublishedRank INT,
  PublishedPoints DECIMAL(12,2),
  PRIMARY KEY (RankingPublicationID, CountryCode),
  CONSTRAINT fk_nations_publication FOREIGN KEY (RankingPublicationID)
    REFERENCES RANKING_PUBLICATION(RankingPublicationID) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT ck_nations_rank CHECK (PublishedRank IS NULL OR PublishedRank > 0),
  CONSTRAINT ck_nations_points CHECK (PublishedPoints IS NULL OR PublishedPoints >= 0)
) ENGINE=InnoDB;

-- Enforce the optional HELD_AT venue and OFFERS course venue agreement.
DELIMITER $$
CREATE TRIGGER bi_offers_venue BEFORE INSERT ON OFFERS FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1 FROM RACE_EDITION re JOIN COURSE c ON c.CourseID = NEW.CourseID
    WHERE re.RaceEventID = NEW.RaceEventID AND re.OccurrenceNo = NEW.OccurrenceNo
      AND re.VenueID IS NOT NULL AND re.VenueID <> c.VenueID
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Offered course must belong to edition venue';
  END IF;
END$$
CREATE TRIGGER bu_offers_venue BEFORE UPDATE ON OFFERS FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1 FROM RACE_EDITION re JOIN COURSE c ON c.CourseID = NEW.CourseID
    WHERE re.RaceEventID = NEW.RaceEventID AND re.OccurrenceNo = NEW.OccurrenceNo
      AND re.VenueID IS NOT NULL AND re.VenueID <> c.VenueID
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Offered course must belong to edition venue';
  END IF;
END$$
CREATE TRIGGER bi_edition_prev BEFORE INSERT ON RACE_EDITION FOR EACH ROW
BEGIN
  DECLARE current_event INT;
  DECLARE current_occ INT;
  DECLARE next_event INT;
  DECLARE next_occ INT;
  DECLARE depth_count INT DEFAULT 0;
  SET current_event = NEW.PrevRaceEventID;
  SET current_occ = NEW.PrevOccurrenceNo;
  WHILE current_event IS NOT NULL AND current_occ IS NOT NULL DO
    IF current_event = NEW.RaceEventID AND current_occ = NEW.OccurrenceNo THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Previous edition cycle not permitted';
    END IF;
    SET next_event = NULL;
    SET next_occ = NULL;
    SELECT PrevRaceEventID, PrevOccurrenceNo INTO next_event, next_occ
      FROM RACE_EDITION WHERE RaceEventID = current_event AND OccurrenceNo = current_occ LIMIT 1;
    SET current_event = next_event;
    SET current_occ = next_occ;
    SET depth_count = depth_count + 1;
    IF depth_count > 1000 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Previous edition chain too long or cyclic';
    END IF;
  END WHILE;
END$$
CREATE TRIGGER bu_edition_integrity BEFORE UPDATE ON RACE_EDITION FOR EACH ROW
BEGIN
  DECLARE current_event INT;
  DECLARE current_occ INT;
  DECLARE next_event INT;
  DECLARE next_occ INT;
  DECLARE depth_count INT DEFAULT 0;
  IF NEW.VenueID IS NOT NULL AND EXISTS (
    SELECT 1 FROM OFFERS o JOIN COURSE c ON c.CourseID = o.CourseID
    WHERE o.RaceEventID = OLD.RaceEventID AND o.OccurrenceNo = OLD.OccurrenceNo
      AND c.VenueID <> NEW.VenueID
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Edition venue conflicts with offered course';
  END IF;
  SET current_event = NEW.PrevRaceEventID;
  SET current_occ = NEW.PrevOccurrenceNo;
  WHILE current_event IS NOT NULL AND current_occ IS NOT NULL DO
    IF current_event = NEW.RaceEventID AND current_occ = NEW.OccurrenceNo THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Previous edition cycle not permitted';
    END IF;
    SET next_event = NULL;
    SET next_occ = NULL;
    SELECT PrevRaceEventID, PrevOccurrenceNo INTO next_event, next_occ
      FROM RACE_EDITION WHERE RaceEventID = current_event AND OccurrenceNo = current_occ LIMIT 1;
    SET current_event = next_event;
    SET current_occ = next_occ;
    SET depth_count = depth_count + 1;
    IF depth_count > 1000 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Previous edition chain too long or cyclic';
    END IF;
  END WHILE;
END$$
CREATE TRIGGER bu_listed_published BEFORE UPDATE ON LISTED_IN FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM RANKING_PUBLICATION WHERE RankingPublicationID = OLD.RankingPublicationID AND PublicationStatus = 'published') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Published ranking rows are immutable';
  END IF;
END$$
CREATE TRIGGER bd_listed_published BEFORE DELETE ON LISTED_IN FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM RANKING_PUBLICATION WHERE RankingPublicationID = OLD.RankingPublicationID AND PublicationStatus = 'published') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Published ranking rows cannot be deleted';
  END IF;
END$$
CREATE TRIGGER bu_nations_published BEFORE UPDATE ON NATIONS_STANDING FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM RANKING_PUBLICATION WHERE RankingPublicationID = OLD.RankingPublicationID AND PublicationStatus = 'published') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Published nations standing is immutable';
  END IF;
END$$
CREATE TRIGGER bd_nations_published BEFORE DELETE ON NATIONS_STANDING FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM RANKING_PUBLICATION WHERE RankingPublicationID = OLD.RankingPublicationID AND PublicationStatus = 'published') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Published nations standing cannot be deleted';
  END IF;
END$$
DELIMITER ;

-- Additional Phase 4 cross-table integrity safeguards.
DELIMITER $$
CREATE TRIGGER bi_result_integrity BEFORE INSERT ON ACHIEVES_RESULT FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM RACE_EDITION WHERE RaceEventID=NEW.RaceEventID AND OccurrenceNo=NEW.OccurrenceNo AND EditionStatus='cancelled') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cancelled editions cannot receive current results';
 END IF;
 IF NEW.SubmissionNo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM RESULT_SUBMISSION WHERE RaceEventID=NEW.RaceEventID AND OccurrenceNo=NEW.OccurrenceNo AND SubmissionNo=NEW.SubmissionNo AND SubmissionStatus='accepted') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Citations require an accepted submission';
 END IF;
END$$
CREATE TRIGGER bi_matrix_overlap BEFORE INSERT ON SCORING_MATRIX_ENTRY FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM SCORING_MATRIX_ENTRY WHERE ScoringSchemeID=NEW.ScoringSchemeID AND Factor=NEW.Factor AND PlaceFrom<=NEW.PlaceTo AND PlaceTo>=NEW.PlaceFrom ) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Scoring matrix ranges overlap';
 END IF;
END$$
CREATE TRIGGER bu_result_integrity BEFORE UPDATE ON ACHIEVES_RESULT FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM RACE_EDITION WHERE RaceEventID=NEW.RaceEventID AND OccurrenceNo=NEW.OccurrenceNo AND EditionStatus='cancelled') AND (NEW.VerificationStatus IS NULL OR NEW.VerificationStatus <> 'withdrawn') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cancelled editions cannot receive current results';
 END IF;
 IF NEW.SubmissionNo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM RESULT_SUBMISSION WHERE RaceEventID=NEW.RaceEventID AND OccurrenceNo=NEW.OccurrenceNo AND SubmissionNo=NEW.SubmissionNo AND SubmissionStatus='accepted') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Citations require an accepted submission';
 END IF;
END$$
CREATE TRIGGER bu_matrix_overlap BEFORE UPDATE ON SCORING_MATRIX_ENTRY FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM SCORING_MATRIX_ENTRY WHERE ScoringSchemeID=NEW.ScoringSchemeID AND Factor=NEW.Factor AND PlaceFrom<=NEW.PlaceTo AND PlaceTo>=NEW.PlaceFrom AND NOT (ScoringSchemeID=OLD.ScoringSchemeID AND Factor=OLD.Factor AND PlaceFrom=OLD.PlaceFrom)) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Scoring matrix ranges overlap';
 END IF;
END$$
CREATE TRIGGER bu_publication_immutable BEFORE UPDATE ON RANKING_PUBLICATION FOR EACH ROW
BEGIN
 IF OLD.PublicationStatus='published' THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Published releases are immutable';
 END IF;
END$$
CREATE TRIGGER bd_publication_immutable BEFORE DELETE ON RANKING_PUBLICATION FOR EACH ROW
BEGIN
 IF OLD.PublicationStatus='published' THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Published releases are immutable';
 END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER bi_listed_published BEFORE INSERT ON LISTED_IN FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM RANKING_PUBLICATION WHERE RankingPublicationID=NEW.RankingPublicationID AND PublicationStatus='published') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Published releases cannot receive new standing rows';
 END IF;
END$$
CREATE TRIGGER bu_listed_destination BEFORE UPDATE ON LISTED_IN FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM RANKING_PUBLICATION WHERE RankingPublicationID=NEW.RankingPublicationID AND PublicationStatus='published') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Published standing destination is immutable';
 END IF;
END$$
CREATE TRIGGER bi_nations_published BEFORE INSERT ON NATIONS_STANDING FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM RANKING_PUBLICATION WHERE RankingPublicationID=NEW.RankingPublicationID AND PublicationStatus='published') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Published releases cannot receive new standing rows';
 END IF;
END$$
CREATE TRIGGER bu_nations_destination BEFORE UPDATE ON NATIONS_STANDING FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM RANKING_PUBLICATION WHERE RankingPublicationID=NEW.RankingPublicationID AND PublicationStatus='published') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Published standing destination is immutable';
 END IF;
END$$
CREATE TRIGGER bu_course_venue BEFORE UPDATE ON COURSE FOR EACH ROW
BEGIN
 IF NEW.VenueID<>OLD.VenueID AND EXISTS (SELECT 1 FROM OFFERS o JOIN RACE_EDITION e USING(RaceEventID,OccurrenceNo) WHERE o.CourseID=OLD.CourseID AND e.VenueID IS NOT NULL AND e.VenueID<>NEW.VenueID) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Course venue conflicts with retained editions';
 END IF;
END$$
CREATE TRIGGER bu_source_evidence BEFORE UPDATE ON SOURCE_ROW FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM ACHIEVES_RESULT WHERE RaceEventID=OLD.RaceEventID AND OccurrenceNo=OLD.OccurrenceNo AND SubmissionNo=OLD.SubmissionNo AND SourceRowNo=OLD.SourceRowNo) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cited source evidence is immutable';
 END IF;
END$$
CREATE TRIGGER bd_source_evidence BEFORE DELETE ON SOURCE_ROW FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM ACHIEVES_RESULT WHERE RaceEventID=OLD.RaceEventID AND OccurrenceNo=OLD.OccurrenceNo AND SubmissionNo=OLD.SubmissionNo AND SourceRowNo=OLD.SourceRowNo) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cited source evidence is immutable';
 END IF;
END$$
CREATE TRIGGER bu_submission_evidence BEFORE UPDATE ON RESULT_SUBMISSION FOR EACH ROW
BEGIN
 IF OLD.SubmissionStatus='accepted' AND EXISTS (SELECT 1 FROM ACHIEVES_RESULT WHERE RaceEventID=OLD.RaceEventID AND OccurrenceNo=OLD.OccurrenceNo AND SubmissionNo=OLD.SubmissionNo) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Accepted cited submission is immutable';
 END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER bu_decision_source BEFORE UPDATE ON SOURCE_ROW FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM RESULT_SUBMISSION WHERE RaceEventID=OLD.RaceEventID AND OccurrenceNo=OLD.OccurrenceNo AND SubmissionNo=OLD.SubmissionNo AND SubmissionStatus='accepted' AND SubmissionKind='disqualification decision') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Reviewed decision evidence is immutable';
 END IF;
END$$
CREATE TRIGGER bd_decision_source BEFORE DELETE ON SOURCE_ROW FOR EACH ROW
BEGIN
 IF EXISTS (SELECT 1 FROM RESULT_SUBMISSION WHERE RaceEventID=OLD.RaceEventID AND OccurrenceNo=OLD.OccurrenceNo AND SubmissionNo=OLD.SubmissionNo AND SubmissionStatus='accepted' AND SubmissionKind='disqualification decision') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Reviewed decision evidence is immutable';
 END IF;
END$$
CREATE TRIGGER bu_decision_submission BEFORE UPDATE ON RESULT_SUBMISSION FOR EACH ROW
BEGIN
 IF OLD.SubmissionStatus='accepted' AND OLD.SubmissionKind='disqualification decision' THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Accepted decision submission is immutable';
 END IF;
END$$
DELIMITER ;
