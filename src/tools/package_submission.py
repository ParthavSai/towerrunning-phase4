"""Package Phase 4. Final: TEAM /path/to/real.mp4; source-only review: --review."""
from pathlib import Path
import shutil
import subprocess
import sys
import zipfile

ROOT=Path(__file__).resolve().parents[2]
SKIP_DIRS={'.venv','.git','__pycache__','.pytest_cache','.local-backups'}
SKIP_SUFFIXES={'.zip','.pyc','.log','.bak'}


def allowed(path):
    return (path.is_file() and not SKIP_DIRS.intersection(path.relative_to(ROOT).parts)
            and path.suffix.lower() not in SKIP_SUFFIXES
            and not (path.name.startswith('.env') and path.name!='.env.example')
            and path.name!='.DS_Store')


def main():
    review=sys.argv[1:]==['--review']
    if not review and (len(sys.argv)!=3 or not sys.argv[1].isdigit()):
        sys.exit('Usage: python src/tools/package_submission.py TEAM /path/to/real.mp4 OR --review')
    team=None if review else sys.argv[1]
    video=None if review else Path(sys.argv[2]).expanduser().resolve()
    if video is not None:
        if video.suffix.lower()!='.mp4' or not video.is_file() or video.stat().st_size<100_000:
            sys.exit('ERROR: supply an existing real .mp4 screen recording.')
        if shutil.which('ffprobe'):
            probe=subprocess.run(['ffprobe','-v','error','-show_entries','format=duration','-of','default=noprint_wrappers=1:nokey=1',str(video)],capture_output=True,text=True)
            try:duration=float(probe.stdout.strip())
            except ValueError:sys.exit('ERROR: ffprobe could not read a real video duration.')
            if probe.returncode or not 0<duration<=600:
                sys.exit('ERROR: video must be positive and at most 600 seconds.')
        else:
            sys.exit('ERROR: install ffprobe to verify video duration before packaging.')
    archive=ROOT/('submission_pending.zip' if review else team+'.zip')
    required={'README.md','phase3.pdf','src/schema.sql','src/populate.sql','src/app.py','src/requirements.txt'}
    if video:required.add(team+'.mp4')
    for name in required:
        if name.endswith('.mp4'):continue
        if not (ROOT/name).is_file():sys.exit('ERROR: missing '+name)
    with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED,compresslevel=8) as z:
        for name in ('README.md','phase3.pdf'):z.write(ROOT/name,name)
        if video:z.write(video,team+'.mp4')
        for path in sorted((ROOT/'src').rglob('*')):
            if allowed(path):z.write(path,path.relative_to(ROOT))
    with zipfile.ZipFile(archive) as z:
        names=set(z.namelist())
        assert required<=names
        assert z.testzip() is None
        roots={name.split('/')[0] for name in names}
        assert roots==({'README.md','phase3.pdf','src'} if review else {'README.md','phase3.pdf','src',team+'.mp4'})
        assert not any(n.endswith('/.env') or '__pycache__' in n or n.startswith('read/') for n in names)
    print('Created and verified:',archive.name,'entries:',len(names),'bytes:',archive.stat().st_size)
    if review:print('SOURCE-ONLY REVIEW: not a final submission; confirmed team number and real MP4 are still required.')

if __name__=='__main__':main()
