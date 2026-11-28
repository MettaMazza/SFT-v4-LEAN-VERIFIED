from pathlib import Path
import subprocess,time,json
w=Path('work')
while not(w/'astroredshift1592_full_entry_audit_report.json').exists():
 ps=subprocess.check_output(['ps','-axo','command='],text=True).splitlines();assert any(x.endswith('Python work/build_astroredshift1592_rest.py')or x=='python3 work/build_astroredshift1592_rest.py'for x in ps),'Rest builder ended; inspect actual log'
 time.sleep(5)
assert json.loads((w/'astroredshift1592_full_entry_audit_report.json').read_text())['status']=='PASS'
for n in ['build_astroredshift1592_native.py','run_astroredshift1592_checks.py']:
 with(w/(n+'.log')).open('w')as f:subprocess.run(['python3',str(w/n)],stdout=f,stderr=subprocess.STDOUT,check=True)
print('PASS complete native entry checks',flush=True)
