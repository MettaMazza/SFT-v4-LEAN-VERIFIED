import subprocess,time,json
from pathlib import Path
w=Path('work')
while subprocess.run(['kill','-0','90799'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(15)
assert json.loads((w/'accuracy1252_empirical_report.json').read_text())['status']=='PASS'
for tag,mod,cid in [['association1253', 'ClinicalAssociation', 'SFT-MED-CLINICAL-ASSOCIATION-001'], ['clinicalcause1254', 'ClinicalCause', 'SFT-MED-CLINICAL-CAUSE-001'], ['clinicalmechanism1255', 'ClinicalMechanism', 'SFT-MED-CLINICAL-MECHANISM-001'], ['confounding1256', 'Confounding', 'SFT-MED-CONFOUNDING-001'], ['mediation1257', 'Mediation', 'SFT-MED-MEDIATION-001'], ['effectmod1258', 'EffectModification', 'SFT-MED-EFFECT-MODIFICATION-001']]:
 for name in ['prepare_'+tag+'_reuse.py','build_'+tag+'_all.py','check_'+tag+'_empirical.py','check_'+tag+'_program.py']:
  print('START '+name,flush=True);subprocess.run(['python3','work/'+name],check=True)
