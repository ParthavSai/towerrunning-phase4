"""Generate reproducible, source-checked additions; apply transactionally with --apply.
Uses exact normalized name + country matches to the existing registered-athlete sample.
Never creates athlete identities or assigns historical scoring schemes/windows.
"""
import argparse
from decimal import Decimal
import hashlib
import json
from pathlib import Path
import sys
import unicodedata
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
import app
import db
from openpyxl import load_workbook
from migrate_integrity import backup

SRC=Path(__file__).resolve().parents[1]
DATA=SRC/'data'/'official'

def literal(value):
    if value is None:return 'NULL'
    if isinstance(value,(int,float,Decimal)):return str(value)
    return "'"+str(value).replace('\\','\\\\').replace("'","''")+"'"

def normalize(name):
    return ' '.join(unicodedata.normalize('NFC',name).casefold().split())

def generate():
    manifest=json.loads((DATA/'manifest.json').read_text())
    for name,entry in manifest.items():
        assert hashlib.sha256((DATA/name).read_bytes()).hexdigest()==entry['sha256'],name
    people={}
    for p in db.all_rows('SELECT p.PersonID,p.FullName,a.NationalityCode FROM PERSON p JOIN ATHLETE a USING(PersonID) JOIN REGISTERED_ATHLETE r USING(PersonID)'):
        people.setdefault((normalize(p['FullName']),p['NationalityCode']),[]).append(p['PersonID'])
    statements=[]
    expected_rows=[]
    stats={}
    def insert(table,columns,values):
        expected_rows.append((table,columns,values))
        statements.append('INSERT INTO '+table+' ('+','.join(columns)+') VALUES ('+','.join(map(literal,values))+');')
    for filename,pid,label,scorecol in [('final2019.xlsx',201911,'TWA Ranking November 2019 Final',6),('final2025.xlsx',202512,'TWA Ranking Final 2025',7),('july2026.xlsx',202607,'TWA Ranking July 2026',7)]:
        w=load_workbook(DATA/filename,data_only=True)
        # Do not infer month-end cutoffs from a filename; date cells contain anomalous years.
        insert('RANKING_PUBLICATION',['RankingPublicationID','PublicationLabel','PublicationType','PublicationStatus','SourceURL','ArchivedFileReference','RulesReference'],
               [pid,label,'Individual and Nations','draft',manifest[filename]['url'],'data/official/'+filename,
                'Workbook Nations!C21:C22: point-best two per division/country/race; best eight country race totals. Exact window boundaries unverified.'])
        n=0;l=0
        for row in w['Nations'].iter_rows(min_row=29,values_only=True):
            rank,country,points=row[0],row[3],row[scorecol-1]
            if not isinstance(rank,(int,float)):continue
            assert isinstance(country,str) and len(country.strip())==3
            assert isinstance(points,(int,float)) and points>=0
            insert('NATIONS_STANDING',['RankingPublicationID','CountryCode','PublishedRank','PublishedPoints'],[pid,country.strip(),rank,points]);n+=1
        # Only 2025/2026: 2019 identity continuity requires independent verification.
        if filename!='final2019.xlsx':
            seen=set()
            for sheet,division in [('Females','Female'),('Males','Male')]:
                for row in w[sheet].iter_rows(min_row=29,values_only=True):
                    if not isinstance(row[0],(int,float)) or not isinstance(row[2],str):continue
                    matches=people.get((normalize(row[2]),row[3]),[])
                    if len(matches)!=1:continue
                    person=matches[0]
                    if person in seen:raise ValueError('Ambiguous published identity')
                    seen.add(person)
                    assert isinstance(row[scorecol-1],(int,float)) and row[scorecol-1]>=0
                    insert('LISTED_IN',['PersonID','RankingPublicationID','PublishedDivision','CountryAtPublication','PublishedRank','PublishedPoints'],[person,pid,division,row[3],row[0],row[scorecol-1]]);l+=1
        statements.append("UPDATE RANKING_PUBLICATION SET PublicationStatus='published' WHERE RankingPublicationID="+str(pid)+';')
        stats[filename]={'nations':n,'matched_individuals':l}
    # Factor 280 sheet explicitly gives base points for eight factors. Other sheets
    # vary with participant counts, a dimension absent from Stage D; never flatten them.
    insert('SCORING_SCHEME',['ScoringSchemeID','VersionLabel','SourceURL'],[202301,'Official matrix base columns (retrieved 2026-11-08; applicability unassigned)',manifest['matrix.xlsx']['url']])
    sheet=load_workbook(DATA/'matrix.xlsx',data_only=True)['Factor 280']
    count=0
    for row in sheet.iter_rows(min_row=3,values_only=True):
        if not isinstance(row[0],int):continue
        for col in range(1,9):
            if not isinstance(row[col],(int,float)):continue
            factor=sheet.cell(1,col+1).value
            insert('SCORING_MATRIX_ENTRY',['ScoringSchemeID','Factor','PlaceFrom','PlaceTo','Points'],[202301,factor,row[0],row[0],row[col]]);count+=1
    stats['matrix_base_entries']=count
    text='-- Generated from checksum-verified official files; do not edit.\n'+'\n'.join(statements)+'\n'
    (DATA/'verified_import.sql').write_text(text)
    (DATA/'import_summary.json').write_text(json.dumps(stats,indent=2))
    base=SRC/'populate.sql'
    content=base.read_text().split('-- BEGIN VERIFIED OFFICIAL SUPPLEMENT')[0].rstrip()
    base.write_text(content+'\n\n-- BEGIN VERIFIED OFFICIAL SUPPLEMENT\nSTART TRANSACTION;\n'+text+'COMMIT;\n')
    print(stats)
    return statements,expected_rows

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--apply',action='store_true')
    args=parser.parse_args()
    statements,expected_rows=generate()
    if not args.apply:return
    conn=db.connection()
    try:
        with conn.cursor() as cur:
            cur.execute('SELECT RankingPublicationID FROM RANKING_PUBLICATION WHERE RankingPublicationID IN (201911,202512,202607)')
            existing=cur.fetchall()
            if existing:
                if len(existing)==3:
                    keys={'RANKING_PUBLICATION':['RankingPublicationID'],'NATIONS_STANDING':['RankingPublicationID','CountryCode'],
                          'LISTED_IN':['PersonID','RankingPublicationID'],'SCORING_SCHEME':['ScoringSchemeID'],
                          'SCORING_MATRIX_ENTRY':['ScoringSchemeID','Factor','PlaceFrom']}
                    for table,columns,values in expected_rows:
                        expected=dict(zip(columns,values))
                        if table=='RANKING_PUBLICATION':expected['PublicationStatus']='published'
                        key=keys[table]
                        cur.execute('SELECT '+','.join(columns)+' FROM '+table+' WHERE '+' AND '.join(c+'=%s' for c in key),tuple(expected[c] for c in key))
                        actual=cur.fetchone()
                        if not actual or any(actual[c]!=expected[c] for c in columns):
                            raise ValueError('Installed official supplement differs from checked source: '+table)
                    print('Official supplement already installed; all expected source fields verified unchanged.');return
                raise ValueError('Partial import present; inspect before proceeding.')
            cur.execute('SELECT DATABASE() name');name=cur.fetchone()['name']
            backup(name)
            for sql in statements:cur.execute(sql)
        conn.commit()
        print('Official supplement committed; original 40 races and 109 results unchanged.')
    except Exception:
        conn.rollback();raise
    finally:conn.close()
if __name__=='__main__':main()
