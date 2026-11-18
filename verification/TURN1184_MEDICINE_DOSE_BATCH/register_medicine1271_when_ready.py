from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['dose1271', 'Dose', 'SFT-MED-DOSE-001'], ['exposure1272', 'ClinicalExposure', 'SFT-MED-EXPOSURE-001'], ['response1273', 'ClinicalResponse', 'SFT-MED-RESPONSE-001'], ['doseresponse1274', 'DoseResponse', 'SFT-MED-DOSE-RESPONSE-001'], ['adverse1275', 'AdverseEvent', 'SFT-MED-ADVERSE-EVENT-001'], ['toxicity1276', 'ClinicalToxicity', 'SFT-MED-TOXICITY-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
