from pathlib import Path
import subprocess,time,json
w=Path('work')
while subprocess.run(['kill','-0','35433'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'correspondence1308_program_report.json').read_text())['status']=='PASS'
for name in ['build_precision1309.py','check_precision1309_core.py','check_precision1309_empirical.py','check_precision1309_program.py']:
 print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True);print('PASS '+name,flush=True)
