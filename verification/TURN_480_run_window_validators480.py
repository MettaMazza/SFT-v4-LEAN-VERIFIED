import subprocess,time
from pathlib import Path
for key in ['dimension','observation','quantity','unit']:
 start=time.monotonic()
 p=subprocess.run(['python3','work/'+key+'_validation480_window.py'],capture_output=True,text=True)
 Path('work/'+key+'_validation480_window.log').write_text(p.stdout+p.stderr)
 print(key,'exit',p.returncode,'seconds',round(time.monotonic()-start,2),p.stdout.strip(),flush=True)
 if p.returncode:raise SystemExit(p.returncode)
