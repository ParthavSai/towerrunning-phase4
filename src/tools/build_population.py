"""Offline, deterministic generator for src/populate.sql.

All real-world fields in SEED below are transcribed from the documented official
source pages (src/docs/DATA_PROVENANCE.md). Unknown data is always SQL NULL. IDs and
'Primary stair route' labels are database-internal identifiers/descriptors.
No network, synthetic athletes or arbitrary point values are used.
"""
from __future__ import annotations
import pathlib
from datetime import date
from collections import defaultdict

ROOT = pathlib.Path(__file__).resolve().parents[2]
OUT = ROOT / 'src' / 'populate.sql'
CALENDAR = 'https://www.towerrunning.com/towerrunning-tour-2026/'
DETAIL = {
 'Barcelona Tower Run Challenge x Mirador Torre Glòries': ('https://www.towerrunning.com/races/r3100/', 'CUPRA Barcelona Tower Running Challenge', 'Torre Glòries','ESP', 'Barcelona',686,34,116,1,'Ivan Vuletić','Tea Faber','T','R3100'),
 'Tower Run Basel': ('https://www.towerrunning.com/races/r3024/','Tower Run Basel','Messeturm','SUI','Basel',542,31,None,1,'Wai Ching Soh','Seow Cher Tan','T','R3024'),
 'Deutsche Post Tower Run':('https://www.towerrunning.com/races/r3207/','Deutsche Post Tower Run','Post Tower','GER','Bonn',828,41,None,6,'Görge Heimann','Adele Blaise-Sohnius','T','R3207'),
 'KL Tower Run International Challenge':('https://www.towerrunning.com/races/r3276/','KL Tower Run International Challenge','KL Tower','MAS','Kuala Lumpur',1608,None,292,23,'Piotr Lobodzinski','Tea Faber','T','R3276'),
 'Raffles City Chongqing Vertical Challenge':('https://www.towerrunning.com/races/r3389/','Raffles City Chongqing Vertical Challenge','Raffles City Tower South','CHN','Chongqing',1178,42,250,3,'Wai Ching Soh','Zhuoman Zheng','R','R3389'),
 'SprintTower 365':('https://www.towerrunning.com/races/r3203/','SprintTower 365','Escalinata de San Simon Tlatlauquitepec','MEX','Xaltocan',365,None,None,2,'Fernando Carreño Ortiz','Jessica Mariana Velez Gutierrez','R','R3203'),
}
# date, factor, city, race, remarks — transcribed from the official 2026 Tour page.
TOUR = [
('01-01',60,'Haikou','IVM Tour Haikou R&F The Top Station',''),
('01-10',200,'Shenzhen','International Vertical Marathon PingAn',''),
('01-17',120,'Barcelona','Barcelona Tower Run Challenge x Mirador Torre Glòries',''),
('02-22',80,'Chicago','Hustle Chicago','US Championships'),
('03-28',120,'Benidorm','Subida Vertical Gran Hotel Bali',''),
('03-28',120,'Warsaw','Bieg Na Szczyt Rondo 1',''),
('03-29',80,'Tallinn','Teletorni Trepijooks - TV Tower Run','Estonian Championships'),
('05-09',200,'Taipei','Taipei 101 Run Up',''),
('05-17',60,'Tianjin','IVM Tour Tianjin R&F Center Station',''),
('05-29',160,'Vienna','DC Tower Run',''),
('05-30',60,'Basel','Tower Run Basel',''),
('06-07',80,'Frankfurt','Skyrun MesseTurm Frankfurt',''),
('06-14',60,'Bonn','Deutsche Post Tower Run',''),
('06-19',60,'Bad Wildbad','Bad Wildbader Stäffeleslauf',''),
('06-21',80,'Cologne','KoelnTurm Treppenlauf','German Championships'),
('06-27',80,'Bratislava','UFO Vertical Sprint','Slovak Championships'),
('08-08',60,'Guangzhou','International Vertical Marathon Guangzhou Yingkai Square Station',''),
('08-20',80,'Singapore','Frasers Tower Vertical Challenge','Singapore Championships'),
('08-22',120,'Kuala Lumpur','The Sky Race','2 days 22.-23.'),
('08-23',80,'Gold Coast','Q1 Stair Challenge','Australian Championships'),
('09-13',120,'Keutschach','Pyramidenkogel Turmlauf',''),
('09-19',120,'Warsaw','Varso Tower Run',''),
('09-20',120,'Kuala Lumpur','KL Tower Run International Challenge',''),
('09-20',60,'Rottweil','TK Elevator Towerrun',''),
('09-20',80,'Brno','Schody AZ Nahoru','Czech Championships'),
('09-26',80,'Wroclaw','Sky Tower Run','Polish Championships'),
('10-03',120,'Barcelona','Metropolitan Sky Run',''),
('10-06',80,'New York','Empire State Building Run Up',''),
('10-11',80,'Torino','Vertical Grattacielo Regione Piemonte','Italian Championships'),
('10-17',60,'Chongqing','Raffles City Chongqing Vertical Challenge',''),
('10-18',60,'Tbilisi','Mtatsminda Run Up',''),
('10-24',200,'Shenzhen','International Vertical Marathon PingAn',''),
('10-31',160,'Shanghai','Sky Marathon SWFC',''),
('11-07',60,'Hong Kong','Hong Chi Climbathon',''),
('11-08',80,'Chicago','SkyRise Chicago',''),
('11-14',120,'Bucharest','Sky Run Bucharest',''),
('11-15',120,'Macau','Oxfam Tower Run',''),
('11-15',60,'Jakarta','Jakarta Vertical Run',''),
('11-27',80,'Acapulco','Towerrunning Grand Prix Acapulco','3 day event'),
('11-28',240,'Shanghai','Shanghai Tower Towerrunning Challenge','Towerrunning Tour Final'),
]
# Official race detail pages, male/female tables. Published point values and *overall*
# placing are copied exactly. Blank time cells are represented as None, not 0.
RESULTS = {
'Barcelona Tower Run Challenge x Mirador Torre Glòries': {
'M': '''CRO2002M001|Ivan Vuletić|1|120
POL1988M001|Mateusz Marunowski|2|102
AUT1988M001|Klaus Hausleitner|3|90
ITA1981M001|Fabio Ruga|4|81
ESP1994M001|Angel López Amor|6|66
AUT1987M003|Daniel Weißenböck|7|60
ESP1988M002|Marc Rocadembosch|8|54
GER1968M001|Görge Heimann|9|49.5
ESP1974M002|Ignacio Cardona Torres|10|45
CZE1985M001|Pavel Holec|11|40.5
SVK2001M001|Marek Smetana|12|36
CZE1992M002|Michal Dočkálek|13|33
NED1996M001|Wesley Smulders|14|30
POL1989M004|Adrian Bednarski|15|27
ROU1980M001|Raphael Igrișianu|16|24
CZE1975M001|Jindrich Schick|24|10.5
GBR1992M002|Luciano Leo|25|9''',
'F': '''CRO1989F001|Tea Faber|1|120
SVK1995F001|Kamila Chomaničová|2|102
AUT1984F002|Annemarie Wilhelm|3|90
POL1993F001|Klaudia Krajewska|4|81
TPE1977F001|Jui Chuan Chao|5|72
ITA1975F001|Cristina Bonacina|6|66
GER1985F001|Claudia Maria Henneken|7|60
ESP1995F001|Elena B. de Castro|8|54
ESP1968F001|Laurence Rastell Diaz|9|49.5
ESP1976F001|Gemma Villacampa Marín|12|36
CZE1981F001|Lenka Wallová|14|30
GBR1998F001|Bianca Tirabosco|30|1.5'''
},
'Tower Run Basel': {
'M': '''MAS1994M001|Wai Ching Soh|1|60
GER1992M001|Matthias Lauer|2|48
ESP1984M001|Marc Toda Vericat|3|40
CZE1992M002|Michal Dočkálek|6|24
GBR1992M002|Luciano Leo|14|7
SUI1960M001|Daniel Ackermann|23|0.5
SIN1978M001|Eddie Tan|34|0.5
SLO1962M001|Silvester Gomboc|41|0.5''',
'F': '''SIN1979F001|Seow Cher Tan|1|60
ESP1995F001|Elena B. de Castro|2|48
CZE1981F001|Lenka Wallová|3|40
GBR1998F001|Bianca Tirabosco|10|11
ESP1985F001|Patricia Pinar Riba|20|1'''
},
'Deutsche Post Tower Run': {
'M': '''GER1968M001|Görge Heimann|1|60
GER1979M002|Andreas Fruhmann|2|48
GER1979M003|Matthias Gall|3|40
GER1976M001|Sylvio Atmanspacher|10|11
GER1973M001|Michael Schneider|12|9
GER1963M001|Siegfried Flor|34|0.5
GER1988M001|Hasan Hüseyin Karadaş|38|0.5
GER1965M001|David Leitheiser|50|0.5''',
'F': '''CAN1985F001|Adele Blaise-Sohnius|1|60
GER1974F001|Cordula Galster|2|48'''
},
'KL Tower Run International Challenge': {
'M': '''POL1985M001|Piotr Lobodzinski|1|120
MAS1994M001|Wai Ching Soh|2|102
CHN1991M001|Jiandong Xue|3|90
AUS1983M001|Mark Bourne|4|81
TPE1997M003|Ching Chun Lo|5|72
MAS2001M001|Muhammad Hazim Zuhairi Bin Azahari|8|54
MAS1988M005|Wong Chin Chun|9|49.5
NZL1983M001|Chris Dufton|11|40.5
GBR1975M003|Jeffrey Ross|13|33
MAS1971M001|Song Hua Tan|18|19.5
MAS1975M002|Chee Choon Chow|19|18
ESP1983M002|Luis Eduardo García Capel|24|10.5
MAS1990M003|Muhamad Idham|31|0.5
MAS1993M004|Pearljit Singh|33|0.5
MAS1990M002|Hwee Aun Khaw|35|0.5''',
'F': '''CRO1989F001|Tea Faber|1|120
JPN1986F001|Yuko Tateishi|2|102
HKG1986F001|Tsz Yau Li|3|90
SIN1983F001|Serene Cheong|4|81
MAS2014F001|Rhea Assyifa|5|72
MAS1984F001|Michele Tan Bee Kiang|6|66
SIN1979F001|Seow Cher Tan|7|60
MAS2012F001|Raisya Adelea|8|54
AUS1982F002|Cindy Reid|9|49.5
MAS1990F001|Wen Yee Lim|10|45'''
},
'SprintTower 365': {
'M': '''MEX1988M001|Fernando Carreño Ortiz|1|40
MEX1992M001|Marco Antonio de la Cruz|3|26
MEX1999M001|Jesus Raya Castillo|4|22
MEX1970M001|Andrés Manzo|8|10
MEX1974M001|Arturo Velazquez Leyva|9|8
MEX1979M001|Jaime Alvarez Barreda|11|5''',
'F': '''MEX1991F002|Jessica Mariana Velez Gutierrez|1|40
MEX1982F001|Blanca Romero|2|32
MEX1965F001|Elizabeth Aguilar Becerril|3|26
MEX1989F002|Lisbeth Mendez|5|18
MEX1972F001|Rosa Maria Gonzalez|15|1'''
},
'Raffles City Chongqing Vertical Challenge': {
'M': '''MAS1994M001|Wai Ching Soh|1|60''',
'F': ''''''
}
}

def sqlval(v):
    if v is None: return 'NULL'
    if isinstance(v,bool): return '1' if v else '0'
    if isinstance(v,(int,float)): return str(v)
    return "'"+str(v).replace('\\','\\\\').replace("'","''")+"'"

def insert(table, cols, rows):
    if not rows: return ''
    keys=', '.join('`'+c+'`' for c in cols)
    records=',\n'.join('  ('+', '.join(sqlval(v) for v in row)+')' for row in rows)
    return f'INSERT INTO {table} ({keys}) VALUES\n{records};\n\n'

# Deterministic surrogate keys for the one archived edition of each race event.
names=list(dict.fromkeys([r[3] for r in TOUR]+['SprintTower 365']))
event_id={name:101+i for i,name in enumerate(names)}
occurrences=defaultdict(int)
editions=[]
race_events=[]
venues=[]
courses=[]
offers=[]
include=[]
notes=[]
calendar_ids={name for _,_,_,name,_ in TOUR}
venue_id_by_name={}
source_urls=[]

for idx,name in enumerate(names):
    city=next((r[2] for r in TOUR if r[3]==name),'Xaltocan')
    description=f'Official Towerrunning 2026 Tour calendar city: {city}.' if name in calendar_ids else 'Official Towerrunning race detail: Xaltocan, Mexico.'
    if name=='International Vertical Marathon PingAn': description+=' Two race dates are listed in the 2026 Tour calendar.'
    race_events.append((event_id[name], DETAIL[name][0] if name in DETAIL else CALENDAR, description, name))
    if name in DETAIL:
        d=DETAIL[name]
        vid=201+len(venues)
        venue_id_by_name[name]=vid
        venues.append((vid,d[2],'tower' if d[2]!='Escalinata de San Simon Tlatlauquitepec' else 'outdoor',d[3],d[4],None,'Source: '+d[0]))
        courses.append((301+len(courses),'Published staircase route',None,'single climb',d[5],d[6],d[7],'confirmed',vid))

# Add sourced Rottweil venue details from official historical race listing.
vid=201+len(venues)
venue_id_by_name['TK Elevator Towerrun']=vid
venues.append((vid,'Testturm','tower','GER','Rottweil',None,'1390 stairs and 232 metres, according to official R2703 race detail.'))
courses.append((301+len(courses),'Published staircase route',None,'single climb',1390,None,232,'confirmed',vid))

# The 2026 Empire State Building event lists its venue, stairs and record holders.
# Keep its details tied to the 2026 source, rather than inventing a second route.
empire_source='https://www.towerrunning.com/races/r3253/'
empire_venue=201+len(venues)
venue_id_by_name['Empire State Building Run Up']=empire_venue
venues.append((empire_venue,'Empire State Building','tower','USA','New York',None,
               '1576 stairs and 86 floors; source: '+empire_source))
courses.append((301+len(courses),'Empire State Building main stair route',None,
               'single climb',1576,86,None,'confirmed',empire_venue))

# One event can have more than one 2026 occurrence (the two Shenzhen dates).
for md,factor,city,name,remark in TOUR+[('03-22',40,'Xaltocan','SprintTower 365','Extra race verified on official 2026 race detail page (not on the displayed Tour list).')]:
    eid=event_id[name]
    occurrences[name]+=1
    occ=occurrences[name]
    details=DETAIL.get(name)
    race_date='2026-'+md
    is_detail=bool(details)
    url=details[0] if is_detail else CALENDAR
    published_no=details[8] if is_detail else None
    finalname=details[1] if is_detail else name
    status='completed' if is_detail else ('planned' if race_date>'2026-11-08' else None)
    additional=remark or None
    end_date='2026-08-23' if name=='The Sky Race' else ('2026-11-29' if name=='Towerrunning Grand Prix Acapulco' else race_date)
    editions.append((eid,occ,published_no,race_date,end_date,None,factor,details[11] if is_detail else None,status,None,details[12].lower() if is_detail else None,url,'2026-11-08',None,None,details[9] if is_detail else None,details[10] if is_detail else None,None,None,additional,None,venue_id_by_name.get(name),None,None))
    # This listed edition has a separate official detail page, including its venue.
    if name=='Empire State Building Run Up':
        row=list(editions[-1])
        row[2]=48              # Published edition number
        row[8]='completed'
        row[10]='r3253'
        row[11]=empire_source
        row[15]='Ryoji Watanabe'
        row[16]='Annemarie Wilhelm'
        row[21]=empire_venue
        editions[-1]=tuple(row)
    if name in calendar_ids:
        include.append((eid,occ,1,'Tour final' if name=='Shanghai Tower Towerrunning Challenge' else 'championship stage' if 'Championship' in remark else 'ordinary',remark or None))
    if name in venue_id_by_name:
        course_id=next(course[0] for course in courses if course[-1]==venue_id_by_name[name])
        offers.append((eid,occ,course_id,'selected' if is_detail else 'pending',url))

# Create athlete and results rows, deduplicating TWA IDs and retaining source spellings.
athletes={}
results=[]
for name in RESULTS:
    detail=DETAIL[name]
    eid=event_id[name]
    course_id=next(c[0] for c in courses if c[-1]==venue_id_by_name[name])
    for gender,raw in RESULTS[name].items():
        for line in raw.strip().splitlines():
            if not line.strip(): continue
            athleteid,athletename,place,pts=line.strip().split('|')
            if athleteid in athletes:
                if athletes[athleteid][0]!=athletename:
                    raise AssertionError(f'Conflicting source names for {athleteid}')
            else:
                athletes[athleteid]=(athletename,gender,athleteid[:3],1001+len(athletes))
            personid=athletes[athleteid][3]
            time_seconds=1023 if (name=='Raffles City Chongqing Vertical Challenge' and athleteid=='MAS1994M001') else None
            results.append((eid,1,course_id,personid,'Male' if gender=='M' else 'Female',athleteid[:3],'finished','verified','none',detail[0],None,None,int(place),time_seconds,float(pts)))

# Historical source-backed editions: 2025 records needed to exercise the original
# Phase 1 high-factor/2025 selection and multi-year race history.
# URLs are official event detail pages, not invented source files.
HISTORICAL_URLS = {
    'Bieg Na Szczyt Rondo 1': 'https://www.towerrunning.com/races/r2929/',
    'Taipei 101 Run Up': 'https://www.towerrunning.com/races/r2940/',
    'The Sky Race': 'https://www.towerrunning.com/races/r3006/',
    'Skyrun MesseTurm Frankfurt': 'https://www.towerrunning.com/races/r2950/',
}
HISTORICAL = [
    ('Bieg Na Szczyt Rondo 1','2025-04-12',200,13,'r2929','Rondo 1','POL','Warsaw',836,38,None,'Wai Ching Soh','Tea Faber'),
    ('Taipei 101 Run Up','2025-05-03',200,18,'r2940','Taipei 101','TWN','Taipei',2046,91,None,'Ryoji Watanabe','Tea Faber'),
    ('The Sky Race','2025-08-30',200,1,'r3006','Merdeka 118','MAS','Kuala Lumpur',2845,118,503,'Wai Ching Soh','Yuko Tateishi'),
    ('Skyrun MesseTurm Frankfurt','2025-06-01',80,16,'r2950','Messeturm Frankfurt','GER','Frankfurt',1200,61,None,'Christian Riedl','Adele Blaise-Sohnius'),
]
for name, start, factor, pubno, code, venue_name, country, city, stairs, floors, height, male, female in HISTORICAL:
    eid=event_id[name]
    occurrences[name]+=1
    occ=occurrences[name]
    vid=201+len(venues)
    venue_id_by_name[name+' 2025']=vid
    source=HISTORICAL_URLS[name]
    venues.append((vid,venue_name,'tower',country,city,None,'2025 route from official page '+source))
    cid=301+len(courses)
    courses.append((cid,'Official 2025 climb course',None,'single climb',stairs,floors,height,'confirmed',vid))
    editions.append((eid,occ,pubno,start,start,None,factor,'T','completed','in-person',code,source,'2026-11-08',None,None,male,female,'unverified',None,'Source-backed historical edition; official 2025 race detail.',None,vid,None,None))
    offers.append((eid,occ,cid,'selected',source))
    include.append((eid,occ,2,'ordinary',None))

# A small but complete 2025 Warsaw result extract; the same published official
# table supplies both country and point information (no synthetic scores).
WARSAW_2025 = {
 'M': '''MAS1994M001|Wai Ching Soh|1|200|437
JPN1984M001|Ryoji Watanabe|2|170|
ITA1981M001|Fabio Ruga|3|150|
POL1985M001|Piotr Lobodzinski|4|135|
AUT1988M001|Klaus Hausleitner|5|120|
CRO2002M001|Ivan Vuletić|7|100|''',
 'F': '''CRO1989F001|Tea Faber|1|200|563
POL1987F001|Iwona Wicha|2|170|
ITA1980F001|Valentina Belotti|3|150|
CAN1985F001|Adele Blaise-Sohnius|4|135|
POL1993F001|Klaudia Krajewska|5|120|
JPN1986F001|Yuko Tateishi|6|110|'''
}
for gender, rows in WARSAW_2025.items():
    for line in rows.strip().splitlines():
        twa_id, person_name, place, point, seconds=line.split('|')
        if twa_id in athletes:
            if athletes[twa_id][0] != person_name:
                raise ValueError('Source athlete name mismatch for '+twa_id)
        else:
            athletes[twa_id]=(person_name,gender,twa_id[:3],1001+len(athletes))
        pid=athletes[twa_id][3]
        results.append((event_id['Bieg Na Szczyt Rondo 1'],2,
            next(c[0] for c in courses if c[-1]==venue_id_by_name['Bieg Na Szczyt Rondo 1 2025']),
            pid,'Male' if gender=='M' else 'Female',twa_id[:3],
            'finished','verified','none',HISTORICAL_URLS['Bieg Na Szczyt Rondo 1'],
            None,None,int(place),int(seconds) if seconds else None,float(point)))

# Eight fully sourced 2025 Taipei results: placements and points from the race
# detail, precise times from the official post-event Top4 report (May 3, 2025).
# This allows the >250 m ascent-speed report to return meaningful real rows.
taipei_news='https://www.towerrunning.com/2025/05/03/top4-towerrunning-200-taipei-101-run-up/'
taipei_source=HISTORICAL_URLS['Taipei 101 Run Up']
taipei_cid=next(c[0] for c in courses if c[-1]==venue_id_by_name['Taipei 101 Run Up 2025'])
TAIPEI_TIMED=[
 ('JPN1984M001','Ryoji Watanabe','M',1,200,682.88),
 ('MAS1994M001','Wai Ching Soh','M',2,170,724.83),
 ('AUS1983M001','Mark Bourne','M',3,150,732.14),
 ('ITA1977M001','Emanuele Manzi','M',4,135,743.40),
 ('CRO1989F001','Tea Faber','F',1,200,848.94),
 ('ITA1980F001','Valentina Belotti','F',2,170,849.19),
 ('FIN1973F001','Laura Manninen','F',3,150,869.27),
 ('TPE1977F001','Jui Chuan Chao','F',4,135,909.93),
]
for twa_id, person_name, gender, place, points, seconds in TAIPEI_TIMED:
    if twa_id in athletes:
        if athletes[twa_id][0]!=person_name:
            raise ValueError('Official name mismatch in Taipei sample for '+twa_id)
    else:
        athletes[twa_id]=(person_name,gender,twa_id[:3],1001+len(athletes))
    results.append((event_id['Taipei 101 Run Up'],2,taipei_cid,
        athletes[twa_id][3],'Male' if gender=='M' else 'Female',twa_id[:3],
        'finished','verified','none',taipei_news,None,None,place,seconds,float(points)))
# Official 2025 news explains that the race climb is 391 m (not the whole building).
for n,c in enumerate(courses):
    if c[0]==taipei_cid:
        row=list(c); row[6]=391; courses[n]=tuple(row)

# Include official details pages for course records only when corresponding holder name/time is printed.
record_venue_id=venue_id_by_name['TK Elevator Towerrun']
record_course_id=next(c[0] for c in courses if c[-1]==record_venue_id)
records=[
(1,'Christian Riedl','Male',None,416,2018,'GER','2026-11-08','https://www.towerrunning.com/races/r2703/',record_course_id,None),
(2,'Verena Schmitz','Female',None,547,2024,'GER','2026-11-08','https://www.towerrunning.com/races/r2703/',record_course_id,None),
(3,'Paul Crake','Male',None,573,2003,'AUS','2026-11-08',empire_source,
    next(c[0] for c in courses if c[-1]==empire_venue),None),
(4,'Andrea Mayr','Female',None,683,2006,'AUT','2026-11-08',empire_source,
    next(c[0] for c in courses if c[-1]==empire_venue),None),
(5,'Paul Crake','Male',None,629.32,2005,'AUS','2026-11-08',taipei_source,taipei_cid,None),
(6,'Andrea Mayr','Female',None,758.85,2005,'AUT','2026-11-08',taipei_source,taipei_cid,None),
]

s='''-- VERIFIED / SOURCED MINI-WORLD DATA
-- Reproducible: run schema.sql first, then populate.sql in a fresh MySQL 8.0+ session.
-- These records originate from the official Towerrunning Tour calendar and cited
-- race detail pages (see src/docs/DATA_PROVENANCE.md).
-- No made-up participant times, ages, membership payments, or official ranking totals.
-- Internal numeric IDs and course-label descriptions are database modelling choices.
USE towerrunning_phase4;
START TRANSACTION;

'''
s+=insert('RACE_EVENT',['RaceEventID','OfficialWebsiteURL','Description','RaceName'],race_events)
s+=insert('COMPETITION_EDITION',['CompetitionEditionID','CompetitionName','CompetitionType','SeasonLabel','StartDate','EndDate','ChampionshipLevel','GeographicScope','SourceURL'],[(1,'Towerrunning Tour 2026','Tour','2026','2026-01-01','2026-11-28',None,'Worldwide',CALENDAR),(2,'Towerrunning Tour 2025','Tour','2025','2025-01-01','2025-11-22',None,'Worldwide','https://www.towerrunning.com/towerrunning-tour-2025/')])
s+=insert('ORGANISATION',['OrganisationID','OrganisationName','OrganisationKind','CountryCode','WebsiteURL','ContactEmail'],[(1,'Towerrunning World Association','association',None,'https://www.towerrunning.com/','office@towerrunning.com')])
s+=insert('VENUE',['VenueID','VenueName','VenueType','CountryCode','City','Region','VenueNotes'],venues)
s+=insert('COURSE',['CourseID','CourseLabel','RouteDescription','RaceFormat','StairCount','FloorCount','VerticalClimbMetres','ConfigurationStatus','VenueID'],courses)
s+=insert('VENUE_ALTERNATIVE_NAME',['VenueID','AlternativeName'],[(venue_id_by_name['KL Tower Run International Challenge'],'Menara Tower')])
s+=insert('RANKING_PUBLICATION',['RankingPublicationID','PublicationLabel','PublicationType','RankingAsOfDate','WindowStartDate','WindowEndDate','PublishedOn','RevisionLabel','PublicationStatus','SourceURL','ArchivedFileReference','RulesReference'],[
(1,'TWA Ranking July 2026','Individual',None,None,None,None,None,'published','https://www.towerrunning.com/ranking/',None,'https://www.towerrunning.com/ranking/'),
(2,'TWA Ranking Final 2025','Individual',None,None,None,None,None,'published','https://www.towerrunning.com/ranking/',None,'https://www.towerrunning.com/ranking/'),
])
s+=insert('FORM',['FormURL','FormType'],[
('https://www.towerrunning.com/twainfo/TWA%20Results%20Form.xlsx','standard'),
('https://www.towerrunning.com/twainfo/TWA%20Results%20Form%2040.xlsx','factor-40')])
s+=insert('RACE_EDITION',['RaceEventID','OccurrenceNo','PublishedEditionNumber','StartDate','EndDate','RankingDate','RaceFactor','WebsiteCategoryCode','EditionStatus','DeliveryMode','PublishedRaceCode','WebsitePageURL','SourceObservedOn','RegistrationURL','ResultsURL','PublishedMaleWinnerName','PublishedFemaleWinnerName','EvaluationStatus','EvaluationEvidence','AdditionalInformation','ScoringSchemeID','VenueID','PrevRaceEventID','PrevOccurrenceNo'],editions)
s+=insert('OFFERS',['RaceEventID','OccurrenceNo','CourseID','EvaluationSelection','SelectionEvidence'],offers)
s+=insert('INCLUDED_IN',['RaceEventID','OccurrenceNo','CompetitionEditionID','RoleLabel','InclusionNote'],include)
s+=insert('PERSON',['PersonID','FullName','BirthDate'],[(v[3],v[0],None) for v in athletes.values()])
s+=insert('ATHLETE',['PersonID','NationalityCode','Gender','DefaultCompetitionDivision'],[(v[3],v[2],None,None) for v in athletes.values()])
s+=insert('REGISTERED_ATHLETE',['PersonID','TWAAthleteID','FirstRegistrationDate'],[(v[3],k,None) for k,v in athletes.items()])
s+=insert('COURSE_RECORD',['CourseRecordID','HolderNameAsPublished','Division','AgeGroupLabel','RecordTimeSeconds','AchievementYear','CountryAsPublished','SourceObservedOn','EvidenceURL','CourseID','HolderPersonID'],records)
s+=insert('ACHIEVES_RESULT',['RaceEventID','OccurrenceNo','CourseID','PersonID','CompetitionDivision','CountryAtRace','FinishStatus','VerificationStatus','DisputeStatus','SourceURL','SubmissionNo','SourceRowNo','OverallPlace','FinishingTimeSeconds','Points'],results)
s+='COMMIT;\n'
supplement=OUT.parent/'data'/'official'/'verified_import.sql'
if supplement.exists():
    s+='\n-- BEGIN VERIFIED OFFICIAL SUPPLEMENT\nSTART TRANSACTION;\n'+supplement.read_text()+'COMMIT;\n'
OUT.write_text(s,encoding='utf-8')
print(f'Created {OUT.name}: {len(names)} real named events, {len(editions)} editions, {len(athletes)} registered athletes, {len(results)} official published result rows, {len(venues)} verified venues, {len(courses)} courses')
