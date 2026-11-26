from pathlib import Path
import subprocess,json
w=Path('work')
for n in ['prepare_parallel1354_chunked1464.py','check_parallel1354_chunked1464.py','adopt_parallel_chunked1464.py']:
 p=w/'parallel1354_empirical_report.json'
 if p.exists() and json.loads(p.read_text()).get('status')=='PASS':
  print('Original Thermal comparison already complete; preserve result.',flush=True);break
 print('RUN '+n,flush=True);subprocess.run(['python3','-u',str(w/n)],check=True)
