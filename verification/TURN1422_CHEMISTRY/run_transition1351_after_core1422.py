from pathlib import Path
import json,hashlib,time,subprocess
w=Path('work');r=w/'turn1064_recovery';p=w/'transition1351_core_entry_audit_report.json'
while True:
 if p.exists():
  a=json.loads(p.read_text())
  if a.get('status')=='PASS' and all(hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()==h for m,h in a['source_sha256'].items()):break
 time.sleep(10)
for name in ['check_transition1351_core.py','build_transition1351_grammar.py']:
 print('RUN '+name,flush=True);subprocess.run(['python3','-u','work/'+name],check=True)
