from pathlib import Path
import json,hashlib,subprocess,time
w=Path('work');r=w/'turn1064_recovery'
while True:
 p=w/'diagram1340_entry_audit_report.json'
 if p.exists():
  a=json.loads(p.read_text())
  if a.get('status')=='PASS' and 'MulticomponentPhaseDiagramEvidence' in a.get('source_sha256',{}):
   assert all(hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()==h for m,h in a['source_sha256'].items());break
 time.sleep(10)
for name in ['prepare_diagram1340_program_native1414.py','check_diagram1340_program_native1414.py']:
 subprocess.run(['python3','-u','work/'+name],check=True)
