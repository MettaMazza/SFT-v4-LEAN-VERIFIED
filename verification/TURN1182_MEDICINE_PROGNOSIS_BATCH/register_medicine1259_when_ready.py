from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['risk1259', 'ClinicalRisk', 'SFT-MED-RISK-001'], ['incidence1260', 'IncidencePrevalence', 'SFT-MED-INCIDENCE-PREVALENCE-001'], ['prognosis1261', 'Prognosis', 'SFT-MED-PROGNOSIS-001'], ['outcome1262', 'ClinicalOutcome', 'SFT-MED-CLINICAL-OUTCOME-001'], ['censoring1263', 'CensoringCompeting', 'SFT-MED-CENSORING-COMPETING-001'], ['calibration1264', 'PrognosticCalibration', 'SFT-MED-PROGNOSTIC-CALIBRATION-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
