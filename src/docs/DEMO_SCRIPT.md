# Recording script — maximum 10 minutes

Follow the 19 numbered README features in this order. Keep the browser and MySQL terminal visible or switch clearly. Never display `.env`, credentials, private backups or shell history. Use an isolated demo database for all writes.

## Safe preparation

```bash
source .venv/bin/activate
python src/tools/prepare_demo.py
# Copy the printed database name and identifiers.
DB_NAME=towerrunning_demo_PRINTED_NAME python src/app.py
mysql -u YOUR_USER -p
```

In MySQL, `USE` the printed demo database. This has the same official seed plus two clearly labelled local draft fixtures. It never changes development. The helper prints course C, athlete P, event E, result occurrence R and cancellation occurrence X. Replace these letters with the printed integer values in the statements below. They are placeholders, not SQL variables. Use a year not already used for the membership demo (2027 initially).

## Timing and browser actions

| Time | README features | Actions |
|---|---|---|
| 0:00–0:35 | 1 | Home branding/navigation, counts; show database SELECT below to establish connection |
| 0:35–1:15 | 2–5 | Search SKY; filter year/factor; open race/division results, athlete directory and history |
| 1:15–1:50 | 6–9 | Points sample caveat; open imported final-2025 individual release; records and venue search |
| 1:50–2:45 | 10 | Insights: selection, projection NULL empty state, record grouping, course AVG, ascent speeds, independent scoring findings |
| 2:45–3:25 | 11 | Nations published 2025 then 2019/2026; explicitly choose exploratory window and each historical method; explain strict empty seed calculation and published/provisional separation |
| 3:25–4:40 | 12–14 | Same SQL before/after draft CREATE, UPDATE, DELETE through Manage; show source parent survives |
| 4:40–5:10 | 15 | Same membership SQL before/after pending insertion; repeat to show duplicate rejection |
| 5:10–6:00 | 16 | Same course/offer SQL before/after correction in demo DB; confirm same route; show incomplete and future pending, historical selection preserved |
| 6:00–6:45 | 17 | Same cancellation SQL before/after cancelling X, with browser confirmation; show not evaluated/not selected |
| 6:45–7:35 | 18 | Same result SQL before/after unverified insertion into R; repeat to show duplicate rejection; cancelled X insertion rejects |
| 7:35–8:20 | 19 | Attempt disqualification without accepted official evidence; show rejection and unchanged SQL; explain successful isolated workflow test and why no actual ruling is fabricated |
| 8:20–9:20 | Verification | Show LIVE_MYSQL tests, migration comparison, FK/table/trigger checks and README setup; explain source limitations/manual video/team steps |

Allow up to 40 seconds slack; stop before 10:00. Do not read every spreadsheet row aloud. Empty known-birthdate/reconstruction outputs are valid evidence of excluding unsupported facts, not missing buttons.

## Exact SQL before and after each UI operation

Connection/seed check:

```sql
SELECT DATABASE(), VERSION();
SELECT COUNT(*) AS races FROM RACE_EVENT;
SELECT COUNT(*) AS results FROM ACHIEVES_RESULT;
SELECT COUNT(*) AS published_countries FROM NATIONS_STANDING;
```

CREATE/UPDATE/DELETE: reuse the **same** statement for each before/after. Use the printed existing event E in the form and SQL. Choose dates 2028-04-01, factor 80, note `RECORDING CRUD DRAFT`; edit factor to 120, then delete this same new draft. Do not delete R or X.

```sql
SELECT RaceEventID,OccurrenceNo,StartDate,EndDate,RaceFactor,EditionStatus,AdditionalInformation
FROM RACE_EDITION WHERE RaceEventID=E ORDER BY OccurrenceNo;
```

Membership: choose athlete P and 2027-01-01 through 2027-12-31. Reuse:

```sql
SELECT PersonID,MembershipYear,ConfirmationStatus,AmountPaid,Currency,PaymentConfirmedOn
FROM ANNUAL_MEMBERSHIP WHERE PersonID=P AND MembershipYear=2027;
```

Course: correct C to 1234 stairs and 321.25 metres **in the isolated database only**. Reuse both:

```sql
SELECT CourseID,StairCount,VerticalClimbMetres,ConfigurationStatus FROM COURSE WHERE CourseID=C;
SELECT o.RaceEventID,o.OccurrenceNo,e.EditionStatus,o.EvaluationSelection
FROM OFFERS o JOIN RACE_EDITION e USING(RaceEventID,OccurrenceNo)
WHERE o.CourseID=C ORDER BY o.RaceEventID,o.OccurrenceNo;
```

Cancellation of E/X: reuse:

```sql
SELECT RaceEventID,OccurrenceNo,EditionStatus,EvaluationStatus
FROM RACE_EDITION WHERE RaceEventID=E AND OccurrenceNo=X;
SELECT CourseID,EvaluationSelection FROM OFFERS WHERE RaceEventID=E AND OccurrenceNo=X;
SELECT SubmissionNo,SubmissionStatus FROM RESULT_SUBMISSION WHERE RaceEventID=E AND OccurrenceNo=X;
```

Result insertion into E/R with course C and athlete P: 400 seconds, place 1, points 10, explicit division if sourced (otherwise Unknown), finished. The entry is a **local demonstration fixture**, not an official historical performance. Reuse before/after insertion, duplicate attempt and disqualification rejection:

```sql
SELECT RaceEventID,OccurrenceNo,CourseID,PersonID,FinishStatus,VerificationStatus,
       DisputeStatus,FinishingTimeSeconds,OverallPlace,Points,SourceURL
FROM ACHIEVES_RESULT WHERE RaceEventID=E AND OccurrenceNo=R AND CourseID=C AND PersonID=P;
```

For disqualification, use decision identifiers that do not exist (for example 999999/999999). Show the explicit evidence validation rejection. Do not create a fictitious production decision to obtain a successful screen recording. The isolated test suite verifies actual success and rollback with labelled artificial fixtures.

Integrity:

```sql
SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_TYPE='BASE TABLE';
SELECT COUNT(*) FROM information_schema.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA=DATABASE();
SELECT TRIGGER_NAME FROM information_schema.TRIGGERS WHERE TRIGGER_SCHEMA=DATABASE() ORDER BY TRIGGER_NAME;
SELECT RankingPublicationID,CountryCode,PublishedRank,PublishedPoints
FROM NATIONS_STANDING WHERE RankingPublicationID=202512 ORDER BY PublishedRank LIMIT 5;
```

After recording, stop the demo app and drop **only the printed demo database** if no longer needed. Start the ordinary app with no DB_NAME override to return to development. Confirm the team number, export a real `<team_number>.mp4` under ten minutes, and use `tools/package_submission.py` to make the final archive.
