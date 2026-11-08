# Towerrunning — Phase 4

A locally runnable Towerrunning data explorer using the final Phase 3 Stage D relational design: **30 MySQL tables and 36 foreign keys**. Tested with **MySQL Community Server 8.4.9**, **Python 3.13**, Flask 3, PyMySQL, Jinja, HTML/CSS and vanilla JavaScript. Raw parameterized SQL only; no ORM or frontend build. Montserrat has an Arial fallback.

**Submission status:** implementation and automated verification are complete within the evidence limits below. The actual team number, Phase 2 authoring team number and real demonstration video remain required. Exact official Nations Cup reconstruction is not claimed: published country standings are preserved, while calculations use explicitly chosen exploratory windows and separate historical rule variants.

## Setup and run

For the existing populated installation, **do not reload schema.sql or populate.sql**:

```bash
source .venv/bin/activate
python src/tools/migrate_integrity.py          # read-only installed-trigger comparison
python src/tools/migrate_integrity.py --apply  # only if differences exist; backs up first
python src/app.py
```

Open **http://127.0.0.1:5000**. CSS and templates must be served by Flask; do not open HTML files directly. Manage is a trusted local coursework interface, without login. Keep it bound to localhost.

For a **fresh, expendable installation only**, from the extracted project root:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r src/requirements.txt
mysql -u root -p --default-character-set=utf8mb4 < src/schema.sql
mysql -u root -p --default-character-set=utf8mb4 < src/populate.sql
cp -n src/.env.example src/.env
# Edit src/.env locally; never commit or package it.
python src/app.py
```

On Windows, use `py -m venv .venv`, `.venv\Scripts\activate`, and `Copy-Item src/.env.example src/.env` only if `.env` does not already exist. The MySQL import commands work from cmd.exe; use an appropriate input method in PowerShell.

`schema.sql` deliberately drops/recreates **towerrunning_phase4**, as required for reproducible fresh setup. Never run it over valuable data. `populate.sql` includes the official spreadsheet supplement; it is not a migration and is intended for an empty schema.

Configure `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME` and a random `SECRET_KEY` in `src/.env`. Defaults are host `127.0.0.1`, port `3306`, database `towerrunning_phase4`, user `towerrunning_app`. Do not print credentials. Ordinary app use needs SELECT/INSERT/UPDATE/DELETE; schema creation, isolated tests and migration need CREATE/DROP/TRIGGER privileges. Migration requires `mysqldump` and saves private backups in `.local-backups/`, outside `src/` and outside the ZIP. Stop writes while migrating because MySQL DDL implicitly commits.

## Features — demonstration order

1. **Home** `/`: SQL counts and linked race highlights.
2. **Race search** `/races`: name/venue partial search, city/year/factor filters; `/races?q=SKY` demonstrates case-insensitive matching.
3. **Race detail** `/races/<event>/<occurrence>`: click a race for offered courses and canonical results; division tabs filter SQL. Status distinguishes local/unverified and disqualified rows.
4. **Athletes** `/athletes`: partial name/TWA-ID, country and result-division filters.
5. **Athlete history** `/athletes/<person>`: click an athlete for sourced results.
6. **Race-points explorer** `/rankings`: sums verified finished imported performances, with division/country/minimum-race filters. These sample totals are not official rolling rankings.
7. **Published individual releases** `/rankings/publication/<id>`: open a release card; imported rows retain source rank/points. Only unambiguous existing-athlete name-and-country matches were imported.
8. **Course records** `/records`: sourced record claims with division/city filters.
9. **Venues** `/venues`: partial name/city search and SQL course/edition counts.
10. **Phase 1 reports** `/insights`: completed 2025 factor ≥200 selection; known post-2000 birthdate projection; Empire State course/division/age-group minima; average known confirmed course ascent; verified >250m single-climb ascent speed; independent scoring-compliance findings. Missing evidence is UNKNOWN, incomplete matrix coverage is a COVERAGE GAP, known contradictions are VIOLATION findings.
11. **Nations Cup** `/nations`, linked from Rankings and Insights: select 2019/2025/2026 published country standings. Enter an exploratory date window and explicitly select point-best or fastest historical method. SQL selects two performances per country/division/race, then eight country race totals. Approved completed editions, selected courses, verified finished results, known ranking dates/countries/points are required; unregistered athletes are eligible. Fastest mode additionally excludes groups with missing/tied times. No official ranks/tie-breakers are invented.
12. **INSERT draft** `/manage`: select existing event, dates, factor, optional venue and notes. Creates a local planned edition with an atomic per-event occurrence number.
13. **UPDATE draft** `/manage`: Edit changes dates/factor/venue/notes. Source-backed editions and drafts with results/submissions are protected.
14. **DELETE draft** `/manage`: Delete and confirm. Rejects results/submissions and retained predecessor references, cleans permitted relationship rows, preserves parents.
15. **INSERT annual membership** `/manage`: choose registered athlete/year/ordered validity dates. Creates pending only, with no payment or official-confirmation claim. Duplicate athlete/year is rejected.
16. **Correct course** `/manage/operations`: enter existing course, positive stairs and/or finite climb; confirm same physical route. Atomically marks configuration incomplete and planned/postponed selections pending. Completed edition selections are preserved. A changed route needs a new CourseID.
17. **Cancel edition** `/manage/operations`: enter planned/postponed edition and confirm. Completed editions, verified results and accepted historical submissions are protected. Offers become not selected, evaluation becomes not evaluated, pending submissions rejected, unverified results withdrawn, invalid placings/points cleared, and inclusion note appended once. Evidence rows remain.
18. **INSERT canonical result** `/manage/operations`: enter existing athlete and offered edition/course, optional division/country/time/place/points and finish status. Validates domains, duplicates and cancellation; non-finished entries cannot carry places/points. Public entry is always unverified and defaults dispute status to none. There is no public evidence-acceptance or official-verification control.
19. **Disqualify a verified result** `/manage/operations`: identify result plus a previously reviewed accepted official decision submission/row. Requires verified check, upheld decision and matching structured athlete/course metadata. Atomically clears place/points, removes dependent placing rows and sets disqualified/upheld. Preserves original evidence, other athletes' placements and immutable published releases. Rejects mismatched/absent decisions and dependent draft standings requiring unsupported recalculation. The production seed contains no actual upheld decisions, so demonstrate rejection or use clearly identified isolated fixtures; never fabricate an official decision.

The recording script in `src/docs/DEMO_SCRIPT.md` follows this order and includes before/after SQL.

## Design Changes and handovers

- Phase 1 origin: **Team 70**, as explicitly identified by the Phase 2 report. This is not proof of the current submission team number.
- Phase 2 EER authoring team: **[CONFIRM FROM COURSE ALLOCATION]**. The provided report says “NotSQL” but does not give its numeric authoring team.
- Phase 3 authoring team: **Team 57**, explicitly stated in `phase3.pdf`.
- Current submission team: **[CONFIRM]**.

Stage D's 30 relations are retained, including normalized `FORM(FormURL,FormType)`. Significant physical/integrity changes and reasons:

- Added composite FK ACHIEVES_RESULT → OFFERS so only offered course/edition pairs can have results.
- Added MySQL types, indexes, unique/domain/date/source-pair constraints to enforce executable keys and domains.
- Used ON UPDATE RESTRICT for CHECK-constrained FK columns to preserve MySQL 8.4 compatibility; identifiers are immutable.
- Limited FORM URL keys to 512 characters to fit utf8mb4 index limits.
- Added venue-agreement and predecessor-cycle triggers for cross-table rules.
- Added matrix non-overlap, cancellation/citation, protected source evidence, reviewed decision evidence and published-release/standing triggers. Published rows can only be loaded under a draft header, then frozen by publishing in the same import transaction.
- No added tables or attributes for management. Reviewed disqualification decisions use existing RESULT_SUBMISSION/SOURCE_ROW; expected metadata is documented in `src/docs/DESIGN_CHANGES.md`. Public forms cannot review evidence.
- The matrix workbook varies by participant count, which Stage D cannot represent. Only its explicitly identified base-column sheet is imported as an **unassigned** scheme; no historical applicability dates or edition assignments are invented.

## Sources and limitations

The seed retains 40 race events, 45 editions, 84 registered athletes and 109 canonical result extracts. Official workbooks add **186 country standings**, **124 matched individual standings**, and **215 base scoring entries**. Original publication headers remain unchanged; imported releases use separate IDs 201911, 202512 and 202607.

`src/data/official/` contains the inspected originals, SHA-256 manifest, import summary and deterministic SQL supplement. `populate.sql` includes that supplement. The generator `python src/tools/import_official.py` verifies checksums and regenerates the supplement using existing athlete identities; `--apply` backs up and imports it once without resetting data. `build_population.py` retains the supplement when regenerating the base seed.

Sources include official Ranking Basics, Organizers Info, Scoring Matrix, final-2019, final-2025 and July-2026 workbooks. Details and URLs are in `src/docs/DATA_PROVENANCE.md`.

Evidence limits: full eligible race results and approvals, exact ranking-window boundaries and historical rule applicability are unverified. Workbooks contain anomalous date-cell years; filenames alone do not establish cutoffs. Published totals are imported directly, never recomputed into official values. Unknown birthdates remain NULL. No actual payments, reviewed dispute decisions or regraded scores are fabricated. The explicit reconstruction windows are exploratory; the strict seed calculation can return no eligible rows while published standings remain meaningful.

## Verification

```bash
python -m compileall -q src
python -m unittest discover -s src/tests -v
LIVE_MYSQL=1 python -m unittest discover -s src/tests -v
python src/tools/integration_test.py
python src/tools/test_migration.py
python src/tools/smoke_test.py
```

The first unit command skips opt-in live tests. With `LIVE_MYSQL=1`, all tests execute against a uniquely named disposable database. Integration/migration tools load the actual schema and population there and drop only that test DB. Smoke tests use development DB rollback, never a reset.

For the optional browser audit, install `playwright`, start the app with `PORT=5055 python src/app.py`, then run `python src/tools/browser_audit.py`. It uses installed Google Chrome at `/usr/bin/google-chrome`, audits desktop/mobile routes, navigation, JavaScript and overflow, and writes screenshots only to `/tmp/`. Adjust the browser path on other systems. Playwright is a development-only dependency.

## Submission

The required archive has exactly these root entries:

```text
<team_number>.mp4
phase3.pdf
README.md
src/
```

Record a real video of at most ten minutes. Once the team number is confirmed:

```bash
python src/tools/package_submission.py YOUR_TEAM_NUMBER /absolute/path/to/real-video.mp4
```

The packager excludes `.env`, caches, local backups, `read/`, virtual environments and generated ZIPs. It requires `ffprobe` to validate video duration. No real MP4 is present yet; `submission_pending.zip` is a source-only review archive and is **not** a compliant final submission. Confirm team identities, add the recording, inspect the final archive and run it from a fresh extraction before submitting.
