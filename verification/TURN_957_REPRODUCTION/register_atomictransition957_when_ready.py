from pathlib import Path
import json,time,subprocess
w=Path('work')
while not (w/'atomictransitionrateempirical957_empirical_report.json').exists():
 log=w/'atomictransitionrate957_finish_checks.log';s=log.read_text() if log.exists() else ''
 if 'Traceback' in s:raise RuntimeError(s[-5000:])
 time.sleep(3)
assert json.loads((w/'atomictransitionrateempirical957_empirical_report.json').read_text())['status']=='PASS'
subprocess.run(['python3',str(w/'register_atomictransitionrate957.py'),'AtomicTransitionRateEntry','atomictransitionrate','957','SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005','ATOMIC_TRANSITION_RATE','829'],check=True)
