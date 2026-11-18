from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['individualinference1295', 'IndividualInference', 'SFT-MED-INDIVIDUAL-INFERENCE-001'], ['populationinference1296', 'PopulationInference', 'SFT-MED-POPULATION-INFERENCE-001'], ['transportability1297', 'Transportability', 'SFT-MED-TRANSPORTABILITY-001'], ['subgroupmultiplicity1298', 'SubgroupMultiplicity', 'SFT-MED-SUBGROUP-MULTIPLICITY-001'], ['clinicaldecision1299', 'ClinicalDecision', 'SFT-MED-CLINICAL-DECISION-001'], ['clinicaluncertainty1300', 'ClinicalUncertainty', 'SFT-MED-CLINICAL-UNCERTAINTY-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
