from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['informedconsent1301', 'InformedConsent', 'SFT-MED-INFORMED-CONSENT-001'], ['decisioncapacity1302', 'DecisionCapacity', 'SFT-MED-DECISION-CAPACITY-001'], ['clinicalprivacy1303', 'ClinicalPrivacy', 'SFT-MED-CLINICAL-PRIVACY-001'], ['dataminimization1304', 'DataMinimization', 'SFT-MED-DATA-MINIMIZATION-001'], ['clinicalequipoise1305', 'ClinicalEquipoise', 'SFT-MED-CLINICAL-EQUIPOISE-001'], ['clinicalevidencehandoff1306', 'ClinicalEvidenceHandoff', 'SFT-MED-CLINICAL-EVIDENCE-HANDOFF-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
