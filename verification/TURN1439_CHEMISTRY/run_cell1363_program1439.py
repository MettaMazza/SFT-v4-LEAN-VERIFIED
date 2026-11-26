from pathlib import Path
import json,hashlib,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
while True:
 p=w/'cell1363_entry_audit_report.json'
 if p.exists():
  a=json.loads(p.read_text());hs=a.get('source_sha256',{})
  if a['status']=='PASS' and 'CellPotentialCompositionEvidence' in hs and all(hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()==h for m,h in hs.items()):break
 time.sleep(10)
subprocess.run(['python3','work/check_cell1363_program.py'],check=True)
