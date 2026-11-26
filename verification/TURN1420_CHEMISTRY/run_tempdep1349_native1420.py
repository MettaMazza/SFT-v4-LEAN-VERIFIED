from pathlib import Path
import json,hashlib,subprocess,time
w=Path('work');r=w/'turn1064_recovery'
while True:
 p=w/'tempdep1349_entry_audit_report.json'
 if p.exists():
  a=json.loads(p.read_text())
  if a.get('status')=='PASS' and 'TemperatureDependenceEvidence' in a.get('source_sha256',{}):
   assert all(hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()==h for m,h in a['source_sha256'].items());break
 time.sleep(10)
for name in ['prepare_tempdep1349_program_native1420.py','check_tempdep1349_program_native1420.py']:
 subprocess.run(['python3','-u','work/'+name],check=True)
