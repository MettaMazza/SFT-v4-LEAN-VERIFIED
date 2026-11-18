from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['normal1241', 'NormalVariation', 'SFT-MED-NORMAL-VARIATION-001'], ['dysfunction1242', 'Dysfunction', 'SFT-MED-DYSFUNCTION-001'], ['disease1243', 'DiseaseState', 'SFT-MED-DISEASE-001'], ['injury1244', 'InjuryState', 'SFT-MED-INJURY-001'], ['comorbidity1245', 'Comorbidity', 'SFT-MED-COMORBIDITY-001'], ['severity1246', 'SeverityStage', 'SFT-MED-SEVERITY-STAGE-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
