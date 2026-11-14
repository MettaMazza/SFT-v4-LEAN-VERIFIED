from pathlib import Path
import subprocess,time
w=Path('work')
def wait(log):
 while True:
  s=(w/log).read_text()
  if 'Build completed successfully' in s:return
  if 'error:' in s:raise RuntimeError(s[-5000:])
  time.sleep(3)
wait('terminallamb951_entry_build.log')
subprocess.run(['python3',str(w/'check_terminallamb_entry951.py')],check=True)
wait('terminallamb951_empirical_build.log')
for name in ['audit_terminallamb951_all.py','prepare_terminallambempirical_native951.py']:
 subprocess.run(['python3',str(w/name)],check=True)
subprocess.run(['python3',str(w/'check_terminallambempirical_program951.py'),str((w/'circuit866_native_objects/TerminalLambEmpiricalProgram951').resolve())],check=True)
for name in ['prepare_terminallambempirical_empirical_native951.py','check_terminallambempirical_empirical951.py']:
 subprocess.run(['python3',str(w/name)],check=True)
print('PASS complete terminal Lamb original law and empirical entry',flush=True)
