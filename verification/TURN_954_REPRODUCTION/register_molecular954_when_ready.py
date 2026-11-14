from pathlib import Path
import json,time,subprocess
w=Path('work')
while True:
 s=(w/'molecularspectroscopy954_finish_checks.log').read_text()
 if 'Traceback' in s:raise RuntimeError(s[-3000:])
 p=w/'molecularspectroscopyempirical954_empirical_report.json'
 if p.exists() and json.loads(p.read_text()).get('status')=='PASS':break
 time.sleep(3)
subprocess.run(['python3',str(w/'register_molecularspectroscopy954.py'),'MolecularSpectroscopyEntry','molecularspectroscopy','954','SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005','MOLECULAR_SPECTROSCOPY','826'],check=True)
