import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','13537'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'heterogeneity1282_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['clinicaltrial1283', 'ClinicalTrial', 'SFT-MED-CLINICAL-TRIAL-001'], ['randomization1284', 'Randomization', 'SFT-MED-RANDOMIZATION-001'], ['blinding1285', 'Blinding', 'SFT-MED-BLINDING-001'], ['observationalstudy1286', 'ObservationalStudy', 'SFT-MED-OBSERVATIONAL-STUDY-001'], ['evidencesynthesis1287', 'EvidenceSynthesis', 'SFT-MED-EVIDENCE-SYNTHESIS-001'], ['missingreporting1288', 'MissingReporting', 'SFT-MED-MISSING-REPORTING-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
