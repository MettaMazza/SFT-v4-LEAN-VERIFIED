import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','2670'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'cointervention1270_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['dose1271', 'Dose', 'SFT-MED-DOSE-001'], ['exposure1272', 'ClinicalExposure', 'SFT-MED-EXPOSURE-001'], ['response1273', 'ClinicalResponse', 'SFT-MED-RESPONSE-001'], ['doseresponse1274', 'DoseResponse', 'SFT-MED-DOSE-RESPONSE-001'], ['adverse1275', 'AdverseEvent', 'SFT-MED-ADVERSE-EVENT-001'], ['toxicity1276', 'ClinicalToxicity', 'SFT-MED-TOXICITY-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
