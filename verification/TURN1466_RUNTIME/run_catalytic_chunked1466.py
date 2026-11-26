from pathlib import Path
import subprocess,json
w=Path('work')
for n in ['prepare_catalytic1356_chunked1466.py','check_catalytic1356_chunked1466.py','adopt_catalytic_chunked1466.py']:
 p=w/'catalytic1356_empirical_report.json'
 if p.exists() and json.loads(p.read_text()).get('status')=='PASS':
  print('Original Thermal comparison already complete; preserve result.',flush=True);break
 print('RUN '+n,flush=True);subprocess.run(['python3','-u',str(w/n)],check=True)
