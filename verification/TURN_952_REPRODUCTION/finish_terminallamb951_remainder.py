from pathlib import Path
import subprocess
w=Path('work')
for name in ['prepare_terminallambempirical_empirical_native951.py','check_terminallambempirical_empirical951.py']:
 subprocess.run(['python3',str(w/name)],check=True)
subprocess.run(['python3',str(w/'register_terminallamb951.py'),'TerminalLambEntry','terminallamb','951','SFT-PHYS-ATOMIC-LAMB-SHIFT-TERMINAL-005','TERMINAL_LAMB','823'],check=True)
