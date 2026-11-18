from pathlib import Path
import subprocess,json,datetime
w=Path('work')
for name in ['build_bondlength1307_resume1192.py','check_bondlength1307_program.py','build_correspondence1308.py','check_correspondence1308_program.py','build_precision1309.py','check_precision1309_core.py','check_precision1309_empirical.py','check_precision1309_program.py']:
 print('START '+name,flush=True)
 (w/'resume_chemistry1192_cursor.json').write_text(json.dumps(dict(command=name,started=datetime.datetime.now(datetime.timezone.utc).isoformat())))
 subprocess.run(['python3','work/'+name],check=True)
 print('PASS '+name,flush=True)
