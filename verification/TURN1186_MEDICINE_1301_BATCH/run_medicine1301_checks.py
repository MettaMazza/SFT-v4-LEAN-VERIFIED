import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','15132'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'clinicaluncertainty1300_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['informedconsent1301', 'InformedConsent', 'SFT-MED-INFORMED-CONSENT-001'], ['decisioncapacity1302', 'DecisionCapacity', 'SFT-MED-DECISION-CAPACITY-001'], ['clinicalprivacy1303', 'ClinicalPrivacy', 'SFT-MED-CLINICAL-PRIVACY-001'], ['dataminimization1304', 'DataMinimization', 'SFT-MED-DATA-MINIMIZATION-001'], ['clinicalequipoise1305', 'ClinicalEquipoise', 'SFT-MED-CLINICAL-EQUIPOISE-001'], ['clinicalevidencehandoff1306', 'ClinicalEvidenceHandoff', 'SFT-MED-CLINICAL-EVIDENCE-HANDOFF-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
