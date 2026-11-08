"""Create an isolated persistent demo DB; development database remains unchanged.
Prints identifiers for the UI recording. Drop this demo DB manually after recording.
"""
import uuid
from pathlib import Path
import integration_test as fixture
import db


def main():
    name='towerrunning_demo_'+uuid.uuid4().hex[:8]
    conn=db.connection()
    try:
        src=Path(__file__).resolve().parents[1]
        fixture.script(conn,src/'schema.sql',name)
        fixture.script(conn,src/'populate.sql',name)
        with conn.cursor() as cur:
            cur.execute('SELECT CourseID,VenueID FROM COURSE ORDER BY CourseID LIMIT 1')
            course=cur.fetchone()
            cur.execute('SELECT MIN(RaceEventID) event FROM RACE_EVENT');event=cur.fetchone()['event']
            cur.execute('SELECT MIN(PersonID) person FROM REGISTERED_ATHLETE');person=cur.fetchone()['person']
            cur.execute('SELECT COALESCE(MAX(OccurrenceNo),0)+1 occurrence FROM RACE_EDITION WHERE RaceEventID=%s',(event,));first=cur.fetchone()['occurrence']
            for occurrence in (first,first+1):
                cur.execute("INSERT INTO RACE_EDITION (RaceEventID,OccurrenceNo,StartDate,EndDate,VenueID,EditionStatus,AdditionalInformation) VALUES (%s,%s,'2027-01-01','2027-01-01',%s,'planned','ISOLATED RECORDING FIXTURE')",(event,occurrence,course['VenueID']))
                cur.execute("INSERT INTO OFFERS VALUES (%s,%s,%s,'selected',NULL)",(event,occurrence,course['CourseID']))
        conn.commit()
        print('Demo database:',name)
        print('Start app: DB_NAME='+name+' python src/app.py')
        print('Course:',course['CourseID'],'athlete:',person,'event:',event)
        print('Result insertion edition:',first,'cancellation edition:',first+1)
        print('All fixture modifications are isolated; no official decisions are fabricated.')
    finally:conn.close()

if __name__=='__main__':main()
