from pathlib import Path
import subprocess,time
w=Path('work')
def wait(log):
 while True:
  s=(w/log).read_text()
  if 'Build completed successfully' in s:return
  if 'error:' in s:raise RuntimeError(s[-5000:])
  time.sleep(3)
wait('hydrogenrydberg955_entry_build.log')
subprocess.run(['python3',str(w/'check_hydrogenrydberg_entry955.py')],check=True)
wait('hydrogenrydberg955_empirical_build.log')
for name in ['audit_hydrogenrydberg955_all.py','prepare_hydrogenrydbergempirical_native955.py']:
 subprocess.run(['python3',str(w/name)],check=True)
subprocess.run(['python3',str(w/'check_hydrogenrydbergempirical_program955.py'),str((w/'circuit866_native_objects/HydrogenRydbergEmpiricalProgram955').resolve())],check=True)
for name in ['prepare_hydrogenrydbergempirical_empirical_native955.py','check_hydrogenrydbergempirical_empirical955.py']:
 subprocess.run(['python3',str(w/name)],check=True)
print('PASS complete terminal Lamb original law and empirical entry',flush=True)
