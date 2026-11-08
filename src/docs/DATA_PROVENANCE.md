# Official Data Provenance — Towerrunning

**Snapshot used:** 8 November 2026. The database preserves published observations. Internal numeric database IDs, `OccurrenceNo` and generic route labels are implementation choices; they are not presented as official Towerrunning identifiers.

## Sources for the 2026 Tour calendar

- Official Tour calendar: https://www.towerrunning.com/towerrunning-tour-2026/
- Event schedule, city, factor, championship annotations and dates were transcribed from this page. The site's displayed Tour sequence is not necessarily chronological.
- Two **International Vertical Marathon PingAn** 2026 entries are represented as separate occurrences (January 10 and October 24).
- A historical edition or detail page may have a different factor in another year. The race factor belongs to RACE_EDITION, not RACE_EVENT.

## Official race detail pages supplying profiles, routes and published results

| Page | Event | Information used |
|---|---|---|
| https://www.towerrunning.com/races/r3100/ | Barcelona Tower Running Challenge | venue Torre Glòries, 686 stairs, 34 floors, 116m, 2026 published male/female points |
| https://www.towerrunning.com/races/r3024/ | Tower Run Basel | venue, staircase count, 2026 printed point rows |
| https://www.towerrunning.com/races/r3207/ | Deutsche Post Tower Run | venue, staircase count, printed point rows |
| https://www.towerrunning.com/races/r3276/ | KL Tower Run International Challenge | 1608 stairs, 292m, 2026 factors, names, ID/point rows |
| https://www.towerrunning.com/races/r3389/ | Raffles City Chongqing Vertical Challenge | 1178 stairs, 42 floors, 250m, 2026 winner and printed result |
| https://www.towerrunning.com/races/r3203/ | SprintTower 365 | additional documented event with sourced printed results |
| https://www.towerrunning.com/races/r2703/ | TK Elevator Towerrun | Testturm, 1390 stairs, 232m, course records 6:56 (2018) and 9:07 (2024) |
| https://www.towerrunning.com/races/r3253/ | Empire State Building Run Up | 1576 stairs, 86 floors, factor 80, official 2026 event, course records 9:33 (2003) and 11:23 (2006) |
| https://www.towerrunning.com/races/r2929/ | Bieg Na Szczyt Rondo 1, 2025 | higher-factor historical edition and published male/female points |
| https://www.towerrunning.com/races/r2940/ | Taipei 101 Run Up, 2025 | factor 200, athlete/placing/point rows, course records 10:29.32 (2005) and 12:38.85 (2005) |
| https://www.towerrunning.com/races/r3006/ | The Sky Race, 2025 | venue, factor and published winners |
| https://www.towerrunning.com/races/r2950/ | Skyrun MesseTurm Frankfurt, 2025 | historical edition and course information |

Official reporting on the 2025 Taipei 101 top four also supplies **precise race times**, absent in the point tables:

- https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/
- https://www.towerrunning.com/2025/03/17/announcement-towerrunning-200-taipei-101-run-up-may-3-2025/ — states the climbed course height is **391m**, distinct from 508m architectural height.

The 2025 Taipei times and names are cross-referenced with the athlete IDs, placements and points on the official race detail page. Additional times that were not printed are left `NULL`. Seconds can have decimals; do not replace them with made-up integers.

## Ranking publications and results forms

- https://www.towerrunning.com/ranking/ — links official published 2026 and 2025 spreadsheets, the standardized Results Form, the Factor-40 variant and the Scoring Matrix.
- Results forms (actual links on that page):
  - https://www.towerrunning.com/twainfo/TWA%20Results%20Form.xlsx
  - https://www.towerrunning.com/twainfo/TWA%20Results%20Form%2040.xlsx

**Original baseline (superseded by the verified ingestion section below):** merely linking a spreadsheet does not import its contents. `RANKING_PUBLICATION` stores two published file descriptions but `LISTED_IN` and `NATIONS_STANDING` are empty until an approved official file has actually been transcribed and validated. No official ranking-point totals have been invented. Likewise no verified full scoring-matrix contents are inserted into `SCORING_MATRIX_ENTRY`.

## Methodology and fields deliberately left NULL

- **Race status:** `completed` is used where an official archived event detail and results confirm completion; calendar-only past entries have `EditionStatus = NULL` if completion was not individually verified. Future official entries are `planned` where appropriate.
- **Athlete IDs:** only names accompanied by official TWA athlete identifiers are inserted into REGISTERED_ATHLETE; no inferred birth dates, gender attributes or registration dates. `CompetitionDivision` records the original result table's male/female classification, not the athlete's personal gender identity.
- **Time:** most TWA *Points* tables show an empty Time column. In those cases `FinishingTimeSeconds` is `NULL`. Where precisely timed results appear in separate official reports, those are cited and imported.
- **Ranking dates:** no assumed effective ranking window, scheme or certification is inserted merely because a race has a factor.
- **Country codes:** use the source's TWA abbreviations, which need not be identical to ISO 3166.
- **Course record:** stores only distinct explicitly documented claims; a course record holder need not be present in the registered-athlete sample.
- **Year and identity:** the four digits embedded in a TWA athlete ID are not converted to BirthDate. No membership fee or payment is inferred.

Any new sources used by teammates should be added here together with the exact field values they support.

## Verified official workbook ingestion — continuation audit

Downloaded directly from links on https://www.towerrunning.com/ranking/ using curl; files and SHA-256 digests are retained in `src/data/official/manifest.json`:

- `final2019.xlsx`: https://www.towerrunning.com/wp-content/uploads/2024/02/TWA-Ranking-November-2019-Season-Final.xlsx — 71 Nations rows, rank column A, country D, score F, data from row 29. Individual identities from this older release were not mapped.
- `final2025.xlsx`: https://www.towerrunning.com/wp-content/uploads/2025/12/TWA-Ranking-Final-2025.xlsx — 54 Nations rows and 60 uniquely matched existing individual athletes. Rank A, country D, score G, names C, data from row 29.
- `july2026.xlsx`: https://www.towerrunning.com/wp-content/uploads/2026/08/TWA-Ranking-July-2026.xlsx — 61 Nations rows and 64 uniquely matched existing individual athletes, same columns as 2025.
- `matrix.xlsx`: https://www.towerrunning.com/splits/TWA%20Scoring%20Matrix.xlsx — all seven sheets inspected. 215 numeric base entries imported from `Factor 280`, rows 3–32, factors from row 1 columns B–I. Participant-dependent sheets are preserved as original evidence, not incorrectly flattened. The final participation-points footnote is not encoded as an unbounded range; no score calculator assumes it is absent.
- `basics.pdf`: https://www.towerrunning.com/splits/TWA%20Ranking%20Basics.pdf — point-best two females and males per country/race; unregistered athletes included. The individual best-eight rule alone was not assumed to prove a country best-eight rule.
- `organizers.pdf`: https://www.towerrunning.com/splits/TWA%20Organizers%20Info.pdf — result completeness and seven-day guidance inspected.

Nations!C21:C22 in each workbook independently supplies the country best-eight and two-per-division descriptions. The 2020 article https://www.towerrunning.com/2020/02/29/twa-national-associations-representatives-update-nations-cup/ instead describes fastest athletes. These are separate selectable report variants, not assumed equivalent. Applicability to a particular release is not established.

Individual mapping uses exact Unicode-normalized, case-insensitive full name plus the same country in the existing registered sample; ambiguous/unmatched rows are skipped. No new people, IDs or birthdates are inferred. This supports only the imported subset, not a claim that all spreadsheet identities were resolved. Original workbooks remain available to audit skipped rows.

Ranking headers are loaded as draft, rows inserted, then published atomically. New IDs avoid modifying the two original published header records. As-of/window dates remain NULL: month labels and inconsistent spreadsheet date cells do not justify inventing exact boundaries. Matrix effective dates and race scheme assignments likewise remain NULL.
