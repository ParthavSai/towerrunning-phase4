# Design Changes — Phase 3 Stage D to Phase 4

**Phase 2 team number:** MUST CONFIRM (Phase 2 PDF title “NotSQL”; original Phase 1 team 70 stated there).  
**Phase 3 team number:** 57.  
**Submission team number:** MUST CONFIRM before naming ZIP and MP4.

No conceptual redesign was undertaken. The final Stage D relation **FORM(FormURL, FormType)** is retained, including RESULT_SUBMISSION.FormURL as a foreign key. The 29 original Stage A relations become 30 after this normalization.

| Item | Implementation change / choice | Reason |
|---|---|---|
| All relations | MySQL 8 InnoDB tables, named PK, FK, `NOT NULL`, `UNIQUE`, domain `CHECK` constraints | Translates the relational model into enforceable schema |
| Entity keys | Existing Phase 3 keys and composite weak-entity primary keys preserved | Maintains identity and ownership semantics |
| `FORM.FormURL` | `VARCHAR(512)` primary key, `RESULT_SUBMISSION.FormURL` same length | MySQL `utf8mb4` max index length; unrestricted 1024-character PK can exceed 3072-byte index cap |
| Multiple page URLs | `VARCHAR(1024)` **non-key** values, where applicable | Source fidelity without over-long index keys |
| `ACHIEVES_RESULT` | Extra composite FK `(RaceEventID,OccurrenceNo,CourseID)` referencing OFFERS | Enforces ternary result => offered course relation from Phase 3 |
| `ACHIEVES_RESULT` | `(RaceEventID,OccurrenceNo,SubmissionNo,SourceRowNo)` FK to SOURCE_ROW | Preserves the source-citation mapping adopted in Phase 3; NULL pair used if an independently verified official source URL is cited |
| `RACE_EDITION` | `PrevRaceEventID`, `PrevOccurrenceNo` self-FK, uniqueness, domain checks and cycle triggers | Implements PREVIOUS_EDITION constraints |
| `OFFERS` | Insert/update venue agreement triggers; `RACE_EDITION` update checks venue consistency | Prevents course/venue conflicts |
| `LISTED_IN`, `NATIONS_STANDING` | Update/delete guard triggers when publication already marked published | Prevents alterations to already published ranking rows |
| Missing external facts | Nullable attributes rather than synthetic values | Official race pages have missing times, birth dates, ranking windows and registrations |
| Local write demo | Only editions without a source URL or published race code can be changed/deleted in UI | Prevents accidental modification of imported source-backed rows |
| `ANNUAL_MEMBERSHIP` | Additional UI insert for a pending membership | Demonstrates weak-entity FK/PK integrity with no invented payment data |
| Python application | Raw SQL functions via PyMySQL, secure placeholders and server-rendered Jinja | Phase 4 required stack with no ORM/query builder |

**Remaining limitations, not silently resolved:** Full scoring matrix domain/non-overlap enforcement; source-row immutability; verified source-row matching; nuanced cancel/disqualify workflows; Nations Cup rules and complete publication data. These require verified evidence or additional transactions and must not be represented as complete. See `FUNCTIONAL_COVERAGE.md`.

### Management completion additions

- No new relations or attributes. Added non-destructive triggers for cancelled results, accepted citation submissions, matrix non-overlap and published ranking-header immutability.
- Added transactional application workflows for same-route measurement correction and cancellation. Completed edition selections are preserved; course measurements remain shared metadata in the supplied Stage D model.
- Added canonical result entry restricted to local unverified records. Official verification is deliberately unavailable without an evidence-review workflow.
- Disqualification processes only pre-reviewed accepted official decisions in existing submission/source relations; absent evidence or dependent draft standings causes rejection. No automatic regrading is invented.
- Draft deletion now explicitly checks protected result/submission/predecessor dependencies and cleans permitted relationship rows atomically.

### Reviewed disqualification metadata

The existing RESULT_SUBMISSION must have SubmissionKind `disqualification decision`, CheckStatus `verified`, SubmissionStatus `accepted`, and an official `https://www.towerrunning.com/...` citation. Its SOURCE_ROW has ResultStatus `upheld` and RawRowText JSON with integer `PersonID`, integer `CourseID`, and `Decision: "upheld disqualification"`. The parent identifies the edition. This metadata is a reviewed evidence index, not authentication inferred from an arbitrary URL. Evidence acceptance/check status must be established by a trusted reviewer outside the public form. No such production decisions were fabricated.

The operation preserves canonical original citation fields. The separate accepted decision row records the ruling. Accepted decision submissions and rows are immutable. If draft individual/country standings depend on the athlete/country, the operation rejects instead of inventing recalculation rules. Other athletes' stored places are never shifted automatically. Real-SQL tests use explicitly isolated artificial evidence to verify success, wrong-target rejection and rollback after placing deletion.
