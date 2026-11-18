from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['clinicaltrial1283', 'ClinicalTrial', 'SFT-MED-CLINICAL-TRIAL-001'], ['randomization1284', 'Randomization', 'SFT-MED-RANDOMIZATION-001'], ['blinding1285', 'Blinding', 'SFT-MED-BLINDING-001'], ['observationalstudy1286', 'ObservationalStudy', 'SFT-MED-OBSERVATIONAL-STUDY-001'], ['evidencesynthesis1287', 'EvidenceSynthesis', 'SFT-MED-EVIDENCE-SYNTHESIS-001'], ['missingreporting1288', 'MissingReporting', 'SFT-MED-MISSING-REPORTING-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
