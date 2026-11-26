from pathlib import Path
import json,time,hashlib,subprocess
w=Path('work');r=w/'turn1064_recovery'
while True:
 try:
  a=json.loads((w/'half1361_entry_audit_report.json').read_text())
  if a['status']=='PASS' and all(hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()==h for m,h in a['source_sha256'].items()):break
 except FileNotFoundError:pass
 time.sleep(5)
for script in ['check_half1361_program.py']:
 print('RUN '+script,flush=True);subprocess.run(['python3','work/'+script],check=True)
