from pathlib import Path
import json,time,subprocess
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
while True:
 log=(w/'terminalfine952_finish_checks.log').read_text()
 if 'Traceback' in log:raise RuntimeError(log[-3000:])
 p=w/'terminalfineempirical952_empirical_report.json'
 if p.exists() and json.loads(p.read_text()).get('status')=='PASS' and json.loads((c/'CONTINUATION_STATE.json').read_text())['scientific_cursor']['next']=='SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005':break
 time.sleep(3)
subprocess.run(['python3',str(w/'register_terminalfine952.py'),'TerminalFineEntry','terminalfine','952','SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005','TERMINAL_FINE','824'],check=True)
