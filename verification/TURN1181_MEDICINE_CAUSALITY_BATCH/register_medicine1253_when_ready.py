from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['association1253', 'ClinicalAssociation', 'SFT-MED-CLINICAL-ASSOCIATION-001'], ['clinicalcause1254', 'ClinicalCause', 'SFT-MED-CLINICAL-CAUSE-001'], ['clinicalmechanism1255', 'ClinicalMechanism', 'SFT-MED-CLINICAL-MECHANISM-001'], ['confounding1256', 'Confounding', 'SFT-MED-CONFOUNDING-001'], ['mediation1257', 'Mediation', 'SFT-MED-MEDIATION-001'], ['effectmod1258', 'EffectModification', 'SFT-MED-EFFECT-MODIFICATION-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
