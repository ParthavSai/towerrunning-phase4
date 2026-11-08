# Final Phase 4 evidence audit

Reference: `read/Phase4_DnA26.pdf`, reread during continuation. Stage D in the complete root `phase3.pdf` remains the model baseline. This file replaces earlier provisional coverage matrices.

| Requirement | Evidence / outcome |
|---|---|
| Relational DBMS, separate schema/population | MySQL 8.4.9; actual scripts imported into isolated databases repeatedly |
| Fresh schema drops/recreates/selects database | Implemented as required; never executed over development DB |
| Stage D mapping/types/keys/FKs | 30 tables, 36 FKs; FORM normalization preserved; checks, composite keys, unique keys/indexes retained |
| Referential/cross-entity integrity | Offered-pair FK; offer/edition/course venue agreement; predecessor same-event/cycle guards; source citation acceptance; overlap and published-release/evidence guards |
| Existing installation compatibility | Migration compares actual definitions via information_schema/SHOW CREATE; missing/stale definitions repaired; repeated migration no-op tested; private dump backup before changes and isolated restore verified |
| Coherent substantial official data | 40 events, 45 editions, 109 results, 84 registered athletes retained; 186 published Nations rows, 124 matched individual standings, 215 base matrix entries added from checksummed original files |
| Repeatable seed | Supplemental official SQL included in populate.sql; builder preserves it; isolated import verifies it |
| Python backend/native driver/raw SQL | Flask + PyMySQL, centralized SQL; input parameters bound separately; no ORM/query builder |
| Five-plus reads/all Phase 1 read categories | All seven basic reports/search implemented and demonstrated by seed/fixture tests; Nations variants implemented separately, with published/provisional views |
| SQL selection/projection/grouping | Known seed high-factor selection and record minima asserted; NULL birthdays excluded; course averages and ascent speed execute in SQL |
| Scoring compliance | Independent UNKNOWN, COVERAGE GAP and known VIOLATION findings; scheme/factor/organiser/date/matrix/result-place/submission checks. Unknown scheme coverage is not asserted to prove a real-world breach |
| Nations historical calculations | Separate point-best and fastest modes; two per country/division/race, best eight country race totals; approved/verified/selected/date scope in SQL; exact 400 versus 136 fixture scores prove methods differ |
| Exact official Nations reconstruction | Evidence-limited: complete eligible results, confirmed publication cutoff/window and historical applicability are missing. No exact official reconstruction claim; imported published standings remain separate and immutable |
| INSERT result | UI and SQL: existing athlete/offered pair, cancellation/uniqueness/domains, division/country/finish status, unverified-only, default dispute none; nonfinished placement/points rejected |
| Verification evidence | Public entry cannot self-verify. Accepted cited submissions enforced. Matching/suitability is a trusted review responsibility; no public arbitrary evidence acceptance provided |
| INSERT membership | Existing registered owner, athlete/year key, valid year/ordered dates, pending-only. Amount/currency/payment remain NULL, never falsely confirmed |
| UPDATE course | Atomic same-route correction, positive finite measurements, incomplete status, future pending selections; completed historical selections unchanged; injected failure rolls back all statements |
| UPDATE cancellation | Atomic status/evaluation/offers/submissions/withdrawal/placing/note changes; verified/completed/accepted-source protection; repeated note deduplicated; failure rollback tested |
| UPDATE disqualification | Successful evidence-gated transaction tested; clears own place/points/additional placings, preserves original evidence/published releases/others. Wrong/missing decisions and dependent draft standings rejected. No unsupported regrading |
| DELETE draft | Local planned draft restriction, dependent results/submissions/predecessor rejection, permitted relationship cleanup; UI create/update/delete exercised against real SQL |
| Natural UI reachability | All 19 README features have pages/forms; no raw query textbox |
| Validation/errors/security | CSRF on every POST; parameterized SQL and injection tests; generic DB errors avoid credentials/SQL details in browser; localhost binding |
| Frontend/branding | Existing Montserrat/navy/colorful design preserved; report wrapping/checkbox/mobile form readability improved; 14 browser pages at 1440 and 390 pixels checked, no document overflow or JS exceptions |
| Local run/complete source | Flask startup documented; dependencies/templates/static/helpers under src; no deployment required |
| README requirements | Paradigm/version/stack/setup/environment/URL/design changes/numbered feature URLs/actions/video order documented |
| Team handover information | Phase 3 Team 57 verified; Phase 1 Team 70 verified; numeric Phase 2 authors/current submission team require course allocation evidence |
| Demo recording | Script and exact before/after SQL prepared; real <=10-minute recording must be made manually |
| ZIP layout | Packaging helper produces only team MP4, phase3.pdf, README.md and src at root; excludes secrets/caches/backups/read/archives; video validity/duration checked with ffprobe |

## Evidence boundaries

The matrix has participant-count adjustments and a participation footnote beyond the imported base entries. Stage D cannot represent that participant dimension; the app neither assigns the base scheme to historical editions nor recalculates official scores from it. This is documented rather than silently flattening rules.

No actual upheld decision exists in the production seed. Success tests use labelled isolated fixtures; the production UI correctly rejects unsupported disqualification. Authenticated evidence review must happen outside this trusted-local public form. Dependent draft standings require verified calculation rules before disqualification can proceed.

A complete official Nations reproduction is limited by source coverage, not by an assertion that downloadable official files are unavailable. Those files were downloaded and published totals ingested. The remaining missing facts are exact windows, historical applicability and complete approved athlete-level performances (including unregistered athletes), not invented totals.

**Acceptance:** substantial implementation, database compatibility, reproducibility, real SQL workflows and frontend checks pass. Final submission is not complete until team information and the real video are supplied. Do not describe provisional historical calculations as exact official rankings.

## Executed final verification (8 November 2026)

- `python -m compileall -q src`: passed.
- `LIVE_MYSQL=1 python -m unittest discover -s src/tests -v`: **30 passed**, including 15 live workflow tests and package rejection checks; no skipped live tests.
- `python src/tools/integration_test.py`: passed, fresh full MySQL schema/population and transaction failure tests.
- `python src/tools/test_migration.py`: passed, missing/stale trigger repair and no-op repeat.
- `python src/tools/migrate_integrity.py`: **no differences**, 25 installed triggers verified from running development database.
- `python src/tools/verify_backup.py`: latest private dump restored into an isolated database; 40 races and 109 results retained.
- `python src/tools/validate_seed.py`: passed key/FK/source/venue checks; base population regenerated while preserving official supplement.
- `python src/tools/import_official.py --apply`: repeat import verifies every expected source field unchanged; no duplicate writes.
- `python src/tools/smoke_test.py`: passed against development MySQL 8.4.9 using rollback.
- `python src/tools/browser_audit.py`: **14 routes × 2 viewport sizes**, no document overflow or JavaScript exceptions; mobile menu works. Screenshots inspected for desktop Insights and mobile management; audit wrapping and checkbox styling corrected.
- Source review ZIP verified for exact source-only root layout and exclusions. Extracted copy executed all 30 tests against isolated MySQL successfully, with credentials passed only through the local environment.
- Root phase3.pdf and reference phase3.pdf both contain eight pages and identical extracted report text; root report retained unchanged.

An isolated recording database `towerrunning_demo_730f299b` has also been prepared. Start it with `DB_NAME=towerrunning_demo_730f299b python src/app.py`. Course 301, athlete 1001, event 101, result occurrence 2 and cancellation occurrence 3 are local fixture identifiers. This database is separate from development and is not a production data source or a packaged requirement.
