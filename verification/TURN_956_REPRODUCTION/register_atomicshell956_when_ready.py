from pathlib import Path
import json,time,subprocess
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
while True:
 p=w/'atomicshellperiodicityempirical956_empirical_report.json'
 prior=c/'verification/TURN_955_HYDROGEN_RYDBERG_COMPLETION.json'
 if p.exists() and prior.exists():break
 s=(w/'atomicshell956_final_empirical_recheck.log').read_text()
 if 'Traceback' in s:raise RuntimeError(s[-5000:])
 time.sleep(3)
assert json.loads(p.read_text())['status']=='PASS'
subprocess.run(['python3',str(w/'register_atomicshell956.py'),'AtomicShellPeriodicityEntry','atomicshell','956','SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005','ATOMIC_SHELL_PERIODICITY','828'],check=True)
