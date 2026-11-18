import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','90472'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'drift1188_program_report.json').read_text())['status']=='PASS'
for name in ['build_bondlength1307.py','check_bondlength1307_program.py']:
 print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
