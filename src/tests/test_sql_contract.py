"""No-database contract tests for complete, parameterized SQL implementation."""
import re
import sys
import unittest
from pathlib import Path
from unittest.mock import patch

SRC=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(SRC))
import queries


class SQLContracts(unittest.TestCase):
    def test_final_table_count_and_normalized_form(self):
        schema=(SRC/'schema.sql').read_text(encoding='utf-8')
        self.assertEqual(len(re.findall(r'\bCREATE\s+TABLE\s+\w+',schema,re.I)),30)
        self.assertIn('CREATE TABLE FORM',schema)
        self.assertIn('FOREIGN KEY (FormURL) REFERENCES FORM(FormURL)',schema)
        self.assertIn('REFERENCES OFFERS(RaceEventID, OccurrenceNo, CourseID)',schema)

    def test_query_filters_are_bound_as_parameters(self):
        with patch.object(queries,'all_rows',return_value=[]) as fetch:
            queries.race_search("a' OR 1=1 --",2025,200,'New York')
            sql,params=fetch.call_args.args
            self.assertNotIn("a' OR 1=1 --",sql)
            self.assertIn('a\' OR 1=1 --',params[0])
            self.assertGreaterEqual(sql.count('%s'),len(params))

    def test_raw_sql_contains_aggregations_and_joins(self):
        with patch.object(queries,'all_rows',return_value=[]) as fetch:
            queries.ascent_speeds()
            sql=fetch.call_args.args[0].upper()
            self.assertIn('JOIN',sql)
            self.assertIn('GROUP BY',sql)
            self.assertIn('AVG(',sql)
            self.assertIn('FINISHINGTIMESECONDS',sql)


if __name__=='__main__':unittest.main()
