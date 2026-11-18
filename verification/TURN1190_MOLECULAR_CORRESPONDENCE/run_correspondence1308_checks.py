from pathlib import Path
import subprocess,time,json
w=Path('work')
while subprocess.run(['kill','-0','19129'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'bondlength1307_program_report.json').read_text())['status']=='PASS'
for name in ['build_correspondence1308.py','check_correspondence1308_program.py']:
 print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True);print('PASS '+name,flush=True)
