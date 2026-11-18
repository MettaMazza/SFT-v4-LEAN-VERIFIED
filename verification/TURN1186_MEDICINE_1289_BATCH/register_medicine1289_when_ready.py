from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
for tag,mod,cid in [['screening1289', 'Screening', 'SFT-MED-SCREENING-001'], ['prevention1290', 'Prevention', 'SFT-MED-PREVENTION-001'], ['treatment1291', 'Treatment', 'SFT-MED-TREATMENT-001'], ['rehabilitation1292', 'Rehabilitation', 'SFT-MED-REHABILITATION-001'], ['monitoring1293', 'Monitoring', 'SFT-MED-MONITORING-001'], ['stoppingwithdrawal1294', 'StoppingWithdrawal', 'SFT-MED-STOPPING-WITHDRAWAL-001']]:
 while True:
  files=[tag+'_full_audit_report.json',tag+'_empirical_report.json',tag+'_program_report.json',tag+'_independent_report.json']
  if all((w/f).exists()for f in files):
   c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
   if x['lean_status']=='complete':break
   if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
    subprocess.run(['python3','work/register_'+tag+'.py'],check=True);break
  time.sleep(15)
