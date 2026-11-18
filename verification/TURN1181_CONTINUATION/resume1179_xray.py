from pathlib import Path
import subprocess,json,datetime
w=Path('work')
commands=['check_xray1163_empirical.py']
for name in commands:
 print('START '+name,flush=True)
 (w/'resume1179_xray_cursor.json').write_text(json.dumps(dict(command=name,started=datetime.datetime.now(datetime.timezone.utc).isoformat())))
 subprocess.run(['python3','work/'+name],check=True)
 print('PASS '+name,flush=True)
