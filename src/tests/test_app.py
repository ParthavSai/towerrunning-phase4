"""Flask route + form tests with the raw SQL layer mocked.

These tests do not need a running MySQL database and do not mutate source data.
Run: python -m unittest discover -s src/tests -v
"""
import sys
import unittest
from pathlib import Path
from unittest.mock import Mock, patch

sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
import app as app_module


class AppTest(unittest.TestCase):
    def setUp(self):
        self.app=app_module.app
        self.app.config.update(TESTING=True,SECRET_KEY='test-session-secret')
        self.client=self.app.test_client()

    def test_every_static_data_page_renders_with_empty_queries(self):
        stubs={
            'counts':{'races':0,'editions':0,'athletes':0,'results':0,'venues':0,'countries':0},
            'highlights':[], 'race_search':[], 'athlete_search':[], 'points_leaderboard':[],
            'published_rankings':[], 'course_records':[], 'venue_directory':[],
            'high_factor_2025':[], 'young_athletes':[], 'empire_record_minimum':[],
            'climb_height_average':{'AverageHeightMetres':None,'KnownCourses':0},
            'ascent_speeds':[], 'scoring_audit':[], 'edit_choices':([],[]),
            'draft_editions':[], 'membership_choices':[], 'recent_memberships':[],
        }
        with patch.multiple(app_module.queries, **{
            name: Mock(return_value=value) for name, value in stubs.items()
        }):
            for path in ['/','/races','/athletes','/rankings','/records','/venues','/insights','/manage']:
                with self.subTest(path=path):
                    res=self.client.get(path)
                    self.assertEqual(res.status_code,200)
                    self.assertIn(b'<html',res.data)

    def test_frontend_styles_and_scripts_are_served(self):
        """Catch broken CSS paths before the project is submitted."""
        css=self.client.get('/static/style.css')
        self.assertEqual(css.status_code, 200)
        self.assertIn(b'font-family:Montserrat', css.data)
        self.assertIn(b'.site-header', css.data)
        self.assertIn('text/css', css.content_type)
        css.close()

        js=self.client.get('/static/main.js')
        self.assertEqual(js.status_code, 200)
        self.assertIn(b'menu-toggle', js.data)
        js.close()

        with patch.object(app_module.queries,'counts',return_value={
            'races':0,'editions':0,'athletes':0,'results':0,'venues':0,'countries':0
        }), patch.object(app_module.queries,'highlights',return_value=[]):
            page=self.client.get('/')
        self.assertEqual(page.status_code,200)
        self.assertIn(b'href="/static/style.css"', page.data)
        self.assertIn(b'src="/static/main.js"', page.data)
        self.assertIn(b'fonts.googleapis.com/css2?family=Montserrat', page.data)

    def test_post_without_csrf_is_rejected(self):
        with patch.object(app_module.queries,'create_draft') as create:
            response=self.client.post('/manage/create',data={'event_id':'103'})
            self.assertEqual(response.status_code,400)
            create.assert_not_called()

    def test_create_draft_calls_parameterized_query_function(self):
        with patch.object(app_module.queries,'create_draft',return_value=3) as create:
            with self.client.session_transaction() as sess:
                sess['_csrf_token']='secure-test-token'
            response=self.client.post('/manage/create',data={
                '_csrf_token':'secure-test-token','event_id':'103','start_date':'2027-04-01',
                'end_date':'2027-04-01','factor':'80','venue_id':'','note':'Local draft',
            })
            self.assertEqual(response.status_code,302)
            self.assertEqual(create.call_count,1)
            self.assertEqual(create.call_args.args[0],103)
            self.assertEqual(create.call_args.args[3],80)

    def test_date_validation_rejects_reversed_dates(self):
        with patch.object(app_module.queries,'create_draft') as create:
            with self.client.session_transaction() as sess:
                sess['_csrf_token']='secure-test-token'
            response=self.client.post('/manage/create',data={
                '_csrf_token':'secure-test-token','event_id':'103','start_date':'2027-10-01',
                'end_date':'2027-04-01','factor':'80','venue_id':'','note':'Local draft',
            })
            self.assertEqual(response.status_code,302)
            create.assert_not_called()

    def test_membership_insert_is_pending_only(self):
        with patch.object(app_module.queries,'create_membership') as create:
            with self.client.session_transaction() as sess:
                sess['_csrf_token']='secure-test-token'
            response=self.client.post('/manage/membership',data={
                '_csrf_token':'secure-test-token','person_id':'1001','membership_year':'2027',
                'valid_from':'2027-01-01','valid_until':'2027-12-31'
            })
            self.assertEqual(response.status_code,302)
            create.assert_called_once()


if __name__=='__main__':unittest.main()
