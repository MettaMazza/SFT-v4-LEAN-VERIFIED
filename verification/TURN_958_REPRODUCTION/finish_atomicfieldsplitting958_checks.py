from pathlib import Path
import subprocess,time
w=Path('work')
def wait(log):
 while True:
  s=(w/log).read_text()
  if 'Build completed successfully' in s:return
  if 'error:' in s:raise RuntimeError(s[-5000:])
  time.sleep(3)
wait('atomicfieldsplitting958_entry_build.log')
subprocess.run(['python3',str(w/'check_atomicfieldsplitting_entry958.py')],check=True)
wait('atomicfieldsplitting958_empirical_build.log')
for name in ['audit_atomicfieldsplitting958_all.py','prepare_atomicfieldsplittingempirical_native958.py']:
 subprocess.run(['python3',str(w/name)],check=True)
subprocess.run(['python3',str(w/'check_atomicfieldsplittingempirical_program958.py'),str((w/'circuit866_native_objects/AtomicFieldSplittingEmpiricalProgram958').resolve())],check=True)
for name in ['prepare_atomicfieldsplittingempirical_empirical_native958.py','check_atomicfieldsplittingempirical_empirical958.py']:
 subprocess.run(['python3',str(w/name)],check=True)
print('PASS complete atomic field splitting original law and empirical entry',flush=True)
