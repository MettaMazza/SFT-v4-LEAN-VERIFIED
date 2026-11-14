from pathlib import Path
import json,time,subprocess
w=Path('work')
while not (w/'hydrogenrydbergempirical955_empirical_report.json').exists():
 s=(w/'hydrogenrydberg955_finish_checks.log').read_text()
 if 'Traceback' in s:raise RuntimeError(s[-5000:])
 time.sleep(3)
assert json.loads((w/'hydrogenrydbergempirical955_empirical_report.json').read_text())['status']=='PASS'
subprocess.run(['python3',str(w/'register_hydrogenrydberg955.py'),'HydrogenRydbergEntry','hydrogenrydberg','955','SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005','HYDROGEN_RYDBERG','827'],check=True)
