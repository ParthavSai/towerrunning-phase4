"""Test missing and stale triggers on a populated isolated database, twice."""
import os
import uuid
from pathlib import Path
import integration_test as fixture
import migrate_integrity as migration
import db

def main():
    name='towerrunning_test_'+uuid.uuid4().hex[:12]
    conn=db.connection()
    original=os.getenv('DB_NAME','towerrunning_phase4')
    try:
        fixture.script(conn,Path('src/schema.sql'),name)
        fixture.script(conn,Path('src/populate.sql'),name)
        with conn.cursor() as cur:
            cur.execute('DROP TRIGGER bi_result_integrity')
            cur.execute("CREATE TRIGGER bi_result_integrity BEFORE INSERT ON ACHIEVES_RESULT FOR EACH ROW SET @migration_test=1")
            cur.execute('DROP TRIGGER bi_listed_published')
            cur.execute('SELECT COUNT(*) n FROM ACHIEVES_RESULT');before=cur.fetchone()
        assert migration.apply(conn)==2
        assert migration.apply(conn)==0
        with conn.cursor() as cur:
            cur.execute('SELECT COUNT(*) n FROM ACHIEVES_RESULT');assert cur.fetchone()==before
        print('PASS migration: stale/missing definitions repaired, second run no-op, populated results preserved.')
    finally:
        os.environ['DB_NAME']=original
        with conn.cursor() as cur:cur.execute('DROP DATABASE `'+name+'`')
        conn.close()
if __name__=='__main__':main()
