import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','15079'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'missingreporting1288_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['screening1289', 'Screening', 'SFT-MED-SCREENING-001'], ['prevention1290', 'Prevention', 'SFT-MED-PREVENTION-001'], ['treatment1291', 'Treatment', 'SFT-MED-TREATMENT-001'], ['rehabilitation1292', 'Rehabilitation', 'SFT-MED-REHABILITATION-001'], ['monitoring1293', 'Monitoring', 'SFT-MED-MONITORING-001'], ['stoppingwithdrawal1294', 'StoppingWithdrawal', 'SFT-MED-STOPPING-WITHDRAWAL-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
