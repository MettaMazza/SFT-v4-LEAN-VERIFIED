from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['intervention1265', 'Intervention', 'SFT-MED-INTERVENTION-001'], ['comparator1266', 'Comparator', 'SFT-MED-COMPARATOR-001'], ['counterfactual1267', 'Counterfactual', 'SFT-MED-COUNTERFACTUAL-001'], ['allocation1268', 'Allocation', 'SFT-MED-ALLOCATION-001'], ['adherence1269', 'AdherenceCrossover', 'SFT-MED-ADHERENCE-CROSSOVER-001'], ['cointervention1270', 'Cointervention', 'SFT-MED-COINTERVENTION-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
