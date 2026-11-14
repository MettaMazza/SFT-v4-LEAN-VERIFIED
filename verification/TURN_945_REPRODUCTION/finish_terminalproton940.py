from pathlib import Path
import subprocess,time,json
w=Path('work')
while True:
 s=(w/'terminalproton940_canonical_build.log').read_text()
 if 'Build completed successfully' in s:break
 if 'error: build failed' in s:raise RuntimeError('Retained terminal-proton build failed; inspect original log')
 time.sleep(10)
for cmd in [['python3','work/check_terminalproton_entry940.py'],['python3','work/audit_terminalproton940_all.py']]:
 subprocess.run(cmd,check=True)
assert json.load(open(w/'terminalprotonempirical940_empirical_report.json'))['status']=='PASS'
subprocess.run(['python3','work/register_terminalproton940.py','TerminalProtonEntry','terminalproton','940','SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004','TERMINAL_PROTON','812'],check=True)
print('COMPLETE registered608',flush=True)
