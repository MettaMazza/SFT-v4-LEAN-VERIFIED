from pathlib import Path
import subprocess,time,json
p=Path('/Volumes/One Touch/SFT v4 Full model LEAN/verification/TURN_940_TERMINAL_PROTON_COMPLETION.json')
while not p.exists():time.sleep(10)
assert json.loads(p.read_text())['status']=='complete'
subprocess.run(['python3','work/register_terminalturn941.py','TerminalTurnEntry','terminalturn','941','SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004','TERMINAL_TURN','813'],check=True)
print('COMPLETE registered609',flush=True)
