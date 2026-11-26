from pathlib import Path
import subprocess,json
w=Path('work')
for n in ['prepare_reversible1355_chunked1465.py','check_reversible1355_chunked1465.py','adopt_reversible_chunked1465.py']:
 p=w/'reversible1355_empirical_report.json'
 if p.exists() and json.loads(p.read_text()).get('status')=='PASS':
  print('Original Thermal comparison already complete; preserve result.',flush=True);break
 print('RUN '+n,flush=True);subprocess.run(['python3','-u',str(w/n)],check=True)
