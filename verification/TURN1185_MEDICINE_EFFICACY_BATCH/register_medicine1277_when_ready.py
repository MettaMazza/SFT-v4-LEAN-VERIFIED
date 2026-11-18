from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['efficacy1277', 'Efficacy', 'SFT-MED-EFFICACY-001'], ['effectiveness1278', 'Effectiveness', 'SFT-MED-EFFECTIVENESS-001'], ['safety1279', 'SafetyEvidence', 'SFT-MED-SAFETY-001'], ['benefitharm1280', 'BenefitHarm', 'SFT-MED-BENEFIT-HARM-001'], ['absolute1281', 'AbsoluteRelativeEffect', 'SFT-MED-ABSOLUTE-RELATIVE-EFFECT-001'], ['heterogeneity1282', 'TreatmentHeterogeneity', 'SFT-MED-TREATMENT-HETEROGENEITY-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
