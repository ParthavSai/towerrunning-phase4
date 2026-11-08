"""Towerrunning Phase 4 — Python Flask + raw MySQL queries.

Read src/docs/DEMO_SCRIPT.md for a full UI/database demonstration sequence.
"""
from __future__ import annotations
import os
import secrets
from datetime import date
from decimal import Decimal
from pathlib import Path
from dotenv import load_dotenv

load_dotenv(Path(__file__).with_name('.env'))
from flask import (Flask, abort, flash, redirect, render_template, request,
                   session, url_for)
import pymysql
import queries

app=Flask(__name__)
app.secret_key=os.getenv('SECRET_KEY') or secrets.token_hex(32)
app.config.update(SESSION_COOKIE_HTTPONLY=True, SESSION_COOKIE_SAMESITE='Lax')


@app.context_processor
def common():
    if '_csrf_token' not in session:
        session['_csrf_token']=secrets.token_hex(24)
    return {'csrf_token':session['_csrf_token'], 'today':date.today()}


@app.before_request
def validate_csrf():
    if request.method=='POST':
        expected=session.get('_csrf_token','')
        supplied=request.form.get('_csrf_token','')
        if not expected or not secrets.compare_digest(expected,supplied):
            abort(400,description='Invalid form security token. Reload and try again.')


def int_filter(key, minimum=None, maximum=None):
    raw=request.args.get(key,'').strip()
    if not raw:return None
    try: value=int(raw)
    except ValueError: return None
    if minimum is not None and value<minimum:return None
    if maximum is not None and value>maximum:return None
    return value


def valid_draft_form():
    """Strict type and date checks before passing values to parameterized SQL."""
    try:
        event_id=int(request.form.get('event_id',''))
        factor=int(request.form.get('factor',''))
        venue_raw=request.form.get('venue_id','').strip()
        venue_id=int(venue_raw) if venue_raw else None
        if event_id<1 or factor<1 or factor>1000 or (venue_id is not None and venue_id<1):
            raise ValueError()
        start=date.fromisoformat(request.form.get('start_date','').strip())
        end=date.fromisoformat(request.form.get('end_date','').strip())
        if end<start: raise ValueError('End date must not precede start date.')
        note=request.form.get('note','').strip()
        if len(note)>800: raise ValueError('Notes must be 800 characters or fewer.')
        return event_id,start,end,factor,venue_id,note or None
    except (TypeError, ValueError) as exc:
        raise ValueError(str(exc) if str(exc) and str(exc)!="invalid literal for int() with base 10: ''" else 'Enter a valid race, dates, factor and venue.') from exc


@app.template_filter('date_pretty')
def date_pretty(value):
    return value.strftime('%d %b %Y') if value else 'Not published'


@app.template_filter('points')
def points(value):
    return f'{float(value):,.1f}' if value is not None else '—'


@app.template_filter('race_time')
def race_time(value):
    """Preserve published hundredths/milliseconds rather than truncating."""
    if value is None:
        return '—'
    seconds=Decimal(str(value))
    whole=int(seconds)
    fraction=seconds-whole
    base=f'{whole//3600:02d}:{(whole%3600)//60:02d}:{whole%60:02d}'
    # Decimal('682.880') -> .88; integer values have no decimal suffix.
    suffix=f'{fraction:.3f}'.split('.')[1].rstrip('0')
    return base+'.'+suffix if suffix else base


@app.route('/')
def home():
    return render_template('index.html',active='home',counts=queries.counts(),events=queries.highlights())


@app.route('/races')
def races():
    q=request.args.get('q','').strip()[:100]
    city=request.args.get('city','').strip()[:100]
    year=int_filter('year',2000,2100)
    factor=int_filter('factor',1,1000)
    items=queries.race_search(q,year,factor,city)
    return render_template('races.html',active='races',items=items,filters={'q':q,'city':city,'year':year,'factor':factor})


@app.route('/races/<int:event_id>/<int:occurrence>')
def race_detail(event_id,occurrence):
    info=queries.race_info(event_id,occurrence)
    if not info:abort(404)
    division=request.args.get('division','')
    if division not in ('','Male','Female'): division=''
    return render_template('race_detail.html',active='races',race=info,
                           courses=queries.race_courses(event_id,occurrence),
                           results=queries.race_results(event_id,occurrence,division),division=division)


@app.route('/athletes')
def athletes():
    q=request.args.get('q','').strip()[:100]
    country=request.args.get('country','').strip().upper()[:3]
    gender=request.args.get('gender','')
    if gender not in ('','Male','Female'):gender=''
    return render_template('athletes.html',active='athletes',items=queries.athlete_search(q,country,gender),
                           filters={'q':q,'country':country,'gender':gender})


@app.route('/athletes/<int:person_id>')
def athlete_detail(person_id):
    athlete=queries.athlete_info(person_id)
    if not athlete:abort(404)
    return render_template('athlete_detail.html',active='athletes',athlete=athlete,results=queries.athlete_results(person_id))


@app.route('/rankings')
def rankings():
    division=request.args.get('division','')
    if division not in ('','Male','Female'):division=''
    country=request.args.get('country','').strip().upper()[:3]
    min_races=int_filter('min_races',1,20) or 1
    return render_template('rankings.html',active='rankings',rows=queries.points_leaderboard(division,country,min_races),
                           publications=queries.published_rankings(),division=division,country=country,min_races=min_races)


@app.route('/rankings/publication/<int:publication_id>')
def publication(publication_id):
    pub=queries.one('SELECT p.*,(SELECT COUNT(*) FROM LISTED_IN l WHERE l.RankingPublicationID=p.RankingPublicationID) AS ImportedEntries FROM RANKING_PUBLICATION p WHERE p.RankingPublicationID=%s',(publication_id,))
    if not pub:abort(404)
    return render_template('publication.html',active='rankings',publication=pub,rows=queries.ranking_rows(publication_id))


@app.route('/nations')
def nations():
    publications=queries.all_rows("SELECT * FROM RANKING_PUBLICATION WHERE RankingPublicationID IN (201911,202512,202607) ORDER BY RankingPublicationID DESC")
    publication_id=int_filter('publication',1) or 202512
    publication=queries.one('SELECT * FROM RANKING_PUBLICATION WHERE RankingPublicationID=%s',(publication_id,))
    if not publication: abort(404)
    start_raw=request.args.get('start','').strip()
    end_raw=request.args.get('end','').strip()
    reconstructed=[]
    method=request.args.get('method','pointbest')
    if method not in ('pointbest','fastest'):abort(400,description='Choose a supported Nations Cup rule variant.')
    error=None
    if start_raw or end_raw:
        try:
            start=date.fromisoformat(start_raw)
            end=date.fromisoformat(end_raw)
            if end<start:raise ValueError()
            reconstructed=queries.nations_reconstruction(start,end,method)
        except ValueError:
            error='Enter both dates with an end date on or after the start date.'
    return render_template('nations.html',active='rankings',publications=publications,
        publication=publication,published=queries.nations_published(publication_id),
        reconstructed=reconstructed,start=start_raw,end=end_raw,error=error,method=method)


@app.route('/records')
def records():
    division=request.args.get('division','')
    if division not in ('','Male','Female'):division=''
    city=request.args.get('city','').strip()[:100]
    return render_template('records.html',active='records',items=queries.course_records(division,city),division=division,city=city)


@app.route('/venues')
def venues():
    q=request.args.get('q','').strip()[:100]
    return render_template('venues.html',active='venues',items=queries.venue_directory(q),q=q)


@app.route('/insights')
def insights():
    return render_template('insights.html',active='insights',
        major_2025=queries.high_factor_2025(),
        young=queries.young_athletes(),
        empire=queries.empire_record_minimum(),
        heights=queries.climb_height_average(),
        speeds=queries.ascent_speeds(),
        audit=queries.scoring_audit())


@app.route('/manage/membership',methods=['POST'])
def add_membership():
    try:
        person_id=int(request.form.get('person_id',''))
        year=int(request.form.get('membership_year',''))
        if person_id<=0 or not 2000<=year<=2100:
            raise ValueError('Choose a registered athlete and a valid membership year.')
        valid_from=date.fromisoformat(request.form.get('valid_from',''))
        valid_until=date.fromisoformat(request.form.get('valid_until',''))
        if valid_from>valid_until or valid_from.year!=year:
            raise ValueError('Validity dates must be ordered and begin in the membership year.')
        queries.create_membership(person_id,year,valid_from,valid_until)
        flash('Pending membership inserted in MySQL. No payment is assumed.','success')
    except (TypeError,ValueError,pymysql.MySQLError) as exc:
        flash('Could not add membership: check dates, registered athlete and duplicate year.' if isinstance(exc,pymysql.MySQLError) else str(exc),'error')
    return redirect(url_for('manage'))


@app.route('/manage')
def manage():
    event_choices,venue_choices=queries.edit_choices()
    return render_template('manage.html',active='manage',events=event_choices,venues=venue_choices,drafts=queries.draft_editions(),members=queries.membership_choices(),memberships=queries.recent_memberships())


@app.route('/manage/create',methods=['POST'])
def create():
    try:
        params=valid_draft_form()
        occurrence=queries.create_draft(*params)
        flash(f'Draft edition #{occurrence} created successfully. The new row is in MySQL.','success')
    except (ValueError,pymysql.MySQLError) as exc:
        flash('Database rejected the edition operation; check references and protected dependencies.' if isinstance(exc,pymysql.MySQLError) else str(exc),'error')
    return redirect(url_for('manage'))


@app.route('/manage/<int:event_id>/<int:occurrence>/edit',methods=['POST'])
def edit(event_id,occurrence):
    try:
        params=valid_draft_form()
        if params[0]!=event_id:raise ValueError('Cannot change a draft edition to a different race event.')
        queries.update_draft(event_id,occurrence,*params[1:])
        flash('Draft edition updated in MySQL.','success')
    except (ValueError,pymysql.MySQLError) as exc:
        flash('Database rejected the edition operation; check references and protected dependencies.' if isinstance(exc,pymysql.MySQLError) else str(exc),'error')
    return redirect(url_for('manage'))


@app.route('/manage/<int:event_id>/<int:occurrence>/delete',methods=['POST'])
def delete(event_id,occurrence):
    try:
        queries.delete_draft(event_id,occurrence)
        flash('Draft edition deleted from MySQL.','success')
    except (ValueError,pymysql.MySQLError) as exc:
        flash('Database rejected the edition operation; check references and protected dependencies.' if isinstance(exc,pymysql.MySQLError) else str(exc),'error')
    return redirect(url_for('manage'))


@app.route('/manage/operations')
def operations():
    return render_template('operations.html', active='manage',
        courses=queries.all_rows('SELECT CourseID,CourseLabel,StairCount,VerticalClimbMetres FROM COURSE ORDER BY CourseID'),
        editions=queries.all_rows('SELECT e.RaceEventID,e.OccurrenceNo,r.RaceName,e.EditionStatus FROM RACE_EDITION e JOIN RACE_EVENT r ON r.RaceEventID=e.RaceEventID ORDER BY r.RaceName'),
        athletes=queries.membership_choices())


@app.route('/manage/operation/<action>', methods=['POST'])
def operation(action):
    try:
        def integer(name):
            value=int(request.form.get(name,''))
            if value<=0: raise ValueError('Identifiers must be positive.')
            return value
        def optional(name, convert):
            value=request.form.get(name,'').strip()
            return convert(value) if value else None
        if action=='course':
            queries.correct_course(integer('course_id'),optional('stairs',int),
                optional('height',Decimal),request.form.get('same_route')=='yes')
        elif action=='cancel':
            queries.cancel_edition(integer('event_id'),integer('occurrence'))
        elif action=='result':
            if request.form.get('verification','unverified')!='unverified':
                raise ValueError('Local entry cannot assert official verification.')
            queries.insert_result(integer('event_id'),integer('occurrence'),integer('course_id'),
                integer('person_id'),optional('seconds',Decimal),optional('place',int),optional('points',Decimal),
                request.form.get('division','') or None,request.form.get('country','').strip().upper() or None,request.form.get('finish_status','finished'))
        elif action=='disqualify':
            queries.disqualify_result(integer('event_id'),integer('occurrence'),integer('course_id'),integer('person_id'),optional('submission_no',int),optional('source_row_no',int))
        else:
            abort(404)
        flash('Operation committed successfully.' + (' This result is local and unverified.' if action=='result' else ''),'success')
    except (ValueError,ArithmeticError) as exc:
        flash(str(exc),'error')
    except pymysql.MySQLError:
        flash('Database rejected the operation: check identifiers, offered course, duplicate identity and domain limits. No changes committed.','error')
    return redirect(url_for('operations'))


@app.errorhandler(pymysql.MySQLError)
def db_error(exc):
    app.logger.error('Database operation failed: %s',exc)
    return render_template('error.html',title='Database unavailable',
                           message='Cannot reach or query MySQL. Check README setup and your DB credentials.'),503


@app.errorhandler(404)
def not_found(exc):
    return render_template('error.html',title='Page not found',message='That record does not exist in the current database.'),404


@app.errorhandler(400)
def bad_request(exc):
    return render_template('error.html',title='Invalid request',message=getattr(exc,'description','Please check your input.')),400


if __name__=='__main__':
    app.run(host='127.0.0.1',port=int(os.getenv('PORT','5000')),debug=os.getenv('FLASK_DEBUG','0')=='1')
