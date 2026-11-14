from pathlib import Path
import subprocess,time
w=Path('work')
def wait(log):
 while True:
  s=(w/log).read_text()
  if 'Build completed successfully' in s:return
  if 'error:' in s:raise RuntimeError(s[-5000:])
  time.sleep(3)
wait('terminalhyperfine953_entry_build.log')
subprocess.run(['python3',str(w/'check_terminalhyperfine_entry953.py')],check=True)
wait('terminalhyperfine953_empirical_build.log')
for name in ['audit_terminalhyperfine953_all.py','prepare_terminalhyperfineempirical_native953.py']:
 subprocess.run(['python3',str(w/name)],check=True)
subprocess.run(['python3',str(w/'check_terminalhyperfineempirical_program953.py'),str((w/'circuit866_native_objects/TerminalHyperfineEmpiricalProgram953').resolve())],check=True)
for name in ['prepare_terminalhyperfineempirical_empirical_native953.py','check_terminalhyperfineempirical_empirical953.py']:
 subprocess.run(['python3',str(w/name)],check=True)
print('PASS complete terminal Lamb original law and empirical entry',flush=True)
