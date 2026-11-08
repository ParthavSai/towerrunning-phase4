"""Real SQL + Flask write tests in a disposable database. Opt in with LIVE_MYSQL=1."""
import json
import os
from pathlib import Path
import sys
import unittest
import uuid
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
import app
import db
import queries as q
from integration_test import script
import migrate_integrity


@unittest.skipUnless(os.getenv('LIVE_MYSQL')=='1','Set LIVE_MYSQL=1 for isolated MySQL tests')
class LiveWorkflows(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.original=os.environ.get('DB_NAME','towerrunning_phase4')
        cls.database='towerrunning_test_'+uuid.uuid4().hex[:12]
        cls.admin=db.connection()
        src=Path(__file__).resolve().parents[1]
        script(cls.admin,src/'schema.sql',cls.database)
        script(cls.admin,src/'populate.sql',cls.database)
        os.environ['DB_NAME']=cls.database

    @classmethod
    def tearDownClass(cls):
        os.environ['DB_NAME']=cls.original
        with cls.admin.cursor() as c:c.execute('DROP DATABASE `'+cls.database+'`')
        cls.admin.close()

    def execute(self,sql,args=()):
        return q.management_write(lambda c:c.execute(sql,args))

    def setUp(self):
        self.course=db.one('SELECT * FROM COURSE ORDER BY CourseID LIMIT 1')
        self.cid=self.course['CourseID']
        self.person=db.one('SELECT PersonID FROM REGISTERED_ATHLETE ORDER BY PersonID LIMIT 1')['PersonID']
        self.event=db.one('SELECT RaceEventID FROM RACE_EVENT ORDER BY RaceEventID LIMIT 1')['RaceEventID']
        self.occ=q.create_draft(self.event,'2027-01-01','2027-01-01',80,self.course['VenueID'],'Isolated workflow fixture')
        self.key=(self.event,self.occ)
        self.resultkey=self.key+(self.cid,self.person)
        self.execute("INSERT INTO OFFERS VALUES (%s,%s,%s,'selected',NULL)",self.key+(self.cid,))
        self.client=app.app.test_client()
        with self.client.session_transaction() as s:s['_csrf_token']='live-token'

    def post(self,action,**data):
        data.update(_csrf_token='live-token',event_id=self.event,occurrence=self.occ,course_id=self.cid,person_id=self.person)
        return self.client.post('/manage/operation/'+action,data=data,follow_redirects=True)

    def verified_result(self):
        q.insert_result(*self.resultkey,400,1,80)
        self.execute("UPDATE ACHIEVES_RESULT SET VerificationStatus='verified',SourceURL='https://www.towerrunning.com/isolated-test-fixture',CountryAtRace='TST',CompetitionDivision='Male' WHERE RaceEventID=%s AND OccurrenceNo=%s AND CourseID=%s AND PersonID=%s",self.resultkey)

    def decision(self,person=None):
        self.execute("INSERT INTO RESULT_SUBMISSION (RaceEventID,OccurrenceNo,SubmissionNo,SubmissionKind,CheckStatus,SubmissionStatus,SourceURL) VALUES (%s,%s,1,'disqualification decision','verified','accepted','https://www.towerrunning.com/isolated-decision-fixture')",self.key)
        self.execute("INSERT INTO SOURCE_ROW (RaceEventID,OccurrenceNo,SubmissionNo,SourceRowNo,RawRowText,ResultStatus) VALUES (%s,%s,1,1,%s,'upheld')",self.key+(json.dumps({'PersonID':person or self.person,'CourseID':self.cid,'Decision':'upheld disqualification'}),))

    def test_migration_repeatability_and_seed(self):
        conn=db.connection()
        try:
            self.assertEqual(migrate_integrity.apply(conn),0)
            self.assertEqual(migrate_integrity.apply(conn),0)
        finally:conn.close()
        self.assertEqual(db.one('SELECT COUNT(*) n FROM RACE_EVENT')['n'],40)
        self.assertEqual(db.one('SELECT COUNT(*) n FROM NATIONS_STANDING')['n'],186)
        self.assertEqual(db.one('SELECT COUNT(*) n FROM LISTED_IN')['n'],124)

    def test_real_ui_result_and_duplicate_invalid_fk(self):
        self.assertEqual(self.post('result',seconds='401.125',place='2',points='10').status_code,200)
        r=db.one('SELECT * FROM ACHIEVES_RESULT WHERE RaceEventID=%s AND OccurrenceNo=%s',self.key)
        self.assertEqual(str(r['FinishingTimeSeconds']),'401.125')
        self.assertEqual(r['VerificationStatus'],'unverified')
        self.assertIn(b'Database rejected',self.post('result',seconds='402').data)
        with self.assertRaises(Exception):q.insert_result(self.event,self.occ,999999,self.person,200)
        with self.assertRaises(Exception):q.insert_result(self.event,self.occ,self.cid,999999,200)

    def test_ui_course_and_cancellation_with_submissions(self):
        self.assertEqual(self.post('course',stairs='1500',height='350.25',same_route='yes').status_code,200)
        self.assertEqual(db.one('SELECT StairCount FROM COURSE WHERE CourseID=%s',(self.cid,))['StairCount'],1500)
        q.insert_result(*self.resultkey,400,1,80)
        self.execute("INSERT INTO RESULT_SUBMISSION (RaceEventID,OccurrenceNo,SubmissionNo,SubmissionStatus) VALUES (%s,%s,1,'pending')",self.key)
        self.execute("INSERT INTO INCLUDED_IN VALUES (%s,%s,(SELECT MIN(CompetitionEditionID) FROM COMPETITION_EDITION),'Fixture','Retained note')",self.key)
        self.assertEqual(self.post('cancel').status_code,200)
        self.assertEqual(q.race_info(*self.key)['EditionStatus'],'cancelled')
        self.assertEqual(db.one('SELECT SubmissionStatus FROM RESULT_SUBMISSION WHERE RaceEventID=%s AND OccurrenceNo=%s',self.key)['SubmissionStatus'],'rejected')
        q.cancel_edition(*self.key)
        note=db.one('SELECT InclusionNote FROM INCLUDED_IN WHERE RaceEventID=%s AND OccurrenceNo=%s',self.key)['InclusionNote']
        self.assertEqual(note.count('[Local cancellation]'),1)
        self.assertIn('Retained note',note)
        with self.assertRaises(ValueError):q.insert_result(*self.resultkey)

    def test_verified_and_completed_history_protected(self):
        self.verified_result()
        with self.assertRaises(ValueError):q.cancel_edition(*self.key)
        with self.assertRaises(ValueError):q.delete_draft(*self.key)
        with self.assertRaises(ValueError):q.update_draft(*self.key,'2028-01-01','2028-01-01',80,self.course['VenueID'],None)
        self.assertEqual(q.race_info(*self.key)['EditionStatus'],'planned')

    def test_disqualification_success_preserves_source_and_publications(self):
        self.verified_result();self.decision()
        self.execute('INSERT INTO ADDITIONAL_PLACING VALUES (%s,%s,%s,%s,\'Fixture\',1)',self.resultkey)
        before=db.one('SELECT * FROM ACHIEVES_RESULT WHERE RaceEventID=%s AND OccurrenceNo=%s',self.key)
        published=db.all_rows('SELECT * FROM LISTED_IN ORDER BY PersonID,RankingPublicationID')
        response=self.post('disqualify',submission_no='1',source_row_no='1')
        self.assertNotIn(b'error',response.data.lower().split(b'<main')[0])
        row=db.one('SELECT * FROM ACHIEVES_RESULT WHERE RaceEventID=%s AND OccurrenceNo=%s',self.key)
        self.assertEqual(row['FinishStatus'],'disqualified')
        self.assertEqual(row['DisputeStatus'],'upheld')
        self.assertIsNone(row['Points']);self.assertIsNone(row['OverallPlace'])
        self.assertEqual(row['SourceURL'],before['SourceURL'])
        self.assertEqual(published,db.all_rows('SELECT * FROM LISTED_IN ORDER BY PersonID,RankingPublicationID'))
        self.assertFalse(db.all_rows('SELECT * FROM ADDITIONAL_PLACING WHERE RaceEventID=%s AND OccurrenceNo=%s',self.key))
        with self.assertRaises(Exception):self.execute('UPDATE SOURCE_ROW SET RawRowText=%s WHERE RaceEventID=%s AND OccurrenceNo=%s',('changed',)+self.key)

    def test_disqualification_wrong_target_and_rollback(self):
        self.verified_result();self.decision(person=999999)
        with self.assertRaises(ValueError):q.disqualify_result(*self.resultkey,1,1)
        self.assertEqual(db.one('SELECT FinishStatus FROM ACHIEVES_RESULT WHERE RaceEventID=%s AND OccurrenceNo=%s',self.key)['FinishStatus'],'finished')

    def test_disqualification_failure_rolls_back_dependent_delete(self):
        self.verified_result();self.decision()
        self.execute('INSERT INTO ADDITIONAL_PLACING VALUES (%s,%s,%s,%s,\'Fixture\',1)',self.resultkey)
        self.execute("CREATE TRIGGER fixture_dq_failure BEFORE UPDATE ON ACHIEVES_RESULT FOR EACH ROW SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Injected failure'")
        try:
            with self.assertRaises(Exception):q.disqualify_result(*self.resultkey,1,1)
            self.assertEqual(len(db.all_rows('SELECT * FROM ADDITIONAL_PLACING WHERE RaceEventID=%s AND OccurrenceNo=%s',self.key)),1)
        finally:self.execute('DROP TRIGGER fixture_dq_failure')

    def test_membership_ui_unique_dates_and_pending(self):
        payload={'_csrf_token':'live-token','person_id':self.person,'membership_year':2098,'valid_from':'2098-01-01','valid_until':'2098-12-31'}
        self.assertEqual(self.client.post('/manage/membership',data=payload).status_code,302)
        self.assertEqual(db.one('SELECT ConfirmationStatus FROM ANNUAL_MEMBERSHIP WHERE PersonID=%s AND MembershipYear=2098',(self.person,))['ConfirmationStatus'],'pending')
        response=self.client.post('/manage/membership',data=payload,follow_redirects=True)
        self.assertIn(b'Could not add membership',response.data)
        with self.assertRaises(ValueError):q.create_membership(self.person,2097,'2098-01-01','2097-12-31')

    def test_published_rows_insert_and_move_rejected(self):
        with self.assertRaises(Exception):self.execute("INSERT INTO NATIONS_STANDING VALUES (202512,'ZZZ',999,1)")
        with self.assertRaises(Exception):self.execute("DELETE FROM NATIONS_STANDING WHERE RankingPublicationID=202512")
        with self.assertRaises(Exception):self.execute("UPDATE RANKING_PUBLICATION SET PublicationLabel='Changed' WHERE RankingPublicationID=202512")

    def test_reports_and_every_get_route(self):
        for route in ['/','/races','/athletes','/rankings','/records','/venues','/insights','/manage','/manage/operations','/nations','/nations?start=2025-01-01&end=2025-12-31','/rankings/publication/202512',f'/races/{self.event}/{self.occ}',f'/athletes/{self.person}','/static/style.css','/static/main.js']:
            with self.subTest(route=route):
                response=self.client.get(route)
                self.assertEqual(response.status_code,200)
                response.close()
        self.assertEqual(len(q.nations_published(202512)),54)
        self.assertFalse(q.race_search("' OR 1=1 --"))
        self.assertTrue(q.race_search('SKY'))

    def test_nations_top_two_each_division_and_best_eight(self):
        people=[r['PersonID'] for r in db.all_rows('SELECT PersonID FROM ATHLETE ORDER BY PersonID LIMIT 6')]
        # A clearly isolated unregistered athlete proves registration is not required.
        self.execute("INSERT INTO PERSON VALUES (999990,'Isolated Nations fixture',NULL)")
        self.execute("INSERT INTO ATHLETE (PersonID,NationalityCode) VALUES (999990,'TST')")
        people[0]=999990
        for index in range(10):
            occurrence=q.create_draft(self.event,'2030-01-01','2030-01-01',80,self.course['VenueID'],'Isolated Nations fixture')
            key=(self.event,occurrence)
            self.execute("INSERT INTO OFFERS VALUES (%s,%s,%s,'selected',NULL)",key+(self.cid,))
            self.execute("UPDATE RACE_EDITION SET EditionStatus='completed',EvaluationStatus='approved',RankingDate='2030-01-01' WHERE RaceEventID=%s AND OccurrenceNo=%s",key)
            for person,division,points in zip(people,['Male']*3+['Female']*3,[20,10,1,15,5,1]):
                self.execute("""INSERT INTO ACHIEVES_RESULT (RaceEventID,OccurrenceNo,CourseID,PersonID,CompetitionDivision,CountryAtRace,FinishStatus,VerificationStatus,SourceURL,Points,FinishingTimeSeconds)
                    VALUES (%s,%s,%s,%s,%s,'TST','finished','verified','https://www.towerrunning.com/isolated-nations-fixture',%s,%s)""",key+(self.cid,person,division,points,{20:300,10:200,1:100,15:300,5:200}[points]))
        rows=q.nations_reconstruction('2030-01-01','2030-12-31')
        row=next(r for r in rows if r['CountryAtRace']=='TST')
        self.assertEqual(row['ProvisionalPoints'],400)
        self.assertEqual(row['EligibleRaces'],10)
        self.assertEqual(row['CountedRaces'],8)
        self.assertEqual(row['Contributions'],32)
        self.assertFalse(q.nations_reconstruction('2031-01-01','2031-12-31'))
        fastest=q.nations_reconstruction('2030-01-01','2030-12-31','fastest')
        self.assertEqual(next(r for r in fastest if r['CountryAtRace']=='TST')['ProvisionalPoints'],136)

    def test_scoring_independent_unknown_coverage_and_date_findings(self):
        self.execute("INSERT INTO SCORING_SCHEME VALUES (999990,'Isolated audit fixture','https://www.towerrunning.com/isolated-audit-fixture','2030-01-01','2030-12-31')")
        self.execute("UPDATE RACE_EDITION SET EditionStatus='completed',ScoringSchemeID=999990,RankingDate='2029-12-31' WHERE RaceEventID=%s AND OccurrenceNo=%s",self.key)
        status=next(r['AuditStatus'] for r in q.scoring_audit() if (r['RaceEventID'],r['OccurrenceNo'])==self.key)
        self.assertIn('VIOLATION: ranking date before scheme',status)
        self.assertIn('COVERAGE GAP',status)
        self.assertIn('UNKNOWN: organiser',status)
        self.execute("UPDATE RACE_EDITION SET RankingDate='2031-01-01' WHERE RaceEventID=%s AND OccurrenceNo=%s",self.key)
        status=next(r['AuditStatus'] for r in q.scoring_audit() if (r['RaceEventID'],r['OccurrenceNo'])==self.key)
        self.assertIn('VIOLATION: ranking date after scheme',status)
        self.execute("UPDATE RACE_EDITION SET RaceFactor=NULL,ScoringSchemeID=NULL WHERE RaceEventID=%s AND OccurrenceNo=%s",self.key)
        status=next(r['AuditStatus'] for r in q.scoring_audit() if (r['RaceEventID'],r['OccurrenceNo'])==self.key)
        self.assertIn('UNKNOWN: race factor',status)
        self.assertIn('UNKNOWN: scheme assignment',status)
        self.assertNotIn('VIOLATION: ranking date',status)

    def test_full_draft_crud_through_ui(self):
        payload={'_csrf_token':'live-token','event_id':self.event,'start_date':'2032-01-01','end_date':'2032-01-01','factor':'80','venue_id':'','note':'Isolated UI fixture'}
        self.assertEqual(self.client.post('/manage/create',data=payload).status_code,302)
        row=db.one("SELECT OccurrenceNo FROM RACE_EDITION WHERE RaceEventID=%s AND AdditionalInformation='Isolated UI fixture'",(self.event,))
        occurrence=row['OccurrenceNo']
        payload['factor']='120'
        self.assertEqual(self.client.post(f'/manage/{self.event}/{occurrence}/edit',data=payload).status_code,302)
        self.assertEqual(q.race_info(self.event,occurrence)['RaceFactor'],120)
        self.assertEqual(self.client.post(f'/manage/{self.event}/{occurrence}/delete',data={'_csrf_token':'live-token'}).status_code,302)
        self.assertIsNone(q.race_info(self.event,occurrence))

    def test_cross_table_integrity_failures(self):
        # Cyclic/self predecessor links fail in the actual MySQL trigger.
        with self.assertRaises(Exception):
            self.execute('UPDATE RACE_EDITION SET PrevRaceEventID=%s,PrevOccurrenceNo=%s WHERE RaceEventID=%s AND OccurrenceNo=%s',self.key+self.key)
        self.execute("INSERT INTO SCORING_SCHEME (ScoringSchemeID,VersionLabel) VALUES (999989,'Isolated range fixture')")
        self.execute('INSERT INTO SCORING_MATRIX_ENTRY VALUES (999989,80,1,5,80)')
        with self.assertRaises(Exception):self.execute('INSERT INTO SCORING_MATRIX_ENTRY VALUES (999989,80,4,7,70)')
        with self.assertRaises(Exception):
            self.execute("UPDATE COURSE SET VenueID=(SELECT VenueID FROM VENUE WHERE VenueID<>%s LIMIT 1) WHERE CourseID=%s",(self.course['VenueID'],self.cid))
        # Neither NULL verification nor an already-withdrawn row can bypass cancellation.
        q.cancel_edition(*self.key)
        for status in (None,'withdrawn'):
            with self.assertRaises(Exception):
                self.execute('INSERT INTO ACHIEVES_RESULT (RaceEventID,OccurrenceNo,CourseID,PersonID,VerificationStatus) VALUES (%s,%s,%s,%s,%s)',self.resultkey+(status,))

    def test_phase1_seed_selection_and_grouping(self):
        rows=q.high_factor_2025()
        self.assertEqual(len(rows),3)
        self.assertTrue(all(r['EditionStatus']=='completed' and r['StartDate'].year==2025 and r['RaceFactor']>=200 for r in rows))
        records=q.empire_record_minimum()
        self.assertEqual({int(r['FastestSeconds']) for r in records},{573,683})
        self.assertGreater(q.climb_height_average()['KnownCourses'],0)
        self.assertTrue(all(r['MeanAscentMps']>0 for r in q.ascent_speeds()))

if __name__=='__main__':unittest.main()
