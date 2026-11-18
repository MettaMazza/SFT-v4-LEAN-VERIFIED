from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery';cid='SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001'
while True:
 files=['bondlength1307_full_audit_report.json','bondlength1307_empirical_report.json','bondlength1307_program_report.json','bondlength1307_independent_report.json','bondlength1307_core_report.json','bondlength1307_experiment_report.json']
 if all((w/f).exists()for f in files):
  c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
  if x['lean_status']=='complete':break
  if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
   subprocess.run(['python3','work/register_bondlength1307.py'],check=True);break
 time.sleep(15)
