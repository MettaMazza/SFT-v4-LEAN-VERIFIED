from pathlib import Path
import subprocess,time
w=Path('work')
def wait(log):
 while True:
  s=(w/log).read_text()
  if 'Build completed successfully' in s:return
  if 'error:' in s:raise RuntimeError(s[-5000:])
  time.sleep(3)
wait('terminalfine952_entry_build.log')
subprocess.run(['python3',str(w/'check_terminalfine_entry952.py')],check=True)
wait('terminalfine952_empirical_build.log')
for name in ['audit_terminalfine952_all.py','prepare_terminalfineempirical_native952.py']:
 subprocess.run(['python3',str(w/name)],check=True)
subprocess.run(['python3',str(w/'check_terminalfineempirical_program952.py'),str((w/'circuit866_native_objects/TerminalFineEmpiricalProgram952').resolve())],check=True)
for name in ['prepare_terminalfineempirical_empirical_native952.py','check_terminalfineempirical_empirical952.py']:
 subprocess.run(['python3',str(w/name)],check=True)
print('PASS complete terminal Lamb original law and empirical entry',flush=True)
