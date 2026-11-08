-- VERIFIED / SOURCED MINI-WORLD DATA
-- Reproducible: run schema.sql first, then populate.sql in a fresh MySQL 8.0+ session.
-- These records originate from the official Towerrunning Tour calendar and cited
-- race detail pages (see src/docs/DATA_PROVENANCE.md).
-- No made-up participant times, ages, membership payments, or official ranking totals.
-- Internal numeric IDs and course-label descriptions are database modelling choices.
USE towerrunning_phase4;
START TRANSACTION;

INSERT INTO RACE_EVENT (`RaceEventID`, `OfficialWebsiteURL`, `Description`, `RaceName`) VALUES
  (101, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Haikou.', 'IVM Tour Haikou R&F The Top Station'),
  (102, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Shenzhen. Two race dates are listed in the 2026 Tour calendar.', 'International Vertical Marathon PingAn'),
  (103, 'https://www.towerrunning.com/races/r3100/', 'Official Towerrunning 2026 Tour calendar city: Barcelona.', 'Barcelona Tower Run Challenge x Mirador Torre Glòries'),
  (104, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Chicago.', 'Hustle Chicago'),
  (105, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Benidorm.', 'Subida Vertical Gran Hotel Bali'),
  (106, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Warsaw.', 'Bieg Na Szczyt Rondo 1'),
  (107, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Tallinn.', 'Teletorni Trepijooks - TV Tower Run'),
  (108, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Taipei.', 'Taipei 101 Run Up'),
  (109, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Tianjin.', 'IVM Tour Tianjin R&F Center Station'),
  (110, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Vienna.', 'DC Tower Run'),
  (111, 'https://www.towerrunning.com/races/r3024/', 'Official Towerrunning 2026 Tour calendar city: Basel.', 'Tower Run Basel'),
  (112, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Frankfurt.', 'Skyrun MesseTurm Frankfurt'),
  (113, 'https://www.towerrunning.com/races/r3207/', 'Official Towerrunning 2026 Tour calendar city: Bonn.', 'Deutsche Post Tower Run'),
  (114, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Bad Wildbad.', 'Bad Wildbader Stäffeleslauf'),
  (115, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Cologne.', 'KoelnTurm Treppenlauf'),
  (116, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Bratislava.', 'UFO Vertical Sprint'),
  (117, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Guangzhou.', 'International Vertical Marathon Guangzhou Yingkai Square Station'),
  (118, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Singapore.', 'Frasers Tower Vertical Challenge'),
  (119, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Kuala Lumpur.', 'The Sky Race'),
  (120, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Gold Coast.', 'Q1 Stair Challenge'),
  (121, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Keutschach.', 'Pyramidenkogel Turmlauf'),
  (122, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Warsaw.', 'Varso Tower Run'),
  (123, 'https://www.towerrunning.com/races/r3276/', 'Official Towerrunning 2026 Tour calendar city: Kuala Lumpur.', 'KL Tower Run International Challenge'),
  (124, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Rottweil.', 'TK Elevator Towerrun'),
  (125, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Brno.', 'Schody AZ Nahoru'),
  (126, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Wroclaw.', 'Sky Tower Run'),
  (127, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Barcelona.', 'Metropolitan Sky Run'),
  (128, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: New York.', 'Empire State Building Run Up'),
  (129, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Torino.', 'Vertical Grattacielo Regione Piemonte'),
  (130, 'https://www.towerrunning.com/races/r3389/', 'Official Towerrunning 2026 Tour calendar city: Chongqing.', 'Raffles City Chongqing Vertical Challenge'),
  (131, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Tbilisi.', 'Mtatsminda Run Up'),
  (132, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Shanghai.', 'Sky Marathon SWFC'),
  (133, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Hong Kong.', 'Hong Chi Climbathon'),
  (134, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Chicago.', 'SkyRise Chicago'),
  (135, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Bucharest.', 'Sky Run Bucharest'),
  (136, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Macau.', 'Oxfam Tower Run'),
  (137, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Jakarta.', 'Jakarta Vertical Run'),
  (138, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Acapulco.', 'Towerrunning Grand Prix Acapulco'),
  (139, 'https://www.towerrunning.com/towerrunning-tour-2026/', 'Official Towerrunning 2026 Tour calendar city: Shanghai.', 'Shanghai Tower Towerrunning Challenge'),
  (140, 'https://www.towerrunning.com/races/r3203/', 'Official Towerrunning race detail: Xaltocan, Mexico.', 'SprintTower 365');

INSERT INTO COMPETITION_EDITION (`CompetitionEditionID`, `CompetitionName`, `CompetitionType`, `SeasonLabel`, `StartDate`, `EndDate`, `ChampionshipLevel`, `GeographicScope`, `SourceURL`) VALUES
  (1, 'Towerrunning Tour 2026', 'Tour', '2026', '2026-01-01', '2026-11-28', NULL, 'Worldwide', 'https://www.towerrunning.com/towerrunning-tour-2026/'),
  (2, 'Towerrunning Tour 2025', 'Tour', '2025', '2025-01-01', '2025-11-22', NULL, 'Worldwide', 'https://www.towerrunning.com/towerrunning-tour-2025/');

INSERT INTO ORGANISATION (`OrganisationID`, `OrganisationName`, `OrganisationKind`, `CountryCode`, `WebsiteURL`, `ContactEmail`) VALUES
  (1, 'Towerrunning World Association', 'association', NULL, 'https://www.towerrunning.com/', 'office@towerrunning.com');

INSERT INTO VENUE (`VenueID`, `VenueName`, `VenueType`, `CountryCode`, `City`, `Region`, `VenueNotes`) VALUES
  (201, 'Torre Glòries', 'tower', 'ESP', 'Barcelona', NULL, 'Source: https://www.towerrunning.com/races/r3100/'),
  (202, 'Messeturm', 'tower', 'SUI', 'Basel', NULL, 'Source: https://www.towerrunning.com/races/r3024/'),
  (203, 'Post Tower', 'tower', 'GER', 'Bonn', NULL, 'Source: https://www.towerrunning.com/races/r3207/'),
  (204, 'KL Tower', 'tower', 'MAS', 'Kuala Lumpur', NULL, 'Source: https://www.towerrunning.com/races/r3276/'),
  (205, 'Raffles City Tower South', 'tower', 'CHN', 'Chongqing', NULL, 'Source: https://www.towerrunning.com/races/r3389/'),
  (206, 'Escalinata de San Simon Tlatlauquitepec', 'outdoor', 'MEX', 'Xaltocan', NULL, 'Source: https://www.towerrunning.com/races/r3203/'),
  (207, 'Testturm', 'tower', 'GER', 'Rottweil', NULL, '1390 stairs and 232 metres, according to official R2703 race detail.'),
  (208, 'Empire State Building', 'tower', 'USA', 'New York', NULL, '1576 stairs and 86 floors; source: https://www.towerrunning.com/races/r3253/'),
  (209, 'Rondo 1', 'tower', 'POL', 'Warsaw', NULL, '2025 route from official page https://www.towerrunning.com/races/r2929/'),
  (210, 'Taipei 101', 'tower', 'TWN', 'Taipei', NULL, '2025 route from official page https://www.towerrunning.com/races/r2940/'),
  (211, 'Merdeka 118', 'tower', 'MAS', 'Kuala Lumpur', NULL, '2025 route from official page https://www.towerrunning.com/races/r3006/'),
  (212, 'Messeturm Frankfurt', 'tower', 'GER', 'Frankfurt', NULL, '2025 route from official page https://www.towerrunning.com/races/r2950/');

INSERT INTO COURSE (`CourseID`, `CourseLabel`, `RouteDescription`, `RaceFormat`, `StairCount`, `FloorCount`, `VerticalClimbMetres`, `ConfigurationStatus`, `VenueID`) VALUES
  (301, 'Published staircase route', NULL, 'single climb', 686, 34, 116, 'confirmed', 201),
  (302, 'Published staircase route', NULL, 'single climb', 542, 31, NULL, 'confirmed', 202),
  (303, 'Published staircase route', NULL, 'single climb', 828, 41, NULL, 'confirmed', 203),
  (304, 'Published staircase route', NULL, 'single climb', 1608, NULL, 292, 'confirmed', 204),
  (305, 'Published staircase route', NULL, 'single climb', 1178, 42, 250, 'confirmed', 205),
  (306, 'Published staircase route', NULL, 'single climb', 365, NULL, NULL, 'confirmed', 206),
  (307, 'Published staircase route', NULL, 'single climb', 1390, NULL, 232, 'confirmed', 207),
  (308, 'Empire State Building main stair route', NULL, 'single climb', 1576, 86, NULL, 'confirmed', 208),
  (309, 'Official 2025 climb course', NULL, 'single climb', 836, 38, NULL, 'confirmed', 209),
  (310, 'Official 2025 climb course', NULL, 'single climb', 2046, 91, 391, 'confirmed', 210),
  (311, 'Official 2025 climb course', NULL, 'single climb', 2845, 118, 503, 'confirmed', 211),
  (312, 'Official 2025 climb course', NULL, 'single climb', 1200, 61, NULL, 'confirmed', 212);

INSERT INTO VENUE_ALTERNATIVE_NAME (`VenueID`, `AlternativeName`) VALUES
  (204, 'Menara Tower');

INSERT INTO RANKING_PUBLICATION (`RankingPublicationID`, `PublicationLabel`, `PublicationType`, `RankingAsOfDate`, `WindowStartDate`, `WindowEndDate`, `PublishedOn`, `RevisionLabel`, `PublicationStatus`, `SourceURL`, `ArchivedFileReference`, `RulesReference`) VALUES
  (1, 'TWA Ranking July 2026', 'Individual', NULL, NULL, NULL, NULL, NULL, 'published', 'https://www.towerrunning.com/ranking/', NULL, 'https://www.towerrunning.com/ranking/'),
  (2, 'TWA Ranking Final 2025', 'Individual', NULL, NULL, NULL, NULL, NULL, 'published', 'https://www.towerrunning.com/ranking/', NULL, 'https://www.towerrunning.com/ranking/');

INSERT INTO FORM (`FormURL`, `FormType`) VALUES
  ('https://www.towerrunning.com/twainfo/TWA%20Results%20Form.xlsx', 'standard'),
  ('https://www.towerrunning.com/twainfo/TWA%20Results%20Form%2040.xlsx', 'factor-40');

INSERT INTO RACE_EDITION (`RaceEventID`, `OccurrenceNo`, `PublishedEditionNumber`, `StartDate`, `EndDate`, `RankingDate`, `RaceFactor`, `WebsiteCategoryCode`, `EditionStatus`, `DeliveryMode`, `PublishedRaceCode`, `WebsitePageURL`, `SourceObservedOn`, `RegistrationURL`, `ResultsURL`, `PublishedMaleWinnerName`, `PublishedFemaleWinnerName`, `EvaluationStatus`, `EvaluationEvidence`, `AdditionalInformation`, `ScoringSchemeID`, `VenueID`, `PrevRaceEventID`, `PrevOccurrenceNo`) VALUES
  (101, 1, NULL, '2026-01-01', '2026-01-01', NULL, 60, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (102, 1, NULL, '2026-01-10', '2026-01-10', NULL, 200, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (103, 1, 1, '2026-01-17', '2026-01-17', NULL, 120, 'T', 'completed', NULL, 'r3100', 'https://www.towerrunning.com/races/r3100/', '2026-11-08', NULL, NULL, 'Ivan Vuletić', 'Tea Faber', NULL, NULL, NULL, NULL, 201, NULL, NULL),
  (104, 1, NULL, '2026-02-22', '2026-02-22', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'US Championships', NULL, NULL, NULL, NULL),
  (105, 1, NULL, '2026-03-28', '2026-03-28', NULL, 120, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (106, 1, NULL, '2026-03-28', '2026-03-28', NULL, 120, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (107, 1, NULL, '2026-03-29', '2026-03-29', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'Estonian Championships', NULL, NULL, NULL, NULL),
  (108, 1, NULL, '2026-05-09', '2026-05-09', NULL, 200, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (109, 1, NULL, '2026-05-17', '2026-05-17', NULL, 60, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (110, 1, NULL, '2026-05-29', '2026-05-29', NULL, 160, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (111, 1, 1, '2026-05-30', '2026-05-30', NULL, 60, 'T', 'completed', NULL, 'r3024', 'https://www.towerrunning.com/races/r3024/', '2026-11-08', NULL, NULL, 'Wai Ching Soh', 'Seow Cher Tan', NULL, NULL, NULL, NULL, 202, NULL, NULL),
  (112, 1, NULL, '2026-06-07', '2026-06-07', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (113, 1, 6, '2026-06-14', '2026-06-14', NULL, 60, 'T', 'completed', NULL, 'r3207', 'https://www.towerrunning.com/races/r3207/', '2026-11-08', NULL, NULL, 'Görge Heimann', 'Adele Blaise-Sohnius', NULL, NULL, NULL, NULL, 203, NULL, NULL),
  (114, 1, NULL, '2026-06-19', '2026-06-19', NULL, 60, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (115, 1, NULL, '2026-06-21', '2026-06-21', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'German Championships', NULL, NULL, NULL, NULL),
  (116, 1, NULL, '2026-06-27', '2026-06-27', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'Slovak Championships', NULL, NULL, NULL, NULL),
  (117, 1, NULL, '2026-08-08', '2026-08-08', NULL, 60, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (118, 1, NULL, '2026-08-20', '2026-08-20', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'Singapore Championships', NULL, NULL, NULL, NULL),
  (119, 1, NULL, '2026-08-22', '2026-08-23', NULL, 120, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, '2 days 22.-23.', NULL, NULL, NULL, NULL),
  (120, 1, NULL, '2026-08-23', '2026-08-23', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'Australian Championships', NULL, NULL, NULL, NULL),
  (121, 1, NULL, '2026-09-13', '2026-09-13', NULL, 120, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (122, 1, NULL, '2026-09-19', '2026-09-19', NULL, 120, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (123, 1, 23, '2026-09-20', '2026-09-20', NULL, 120, 'T', 'completed', NULL, 'r3276', 'https://www.towerrunning.com/races/r3276/', '2026-11-08', NULL, NULL, 'Piotr Lobodzinski', 'Tea Faber', NULL, NULL, NULL, NULL, 204, NULL, NULL),
  (124, 1, NULL, '2026-09-20', '2026-09-20', NULL, 60, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 207, NULL, NULL),
  (125, 1, NULL, '2026-09-20', '2026-09-20', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'Czech Championships', NULL, NULL, NULL, NULL),
  (126, 1, NULL, '2026-09-26', '2026-09-26', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'Polish Championships', NULL, NULL, NULL, NULL),
  (127, 1, NULL, '2026-10-03', '2026-10-03', NULL, 120, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (128, 1, 48, '2026-10-06', '2026-10-06', NULL, 80, NULL, 'completed', NULL, 'r3253', 'https://www.towerrunning.com/races/r3253/', '2026-11-08', NULL, NULL, 'Ryoji Watanabe', 'Annemarie Wilhelm', NULL, NULL, NULL, NULL, 208, NULL, NULL),
  (129, 1, NULL, '2026-10-11', '2026-10-11', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'Italian Championships', NULL, NULL, NULL, NULL),
  (130, 1, 3, '2026-10-17', '2026-10-17', NULL, 60, 'R', 'completed', NULL, 'r3389', 'https://www.towerrunning.com/races/r3389/', '2026-11-08', NULL, NULL, 'Wai Ching Soh', 'Zhuoman Zheng', NULL, NULL, NULL, NULL, 205, NULL, NULL),
  (131, 1, NULL, '2026-10-18', '2026-10-18', NULL, 60, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (102, 2, NULL, '2026-10-24', '2026-10-24', NULL, 200, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (132, 1, NULL, '2026-10-31', '2026-10-31', NULL, 160, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (133, 1, NULL, '2026-11-07', '2026-11-07', NULL, 60, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (134, 1, NULL, '2026-11-08', '2026-11-08', NULL, 80, NULL, NULL, NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (135, 1, NULL, '2026-11-14', '2026-11-14', NULL, 120, NULL, 'planned', NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (136, 1, NULL, '2026-11-15', '2026-11-15', NULL, 120, NULL, 'planned', NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (137, 1, NULL, '2026-11-15', '2026-11-15', NULL, 60, NULL, 'planned', NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (138, 1, NULL, '2026-11-27', '2026-11-29', NULL, 80, NULL, 'planned', NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, '3 day event', NULL, NULL, NULL, NULL),
  (139, 1, NULL, '2026-11-28', '2026-11-28', NULL, 240, NULL, 'planned', NULL, NULL, 'https://www.towerrunning.com/towerrunning-tour-2026/', '2026-11-08', NULL, NULL, NULL, NULL, NULL, NULL, 'Towerrunning Tour Final', NULL, NULL, NULL, NULL),
  (140, 1, 2, '2026-03-22', '2026-03-22', NULL, 40, 'R', 'completed', NULL, 'r3203', 'https://www.towerrunning.com/races/r3203/', '2026-11-08', NULL, NULL, 'Fernando Carreño Ortiz', 'Jessica Mariana Velez Gutierrez', NULL, NULL, 'Extra race verified on official 2026 race detail page (not on the displayed Tour list).', NULL, 206, NULL, NULL),
  (106, 2, 13, '2025-04-12', '2025-04-12', NULL, 200, 'T', 'completed', 'in-person', 'r2929', 'https://www.towerrunning.com/races/r2929/', '2026-11-08', NULL, NULL, 'Wai Ching Soh', 'Tea Faber', 'unverified', NULL, 'Source-backed historical edition; official 2025 race detail.', NULL, 209, NULL, NULL),
  (108, 2, 18, '2025-05-03', '2025-05-03', NULL, 200, 'T', 'completed', 'in-person', 'r2940', 'https://www.towerrunning.com/races/r2940/', '2026-11-08', NULL, NULL, 'Ryoji Watanabe', 'Tea Faber', 'unverified', NULL, 'Source-backed historical edition; official 2025 race detail.', NULL, 210, NULL, NULL),
  (119, 2, 1, '2025-08-30', '2025-08-30', NULL, 200, 'T', 'completed', 'in-person', 'r3006', 'https://www.towerrunning.com/races/r3006/', '2026-11-08', NULL, NULL, 'Wai Ching Soh', 'Yuko Tateishi', 'unverified', NULL, 'Source-backed historical edition; official 2025 race detail.', NULL, 211, NULL, NULL),
  (112, 2, 16, '2025-06-01', '2025-06-01', NULL, 80, 'T', 'completed', 'in-person', 'r2950', 'https://www.towerrunning.com/races/r2950/', '2026-11-08', NULL, NULL, 'Christian Riedl', 'Adele Blaise-Sohnius', 'unverified', NULL, 'Source-backed historical edition; official 2025 race detail.', NULL, 212, NULL, NULL);

INSERT INTO OFFERS (`RaceEventID`, `OccurrenceNo`, `CourseID`, `EvaluationSelection`, `SelectionEvidence`) VALUES
  (103, 1, 301, 'selected', 'https://www.towerrunning.com/races/r3100/'),
  (111, 1, 302, 'selected', 'https://www.towerrunning.com/races/r3024/'),
  (113, 1, 303, 'selected', 'https://www.towerrunning.com/races/r3207/'),
  (123, 1, 304, 'selected', 'https://www.towerrunning.com/races/r3276/'),
  (124, 1, 307, 'pending', 'https://www.towerrunning.com/towerrunning-tour-2026/'),
  (128, 1, 308, 'pending', 'https://www.towerrunning.com/towerrunning-tour-2026/'),
  (130, 1, 305, 'selected', 'https://www.towerrunning.com/races/r3389/'),
  (140, 1, 306, 'selected', 'https://www.towerrunning.com/races/r3203/'),
  (106, 2, 309, 'selected', 'https://www.towerrunning.com/races/r2929/'),
  (108, 2, 310, 'selected', 'https://www.towerrunning.com/races/r2940/'),
  (119, 2, 311, 'selected', 'https://www.towerrunning.com/races/r3006/'),
  (112, 2, 312, 'selected', 'https://www.towerrunning.com/races/r2950/');

INSERT INTO INCLUDED_IN (`RaceEventID`, `OccurrenceNo`, `CompetitionEditionID`, `RoleLabel`, `InclusionNote`) VALUES
  (101, 1, 1, 'ordinary', NULL),
  (102, 1, 1, 'ordinary', NULL),
  (103, 1, 1, 'ordinary', NULL),
  (104, 1, 1, 'championship stage', 'US Championships'),
  (105, 1, 1, 'ordinary', NULL),
  (106, 1, 1, 'ordinary', NULL),
  (107, 1, 1, 'championship stage', 'Estonian Championships'),
  (108, 1, 1, 'ordinary', NULL),
  (109, 1, 1, 'ordinary', NULL),
  (110, 1, 1, 'ordinary', NULL),
  (111, 1, 1, 'ordinary', NULL),
  (112, 1, 1, 'ordinary', NULL),
  (113, 1, 1, 'ordinary', NULL),
  (114, 1, 1, 'ordinary', NULL),
  (115, 1, 1, 'championship stage', 'German Championships'),
  (116, 1, 1, 'championship stage', 'Slovak Championships'),
  (117, 1, 1, 'ordinary', NULL),
  (118, 1, 1, 'championship stage', 'Singapore Championships'),
  (119, 1, 1, 'ordinary', '2 days 22.-23.'),
  (120, 1, 1, 'championship stage', 'Australian Championships'),
  (121, 1, 1, 'ordinary', NULL),
  (122, 1, 1, 'ordinary', NULL),
  (123, 1, 1, 'ordinary', NULL),
  (124, 1, 1, 'ordinary', NULL),
  (125, 1, 1, 'championship stage', 'Czech Championships'),
  (126, 1, 1, 'championship stage', 'Polish Championships'),
  (127, 1, 1, 'ordinary', NULL),
  (128, 1, 1, 'ordinary', NULL),
  (129, 1, 1, 'championship stage', 'Italian Championships'),
  (130, 1, 1, 'ordinary', NULL),
  (131, 1, 1, 'ordinary', NULL),
  (102, 2, 1, 'ordinary', NULL),
  (132, 1, 1, 'ordinary', NULL),
  (133, 1, 1, 'ordinary', NULL),
  (134, 1, 1, 'ordinary', NULL),
  (135, 1, 1, 'ordinary', NULL),
  (136, 1, 1, 'ordinary', NULL),
  (137, 1, 1, 'ordinary', NULL),
  (138, 1, 1, 'ordinary', '3 day event'),
  (139, 1, 1, 'Tour final', 'Towerrunning Tour Final'),
  (106, 2, 2, 'ordinary', NULL),
  (108, 2, 2, 'ordinary', NULL),
  (119, 2, 2, 'ordinary', NULL),
  (112, 2, 2, 'ordinary', NULL);

INSERT INTO PERSON (`PersonID`, `FullName`, `BirthDate`) VALUES
  (1001, 'Ivan Vuletić', NULL),
  (1002, 'Mateusz Marunowski', NULL),
  (1003, 'Klaus Hausleitner', NULL),
  (1004, 'Fabio Ruga', NULL),
  (1005, 'Angel López Amor', NULL),
  (1006, 'Daniel Weißenböck', NULL),
  (1007, 'Marc Rocadembosch', NULL),
  (1008, 'Görge Heimann', NULL),
  (1009, 'Ignacio Cardona Torres', NULL),
  (1010, 'Pavel Holec', NULL),
  (1011, 'Marek Smetana', NULL),
  (1012, 'Michal Dočkálek', NULL),
  (1013, 'Wesley Smulders', NULL),
  (1014, 'Adrian Bednarski', NULL),
  (1015, 'Raphael Igrișianu', NULL),
  (1016, 'Jindrich Schick', NULL),
  (1017, 'Luciano Leo', NULL),
  (1018, 'Tea Faber', NULL),
  (1019, 'Kamila Chomaničová', NULL),
  (1020, 'Annemarie Wilhelm', NULL),
  (1021, 'Klaudia Krajewska', NULL),
  (1022, 'Jui Chuan Chao', NULL),
  (1023, 'Cristina Bonacina', NULL),
  (1024, 'Claudia Maria Henneken', NULL),
  (1025, 'Elena B. de Castro', NULL),
  (1026, 'Laurence Rastell Diaz', NULL),
  (1027, 'Gemma Villacampa Marín', NULL),
  (1028, 'Lenka Wallová', NULL),
  (1029, 'Bianca Tirabosco', NULL),
  (1030, 'Wai Ching Soh', NULL),
  (1031, 'Matthias Lauer', NULL),
  (1032, 'Marc Toda Vericat', NULL),
  (1033, 'Daniel Ackermann', NULL),
  (1034, 'Eddie Tan', NULL),
  (1035, 'Silvester Gomboc', NULL),
  (1036, 'Seow Cher Tan', NULL),
  (1037, 'Patricia Pinar Riba', NULL),
  (1038, 'Andreas Fruhmann', NULL),
  (1039, 'Matthias Gall', NULL),
  (1040, 'Sylvio Atmanspacher', NULL),
  (1041, 'Michael Schneider', NULL),
  (1042, 'Siegfried Flor', NULL),
  (1043, 'Hasan Hüseyin Karadaş', NULL),
  (1044, 'David Leitheiser', NULL),
  (1045, 'Adele Blaise-Sohnius', NULL),
  (1046, 'Cordula Galster', NULL),
  (1047, 'Piotr Lobodzinski', NULL),
  (1048, 'Jiandong Xue', NULL),
  (1049, 'Mark Bourne', NULL),
  (1050, 'Ching Chun Lo', NULL),
  (1051, 'Muhammad Hazim Zuhairi Bin Azahari', NULL),
  (1052, 'Wong Chin Chun', NULL),
  (1053, 'Chris Dufton', NULL),
  (1054, 'Jeffrey Ross', NULL),
  (1055, 'Song Hua Tan', NULL),
  (1056, 'Chee Choon Chow', NULL),
  (1057, 'Luis Eduardo García Capel', NULL),
  (1058, 'Muhamad Idham', NULL),
  (1059, 'Pearljit Singh', NULL),
  (1060, 'Hwee Aun Khaw', NULL),
  (1061, 'Yuko Tateishi', NULL),
  (1062, 'Tsz Yau Li', NULL),
  (1063, 'Serene Cheong', NULL),
  (1064, 'Rhea Assyifa', NULL),
  (1065, 'Michele Tan Bee Kiang', NULL),
  (1066, 'Raisya Adelea', NULL),
  (1067, 'Cindy Reid', NULL),
  (1068, 'Wen Yee Lim', NULL),
  (1069, 'Fernando Carreño Ortiz', NULL),
  (1070, 'Marco Antonio de la Cruz', NULL),
  (1071, 'Jesus Raya Castillo', NULL),
  (1072, 'Andrés Manzo', NULL),
  (1073, 'Arturo Velazquez Leyva', NULL),
  (1074, 'Jaime Alvarez Barreda', NULL),
  (1075, 'Jessica Mariana Velez Gutierrez', NULL),
  (1076, 'Blanca Romero', NULL),
  (1077, 'Elizabeth Aguilar Becerril', NULL),
  (1078, 'Lisbeth Mendez', NULL),
  (1079, 'Rosa Maria Gonzalez', NULL),
  (1080, 'Ryoji Watanabe', NULL),
  (1081, 'Iwona Wicha', NULL),
  (1082, 'Valentina Belotti', NULL),
  (1083, 'Emanuele Manzi', NULL),
  (1084, 'Laura Manninen', NULL);

INSERT INTO ATHLETE (`PersonID`, `NationalityCode`, `Gender`, `DefaultCompetitionDivision`) VALUES
  (1001, 'CRO', NULL, NULL),
  (1002, 'POL', NULL, NULL),
  (1003, 'AUT', NULL, NULL),
  (1004, 'ITA', NULL, NULL),
  (1005, 'ESP', NULL, NULL),
  (1006, 'AUT', NULL, NULL),
  (1007, 'ESP', NULL, NULL),
  (1008, 'GER', NULL, NULL),
  (1009, 'ESP', NULL, NULL),
  (1010, 'CZE', NULL, NULL),
  (1011, 'SVK', NULL, NULL),
  (1012, 'CZE', NULL, NULL),
  (1013, 'NED', NULL, NULL),
  (1014, 'POL', NULL, NULL),
  (1015, 'ROU', NULL, NULL),
  (1016, 'CZE', NULL, NULL),
  (1017, 'GBR', NULL, NULL),
  (1018, 'CRO', NULL, NULL),
  (1019, 'SVK', NULL, NULL),
  (1020, 'AUT', NULL, NULL),
  (1021, 'POL', NULL, NULL),
  (1022, 'TPE', NULL, NULL),
  (1023, 'ITA', NULL, NULL),
  (1024, 'GER', NULL, NULL),
  (1025, 'ESP', NULL, NULL),
  (1026, 'ESP', NULL, NULL),
  (1027, 'ESP', NULL, NULL),
  (1028, 'CZE', NULL, NULL),
  (1029, 'GBR', NULL, NULL),
  (1030, 'MAS', NULL, NULL),
  (1031, 'GER', NULL, NULL),
  (1032, 'ESP', NULL, NULL),
  (1033, 'SUI', NULL, NULL),
  (1034, 'SIN', NULL, NULL),
  (1035, 'SLO', NULL, NULL),
  (1036, 'SIN', NULL, NULL),
  (1037, 'ESP', NULL, NULL),
  (1038, 'GER', NULL, NULL),
  (1039, 'GER', NULL, NULL),
  (1040, 'GER', NULL, NULL),
  (1041, 'GER', NULL, NULL),
  (1042, 'GER', NULL, NULL),
  (1043, 'GER', NULL, NULL),
  (1044, 'GER', NULL, NULL),
  (1045, 'CAN', NULL, NULL),
  (1046, 'GER', NULL, NULL),
  (1047, 'POL', NULL, NULL),
  (1048, 'CHN', NULL, NULL),
  (1049, 'AUS', NULL, NULL),
  (1050, 'TPE', NULL, NULL),
  (1051, 'MAS', NULL, NULL),
  (1052, 'MAS', NULL, NULL),
  (1053, 'NZL', NULL, NULL),
  (1054, 'GBR', NULL, NULL),
  (1055, 'MAS', NULL, NULL),
  (1056, 'MAS', NULL, NULL),
  (1057, 'ESP', NULL, NULL),
  (1058, 'MAS', NULL, NULL),
  (1059, 'MAS', NULL, NULL),
  (1060, 'MAS', NULL, NULL),
  (1061, 'JPN', NULL, NULL),
  (1062, 'HKG', NULL, NULL),
  (1063, 'SIN', NULL, NULL),
  (1064, 'MAS', NULL, NULL),
  (1065, 'MAS', NULL, NULL),
  (1066, 'MAS', NULL, NULL),
  (1067, 'AUS', NULL, NULL),
  (1068, 'MAS', NULL, NULL),
  (1069, 'MEX', NULL, NULL),
  (1070, 'MEX', NULL, NULL),
  (1071, 'MEX', NULL, NULL),
  (1072, 'MEX', NULL, NULL),
  (1073, 'MEX', NULL, NULL),
  (1074, 'MEX', NULL, NULL),
  (1075, 'MEX', NULL, NULL),
  (1076, 'MEX', NULL, NULL),
  (1077, 'MEX', NULL, NULL),
  (1078, 'MEX', NULL, NULL),
  (1079, 'MEX', NULL, NULL),
  (1080, 'JPN', NULL, NULL),
  (1081, 'POL', NULL, NULL),
  (1082, 'ITA', NULL, NULL),
  (1083, 'ITA', NULL, NULL),
  (1084, 'FIN', NULL, NULL);

INSERT INTO REGISTERED_ATHLETE (`PersonID`, `TWAAthleteID`, `FirstRegistrationDate`) VALUES
  (1001, 'CRO2002M001', NULL),
  (1002, 'POL1988M001', NULL),
  (1003, 'AUT1988M001', NULL),
  (1004, 'ITA1981M001', NULL),
  (1005, 'ESP1994M001', NULL),
  (1006, 'AUT1987M003', NULL),
  (1007, 'ESP1988M002', NULL),
  (1008, 'GER1968M001', NULL),
  (1009, 'ESP1974M002', NULL),
  (1010, 'CZE1985M001', NULL),
  (1011, 'SVK2001M001', NULL),
  (1012, 'CZE1992M002', NULL),
  (1013, 'NED1996M001', NULL),
  (1014, 'POL1989M004', NULL),
  (1015, 'ROU1980M001', NULL),
  (1016, 'CZE1975M001', NULL),
  (1017, 'GBR1992M002', NULL),
  (1018, 'CRO1989F001', NULL),
  (1019, 'SVK1995F001', NULL),
  (1020, 'AUT1984F002', NULL),
  (1021, 'POL1993F001', NULL),
  (1022, 'TPE1977F001', NULL),
  (1023, 'ITA1975F001', NULL),
  (1024, 'GER1985F001', NULL),
  (1025, 'ESP1995F001', NULL),
  (1026, 'ESP1968F001', NULL),
  (1027, 'ESP1976F001', NULL),
  (1028, 'CZE1981F001', NULL),
  (1029, 'GBR1998F001', NULL),
  (1030, 'MAS1994M001', NULL),
  (1031, 'GER1992M001', NULL),
  (1032, 'ESP1984M001', NULL),
  (1033, 'SUI1960M001', NULL),
  (1034, 'SIN1978M001', NULL),
  (1035, 'SLO1962M001', NULL),
  (1036, 'SIN1979F001', NULL),
  (1037, 'ESP1985F001', NULL),
  (1038, 'GER1979M002', NULL),
  (1039, 'GER1979M003', NULL),
  (1040, 'GER1976M001', NULL),
  (1041, 'GER1973M001', NULL),
  (1042, 'GER1963M001', NULL),
  (1043, 'GER1988M001', NULL),
  (1044, 'GER1965M001', NULL),
  (1045, 'CAN1985F001', NULL),
  (1046, 'GER1974F001', NULL),
  (1047, 'POL1985M001', NULL),
  (1048, 'CHN1991M001', NULL),
  (1049, 'AUS1983M001', NULL),
  (1050, 'TPE1997M003', NULL),
  (1051, 'MAS2001M001', NULL),
  (1052, 'MAS1988M005', NULL),
  (1053, 'NZL1983M001', NULL),
  (1054, 'GBR1975M003', NULL),
  (1055, 'MAS1971M001', NULL),
  (1056, 'MAS1975M002', NULL),
  (1057, 'ESP1983M002', NULL),
  (1058, 'MAS1990M003', NULL),
  (1059, 'MAS1993M004', NULL),
  (1060, 'MAS1990M002', NULL),
  (1061, 'JPN1986F001', NULL),
  (1062, 'HKG1986F001', NULL),
  (1063, 'SIN1983F001', NULL),
  (1064, 'MAS2014F001', NULL),
  (1065, 'MAS1984F001', NULL),
  (1066, 'MAS2012F001', NULL),
  (1067, 'AUS1982F002', NULL),
  (1068, 'MAS1990F001', NULL),
  (1069, 'MEX1988M001', NULL),
  (1070, 'MEX1992M001', NULL),
  (1071, 'MEX1999M001', NULL),
  (1072, 'MEX1970M001', NULL),
  (1073, 'MEX1974M001', NULL),
  (1074, 'MEX1979M001', NULL),
  (1075, 'MEX1991F002', NULL),
  (1076, 'MEX1982F001', NULL),
  (1077, 'MEX1965F001', NULL),
  (1078, 'MEX1989F002', NULL),
  (1079, 'MEX1972F001', NULL),
  (1080, 'JPN1984M001', NULL),
  (1081, 'POL1987F001', NULL),
  (1082, 'ITA1980F001', NULL),
  (1083, 'ITA1977M001', NULL),
  (1084, 'FIN1973F001', NULL);

INSERT INTO COURSE_RECORD (`CourseRecordID`, `HolderNameAsPublished`, `Division`, `AgeGroupLabel`, `RecordTimeSeconds`, `AchievementYear`, `CountryAsPublished`, `SourceObservedOn`, `EvidenceURL`, `CourseID`, `HolderPersonID`) VALUES
  (1, 'Christian Riedl', 'Male', NULL, 416, 2018, 'GER', '2026-11-08', 'https://www.towerrunning.com/races/r2703/', 307, NULL),
  (2, 'Verena Schmitz', 'Female', NULL, 547, 2024, 'GER', '2026-11-08', 'https://www.towerrunning.com/races/r2703/', 307, NULL),
  (3, 'Paul Crake', 'Male', NULL, 573, 2003, 'AUS', '2026-11-08', 'https://www.towerrunning.com/races/r3253/', 308, NULL),
  (4, 'Andrea Mayr', 'Female', NULL, 683, 2006, 'AUT', '2026-11-08', 'https://www.towerrunning.com/races/r3253/', 308, NULL),
  (5, 'Paul Crake', 'Male', NULL, 629.32, 2005, 'AUS', '2026-11-08', 'https://www.towerrunning.com/races/r2940/', 310, NULL),
  (6, 'Andrea Mayr', 'Female', NULL, 758.85, 2005, 'AUT', '2026-11-08', 'https://www.towerrunning.com/races/r2940/', 310, NULL);

INSERT INTO ACHIEVES_RESULT (`RaceEventID`, `OccurrenceNo`, `CourseID`, `PersonID`, `CompetitionDivision`, `CountryAtRace`, `FinishStatus`, `VerificationStatus`, `DisputeStatus`, `SourceURL`, `SubmissionNo`, `SourceRowNo`, `OverallPlace`, `FinishingTimeSeconds`, `Points`) VALUES
  (103, 1, 301, 1001, 'Male', 'CRO', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 1, NULL, 120.0),
  (103, 1, 301, 1002, 'Male', 'POL', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 2, NULL, 102.0),
  (103, 1, 301, 1003, 'Male', 'AUT', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 3, NULL, 90.0),
  (103, 1, 301, 1004, 'Male', 'ITA', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 4, NULL, 81.0),
  (103, 1, 301, 1005, 'Male', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 6, NULL, 66.0),
  (103, 1, 301, 1006, 'Male', 'AUT', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 7, NULL, 60.0),
  (103, 1, 301, 1007, 'Male', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 8, NULL, 54.0),
  (103, 1, 301, 1008, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 9, NULL, 49.5),
  (103, 1, 301, 1009, 'Male', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 10, NULL, 45.0),
  (103, 1, 301, 1010, 'Male', 'CZE', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 11, NULL, 40.5),
  (103, 1, 301, 1011, 'Male', 'SVK', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 12, NULL, 36.0),
  (103, 1, 301, 1012, 'Male', 'CZE', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 13, NULL, 33.0),
  (103, 1, 301, 1013, 'Male', 'NED', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 14, NULL, 30.0),
  (103, 1, 301, 1014, 'Male', 'POL', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 15, NULL, 27.0),
  (103, 1, 301, 1015, 'Male', 'ROU', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 16, NULL, 24.0),
  (103, 1, 301, 1016, 'Male', 'CZE', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 24, NULL, 10.5),
  (103, 1, 301, 1017, 'Male', 'GBR', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 25, NULL, 9.0),
  (103, 1, 301, 1018, 'Female', 'CRO', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 1, NULL, 120.0),
  (103, 1, 301, 1019, 'Female', 'SVK', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 2, NULL, 102.0),
  (103, 1, 301, 1020, 'Female', 'AUT', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 3, NULL, 90.0),
  (103, 1, 301, 1021, 'Female', 'POL', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 4, NULL, 81.0),
  (103, 1, 301, 1022, 'Female', 'TPE', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 5, NULL, 72.0),
  (103, 1, 301, 1023, 'Female', 'ITA', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 6, NULL, 66.0),
  (103, 1, 301, 1024, 'Female', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 7, NULL, 60.0),
  (103, 1, 301, 1025, 'Female', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 8, NULL, 54.0),
  (103, 1, 301, 1026, 'Female', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 9, NULL, 49.5),
  (103, 1, 301, 1027, 'Female', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 12, NULL, 36.0),
  (103, 1, 301, 1028, 'Female', 'CZE', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 14, NULL, 30.0),
  (103, 1, 301, 1029, 'Female', 'GBR', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3100/', NULL, NULL, 30, NULL, 1.5),
  (111, 1, 302, 1030, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 1, NULL, 60.0),
  (111, 1, 302, 1031, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 2, NULL, 48.0),
  (111, 1, 302, 1032, 'Male', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 3, NULL, 40.0),
  (111, 1, 302, 1012, 'Male', 'CZE', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 6, NULL, 24.0),
  (111, 1, 302, 1017, 'Male', 'GBR', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 14, NULL, 7.0),
  (111, 1, 302, 1033, 'Male', 'SUI', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 23, NULL, 0.5),
  (111, 1, 302, 1034, 'Male', 'SIN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 34, NULL, 0.5),
  (111, 1, 302, 1035, 'Male', 'SLO', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 41, NULL, 0.5),
  (111, 1, 302, 1036, 'Female', 'SIN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 1, NULL, 60.0),
  (111, 1, 302, 1025, 'Female', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 2, NULL, 48.0),
  (111, 1, 302, 1028, 'Female', 'CZE', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 3, NULL, 40.0),
  (111, 1, 302, 1029, 'Female', 'GBR', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 10, NULL, 11.0),
  (111, 1, 302, 1037, 'Female', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3024/', NULL, NULL, 20, NULL, 1.0),
  (113, 1, 303, 1008, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 1, NULL, 60.0),
  (113, 1, 303, 1038, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 2, NULL, 48.0),
  (113, 1, 303, 1039, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 3, NULL, 40.0),
  (113, 1, 303, 1040, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 10, NULL, 11.0),
  (113, 1, 303, 1041, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 12, NULL, 9.0),
  (113, 1, 303, 1042, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 34, NULL, 0.5),
  (113, 1, 303, 1043, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 38, NULL, 0.5),
  (113, 1, 303, 1044, 'Male', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 50, NULL, 0.5),
  (113, 1, 303, 1045, 'Female', 'CAN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 1, NULL, 60.0),
  (113, 1, 303, 1046, 'Female', 'GER', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3207/', NULL, NULL, 2, NULL, 48.0),
  (123, 1, 304, 1047, 'Male', 'POL', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 1, NULL, 120.0),
  (123, 1, 304, 1030, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 2, NULL, 102.0),
  (123, 1, 304, 1048, 'Male', 'CHN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 3, NULL, 90.0),
  (123, 1, 304, 1049, 'Male', 'AUS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 4, NULL, 81.0),
  (123, 1, 304, 1050, 'Male', 'TPE', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 5, NULL, 72.0),
  (123, 1, 304, 1051, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 8, NULL, 54.0),
  (123, 1, 304, 1052, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 9, NULL, 49.5),
  (123, 1, 304, 1053, 'Male', 'NZL', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 11, NULL, 40.5),
  (123, 1, 304, 1054, 'Male', 'GBR', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 13, NULL, 33.0),
  (123, 1, 304, 1055, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 18, NULL, 19.5),
  (123, 1, 304, 1056, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 19, NULL, 18.0),
  (123, 1, 304, 1057, 'Male', 'ESP', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 24, NULL, 10.5),
  (123, 1, 304, 1058, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 31, NULL, 0.5),
  (123, 1, 304, 1059, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 33, NULL, 0.5),
  (123, 1, 304, 1060, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 35, NULL, 0.5),
  (123, 1, 304, 1018, 'Female', 'CRO', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 1, NULL, 120.0),
  (123, 1, 304, 1061, 'Female', 'JPN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 2, NULL, 102.0),
  (123, 1, 304, 1062, 'Female', 'HKG', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 3, NULL, 90.0),
  (123, 1, 304, 1063, 'Female', 'SIN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 4, NULL, 81.0),
  (123, 1, 304, 1064, 'Female', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 5, NULL, 72.0),
  (123, 1, 304, 1065, 'Female', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 6, NULL, 66.0),
  (123, 1, 304, 1036, 'Female', 'SIN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 7, NULL, 60.0),
  (123, 1, 304, 1066, 'Female', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 8, NULL, 54.0),
  (123, 1, 304, 1067, 'Female', 'AUS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 9, NULL, 49.5),
  (123, 1, 304, 1068, 'Female', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3276/', NULL, NULL, 10, NULL, 45.0),
  (140, 1, 306, 1069, 'Male', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 1, NULL, 40.0),
  (140, 1, 306, 1070, 'Male', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 3, NULL, 26.0),
  (140, 1, 306, 1071, 'Male', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 4, NULL, 22.0),
  (140, 1, 306, 1072, 'Male', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 8, NULL, 10.0),
  (140, 1, 306, 1073, 'Male', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 9, NULL, 8.0),
  (140, 1, 306, 1074, 'Male', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 11, NULL, 5.0),
  (140, 1, 306, 1075, 'Female', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 1, NULL, 40.0),
  (140, 1, 306, 1076, 'Female', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 2, NULL, 32.0),
  (140, 1, 306, 1077, 'Female', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 3, NULL, 26.0),
  (140, 1, 306, 1078, 'Female', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 5, NULL, 18.0),
  (140, 1, 306, 1079, 'Female', 'MEX', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3203/', NULL, NULL, 15, NULL, 1.0),
  (130, 1, 305, 1030, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r3389/', NULL, NULL, 1, 1023, 60.0),
  (106, 2, 309, 1030, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 1, 437, 200.0),
  (106, 2, 309, 1080, 'Male', 'JPN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 2, NULL, 170.0),
  (106, 2, 309, 1004, 'Male', 'ITA', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 3, NULL, 150.0),
  (106, 2, 309, 1047, 'Male', 'POL', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 4, NULL, 135.0),
  (106, 2, 309, 1003, 'Male', 'AUT', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 5, NULL, 120.0),
  (106, 2, 309, 1001, 'Male', 'CRO', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 7, NULL, 100.0),
  (106, 2, 309, 1018, 'Female', 'CRO', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 1, 563, 200.0),
  (106, 2, 309, 1081, 'Female', 'POL', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 2, NULL, 170.0),
  (106, 2, 309, 1082, 'Female', 'ITA', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 3, NULL, 150.0),
  (106, 2, 309, 1045, 'Female', 'CAN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 4, NULL, 135.0),
  (106, 2, 309, 1021, 'Female', 'POL', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 5, NULL, 120.0),
  (106, 2, 309, 1061, 'Female', 'JPN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/races/r2929/', NULL, NULL, 6, NULL, 110.0),
  (108, 2, 310, 1080, 'Male', 'JPN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/', NULL, NULL, 1, 682.88, 200.0),
  (108, 2, 310, 1030, 'Male', 'MAS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/', NULL, NULL, 2, 724.83, 170.0),
  (108, 2, 310, 1049, 'Male', 'AUS', 'finished', 'verified', 'none', 'https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/', NULL, NULL, 3, 732.14, 150.0),
  (108, 2, 310, 1083, 'Male', 'ITA', 'finished', 'verified', 'none', 'https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/', NULL, NULL, 4, 743.4, 135.0),
  (108, 2, 310, 1018, 'Female', 'CRO', 'finished', 'verified', 'none', 'https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/', NULL, NULL, 1, 848.94, 200.0),
  (108, 2, 310, 1082, 'Female', 'ITA', 'finished', 'verified', 'none', 'https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/', NULL, NULL, 2, 849.19, 170.0),
  (108, 2, 310, 1084, 'Female', 'FIN', 'finished', 'verified', 'none', 'https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/', NULL, NULL, 3, 869.27, 150.0),
  (108, 2, 310, 1022, 'Female', 'TPE', 'finished', 'verified', 'none', 'https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/', NULL, NULL, 4, 909.93, 135.0);

COMMIT;

-- BEGIN VERIFIED OFFICIAL SUPPLEMENT
START TRANSACTION;
-- Generated from checksum-verified official files; do not edit.
INSERT INTO RANKING_PUBLICATION (RankingPublicationID,PublicationLabel,PublicationType,PublicationStatus,SourceURL,ArchivedFileReference,RulesReference) VALUES (201911,'TWA Ranking November 2019 Final','Individual and Nations','draft','https://www.towerrunning.com/wp-content/uploads/2024/02/TWA-Ranking-November-2019-Season-Final.xlsx','data/official/final2019.xlsx','Workbook Nations!C21:C22: point-best two per division/country/race; best eight country race totals. Exact window boundaries unverified.');
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'CHN',1,2418);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'MEX',2,2415.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'POL',3,2063);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'AUS',4,2022);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'SVK',5,1824.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'MAS',6,1675);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'ITA',7,1669.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'USA',8,1514);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'GER',9,1410);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'COL',10,1348);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'AUT',11,1347.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'GBR',12,1290);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'EST',13,1246);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'JPN',14,1134);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'ESP',15,1063);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'SLO',16,1035);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'CZE',17,895.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'FRA',18,833.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'NED',19,829.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'NOR',20,594);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'TPE',21,542);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'FIN',22,520);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'RUS',23,484.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'KEN',24,482.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'BEL',25,352);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'CRO',26,283);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'CAN',27,273);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'PHI',28,253);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'DEN',29,228);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'HKG',30,228);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'NZL',31,213);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'CHL',32,200);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'SUI',33,176);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'SIN',34,161);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'KUW',35,138);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'TUN',36,114);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'IRI',37,106);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'KOR',38,98);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'IRL',39,83);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'GEO',40,77);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'UKR',41,46);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'VIE',42,45);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'THA',42,45);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'SWE',44,44);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'EGY',45,40);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'IND',46,35);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'RSA',47,28);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'POR',47,28);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'OMA',49,26);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'CAM',50,24);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'KSA',51,22);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'BUR',51,22);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'NEP',53,20);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'HUN',54,18);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'QAT',55,17);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'MAR',56,17);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'LAT',57,16);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'SRB',58,14);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'LIB',58,14);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'ALG',58,14);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'PAK',61,12);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'ZIM',61,12);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'UAE',63,12);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'BRN',64,10);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'IRQ',65,8);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'CMR',66,6);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'ROU',67,4);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'LTU',67,4);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'MDA',67,4);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'TUR',67,4);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (201911,'JOR',71,3);
UPDATE RANKING_PUBLICATION SET PublicationStatus='published' WHERE RankingPublicationID=201911;
INSERT INTO RANKING_PUBLICATION (RankingPublicationID,PublicationLabel,PublicationType,PublicationStatus,SourceURL,ArchivedFileReference,RulesReference) VALUES (202512,'TWA Ranking Final 2025','Individual and Nations','draft','https://www.towerrunning.com/wp-content/uploads/2025/12/TWA-Ranking-Final-2025.xlsx','data/official/final2025.xlsx','Workbook Nations!C21:C22: point-best two per division/country/race; best eight country race totals. Exact window boundaries unverified.');
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'JPN',1,2904);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'POL',2,2611);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'CHN',3,2565);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'ITA',4,2440.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'MAS',5,2343);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'CRO',6,1912.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'AUT',7,1694.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'MEX',8,1528);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'USA',9,1510);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'GER',10,1482);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'AUS',11,1443);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'TPE',12,1339);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'SVK',13,1279);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'ESP',14,1254);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'SIN',15,1176.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'HKG',16,937.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'EST',17,864);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'SLO',18,840);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'GBR',19,658);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'CZE',20,462);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'CAN',21,457);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'ROU',22,406);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'DEN',23,314);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'SUI',24,277);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'FRA',25,273);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'VIE',26,238);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'MAC',27,220.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'BRA',28,219.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'AZE',29,170);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'BEL',30,162);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'FIN',31,150);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'KOR',32,146);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'RUS',33,135.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'BIH',34,116);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'THA',35,100);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'KEN',36,84);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'UKR',37,69);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'PHI',38,54);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'UGA',39,44);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'NEP',40,35);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'TUN',41,30);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'POR',41,30);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'ICE',43,22.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'SWE',44,22);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'SRB',44,22);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'NED',46,18);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'LAT',47,12);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'RSA',48,10);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'PER',49,8);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'MLT',49,8);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'LIB',51,6);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'ERI',51,6);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'BUL',53,2);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202512,'NOR',54,0);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1018,202512,'Female','CRO',1,1330);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1061,202512,'Female','JPN',2,1065);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1082,202512,'Female','ITA',3,1058);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1021,202512,'Female','POL',4,894);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1062,202512,'Female','HKG',5,760.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1081,202512,'Female','POL',8,625);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1022,202512,'Female','TPE',9,588);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1065,202512,'Female','MAS',10,519.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1076,202512,'Female','MEX',11,494);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1063,202512,'Female','SIN',12,469.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1020,202512,'Female','AUT',14,457);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1084,202512,'Female','FIN',17,354);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1036,202512,'Female','SIN',20,329);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1045,202512,'Female','CAN',29,251);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1067,202512,'Female','AUS',32,229);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1024,202512,'Female','GER',39,148);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1028,202512,'Female','CZE',43,124);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1023,202512,'Female','ITA',44,121.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1078,202512,'Female','MEX',47,111);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1029,202512,'Female','GBR',66,54);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1068,202512,'Female','MAS',119,0);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1046,202512,'Female','GER',119,0);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1030,202512,'Male','MAS',1,1420);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1080,202512,'Male','JPN',2,1202);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1004,202512,'Male','ITA',3,948);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1049,202512,'Male','AUS',4,878);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1083,202512,'Male','ITA',5,853);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1050,202512,'Male','TPE',6,783);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1003,202512,'Male','AUT',8,739);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1002,202512,'Male','POL',10,567);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1051,202512,'Male','MAS',11,559.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1048,202512,'Male','CHN',12,457);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1038,202512,'Male','GER',14,393);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1006,202512,'Male','AUT',24,296.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1056,202512,'Male','MAS',25,283.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1032,202512,'Male','ESP',26,283);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1070,202512,'Male','MEX',30,278);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1011,202512,'Male','SVK',34,237);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1014,202512,'Male','POL',37,207.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1009,202512,'Male','ESP',45,182);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1007,202512,'Male','ESP',50,176);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1047,202512,'Male','POL',51,175);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1074,202512,'Male','MEX',54,170);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1039,202512,'Male','GER',61,136);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1042,202512,'Male','GER',63,133);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1034,202512,'Male','SIN',67,111);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1052,202512,'Male','MAS',73,103.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1012,202512,'Male','CZE',74,103.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1017,202512,'Male','GBR',75,98.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1010,202512,'Male','CZE',76,98);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1016,202512,'Male','CZE',80,92.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1031,202512,'Male','GER',88,80.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1035,202512,'Male','SLO',104,60.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1044,202512,'Male','GER',134,30);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1041,202512,'Male','GER',143,22.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1043,202512,'Male','GER',144,21);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1013,202512,'Male','NED',156,9);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1033,202512,'Male','SUI',162,5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1060,202512,'Male','MAS',170,3);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1054,202512,'Male','GBR',192,0.5);
UPDATE RANKING_PUBLICATION SET PublicationStatus='published' WHERE RankingPublicationID=202512;
INSERT INTO RANKING_PUBLICATION (RankingPublicationID,PublicationLabel,PublicationType,PublicationStatus,SourceURL,ArchivedFileReference,RulesReference) VALUES (202607,'TWA Ranking July 2026','Individual and Nations','draft','https://www.towerrunning.com/wp-content/uploads/2026/08/TWA-Ranking-July-2026.xlsx','data/official/july2026.xlsx','Workbook Nations!C21:C22: point-best two per division/country/race; best eight country race totals. Exact window boundaries unverified.');
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'CHN',1,2733);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'JPN',2,2714);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'ITA',3,2260);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'MAS',4,2211.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'POL',5,2101);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'AUT',6,1980.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'GER',7,1746.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'CRO',8,1736);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'USA',9,1496);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'ESP',10,1396.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'AUS',11,1385.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'TPE',12,1317.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'MEX',13,1224);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'SVK',14,1220);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'SIN',15,1119.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'HKG',16,810);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'CZE',17,771.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'GBR',18,739);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'EST',19,673);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'SLO',20,657.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'CAN',21,392);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'ROU',22,381);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'THA',23,342);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'SUI',24,294);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'FRA',25,281);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'NED',26,241);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'RUS',27,240.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'VIE',28,238);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'DEN',29,237);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'MAC',30,220.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'FIN',31,180);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'AZE',32,170);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'GEO',33,144);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'KEN',34,127);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'BIH',35,116);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'UKR',36,91);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'BRA',37,80.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'BEL',38,80);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'BRB',39,58);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'KUW',40,46);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'NZL',41,41);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'IND',42,36);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'NEP',43,35);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'MAR',44,32);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'TUN',45,30);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'POR',45,30);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'ICE',47,22.5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'SLE',48,14);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'ZWE',48,14);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'LAT',50,12);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'SWZ',50,12);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'LIB',52,10);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'BUL',53,8);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'PAK',53,8);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'RSA',55,6);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'ERI',55,6);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'SYR',55,6);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'SRB',58,5);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'GAM',59,4);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'SWE',60,2);
INSERT INTO NATIONS_STANDING (RankingPublicationID,CountryCode,PublishedRank,PublishedPoints) VALUES (202607,'EGY',61,1);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1018,202607,'Female','CRO',1,1250);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1061,202607,'Female','JPN',2,1037);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1020,202607,'Female','AUT',3,877);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1021,202607,'Female','POL',4,874);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1082,202607,'Female','ITA',5,812);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1062,202607,'Female','HKG',6,738);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1022,202607,'Female','TPE',9,502.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1063,202607,'Female','SIN',11,450.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1045,202607,'Female','CAN',12,392);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1065,202607,'Female','MAS',13,385.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1076,202607,'Female','MEX',16,382);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1084,202607,'Female','FIN',17,374);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1036,202607,'Female','SIN',18,365);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1028,202607,'Female','CZE',20,310);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1067,202607,'Female','AUS',23,291);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1081,202607,'Female','POL',28,252);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1024,202607,'Female','GER',30,242);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1023,202607,'Female','ITA',34,200.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1046,202607,'Female','GER',44,146);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1078,202607,'Female','MEX',47,129);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1066,202607,'Female','MAS',50,122);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1068,202607,'Female','MAS',54,111);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1064,202607,'Female','MAS',70,58);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1029,202607,'Female','GBR',80,33.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1030,202607,'Male','MAS',1,1283);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1080,202607,'Male','JPN',2,1116);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1004,202607,'Male','ITA',3,939);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1049,202607,'Male','AUS',4,848);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1050,202607,'Male','TPE',6,752);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1083,202607,'Male','ITA',7,732);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1003,202607,'Male','AUT',8,709);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1051,202607,'Male','MAS',9,591.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1002,202607,'Male','POL',10,588);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1048,202607,'Male','CHN',11,532);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1032,202607,'Male','ESP',15,389);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1038,202607,'Male','GER',16,380);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1006,202607,'Male','AUT',19,354.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1007,202607,'Male','ESP',20,348);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1031,202607,'Male','GER',25,306.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1011,202607,'Male','SVK',27,277);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1056,202607,'Male','MAS',30,247.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1014,202607,'Male','POL',32,229.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1012,202607,'Male','CZE',33,228.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1009,202607,'Male','ESP',37,219.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1039,202607,'Male','GER',38,213);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1010,202607,'Male','CZE',41,203);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1070,202607,'Male','MEX',42,200);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1016,202607,'Male','CZE',58,132.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1042,202607,'Male','GER',60,128);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1034,202607,'Male','SIN',64,111);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1013,202607,'Male','NED',70,96);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1052,202607,'Male','MAS',76,92);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1017,202607,'Male','GBR',81,83);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1074,202607,'Male','MEX',105,54);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1060,202607,'Male','MAS',106,52);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1041,202607,'Male','GER',111,46.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1054,202607,'Male','GBR',113,44);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1053,202607,'Male','NZL',116,41);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1043,202607,'Male','GER',124,34.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1035,202607,'Male','SLO',151,9.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1044,202607,'Male','GER',162,4);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1033,202607,'Male','SUI',176,1.5);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1058,202607,'Male','MAS',185,1);
INSERT INTO LISTED_IN (PersonID,RankingPublicationID,PublishedDivision,CountryAtPublication,PublishedRank,PublishedPoints) VALUES (1047,202607,'Male','POL',228,0);
UPDATE RANKING_PUBLICATION SET PublicationStatus='published' WHERE RankingPublicationID=202607;
INSERT INTO SCORING_SCHEME (ScoringSchemeID,VersionLabel,SourceURL) VALUES (202301,'Official matrix base columns (retrieved 2026-11-08; applicability unassigned)','https://www.towerrunning.com/splits/TWA%20Scoring%20Matrix.xlsx');
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,1,1,280);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,1,1,240);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,1,1,200);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,1,1,160);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,1,1,120);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,1,1,80);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,1,1,60);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,1,1,40);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,2,2,238);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,2,2,204);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,2,2,170);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,2,2,136);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,2,2,102);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,2,2,68);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,2,2,48);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,2,2,32);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,3,3,210);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,3,3,180);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,3,3,150);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,3,3,120);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,3,3,90);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,3,3,60);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,3,3,40);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,3,3,26);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,4,4,189);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,4,4,162);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,4,4,135);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,4,4,108);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,4,4,81);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,4,4,54);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,4,4,34);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,4,4,22);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,5,5,168);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,5,5,144);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,5,5,120);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,5,5,96);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,5,5,72);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,5,5,48);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,5,5,28);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,5,5,18);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,6,6,154);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,6,6,132);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,6,6,110);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,6,6,88);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,6,6,66);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,6,6,44);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,6,6,24);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,6,6,14);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,7,7,140);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,7,7,120);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,7,7,100);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,7,7,80);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,7,7,60);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,7,7,40);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,7,7,20);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,7,7,12);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,8,8,126);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,8,8,108);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,8,8,90);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,8,8,72);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,8,8,54);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,8,8,36);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,8,8,16);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,8,8,10);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,9,9,115.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,9,9,99);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,9,9,82.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,9,9,66);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,9,9,49.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,9,9,33);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,9,9,13);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,9,9,8);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,10,10,105);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,10,10,90);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,10,10,75);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,10,10,60);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,10,10,45);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,10,10,30);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,10,10,11);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,10,10,6);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,11,11,94.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,11,11,81);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,11,11,67.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,11,11,54);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,11,11,40.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,11,11,27);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,11,11,10);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,11,11,5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,12,12,84);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,12,12,72);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,12,12,60);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,12,12,48);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,12,12,36);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,12,12,24);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,12,12,9);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,12,12,4);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,13,13,77);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,13,13,66);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,13,13,55);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,13,13,44);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,13,13,33);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,13,13,22);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,13,13,8);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,13,13,3);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,14,14,70);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,14,14,60);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,14,14,50);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,14,14,40);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,14,14,30);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,14,14,20);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,14,14,7);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,14,14,2);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,15,15,63);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,15,15,54);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,15,15,45);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,15,15,36);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,15,15,27);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,15,15,18);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,15,15,6);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,40,15,15,1);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,16,16,56);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,16,16,48);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,16,16,40);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,16,16,32);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,16,16,24);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,16,16,16);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,16,16,5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,17,17,49);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,17,17,42);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,17,17,35);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,17,17,28);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,17,17,21);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,17,17,14);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,17,17,4);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,18,18,45.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,18,18,39);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,18,18,32.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,18,18,26);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,18,18,19.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,18,18,13);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,18,18,3);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,19,19,42);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,19,19,36);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,19,19,30);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,19,19,24);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,19,19,18);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,19,19,12);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,19,19,2);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,20,20,38.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,20,20,33);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,20,20,27.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,20,20,22);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,20,20,16.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,20,20,11);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,60,20,20,1);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,21,21,35);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,21,21,30);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,21,21,25);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,21,21,20);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,21,21,15);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,21,21,10);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,22,22,31.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,22,22,27);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,22,22,22.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,22,22,18);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,22,22,13.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,22,22,9);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,23,23,28);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,23,23,24);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,23,23,20);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,23,23,16);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,23,23,12);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,23,23,8);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,24,24,24.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,24,24,21);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,24,24,17.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,24,24,14);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,24,24,10.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,24,24,7);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,25,25,21);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,25,25,18);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,25,25,15);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,25,25,12);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,25,25,9);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,25,25,6);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,26,26,17.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,26,26,15);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,26,26,12.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,26,26,10);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,26,26,7.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,26,26,5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,27,27,14);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,27,27,12);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,27,27,10);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,27,27,8);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,27,27,6);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,27,27,4);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,28,28,10.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,28,28,9);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,28,28,7.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,28,28,6);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,28,28,4.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,28,28,3);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,29,29,7);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,29,29,6);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,29,29,5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,29,29,4);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,29,29,3);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,29,29,2);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,280,30,30,3.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,240,30,30,3);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,200,30,30,2.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,160,30,30,2);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,120,30,30,1.5);
INSERT INTO SCORING_MATRIX_ENTRY (ScoringSchemeID,Factor,PlaceFrom,PlaceTo,Points) VALUES (202301,80,30,30,1);
COMMIT;
