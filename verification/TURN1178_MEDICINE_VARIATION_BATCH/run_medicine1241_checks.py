import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','63247'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'course1240_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['normal1241', 'NormalVariation', 'SFT-MED-NORMAL-VARIATION-001'], ['dysfunction1242', 'Dysfunction', 'SFT-MED-DYSFUNCTION-001'], ['disease1243', 'DiseaseState', 'SFT-MED-DISEASE-001'], ['injury1244', 'InjuryState', 'SFT-MED-INJURY-001'], ['comorbidity1245', 'Comorbidity', 'SFT-MED-COMORBIDITY-001'], ['severity1246', 'SeverityStage', 'SFT-MED-SEVERITY-STAGE-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
