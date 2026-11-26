from pathlib import Path
import subprocess,json
w=Path('work')
for n in ['prepare_thermal1345_chunked1453.py','check_thermal1345_chunked1453.py','adopt_thermal_chunked1453.py']:
 p=w/'thermal1345_empirical_report.json'
 if p.exists() and json.loads(p.read_text()).get('status')=='PASS':
  print('Original Thermal comparison already complete; preserve result.',flush=True);break
 print('RUN '+n,flush=True);subprocess.run(['python3','-u',str(w/n)],check=True)
