"""All database reads are native parameterized SQL, executed by PyMySQL.
No table filtering, sorting, joining, or aggregation in application Python.
"""
from db import one, all_rows


def counts():
    return one('''
        SELECT
          (SELECT COUNT(*) FROM RACE_EDITION) AS editions,
          (SELECT COUNT(*) FROM RACE_EVENT) AS races,
          (SELECT COUNT(*) FROM REGISTERED_ATHLETE) AS athletes,
          (SELECT COUNT(*) FROM ACHIEVES_RESULT) AS results,
          (SELECT COUNT(*) FROM VENUE) AS venues,
          (SELECT COUNT(DISTINCT CountryAtRace) FROM ACHIEVES_RESULT) AS countries
    ''')


def highlights():
    return all_rows('''
        SELECT e.RaceEventID, e.OccurrenceNo, r.RaceName,
          e.StartDate, e.RaceFactor, e.EditionStatus,
          v.VenueName, v.City, v.CountryCode,
          (SELECT COUNT(*) FROM ACHIEVES_RESULT x
           WHERE x.RaceEventID=e.RaceEventID AND x.OccurrenceNo=e.OccurrenceNo) AS ResultCount,
          (SELECT COUNT(*) FROM OFFERS o
           WHERE o.RaceEventID=e.RaceEventID AND o.OccurrenceNo=e.OccurrenceNo) AS CourseCount
        FROM RACE_EDITION e
        JOIN RACE_EVENT r ON r.RaceEventID=e.RaceEventID
        LEFT JOIN VENUE v ON v.VenueID=e.VenueID
        ORDER BY (CASE WHEN e.StartDate >= CURDATE() THEN 0 ELSE 1 END),
          CASE WHEN e.StartDate >= CURDATE() THEN e.StartDate END ASC,
          CASE WHEN e.StartDate < CURDATE() THEN e.StartDate END DESC,
          r.RaceName ASC
        LIMIT 6
    ''')


def race_search(q='', year=None, factor=None, city='', limit=80):
    return all_rows('''
        SELECT e.RaceEventID, e.OccurrenceNo, r.RaceName, r.Description,
          e.StartDate, e.EndDate, e.RaceFactor, e.EditionStatus,
          e.WebsitePageURL, e.PublishedEditionNumber,
          v.VenueName, v.City, v.CountryCode, c.CompetitionName,
          COUNT(DISTINCT o.CourseID) AS CourseCount,
          COUNT(DISTINCT ar.PersonID) AS ResultCount
        FROM RACE_EDITION e
        JOIN RACE_EVENT r ON r.RaceEventID=e.RaceEventID
        LEFT JOIN VENUE v ON v.VenueID=e.VenueID
        LEFT JOIN INCLUDED_IN inc ON inc.RaceEventID=e.RaceEventID AND inc.OccurrenceNo=e.OccurrenceNo
        LEFT JOIN COMPETITION_EDITION c ON c.CompetitionEditionID=inc.CompetitionEditionID
        LEFT JOIN OFFERS o ON o.RaceEventID=e.RaceEventID AND o.OccurrenceNo=e.OccurrenceNo
        LEFT JOIN ACHIEVES_RESULT ar ON ar.RaceEventID=e.RaceEventID AND ar.OccurrenceNo=e.OccurrenceNo
        WHERE (%s = '' OR r.RaceName LIKE %s OR r.Description LIKE %s OR v.VenueName LIKE %s)
          AND (%s IS NULL OR YEAR(e.StartDate) = %s)
          AND (%s IS NULL OR e.RaceFactor = %s)
          AND (%s = '' OR v.City LIKE %s OR r.Description LIKE %s)
        GROUP BY e.RaceEventID, e.OccurrenceNo, r.RaceName, r.Description,
          e.StartDate, e.EndDate, e.RaceFactor, e.EditionStatus,
          e.WebsitePageURL, e.PublishedEditionNumber,
          v.VenueName, v.City, v.CountryCode, c.CompetitionName
        ORDER BY e.StartDate DESC, r.RaceName ASC
        LIMIT %s
    ''', (q, f'%{q}%', f'%{q}%', f'%{q}%', year, year, factor, factor,
          city, f'%{city}%', f'%{city}%', limit))


def race_info(event_id, occurrence):
    return one('''
        SELECT e.*, r.RaceName, r.OfficialWebsiteURL, r.Description,
          v.VenueName, v.VenueType, v.City, v.CountryCode,
          c.CompetitionName
        FROM RACE_EDITION e
        JOIN RACE_EVENT r ON r.RaceEventID=e.RaceEventID
        LEFT JOIN VENUE v ON v.VenueID=e.VenueID
        LEFT JOIN INCLUDED_IN inc ON inc.RaceEventID=e.RaceEventID AND inc.OccurrenceNo=e.OccurrenceNo
        LEFT JOIN COMPETITION_EDITION c ON c.CompetitionEditionID=inc.CompetitionEditionID
        WHERE e.RaceEventID=%s AND e.OccurrenceNo=%s
    ''', (event_id, occurrence))


def race_courses(event_id, occurrence):
    return all_rows('''
        SELECT c.CourseID, c.CourseLabel, c.StairCount, c.FloorCount,
          c.VerticalClimbMetres, c.RaceFormat, v.VenueName, v.City
        FROM OFFERS o
        JOIN COURSE c ON c.CourseID=o.CourseID
        JOIN VENUE v ON v.VenueID=c.VenueID
        WHERE o.RaceEventID=%s AND o.OccurrenceNo=%s
        ORDER BY c.CourseID
    ''', (event_id, occurrence))


def race_results(event_id, occurrence, division=''):
    return all_rows('''
        SELECT ar.FinishStatus, ar.VerificationStatus, ar.DisputeStatus, ar.OverallPlace, ar.CompetitionDivision, ar.CountryAtRace,
          ar.FinishingTimeSeconds, ar.Points, ar.SourceURL,
          p.PersonID, p.FullName, ra.TWAAthleteID, co.CourseLabel
        FROM ACHIEVES_RESULT ar
        JOIN PERSON p ON p.PersonID=ar.PersonID
        JOIN COURSE co ON co.CourseID=ar.CourseID
        LEFT JOIN REGISTERED_ATHLETE ra ON ra.PersonID=ar.PersonID
        WHERE ar.RaceEventID=%s AND ar.OccurrenceNo=%s
          AND (%s='' OR ar.CompetitionDivision=%s)
        ORDER BY ar.CompetitionDivision ASC, ar.OverallPlace ASC, p.FullName ASC
        LIMIT 200
    ''', (event_id, occurrence, division, division))


def athlete_search(q='', country='', division='', limit=100):
    return all_rows('''
        SELECT p.PersonID, p.FullName, a.Gender, a.NationalityCode,
          ra.TWAAthleteID, COUNT(r.PersonID) AS Races,
          COALESCE(SUM(r.Points),0) AS ImportedPoints
        FROM ATHLETE a
        JOIN PERSON p ON p.PersonID=a.PersonID
        LEFT JOIN REGISTERED_ATHLETE ra ON ra.PersonID=p.PersonID
        LEFT JOIN ACHIEVES_RESULT r ON r.PersonID=p.PersonID
        WHERE (%s='' OR p.FullName LIKE %s OR ra.TWAAthleteID LIKE %s)
          AND (%s='' OR a.NationalityCode=%s)
          AND (%s='' OR EXISTS (SELECT 1 FROM ACHIEVES_RESULT ar2 WHERE ar2.PersonID=p.PersonID AND ar2.CompetitionDivision=%s))
        GROUP BY p.PersonID, p.FullName, a.Gender, a.NationalityCode, ra.TWAAthleteID
        ORDER BY ImportedPoints DESC, p.FullName ASC
        LIMIT %s
    ''',(q,f'%{q}%',f'%{q}%',country,country,division,division,limit))


def athlete_info(person_id):
    return one('''
        SELECT p.PersonID, p.FullName, p.BirthDate, a.NationalityCode,
          a.Gender, ra.TWAAthleteID, ra.FirstRegistrationDate
        FROM ATHLETE a
        JOIN PERSON p ON p.PersonID=a.PersonID
        LEFT JOIN REGISTERED_ATHLETE ra ON ra.PersonID=p.PersonID
        WHERE p.PersonID=%s
    ''',(person_id,))


def athlete_results(person_id):
    return all_rows('''
        SELECT e.RaceEventID, e.OccurrenceNo, e.StartDate, e.RaceFactor,
          re.RaceName, ar.FinishStatus, ar.VerificationStatus, ar.OverallPlace, ar.CompetitionDivision,
          ar.Points, ar.FinishingTimeSeconds, ar.SourceURL
        FROM ACHIEVES_RESULT ar
        JOIN RACE_EDITION e ON e.RaceEventID=ar.RaceEventID AND e.OccurrenceNo=ar.OccurrenceNo
        JOIN RACE_EVENT re ON re.RaceEventID=e.RaceEventID
        WHERE ar.PersonID=%s
        ORDER BY e.StartDate DESC, ar.OverallPlace ASC
    ''',(person_id,))


def points_leaderboard(division='', country='', min_races=1):
    return all_rows('''
        SELECT p.PersonID, p.FullName, a.Gender, a.NationalityCode,
          ra.TWAAthleteID, r.CompetitionDivision AS ImportedDivision, COUNT(*) AS ImportedRaceCount,
          SUM(r.Points) AS ImportedPointTotal
        FROM ACHIEVES_RESULT r
        JOIN PERSON p ON p.PersonID=r.PersonID
        JOIN ATHLETE a ON a.PersonID=p.PersonID
        LEFT JOIN REGISTERED_ATHLETE ra ON ra.PersonID=p.PersonID
        WHERE r.Points IS NOT NULL AND r.VerificationStatus='verified' AND r.FinishStatus='finished'
          AND (%s='' OR r.CompetitionDivision=%s)
          AND (%s='' OR a.NationalityCode=%s)
        GROUP BY p.PersonID, p.FullName, a.Gender, a.NationalityCode, ra.TWAAthleteID, r.CompetitionDivision
        HAVING COUNT(*) >= %s
        ORDER BY ImportedPointTotal DESC, ImportedRaceCount DESC, p.FullName
        LIMIT 100
    ''',(division,division,country,country,min_races))


def published_rankings():
    return all_rows('''
        SELECT p.RankingPublicationID, p.PublicationLabel, p.PublicationType,
          p.RankingAsOfDate, p.PublicationStatus, p.SourceURL,
          COUNT(l.PersonID) AS ImportedEntries
        FROM RANKING_PUBLICATION p
        LEFT JOIN LISTED_IN l ON l.RankingPublicationID=p.RankingPublicationID
        GROUP BY p.RankingPublicationID, p.PublicationLabel, p.PublicationType,
          p.RankingAsOfDate, p.PublicationStatus, p.SourceURL
        ORDER BY p.RankingPublicationID ASC
    ''')


def ranking_rows(publication_id):
    return all_rows('''
        SELECT l.PublishedRank, l.PublishedDivision, l.CountryAtPublication,
          l.PublishedPoints, p.PersonID, p.FullName
        FROM LISTED_IN l
        JOIN PERSON p ON p.PersonID=l.PersonID
        WHERE l.RankingPublicationID=%s
        ORDER BY l.PublishedDivision ASC, l.PublishedRank ASC
        LIMIT 200
    ''',(publication_id,))


def course_records(division='', city=''):
    return all_rows('''
        SELECT cr.CourseRecordID, cr.HolderNameAsPublished, cr.Division,
          cr.RecordTimeSeconds, cr.AchievementYear, cr.CountryAsPublished,
          cr.EvidenceURL, c.CourseLabel, c.StairCount, c.VerticalClimbMetres,
          v.VenueName, v.City, v.CountryCode
        FROM COURSE_RECORD cr
        JOIN COURSE c ON c.CourseID=cr.CourseID
        JOIN VENUE v ON v.VenueID=c.VenueID
        WHERE (%s='' OR cr.Division=%s)
          AND (%s='' OR v.City LIKE %s)
        ORDER BY v.VenueName, cr.Division, cr.RecordTimeSeconds
    ''',(division,division,city,f'%{city}%'))


def venue_directory(q=''):
    return all_rows('''
        SELECT v.VenueID, v.VenueName, v.City, v.CountryCode,
          COUNT(DISTINCT c.CourseID) AS Courses,
          COUNT(DISTINCT e.RaceEventID, e.OccurrenceNo) AS HostedEditions,
          MAX(c.StairCount) AS MaximumStairs
        FROM VENUE v
        LEFT JOIN COURSE c ON c.VenueID=v.VenueID
        LEFT JOIN RACE_EDITION e ON e.VenueID=v.VenueID
        WHERE (%s='' OR v.VenueName LIKE %s OR v.City LIKE %s)
        GROUP BY v.VenueID, v.VenueName, v.City, v.CountryCode
        ORDER BY v.City ASC, v.VenueName ASC
    ''',(q,f'%{q}%',f'%{q}%'))


def edit_choices():
    return (
        all_rows('SELECT RaceEventID, RaceName FROM RACE_EVENT ORDER BY RaceName'),
        all_rows('SELECT VenueID, VenueName, City FROM VENUE ORDER BY VenueName'),
    )


def draft_editions():
    return all_rows('''
        SELECT e.RaceEventID, e.OccurrenceNo, e.StartDate, e.EndDate,
          e.RaceFactor, e.AdditionalInformation, e.VenueID, r.RaceName
        FROM RACE_EDITION e JOIN RACE_EVENT r ON r.RaceEventID=e.RaceEventID
        WHERE e.EditionStatus='planned' AND e.WebsitePageURL IS NULL
          AND e.PublishedRaceCode IS NULL
        ORDER BY e.StartDate DESC, e.RaceEventID DESC
        LIMIT 40
    ''')


def create_draft(event_id, start_date, end_date, factor, venue_id, note):
    """Lock event row; assign partial weak-entity key atomically."""
    from db import connection
    conn=connection()
    try:
        with conn.cursor() as cur:
            cur.execute('SELECT RaceEventID FROM RACE_EVENT WHERE RaceEventID=%s FOR UPDATE',(event_id,))
            if not cur.fetchone(): raise ValueError('Select an existing race event.')
            cur.execute('SELECT COALESCE(MAX(OccurrenceNo),0)+1 AS NextNo FROM RACE_EDITION WHERE RaceEventID=%s',(event_id,))
            occurrence=cur.fetchone()['NextNo']
            cur.execute('''
                INSERT INTO RACE_EDITION
                  (RaceEventID, OccurrenceNo, StartDate, EndDate, RaceFactor,
                   VenueID, EditionStatus, AdditionalInformation)
                VALUES (%s,%s,%s,%s,%s,%s,'planned',%s)
            ''',(event_id,occurrence,start_date,end_date,factor,venue_id,note))
        conn.commit()
        return occurrence
    except Exception:
        conn.rollback()
        raise
    finally: conn.close()


def update_draft(event_id, occurrence, start_date, end_date, factor, venue_id, note):
    from db import connection
    conn=connection()
    try:
        with conn.cursor() as cur:
            cur.execute('''SELECT RaceEventID FROM RACE_EDITION
                WHERE RaceEventID=%s AND OccurrenceNo=%s
                  AND EditionStatus='planned' AND WebsitePageURL IS NULL
                  AND PublishedRaceCode IS NULL FOR UPDATE''',(event_id,occurrence))
            if not cur.fetchone(): raise ValueError('Only locally created draft editions can be edited.')
            for table in ('ACHIEVES_RESULT','RESULT_SUBMISSION'):
                cur.execute('SELECT 1 FROM '+table+' WHERE RaceEventID=%s AND OccurrenceNo=%s LIMIT 1',(event_id,occurrence))
                if cur.fetchone(): raise ValueError('Results or submissions protect this draft from editing.')

            cur.execute('''UPDATE RACE_EDITION SET StartDate=%s, EndDate=%s,
                RaceFactor=%s, VenueID=%s, AdditionalInformation=%s
                WHERE RaceEventID=%s AND OccurrenceNo=%s''',
                (start_date,end_date,factor,venue_id,note,event_id,occurrence))
        conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally: conn.close()


def delete_draft(event_id, occurrence):
    from db import connection
    conn=connection()
    try:
        with conn.cursor() as cur:
            cur.execute('''SELECT RaceEventID FROM RACE_EDITION
                WHERE RaceEventID=%s AND OccurrenceNo=%s
                  AND EditionStatus='planned' AND WebsitePageURL IS NULL
                  AND PublishedRaceCode IS NULL FOR UPDATE''',(event_id,occurrence))
            if not cur.fetchone(): raise ValueError('Published or source-backed editions cannot be deleted.')
            for table in ('ACHIEVES_RESULT','RESULT_SUBMISSION'):
                cur.execute('SELECT 1 FROM '+table+' WHERE RaceEventID=%s AND OccurrenceNo=%s LIMIT 1', (event_id,occurrence))
                if cur.fetchone(): raise ValueError('Results or submissions protect this draft.')
            cur.execute('SELECT 1 FROM RACE_EDITION WHERE PrevRaceEventID=%s AND PrevOccurrenceNo=%s LIMIT 1',(event_id,occurrence))
            if cur.fetchone(): raise ValueError('A retained predecessor link protects this draft.')
            cur.execute('DELETE FROM ASSISTS_EDITION_RESPONSIBILITY WHERE RaceEventID=%s AND OccurrenceNo=%s',(event_id,occurrence))
            for table in ('ASSISTS_EDITION','ORGANISES','INCLUDED_IN','OFFERS'):
                cur.execute('DELETE FROM '+table+' WHERE RaceEventID=%s AND OccurrenceNo=%s',(event_id,occurrence))
            cur.execute('''DELETE FROM RACE_EDITION
                WHERE RaceEventID=%s AND OccurrenceNo=%s''',(event_id,occurrence))
        conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally: conn.close()

# -------- Phase 1 functional-requirement retrievals and analysis --------

def high_factor_2025():
    """Original Phase 1 §3.1.1: selection (completed, 2025, factor >=200)."""
    return all_rows('''
        SELECT e.RaceEventID, e.OccurrenceNo, e.StartDate, e.RaceFactor,
          r.RaceName, v.City, e.EditionStatus
        FROM RACE_EDITION e
        JOIN RACE_EVENT r ON r.RaceEventID=e.RaceEventID
        LEFT JOIN VENUE v ON v.VenueID=e.VenueID
        WHERE e.EditionStatus='completed' AND e.RaceFactor>=200
          AND e.StartDate>='2025-01-01' AND e.StartDate<'2026-01-01'
        ORDER BY e.RaceFactor DESC, e.StartDate
    ''')


def young_athletes():
    """Original Phase 1 §3.1.2; no guessed birth dates in the source data."""
    return all_rows('''
        SELECT p.FullName, a.NationalityCode, a.DefaultCompetitionDivision, p.BirthDate
        FROM ATHLETE a JOIN PERSON p ON p.PersonID=a.PersonID
        WHERE p.BirthDate > '2000-12-31'
        ORDER BY p.FullName
    ''')


def empire_record_minimum():
    """Original Phase 1 §3.1.3(a): category-specific record minima."""
    return all_rows('''
        SELECT c.CourseLabel, cr.Division, cr.AgeGroupLabel,
          MIN(cr.RecordTimeSeconds) AS FastestSeconds,
          COUNT(*) AS Claims
        FROM COURSE_RECORD cr
        JOIN COURSE c ON c.CourseID=cr.CourseID
        JOIN VENUE v ON v.VenueID=c.VenueID
        WHERE v.VenueName='Empire State Building'
          AND cr.RecordTimeSeconds IS NOT NULL
        GROUP BY c.CourseID, c.CourseLabel, cr.Division, cr.AgeGroupLabel
        ORDER BY cr.Division, cr.AgeGroupLabel
    ''')


def climb_height_average():
    """Original Phase 1 §3.1.3(b): known, confirmed vertical climbs only."""
    return one('''
        SELECT AVG(c.VerticalClimbMetres) AS AverageHeightMetres,
          COUNT(*) AS KnownCourses
        FROM COURSE c
        WHERE c.ConfigurationStatus='confirmed' AND c.VerticalClimbMetres IS NOT NULL
    ''')


def ascent_speeds():
    """Original Phase 1 §3.2.1: verified finishes on >250m single climbs."""
    return all_rows('''
        SELECT p.FullName, a.NationalityCode, v.VenueName, v.City,
          COUNT(*) AS CompletedClimbs,
          ROUND(AVG(c.VerticalClimbMetres / ar.FinishingTimeSeconds),4) AS MeanAscentMps
        FROM ACHIEVES_RESULT ar
        JOIN ATHLETE a ON a.PersonID=ar.PersonID
        JOIN PERSON p ON p.PersonID=a.PersonID
        JOIN COURSE c ON c.CourseID=ar.CourseID
        JOIN VENUE v ON v.VenueID=c.VenueID
        WHERE ar.VerificationStatus='verified' AND ar.FinishStatus='finished'
          AND ar.FinishingTimeSeconds>0 AND c.VerticalClimbMetres>250
          AND c.RaceFormat='single climb'
        GROUP BY ar.PersonID, p.FullName, a.NationalityCode, v.VenueID, v.VenueName, v.City
        ORDER BY MeanAscentMps DESC, p.FullName
        LIMIT 60
    ''')


def scoring_audit():
    """Independent findings: unknown evidence is distinct from definite violations."""
    return all_rows('''
        SELECT e.RaceEventID,e.OccurrenceNo,r.RaceName,e.StartDate,e.RaceFactor,e.RankingDate,
          ss.VersionLabel,
          (SELECT GROUP_CONCAT(o.OrganisationName ORDER BY o.OrganisationName SEPARATOR ', ')
           FROM ORGANISES g JOIN ORGANISATION o USING(OrganisationID)
           WHERE g.RaceEventID=e.RaceEventID AND g.OccurrenceNo=e.OccurrenceNo) AS Organisers,
          CONCAT_WS('; ',
            IF(e.ScoringSchemeID IS NULL,'UNKNOWN: scheme assignment missing',NULL),
            IF(e.RaceFactor IS NULL,'UNKNOWN: race factor missing',NULL),
            IF(e.RankingDate IS NULL,'UNKNOWN: ranking date missing',NULL),
            IF(NOT EXISTS(SELECT 1 FROM ORGANISES g WHERE g.RaceEventID=e.RaceEventID AND g.OccurrenceNo=e.OccurrenceNo),'UNKNOWN: organiser not sourced',NULL),
            IF(e.ScoringSchemeID IS NOT NULL AND (ss.EffectiveFrom IS NULL OR ss.EffectiveUntil IS NULL),'UNKNOWN: scheme effective bounds incomplete',NULL),
            IF(e.ScoringSchemeID IS NOT NULL AND e.RaceFactor IS NOT NULL AND NOT EXISTS
              (SELECT 1 FROM SCORING_MATRIX_ENTRY m WHERE m.ScoringSchemeID=e.ScoringSchemeID AND m.Factor=e.RaceFactor),
              'COVERAGE GAP: assigned factor absent from stored matrix',NULL),
            IF(EXISTS(SELECT 1 FROM ACHIEVES_RESULT ar WHERE ar.RaceEventID=e.RaceEventID AND ar.OccurrenceNo=e.OccurrenceNo
              AND ar.OverallPlace IS NOT NULL AND e.ScoringSchemeID IS NOT NULL AND e.RaceFactor IS NOT NULL
              AND NOT EXISTS(SELECT 1 FROM SCORING_MATRIX_ENTRY m WHERE m.ScoringSchemeID=e.ScoringSchemeID
                AND m.Factor=e.RaceFactor AND ar.OverallPlace BETWEEN m.PlaceFrom AND m.PlaceTo)),
              'COVERAGE GAP: result place absent from stored matrix',NULL),
            IF(e.RankingDate<ss.EffectiveFrom,'VIOLATION: ranking date before scheme',NULL),
            IF(e.RankingDate>ss.EffectiveUntil,'VIOLATION: ranking date after scheme',NULL),
            IF(e.EvaluationStatus='approved' AND NOT EXISTS(SELECT 1 FROM OFFERS o WHERE o.RaceEventID=e.RaceEventID AND o.OccurrenceNo=e.OccurrenceNo AND o.EvaluationSelection='selected'),
              'VIOLATION: approved edition has no selected course',NULL),
            IF(NOT EXISTS(SELECT 1 FROM RESULT_SUBMISSION sub WHERE sub.RaceEventID=e.RaceEventID AND sub.OccurrenceNo=e.OccurrenceNo AND sub.SubmissionStatus='accepted' AND sub.CompleteAvailableOn IS NOT NULL),
              'UNKNOWN: complete accepted submission date unavailable',NULL),
            IF(EXISTS(SELECT 1 FROM RESULT_SUBMISSION sub WHERE sub.RaceEventID=e.RaceEventID AND sub.OccurrenceNo=e.OccurrenceNo AND sub.SubmissionStatus='accepted')
               AND NOT EXISTS(SELECT 1 FROM RESULT_SUBMISSION sub WHERE sub.RaceEventID=e.RaceEventID AND sub.OccurrenceNo=e.OccurrenceNo AND sub.SubmissionStatus='accepted' AND sub.CompleteAvailableOn IS NULL)
               AND (SELECT MIN(sub.CompleteAvailableOn) FROM RESULT_SUBMISSION sub WHERE sub.RaceEventID=e.RaceEventID AND sub.OccurrenceNo=e.OccurrenceNo AND sub.SubmissionStatus='accepted') > DATE_ADD(COALESCE(e.EndDate,e.StartDate),INTERVAL 7 DAY),
              'VIOLATION: earliest known complete submission over seven days late',NULL)
          ) AS AuditStatus
        FROM RACE_EDITION e JOIN RACE_EVENT r USING(RaceEventID)
        LEFT JOIN SCORING_SCHEME ss ON ss.ScoringSchemeID=e.ScoringSchemeID
        WHERE e.EditionStatus='completed' ORDER BY e.StartDate DESC,e.RaceEventID
    ''')


def nations_published(publication_id):
    return all_rows('''SELECT CountryCode,PublishedRank,PublishedPoints FROM NATIONS_STANDING
        WHERE RankingPublicationID=%s ORDER BY PublishedRank,CountryCode''',(publication_id,))


def nations_reconstruction(start, end, method='pointbest'):
    """Separate sourced point-best/fastest methods. Best eight COUNTRY race totals.
    Dates supplied by caller are explicitly exploratory unless publication confirms them.
    Do not require athlete registration: Nations Cup includes unregistered athletes.
    """
    if method not in ('pointbest','fastest'):
        raise ValueError('Unknown Nations Cup rule variant.')
    return all_rows('''
      WITH eligible AS (
        SELECT ar.RaceEventID,ar.OccurrenceNo,ar.PersonID,ar.CompetitionDivision,
          ar.CountryAtRace,MAX(ar.Points) AS Points,MAX(ar.FinishingTimeSeconds) AS FinishingTimeSeconds
        FROM ACHIEVES_RESULT ar
        JOIN RACE_EDITION e USING(RaceEventID,OccurrenceNo)
        JOIN OFFERS o USING(RaceEventID,OccurrenceNo,CourseID)
        WHERE e.EditionStatus='completed' AND e.EvaluationStatus='approved'
          AND e.RankingDate BETWEEN %s AND %s AND o.EvaluationSelection='selected'
          AND ar.VerificationStatus='verified' AND ar.FinishStatus='finished'
          AND ar.DisputeStatus IN ('none','rejected') AND ar.Points IS NOT NULL
          AND ar.CountryAtRace IS NOT NULL AND ar.CountryAtRace<>''
          AND ar.CompetitionDivision IN ('Male','Female')
        GROUP BY ar.RaceEventID,ar.OccurrenceNo,ar.PersonID,ar.CompetitionDivision,ar.CountryAtRace
        HAVING COUNT(*)=1
      ), time_complete AS (
        SELECT RaceEventID,OccurrenceNo,CountryAtRace,CompetitionDivision
        FROM eligible GROUP BY RaceEventID,OccurrenceNo,CountryAtRace,CompetitionDivision
        HAVING COUNT(*)=COUNT(FinishingTimeSeconds) AND COUNT(*)=COUNT(DISTINCT FinishingTimeSeconds)
      ), performances AS (
        SELECT e.*,ROW_NUMBER() OVER(PARTITION BY e.RaceEventID,e.OccurrenceNo,e.CountryAtRace,e.CompetitionDivision
          ORDER BY CASE WHEN %s='fastest' THEN e.FinishingTimeSeconds ELSE -e.Points END,e.PersonID) AS slot
        FROM eligible e
        WHERE %s='pointbest' OR EXISTS(SELECT 1 FROM time_complete t WHERE t.RaceEventID=e.RaceEventID AND t.OccurrenceNo=e.OccurrenceNo AND t.CountryAtRace=e.CountryAtRace AND t.CompetitionDivision=e.CompetitionDivision)
      ), races AS (
        SELECT CountryAtRace,RaceEventID,OccurrenceNo,SUM(Points) AS RacePoints,
          COUNT(*) AS Contributions FROM performances WHERE slot<=2
        GROUP BY CountryAtRace,RaceEventID,OccurrenceNo
      ), best AS (
        SELECT *,ROW_NUMBER() OVER(PARTITION BY CountryAtRace ORDER BY RacePoints DESC,RaceEventID,OccurrenceNo) AS slot
        FROM races
      )
      SELECT CountryAtRace,SUM(IF(slot<=8,RacePoints,0)) AS ProvisionalPoints,
        COUNT(*) AS EligibleRaces,SUM(IF(slot<=8,1,0)) AS CountedRaces,
        SUM(IF(slot<=8,Contributions,0)) AS Contributions
      FROM best GROUP BY CountryAtRace ORDER BY ProvisionalPoints DESC,CountryAtRace
    ''',(start,end,method,method))


def membership_choices():
    return all_rows('''
        SELECT a.PersonID, p.FullName, a.TWAAthleteID
        FROM REGISTERED_ATHLETE a JOIN PERSON p ON p.PersonID=a.PersonID
        ORDER BY p.FullName
    ''')


def recent_memberships():
    return all_rows('''
        SELECT m.PersonID, m.MembershipYear, m.ConfirmationStatus,
          m.ValidFrom, m.ValidUntil, p.FullName, a.TWAAthleteID
        FROM ANNUAL_MEMBERSHIP m
        JOIN REGISTERED_ATHLETE a ON a.PersonID=m.PersonID
        JOIN PERSON p ON p.PersonID=m.PersonID
        ORDER BY m.MembershipYear DESC, p.FullName
        LIMIT 30
    ''')


def create_membership(person_id, year, valid_from, valid_until):
    """Original Phase 1 §3.3(a). Record pending, never imply fee payment."""
    from datetime import date
    valid_from=date.fromisoformat(str(valid_from))
    valid_until=date.fromisoformat(str(valid_until))
    if not 2000<=year<=2100 or valid_from.year!=year or valid_until<valid_from:
        raise ValueError('Membership year and validity dates are inconsistent.')
    from db import connection
    conn=connection()
    try:
        with conn.cursor() as cur:
            cur.execute('''
                INSERT INTO ANNUAL_MEMBERSHIP
                  (PersonID, MembershipYear, ValidFrom, ValidUntil, ConfirmationStatus)
                VALUES (%s,%s,%s,%s,'pending')
            ''',(person_id,year,valid_from,valid_until))
        conn.commit()
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()


# All multi-row management operations share one commit/rollback boundary.
def management_write(operation):
    from db import connection
    conn = connection()
    try:
        with conn.cursor() as cur:
            result = operation(cur)
        conn.commit()
        return result
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()


def correct_course(course_id, stairs=None, height=None, same_route=False):
    from decimal import Decimal
    if not same_route:
        raise ValueError('A changed physical route requires a new CourseID.')
    if stairs is None and height is None:
        raise ValueError('Enter at least one corrected measurement.')
    if stairs is not None and (not isinstance(stairs, int) or stairs <= 0):
        raise ValueError('Stair count must be a positive integer.')
    if height is not None and (not Decimal(str(height)).is_finite() or height <= 0):
        raise ValueError('Vertical climb must be positive and finite.')
    def operation(cur):
        cur.execute('SELECT CourseID FROM COURSE WHERE CourseID=%s FOR UPDATE', (course_id,))
        if not cur.fetchone():
            raise ValueError('Course does not exist.')
        cur.execute("""UPDATE COURSE SET StairCount=COALESCE(%s,StairCount),
            VerticalClimbMetres=COALESCE(%s,VerticalClimbMetres),
            ConfigurationStatus='incomplete' WHERE CourseID=%s""", (stairs,height,course_id))
        cur.execute("""UPDATE OFFERS o JOIN RACE_EDITION e
            ON e.RaceEventID=o.RaceEventID AND e.OccurrenceNo=o.OccurrenceNo
            SET o.EvaluationSelection='pending'
            WHERE o.CourseID=%s AND e.EditionStatus IN ('planned','postponed')""", (course_id,))
    management_write(operation)


def cancel_edition(event_id, occurrence):
    def operation(cur):
        key=(event_id,occurrence)
        cur.execute('SELECT EditionStatus FROM RACE_EDITION WHERE RaceEventID=%s AND OccurrenceNo=%s FOR UPDATE',key)
        row=cur.fetchone()
        if not row or row['EditionStatus'] not in ('planned','postponed','cancelled'):
            raise ValueError('Only planned or postponed editions can be cancelled.')
        cur.execute("""SELECT PersonID FROM ACHIEVES_RESULT WHERE RaceEventID=%s
            AND OccurrenceNo=%s AND VerificationStatus='verified' LIMIT 1 FOR UPDATE""",key)
        if cur.fetchone():
            raise ValueError('Verified historical results protect this edition.')
        cur.execute("SELECT 1 FROM RESULT_SUBMISSION WHERE RaceEventID=%s AND OccurrenceNo=%s AND SubmissionStatus='accepted' LIMIT 1 FOR UPDATE",key)
        if cur.fetchone():
            raise ValueError('Accepted historical evidence protects this edition from local cancellation.')
        cur.execute('DELETE p FROM ADDITIONAL_PLACING p JOIN ACHIEVES_RESULT ar USING(RaceEventID,OccurrenceNo,CourseID,PersonID) WHERE ar.RaceEventID=%s AND ar.OccurrenceNo=%s AND (ar.VerificationStatus IS NULL OR ar.VerificationStatus<>"verified")',key)
        cur.execute("UPDATE RACE_EDITION SET EditionStatus='cancelled', EvaluationStatus='not evaluated' WHERE RaceEventID=%s AND OccurrenceNo=%s",key)
        cur.execute("UPDATE OFFERS SET EvaluationSelection='not selected' WHERE RaceEventID=%s AND OccurrenceNo=%s",key)
        cur.execute("UPDATE RESULT_SUBMISSION SET SubmissionStatus='rejected' WHERE RaceEventID=%s AND OccurrenceNo=%s AND SubmissionStatus='pending'",key)
        cur.execute("""UPDATE ACHIEVES_RESULT SET VerificationStatus='withdrawn',OverallPlace=NULL,Points=NULL
            WHERE RaceEventID=%s AND OccurrenceNo=%s AND (VerificationStatus IS NULL OR VerificationStatus<>'verified')""",key)
        cur.execute("""UPDATE INCLUDED_IN SET InclusionNote=CONCAT_WS('\n',NULLIF(InclusionNote,''),'[Local cancellation] Edition cancelled.')
            WHERE RaceEventID=%s AND OccurrenceNo=%s
            AND LOCATE('[Local cancellation] Edition cancelled.',COALESCE(InclusionNote,''))=0""",key)
    management_write(operation)


def insert_result(event_id, occurrence, course_id, person_id, seconds=None, place=None, points=None, division=None, country=None, finish_status='finished'):
    from decimal import Decimal
    for value, label, positive in ((seconds,'Time',True),(points,'Points',False)):
        if value is not None and (not Decimal(str(value)).is_finite() or value<0 or (positive and value==0)):
            raise ValueError(label+' is outside its permitted range.')
    if place is not None and place<=0:
        raise ValueError('Place must be positive.')
    import re
    if division not in (None,'Male','Female','Open'):
        raise ValueError('Choose a valid competition division.')
    if country is not None and not re.fullmatch('[A-Z]{3}',country):
        raise ValueError('Country must be a three-letter source country code.')
    if finish_status not in ('finished','did not finish','did not start','disqualified','unknown'):
        raise ValueError('Choose a valid finish status.')
    if finish_status!='finished' and (place is not None or points is not None):
        raise ValueError('Non-finished results cannot retain placement or points.')

    def operation(cur):
        cur.execute('SELECT EditionStatus FROM RACE_EDITION WHERE RaceEventID=%s AND OccurrenceNo=%s FOR UPDATE',(event_id,occurrence))
        edition=cur.fetchone()
        if not edition or edition['EditionStatus']=='cancelled':
            raise ValueError('Select an existing, non-cancelled edition.')
        cur.execute("""INSERT INTO ACHIEVES_RESULT
            (RaceEventID,OccurrenceNo,CourseID,PersonID,FinishingTimeSeconds,OverallPlace,Points,CompetitionDivision,CountryAtRace,FinishStatus,VerificationStatus)
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,'unverified')""",
            (event_id,occurrence,course_id,person_id,seconds,place,points,division,country,finish_status))
    management_write(operation)


def disqualify_result(event_id, occurrence, course_id, person_id, submission_no=None, source_row_no=None):
    """Invalidate one result only after a reviewed official upheld decision.
    Preserve source rows, other athletes' places and all published ranking releases.
    Reject affected persisted draft standings rather than inventing regrading rules.
    """
    import json
    from urllib.parse import urlparse
    def operation(cur):
        key=(event_id,occurrence,course_id,person_id)
        # Edition lock follows insertion/cancellation lock order.
        cur.execute('SELECT EditionStatus FROM RACE_EDITION WHERE RaceEventID=%s AND OccurrenceNo=%s FOR UPDATE',(event_id,occurrence))
        cur.fetchone()
        cur.execute('SELECT * FROM ACHIEVES_RESULT WHERE RaceEventID=%s AND OccurrenceNo=%s AND CourseID=%s AND PersonID=%s FOR UPDATE',key)
        result=cur.fetchone()
        if not result:
            raise ValueError('Result does not exist.')
        if submission_no is None or source_row_no is None:
            raise ValueError('Disqualification requires an accepted, verified official upheld-decision source row. No changes made.')
        cur.execute('''SELECT s.SourceURL,s.CheckStatus,s.SubmissionStatus,s.SubmissionKind,
            r.ResultStatus,r.RawRowText FROM RESULT_SUBMISSION s JOIN SOURCE_ROW r
            USING(RaceEventID,OccurrenceNo,SubmissionNo)
            WHERE s.RaceEventID=%s AND s.OccurrenceNo=%s AND s.SubmissionNo=%s AND r.SourceRowNo=%s FOR UPDATE''',
            (event_id,occurrence,submission_no,source_row_no))
        evidence=cur.fetchone()
        if not evidence or evidence['CheckStatus']!='verified' or evidence['SubmissionStatus']!='accepted' or evidence['SubmissionKind']!='disqualification decision' or evidence['ResultStatus']!='upheld':
            raise ValueError('The decision must already be accepted, verified and upheld by evidence review.')
        parsed=urlparse(evidence['SourceURL'] or '')
        if parsed.scheme!='https' or parsed.hostname not in ('www.towerrunning.com','towerrunning.com'):
            raise ValueError('An official HTTPS decision citation is required.')
        try:
            target=json.loads(evidence['RawRowText'])
        except (TypeError,ValueError):
            raise ValueError('Decision metadata does not identify the target result.')
        if not isinstance(target,dict) or target.get('PersonID')!=person_id or target.get('CourseID')!=course_id or target.get('Decision')!='upheld disqualification':
            raise ValueError('The verified decision does not match this athlete and course.')
        if result['VerificationStatus']!='verified':
            raise ValueError('Only a verified canonical result can enter this workflow.')
        cur.execute('''SELECT 1 FROM LISTED_IN l JOIN RANKING_PUBLICATION p USING(RankingPublicationID)
            WHERE l.PersonID=%s AND (p.PublicationStatus IS NULL OR p.PublicationStatus<>'published') LIMIT 1''',(person_id,))
        if cur.fetchone():
            raise ValueError('Dependent draft athlete standings require verified recalculation rules first.')
        cur.execute('''SELECT 1 FROM NATIONS_STANDING n JOIN RANKING_PUBLICATION p USING(RankingPublicationID)
            WHERE n.CountryCode=%s AND (p.PublicationStatus IS NULL OR p.PublicationStatus<>'published') LIMIT 1''',(result['CountryAtRace'],))
        if cur.fetchone():
            raise ValueError('Dependent draft country standings require verified recalculation rules first.')
        cur.execute('DELETE FROM ADDITIONAL_PLACING WHERE RaceEventID=%s AND OccurrenceNo=%s AND CourseID=%s AND PersonID=%s',key)
        cur.execute('''UPDATE ACHIEVES_RESULT SET FinishStatus='disqualified',DisputeStatus='upheld',OverallPlace=NULL,Points=NULL
            WHERE RaceEventID=%s AND OccurrenceNo=%s AND CourseID=%s AND PersonID=%s''',key)
    management_write(operation)
