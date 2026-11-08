"""Restore latest private migration backup into an isolated database and verify it."""
import gzip
import os
from pathlib import Path
import subprocess
import sys
import uuid
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
import app
import db

def main():
    directory=Path(__file__).resolve().parents[2]/'.local-backups'
    path=max(directory.glob('*.sql.gz'),key=lambda p:p.stat().st_mtime)
    data=gzip.open(path,'rb').read()
    name='towerrunning_test_'+uuid.uuid4().hex[:12]
    conn=db.connection()
    try:
        with conn.cursor() as cur:cur.execute('CREATE DATABASE `'+name+'` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci')
        env=os.environ.copy();env['MYSQL_PWD']=os.getenv('DB_PASSWORD','')
        command=['mysql','--host='+os.getenv('DB_HOST','127.0.0.1'),'--port='+os.getenv('DB_PORT','3306'),'--user='+os.getenv('DB_USER','towerrunning_app'),'--database='+name]
        result=subprocess.run(command,input=data,env=env,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        if result.returncode:raise RuntimeError('Isolated backup restore failed; inspect local backup privileges/compatibility.')
        with conn.cursor() as cur:
            cur.execute('SELECT COUNT(*) n FROM `'+name+'`.RACE_EVENT');assert cur.fetchone()['n']==40
            cur.execute('SELECT COUNT(*) n FROM `'+name+'`.ACHIEVES_RESULT');assert cur.fetchone()['n']==109
        print('PASS: private dump restored in isolation; 40 races and 109 results intact.')
    finally:
        with conn.cursor() as cur:cur.execute('DROP DATABASE IF EXISTS `'+name+'`')
        conn.close()
if __name__=='__main__':main()
