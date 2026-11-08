"""Repeatable trigger migration. Never changes data; backs up before DDL.
Run with the web server stopped: python src/tools/migrate_integrity.py --apply
Without --apply only compares information_schema with schema.sql.
"""
import argparse
import gzip
import os
from pathlib import Path
import re
import subprocess
import sys
from datetime import datetime, timezone
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
import app  # loads .env without printing credentials
import db

SRC=Path(__file__).resolve().parents[1]


def definitions():
    return {m.group(1):m.group(0)[:-2] for m in re.finditer(
        r'CREATE TRIGGER (\w+).*?END\$\$',(SRC/'schema.sql').read_text(),re.S)}


def normalize(value):
    return re.sub(r'\s+',' ',value.replace('`','')).strip().lower()


def pending(conn):
    result=[]
    with conn.cursor() as cur:
        cur.execute('SELECT TRIGGER_NAME FROM information_schema.TRIGGERS WHERE TRIGGER_SCHEMA=DATABASE()')
        installed={r['TRIGGER_NAME'] for r in cur.fetchall()}
        for name,sql in definitions().items():
            if name in installed:
                cur.execute('SHOW CREATE TRIGGER `'+name+'`')
                old=cur.fetchone()['SQL Original Statement']
                old='CREATE TRIGGER '+old.split(' TRIGGER ',1)[1]
                if normalize(old)==normalize(sql):continue
            result.append((name,sql,name in installed))
    return result


def apply(conn):
    changes=pending(conn)
    with conn.cursor() as cur:
        for name,sql,exists in changes:
            if exists:cur.execute('DROP TRIGGER `'+name+'`')
            cur.execute(sql)
    assert not pending(conn), 'Installed trigger definitions differ'
    return len(changes)


def backup(database):
    directory=SRC.parents[0]/'.local-backups'
    directory.mkdir(mode=0o700,exist_ok=True)
    path=directory/(database+'_'+datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%f')+'.sql.gz')
    env=os.environ.copy()
    env['MYSQL_PWD']=os.getenv('DB_PASSWORD','')
    command=['mysqldump','--single-transaction','--routines','--triggers','--no-tablespaces',
             '--set-gtid-purged=OFF','--column-statistics=0',
             '--host='+os.getenv('DB_HOST','127.0.0.1'),
             '--port='+os.getenv('DB_PORT','3306'),'--user='+os.getenv('DB_USER','towerrunning_app'),database]
    result=subprocess.run(command,env=env,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    if result.returncode:raise RuntimeError('Backup failed; no migration attempted. Check mysqldump privileges.')
    if b'CREATE TABLE' not in result.stdout:raise RuntimeError('Backup validation failed')
    path.touch(mode=0o600)
    with gzip.open(path,'wb') as target:target.write(result.stdout)
    with gzip.open(path,'rb') as source:assert source.read()==result.stdout
    print('Verified private backup:',path)
    return path


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--apply',action='store_true')
    args=parser.parse_args()
    conn=db.connection()
    try:
        changes=pending(conn)
        print('Trigger differences:',[name for name,_,_ in changes])
        if args.apply and changes:
            with conn.cursor() as cur:
                cur.execute('SELECT DATABASE() AS name')
                database=cur.fetchone()['name']
                cur.execute('SELECT (SELECT COUNT(*) FROM RACE_EVENT) races,(SELECT COUNT(*) FROM ACHIEVES_RESULT) results')
                before=cur.fetchone()
            backup(database)
            print('Applied trigger changes:',apply(conn))
            with conn.cursor() as cur:
                cur.execute('SELECT (SELECT COUNT(*) FROM RACE_EVENT) races,(SELECT COUNT(*) FROM ACHIEVES_RESULT) results')
                assert before==cur.fetchone()
        with conn.cursor() as cur:
            cur.execute('SELECT TRIGGER_NAME FROM information_schema.TRIGGERS WHERE TRIGGER_SCHEMA=DATABASE() ORDER BY TRIGGER_NAME')
            print('Installed triggers:',[r['TRIGGER_NAME'] for r in cur.fetchall()])
    finally:conn.close()

if __name__=='__main__':main()
