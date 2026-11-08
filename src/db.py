"""Only server-side MySQL connectivity. No ORM, query builder or browser DB access."""
import os
import pymysql
from pymysql.cursors import DictCursor


def connection():
    return pymysql.connect(
        host=os.getenv('DB_HOST', '127.0.0.1'),
        port=int(os.getenv('DB_PORT', '3306')),
        user=os.getenv('DB_USER', 'towerrunning_app'),
        password=os.getenv('DB_PASSWORD', ''),
        database=os.getenv('DB_NAME', 'towerrunning_phase4'),
        charset='utf8mb4',
        cursorclass=DictCursor,
        autocommit=False,
        connect_timeout=5,
        read_timeout=10,
        write_timeout=10,
    )


def one(sql, params=()):
    conn = connection()
    try:
        with conn.cursor() as cur:
            cur.execute(sql, params)
            return cur.fetchone()
    finally:
        conn.close()


def all_rows(sql, params=()):
    conn = connection()
    try:
        with conn.cursor() as cur:
            cur.execute(sql, params)
            return cur.fetchall()
    finally:
        conn.close()
