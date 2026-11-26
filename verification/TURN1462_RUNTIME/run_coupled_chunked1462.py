from pathlib import Path
import subprocess,json
w=Path('work')
for n in ['prepare_coupled1346_chunked1462.py','check_coupled1346_chunked1462.py','adopt_coupled_chunked1462.py']:
 p=w/'coupled1346_empirical_report.json'
 if p.exists() and json.loads(p.read_text()).get('status')=='PASS':
  print('Original Thermal comparison already complete; preserve result.',flush=True);break
 print('RUN '+n,flush=True);subprocess.run(['python3','-u',str(w/n)],check=True)
