from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['symptom1247', 'SymptomRecord', 'SFT-MED-SYMPTOM-001'], ['sign1248', 'ClinicalSign', 'SFT-MED-SIGN-001'], ['clinicalmeasure1249', 'ClinicalMeasurement', 'SFT-MED-CLINICAL-MEASUREMENT-001'], ['diagnostic1250', 'DiagnosticClassification', 'SFT-MED-DIAGNOSTIC-CLASSIFICATION-001'], ['differentialdiagnosis1251', 'DifferentialDiagnosis', 'SFT-MED-DIFFERENTIAL-DIAGNOSIS-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
