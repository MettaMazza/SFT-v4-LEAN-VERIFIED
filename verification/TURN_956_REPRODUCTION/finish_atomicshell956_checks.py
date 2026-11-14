from pathlib import Path
import subprocess,time
w=Path('work')
def wait(log):
 while True:
  s=(w/log).read_text()
  if 'Build completed successfully' in s:return
  if 'error:' in s:raise RuntimeError(s[-5000:])
  time.sleep(3)
wait('atomicshell956_entry_build.log')
subprocess.run(['python3',str(w/'check_atomicshell_entry956.py')],check=True)
wait('atomicshell956_empirical_build.log')
for name in ['audit_atomicshell956_all.py','prepare_atomicshellperiodicityempirical_native956.py']:
 subprocess.run(['python3',str(w/name)],check=True)
subprocess.run(['python3',str(w/'check_atomicshellperiodicityempirical_program956.py'),str((w/'circuit866_native_objects/AtomicShellPeriodicityEmpiricalProgram956').resolve())],check=True)
for name in ['prepare_atomicshellperiodicityempirical_empirical_native956.py','check_atomicshellperiodicityempirical_empirical956.py']:
 subprocess.run(['python3',str(w/name)],check=True)
print('PASS complete terminal Lamb original law and empirical entry',flush=True)
