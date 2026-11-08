"""Static, dependency-free cross-reference checks for the deterministic seed."""
from __future__ import annotations
import runpy
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
data=runpy.run_path(str(ROOT/'src'/'tools'/'build_population.py'))

def unique(rows,key,label):
    values=[key(x) for x in rows]
    assert len(values)==len(set(values)),f'duplicate {label}'

unique(data['race_events'],lambda x:x[0],'RaceEventID')
unique(data['venues'],lambda x:x[0],'VenueID')
unique(data['courses'],lambda x:x[0],'CourseID')
unique(data['editions'],lambda x:(x[0],x[1]),'RaceEdition owner + occurrence')
unique(data['offers'],lambda x:(x[0],x[1],x[2]),'Offer')
unique(data['results'],lambda x:(x[0],x[1],x[2],x[3]),'Canonical result triple')
unique(data['records'],lambda x:x[0],'CourseRecordID')

race_ids={r[0] for r in data['race_events']}
venue_ids={v[0] for v in data['venues']}
course_venues={c[0]:c[-1] for c in data['courses']}
edition_venues={(e[0],e[1]):e[21] for e in data['editions']}
offer_keys={(o[0],o[1],o[2]) for o in data['offers']}
athlete_ids={a[3] for a in data['athletes'].values()}
assert len(athlete_ids)==len(data['athletes'])
for ed in data['editions']:
    assert ed[0] in race_ids
    assert ed[21] is None or ed[21] in venue_ids
    if ed[3] is not None and ed[4] is not None:
        assert ed[3]<=ed[4],f'End date before start date {ed[0]}'
for o in data['offers']:
    assert (o[0],o[1]) in edition_venues
    assert o[2] in course_venues
    known=edition_venues[(o[0],o[1])]
    assert known is None or known==course_venues[o[2]],'Venue disagreement'
for r in data['results']:
    assert (r[0],r[1],r[2]) in offer_keys,'Result course not offered'
    assert r[3] in athlete_ids,'Result athlete not in persons'
    assert r[13] is None or r[13]>0
    assert r[14] is None or r[14]>=0
    assert r[9].startswith('https://www.towerrunning.com/'),r[9]
for r in data['records']:
    assert r[-2] in course_venues,'Record needs course'
    assert r[4] is None or r[4]>0

counts=(len(race_ids),len(edition_venues),len(athlete_ids),len(data['results']),len(venue_ids),len(course_venues),len(data['records']))
assert counts==(40,45,84,109,12,12,6),f'unexpected seed sizes: {counts}'
print('PASS: 40 races, 45 editions, 84 athletes, 109 results, 12 venues, 12 courses, 6 records')
print('PASS: unique keys, offered courses, existing FKs, valid sources, and venue consistency')
