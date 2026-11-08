"""Input/security boundaries; SQL transactions are tested by tools/integration_test.py."""
import sys
import unittest
from decimal import Decimal
from pathlib import Path
from unittest.mock import patch
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
import app
import queries


class ManagementValidation(unittest.TestCase):
    def test_invalid_measurements_never_open_transaction(self):
        with patch.object(queries,'management_write') as write:
            for args in ((1,None,None,True),(1,0,None,True),(1,-1,None,True),
                         (1,None,Decimal('NaN'),True),(1,None,Decimal('Infinity'),True),
                         (1,20,None,False)):
                with self.subTest(args=args), self.assertRaises(ValueError):
                    queries.correct_course(*args)
            write.assert_not_called()

    def test_invalid_result_domains_never_open_transaction(self):
        with patch.object(queries,'management_write') as write:
            for seconds,place,points in ((Decimal('-1'),None,None),
                                        (Decimal('NaN'),None,None),
                                        (None,0,None),(None,None,Decimal('-1'))):
                with self.assertRaises(ValueError):
                    queries.insert_result(1,1,1,1,seconds,place,points)
            write.assert_not_called()

    def test_all_operation_forms_require_csrf(self):
        client=app.app.test_client()
        for action in ('course','cancel','result','disqualify'):
            with self.subTest(action=action):
                self.assertEqual(client.post('/manage/operation/'+action).status_code,400)

    def test_cannot_request_official_verification(self):
        client=app.app.test_client()
        with client.session_transaction() as session: session['_csrf_token']='test'
        with patch.object(queries,'insert_result') as insert:
            response=client.post('/manage/operation/result',data={
                '_csrf_token':'test','verification':'verified','event_id':'1',
                'occurrence':'1','course_id':'1','person_id':'1'})
            self.assertEqual(response.status_code,302)
            insert.assert_not_called()
