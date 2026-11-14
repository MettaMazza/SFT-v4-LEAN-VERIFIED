from pathlib import Path
import subprocess,time
w=Path('work')
def wait(log):
 while True:
  s=(w/log).read_text()
  if 'Build completed successfully' in s:return
  if 'error:' in s:raise RuntimeError(s[-5000:])
  time.sleep(3)
wait('atomictransitionrate957_entry_build.log')
subprocess.run(['python3',str(w/'check_atomictransitionrate_entry957.py')],check=True)
wait('atomictransitionrate957_empirical_build.log')
for name in ['audit_atomictransitionrate957_all.py','prepare_atomictransitionrateempirical_native957.py']:
 subprocess.run(['python3',str(w/name)],check=True)
subprocess.run(['python3',str(w/'check_atomictransitionrateempirical_program957.py'),str((w/'circuit866_native_objects/AtomicTransitionRateEmpiricalProgram957').resolve())],check=True)
for name in ['prepare_atomictransitionrateempirical_empirical_native957.py','check_atomictransitionrateempirical_empirical957.py']:
 subprocess.run(['python3',str(w/name)],check=True)
print('PASS complete terminal Lamb original law and empirical entry',flush=True)
