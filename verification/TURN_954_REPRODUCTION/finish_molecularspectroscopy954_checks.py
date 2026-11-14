from pathlib import Path
import subprocess,time
w=Path('work')
def wait(log):
 while True:
  s=(w/log).read_text()
  if 'Build completed successfully' in s:return
  if 'error:' in s:raise RuntimeError(s[-5000:])
  time.sleep(3)
wait('molecularspectroscopy954_entry_build.log')
subprocess.run(['python3',str(w/'check_molecularspectroscopy_entry954.py')],check=True)
wait('molecularspectroscopy954_empirical_build.log')
for name in ['audit_molecularspectroscopy954_all.py','prepare_molecularspectroscopyempirical_native954.py']:
 subprocess.run(['python3',str(w/name)],check=True)
subprocess.run(['python3',str(w/'check_molecularspectroscopyempirical_program954.py'),str((w/'circuit866_native_objects/MolecularSpectroscopyEmpiricalProgram954').resolve())],check=True)
for name in ['prepare_molecularspectroscopyempirical_empirical_native954.py','check_molecularspectroscopyempirical_empirical954.py']:
 subprocess.run(['python3',str(w/name)],check=True)
print('PASS complete terminal Lamb original law and empirical entry',flush=True)
