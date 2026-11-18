import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','15110'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'stoppingwithdrawal1294_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['individualinference1295', 'IndividualInference', 'SFT-MED-INDIVIDUAL-INFERENCE-001'], ['populationinference1296', 'PopulationInference', 'SFT-MED-POPULATION-INFERENCE-001'], ['transportability1297', 'Transportability', 'SFT-MED-TRANSPORTABILITY-001'], ['subgroupmultiplicity1298', 'SubgroupMultiplicity', 'SFT-MED-SUBGROUP-MULTIPLICITY-001'], ['clinicaldecision1299', 'ClinicalDecision', 'SFT-MED-CLINICAL-DECISION-001'], ['clinicaluncertainty1300', 'ClinicalUncertainty', 'SFT-MED-CLINICAL-UNCERTAINTY-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
