from pathlib import Path
import json,hashlib,time,subprocess
w=Path('work');r=w/'turn1064_recovery'
while True:
 p=w/'isotope1358_core_entry_audit_report.json'
 if p.exists():
  a=json.loads(p.read_text())
  if a['status']=='PASS' and all(hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()==h for m,h in a['source_sha256'].items()):break
 time.sleep(10)
for n in ['check_isotope1358_core.py','build_isotope1358_grammar.py']:
 print('RUN '+n,flush=True);subprocess.run(['python3','-u',str(w/n)],check=True)
