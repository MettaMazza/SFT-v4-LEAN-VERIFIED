import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','93367'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'effectmod1258_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['risk1259', 'ClinicalRisk', 'SFT-MED-RISK-001'], ['incidence1260', 'IncidencePrevalence', 'SFT-MED-INCIDENCE-PREVALENCE-001'], ['prognosis1261', 'Prognosis', 'SFT-MED-PROGNOSIS-001'], ['outcome1262', 'ClinicalOutcome', 'SFT-MED-CLINICAL-OUTCOME-001'], ['censoring1263', 'CensoringCompeting', 'SFT-MED-CENSORING-COMPETING-001'], ['calibration1264', 'PrognosticCalibration', 'SFT-MED-PROGNOSTIC-CALIBRATION-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
