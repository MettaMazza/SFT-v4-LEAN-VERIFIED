import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','96424'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'calibration1264_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['intervention1265', 'Intervention', 'SFT-MED-INTERVENTION-001'], ['comparator1266', 'Comparator', 'SFT-MED-COMPARATOR-001'], ['counterfactual1267', 'Counterfactual', 'SFT-MED-COUNTERFACTUAL-001'], ['allocation1268', 'Allocation', 'SFT-MED-ALLOCATION-001'], ['adherence1269', 'AdherenceCrossover', 'SFT-MED-ADHERENCE-CROSSOVER-001'], ['cointervention1270', 'Cointervention', 'SFT-MED-COINTERVENTION-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
