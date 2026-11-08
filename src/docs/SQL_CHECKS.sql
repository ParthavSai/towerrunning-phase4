USE towerrunning_phase4;
SELECT VERSION() AS MySQLVersion;
SELECT COUNT(*) AS ActualTableCount FROM information_schema.TABLES
 WHERE TABLE_SCHEMA='towerrunning_phase4' AND TABLE_TYPE='BASE TABLE';
SELECT COUNT(*) AS ForeignKeyCount FROM information_schema.TABLE_CONSTRAINTS
 WHERE TABLE_SCHEMA='towerrunning_phase4' AND CONSTRAINT_TYPE='FOREIGN KEY';
SELECT COUNT(*) AS TriggerCount FROM information_schema.TRIGGERS
 WHERE TRIGGER_SCHEMA='towerrunning_phase4';
SELECT 'Race events' AS Type, COUNT(*) AS RowsFound FROM RACE_EVENT
UNION ALL SELECT 'Race editions',COUNT(*) FROM RACE_EDITION
UNION ALL SELECT 'Registered athletes',COUNT(*) FROM REGISTERED_ATHLETE
UNION ALL SELECT 'Results',COUNT(*) FROM ACHIEVES_RESULT
UNION ALL SELECT 'Venues',COUNT(*) FROM VENUE
UNION ALL SELECT 'Courses',COUNT(*) FROM COURSE
UNION ALL SELECT 'Explicit records',COUNT(*) FROM COURSE_RECORD;
-- The selected original Phase 1 high-factor 2025 requirement:
SELECT e.RaceEventID,e.OccurrenceNo,r.RaceName,e.RaceFactor,e.StartDate
 FROM RACE_EDITION e JOIN RACE_EVENT r ON r.RaceEventID=e.RaceEventID
 WHERE e.EditionStatus='completed' AND e.StartDate BETWEEN '2025-01-01' AND '2025-12-31'
   AND e.RaceFactor>=200 ORDER BY e.RaceFactor DESC,e.StartDate;
-- Confirm real timed 2025 Taipei results were imported:
SELECT p.FullName,a.FinishingTimeSeconds,a.Points
 FROM ACHIEVES_RESULT a JOIN PERSON p ON p.PersonID=a.PersonID
 JOIN RACE_EVENT r ON r.RaceEventID=a.RaceEventID
 JOIN RACE_EDITION e ON e.RaceEventID=a.RaceEventID AND e.OccurrenceNo=a.OccurrenceNo
 WHERE r.RaceName='Taipei 101 Run Up' AND e.StartDate='2025-05-03'
 ORDER BY a.CompetitionDivision,a.OverallPlace;
-- No result may point to an unavailable edition/course pair:
SELECT COUNT(*) AS OrphanedResults FROM ACHIEVES_RESULT a
 LEFT JOIN OFFERS o ON o.RaceEventID=a.RaceEventID AND o.OccurrenceNo=a.OccurrenceNo AND o.CourseID=a.CourseID
 WHERE o.CourseID IS NULL;
-- No offered course should contradict known edition venue:
SELECT COUNT(*) AS VenueMismatches FROM OFFERS o
 JOIN RACE_EDITION e ON e.RaceEventID=o.RaceEventID AND e.OccurrenceNo=o.OccurrenceNo
 JOIN COURSE c ON c.CourseID=o.CourseID
 WHERE e.VenueID IS NOT NULL AND e.VenueID<>c.VenueID;
