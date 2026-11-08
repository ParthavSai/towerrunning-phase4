"""Build and test a uniquely named isolated MySQL database; never reset development."""
import os
import sys
import uuid
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
import app
import db
import queries as q
from decimal import Decimal


def script(conn, path, database):
    delimiter=';'
    buffer=''
    for line in path.read_text().replace('towerrunning_phase4',database).splitlines():
        if line.startswith('--') or not line.strip(): continue
        if line.startswith('DELIMITER '):
            delimiter=line.split()[1]
            continue
        buffer+=line+'\n'
        if buffer.rstrip().endswith(delimiter):
            with conn.cursor() as cur: cur.execute(buffer.rstrip()[:-len(delimiter)])
            buffer=''
    conn.commit()


def main():
    database='towerrunning_test_'+uuid.uuid4().hex[:12]
    original=os.environ.get('DB_NAME','towerrunning_phase4')
    admin=db.connection()
    src=Path(__file__).resolve().parents[1]
    try:
        script(admin,src/'schema.sql',database)
        script(admin,src/'populate.sql',database)
        os.environ['DB_NAME']=database
        for name in ('counts','highlights','race_search','athlete_search','points_leaderboard','published_rankings','course_records','venue_directory','high_factor_2025','young_athletes','empire_record_minimum','climb_height_average','ascent_speeds','scoring_audit'):
            getattr(q,name)()
        assert not q.race_search("' OR 1=1 --")
        assert q.race_search('SKY')
        client=app.app.test_client()
        for route in ('/','/races','/athletes','/rankings','/records','/venues','/insights','/manage','/manage/operations','/static/style.css','/static/main.js'):
            response=client.get(route)
            assert response.status_code==200,(route,response.status_code)
            response.close()
        assert client.get('/races/999999/1').status_code==404
        for action in ('course','cancel','result','disqualify'):
            assert client.post('/manage/operation/'+action).status_code==400
        course=db.one('SELECT * FROM COURSE LIMIT 1')
        event=db.one('SELECT RaceEventID FROM RACE_EVENT LIMIT 1')['RaceEventID']
        person=db.one('SELECT PersonID FROM REGISTERED_ATHLETE LIMIT 1')['PersonID']
        cid=course['CourseID']
        occurrence=q.create_draft(event,'2027-01-01','2027-01-01',80,course['VenueID'],'Isolated fixture')
        def execute(sql,params=()):
            return q.management_write(lambda cur: cur.execute(sql,params))
        execute("INSERT INTO OFFERS VALUES (%s,%s,%s,'selected',NULL)",(event,occurrence,cid))
        historical=db.all_rows("SELECT * FROM OFFERS o JOIN RACE_EDITION e USING(RaceEventID,OccurrenceNo) WHERE o.CourseID=%s AND e.EditionStatus='completed'",(cid,))
        q.correct_course(cid,1234,Decimal('321.25'),True)
        assert db.one('SELECT * FROM COURSE WHERE CourseID=%s',(cid,))['ConfigurationStatus']=='incomplete'
        assert db.one('SELECT EvaluationSelection FROM OFFERS WHERE RaceEventID=%s AND OccurrenceNo=%s',(event,occurrence))['EvaluationSelection']=='pending'
        assert historical==db.all_rows("SELECT * FROM OFFERS o JOIN RACE_EDITION e USING(RaceEventID,OccurrenceNo) WHERE o.CourseID=%s AND e.EditionStatus='completed'",(cid,))
        for args in ((cid,-1,None,True),(cid,None,None,True),(cid,1,None,False),(999999,1,None,True)):
            try: q.correct_course(*args)
            except ValueError: pass
            else: raise AssertionError('Invalid correction accepted')
        # Force the second statement to fail to verify full rollback.
        execute("CREATE TRIGGER test_rollback BEFORE UPDATE ON OFFERS FOR EACH ROW SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Injected failure'")
        before=db.one('SELECT * FROM COURSE WHERE CourseID=%s',(cid,))
        try: q.correct_course(cid,555,None,True)
        except Exception: pass
        else: raise AssertionError('Injected failure did not occur')
        assert before==db.one('SELECT * FROM COURSE WHERE CourseID=%s',(cid,))
        execute('DROP TRIGGER test_rollback')
        q.insert_result(event,occurrence,cid,person,Decimal('400'),1,Decimal('10'))
        try: q.delete_draft(event,occurrence)
        except ValueError: pass
        else: raise AssertionError('Result dependent draft deleted')
        try: q.disqualify_result(event,occurrence,cid,person)
        except ValueError: pass
        else: raise AssertionError('Unsupported disqualification accepted')
        execute("CREATE TRIGGER test_cancel_rollback BEFORE UPDATE ON OFFERS FOR EACH ROW SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Injected cancellation failure'")
        try: q.cancel_edition(event,occurrence)
        except Exception: pass
        else: raise AssertionError('Cancellation failure did not occur')
        assert q.race_info(event,occurrence)['EditionStatus']=='planned'
        execute('DROP TRIGGER test_cancel_rollback')
        q.cancel_edition(event,occurrence)
        row=db.one('SELECT * FROM ACHIEVES_RESULT WHERE RaceEventID=%s AND OccurrenceNo=%s',(event,occurrence))
        assert row['VerificationStatus']=='withdrawn' and row['Points'] is None
        try: q.insert_result(event,occurrence,cid,person)
        except ValueError: pass
        else: raise AssertionError('Cancelled result accepted')
        for callback in (
            lambda: q.insert_result(event,occurrence,cid,person,Decimal('-1')),
            lambda: q.insert_result(event,occurrence,cid,person,Decimal('NaN')),
            lambda: q.create_membership(999999,2099,'2099-01-01','2099-12-31')):
            try: callback()
            except Exception: pass
            else: raise AssertionError('Invalid write accepted')
        pub=db.one("SELECT RankingPublicationID FROM RANKING_PUBLICATION WHERE PublicationStatus='published' LIMIT 1")
        try: execute('UPDATE RANKING_PUBLICATION SET PublicationLabel=%s WHERE RankingPublicationID=%s',('Changed',pub['RankingPublicationID']))
        except Exception: pass
        else: raise AssertionError('Published release mutated')
        with client.session_transaction() as sess: sess['_csrf_token']='integration-token'
        response=client.post('/manage/operation/course',data={'_csrf_token':'integration-token','course_id':cid,'stairs':'1235','same_route':'yes'})
        assert response.status_code==302
        assert db.one('SELECT StairCount FROM COURSE WHERE CourseID=%s',(cid,))['StairCount']==1235
        q.create_membership(person,2099,'2099-01-01','2099-12-31')
        assert db.one('SELECT ConfirmationStatus FROM ANNUAL_MEMBERSHIP WHERE PersonID=%s AND MembershipYear=2099',(person,))['ConfirmationStatus']=='pending'
        draft=q.create_draft(event,'2028-01-01','2028-01-01',80,None,'delete fixture')
        q.update_draft(event,draft,'2028-02-01','2028-02-01',100,None,None)
        q.delete_draft(event,draft)
        assert not q.race_info(event,draft)
        print('PASS: fresh MySQL schema/population, retrievals, routes/assets, CSRF, injection, course correction/history/rollback, result insertion, cancellation, disqualification rejection, membership, draft CRUD.')
    finally:
        os.environ['DB_NAME']=original
        with admin.cursor() as cur: cur.execute('DROP DATABASE IF EXISTS `'+database+'`')
        admin.close()

if __name__=='__main__': main()
