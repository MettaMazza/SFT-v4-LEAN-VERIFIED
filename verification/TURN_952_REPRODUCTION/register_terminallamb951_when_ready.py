from pathlib import Path
import json,time,subprocess
w=Path('work')
while True:
 log=(w/'terminallamb951_finish_checks.log').read_text()
 if 'Traceback' in log:raise RuntimeError(log[-3000:])
 p=w/'terminallambempirical951_empirical_report.json'
 if p.exists() and json.loads(p.read_text()).get('status')=='PASS':break
 time.sleep(3)
subprocess.run(['python3',str(w/'register_terminallamb951.py'),'TerminalLambEntry','terminallamb','951','SFT-PHYS-ATOMIC-LAMB-SHIFT-TERMINAL-005','TERMINAL_LAMB','823'],check=True)
