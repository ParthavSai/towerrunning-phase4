"""Run against a *real loaded MySQL 8 server*. Safe transactional demo checks.

No source-backed record is modified permanently: INSERT/UPDATE/DELETE a new
local draft in one transaction, then ROLLBACK. Exits nonzero on any failure.
"""
from __future__ import annotations
import os
import sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
try:
    from dotenv import load_dotenv
    load_dotenv(ROOT/'src'/'.env')
    from db import connection
except ImportError:
    print('Install dependencies first: python -m pip install -r src/requirements.txt')
    raise


def check(test,explanation):
    if not test:
        raise AssertionError(explanation)
    print('  PASS:',explanation)


def main():
    print('MySQL Phase 4 smoke test; never executes schema.sql or populate.sql.')
    conn=connection()
    try:
        with conn.cursor() as cur:
            cur.execute('SELECT VERSION() AS version')
            v=cur.fetchone()['version']
            print('  Connected to MySQL-compatible server:',v)
            check('mariadb' not in v.lower(),'MySQL 8 target (not MariaDB; CHECK/trigger differences)')
            cur.execute('''SELECT COUNT(*) AS n FROM information_schema.TABLES
                WHERE TABLE_SCHEMA=DATABASE() AND TABLE_TYPE='BASE TABLE' ''')
            check(cur.fetchone()['n']==30,'30 final Phase 3 Stage D tables present')
            cur.execute('''SELECT COUNT(*) AS n FROM information_schema.TABLE_CONSTRAINTS
                WHERE TABLE_SCHEMA=DATABASE() AND CONSTRAINT_TYPE='FOREIGN KEY' ''')
            fk=cur.fetchone()['n']
            check(fk>=35,f'Foreign keys installed ({fk} counted)')
            cur.execute("SELECT COUNT(*) AS n FROM ACHIEVES_RESULT")
            check(cur.fetchone()['n']>=100,'100+ source-backed race results imported')
            cur.execute("SELECT COUNT(*) AS n FROM COURSE_RECORD")
            check(cur.fetchone()['n']>=6,'Course-record claims exist')
            cur.execute('''SELECT COUNT(*) AS n FROM ACHIEVES_RESULT ar
                LEFT JOIN OFFERS o ON ar.RaceEventID=o.RaceEventID
                    AND ar.OccurrenceNo=o.OccurrenceNo AND ar.CourseID=o.CourseID
                WHERE o.CourseID IS NULL''')
            check(cur.fetchone()['n']==0,'No results without offered courses')

            # Reversible create/update/delete checks. All changes stay inside a transaction.
            cur.execute('SELECT RaceEventID FROM RACE_EVENT WHERE RaceEventID=103 FOR UPDATE')
            check(cur.fetchone() is not None,'Existing parent race event available')
            cur.execute('''SELECT COALESCE(MAX(OccurrenceNo),0)+1 AS next_no
                FROM RACE_EDITION WHERE RaceEventID=103''')
            occ=cur.fetchone()['next_no']
            cur.execute('''INSERT INTO RACE_EDITION
                (RaceEventID,OccurrenceNo,StartDate,EndDate,RaceFactor,EditionStatus,EvaluationStatus)
                VALUES (103,%s,'2027-06-01','2027-06-01',80,'planned','unverified')''',(occ,))
            cur.execute('''SELECT RaceFactor FROM RACE_EDITION
                WHERE RaceEventID=103 AND OccurrenceNo=%s''',(occ,))
            check(cur.fetchone()['RaceFactor']==80,'INSERT draft via SQL succeeds')
            cur.execute('''UPDATE RACE_EDITION SET RaceFactor=120
                WHERE RaceEventID=103 AND OccurrenceNo=%s''',(occ,))
            cur.execute('''SELECT RaceFactor FROM RACE_EDITION
                WHERE RaceEventID=103 AND OccurrenceNo=%s''',(occ,))
            check(cur.fetchone()['RaceFactor']==120,'UPDATE draft via SQL succeeds')
            cur.execute('''DELETE FROM RACE_EDITION
                WHERE RaceEventID=103 AND OccurrenceNo=%s''',(occ,))
            cur.execute('''SELECT COUNT(*) AS n FROM RACE_EDITION
                WHERE RaceEventID=103 AND OccurrenceNo=%s''',(occ,))
            check(cur.fetchone()['n']==0,'DELETE local draft via SQL succeeds')
        print('\nALL LIVE DATABASE SMOKE CHECKS PASSED. Rolling back the entire test transaction.')
    finally:
        conn.rollback()
        conn.close()


if __name__=='__main__':
    main()
