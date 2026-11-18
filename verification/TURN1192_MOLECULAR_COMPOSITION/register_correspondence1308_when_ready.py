from pathlib import Path
import json,time,subprocess
w=Path('work');r=w/'turn1064_recovery';cid='SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015'
while True:
 files=['correspondence1308_full_audit_report.json','correspondence1308_program_report.json','correspondence1308_independent_report.json','correspondence1308_core_report.json']
 if all((w/f).exists()for f in files):
  c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid]
  if x['lean_status']=='complete':break
  if all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']):
   subprocess.run(['python3','work/register_correspondence1308.py'],check=True);break
 time.sleep(15)
