import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','90470'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'severity1246_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['symptom1247', 'SymptomRecord', 'SFT-MED-SYMPTOM-001'], ['sign1248', 'ClinicalSign', 'SFT-MED-SIGN-001'], ['clinicalmeasure1249', 'ClinicalMeasurement', 'SFT-MED-CLINICAL-MEASUREMENT-001'], ['diagnostic1250', 'DiagnosticClassification', 'SFT-MED-DIAGNOSTIC-CLASSIFICATION-001'], ['differentialdiagnosis1251', 'DifferentialDiagnosis', 'SFT-MED-DIFFERENTIAL-DIAGNOSIS-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
