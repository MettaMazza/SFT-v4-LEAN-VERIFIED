from pathlib import Path
import subprocess,time,json
w=Path('work')
while subprocess.run(['kill','-0','90475'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'differentialdiagnosis1251_empirical_report.json').read_text())['status']=='PASS'
for name in ['prepare_accuracy1252_reuse.py','build_accuracy1252_all.py','check_accuracy1252_counts.py','check_accuracy1252_empirical.py','check_accuracy1252_program.py']:
 print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
