from pathlib import Path
import subprocess,time,json
w=Path('work')
while not(w/'astroobject1584_full_entry_audit_report.json').exists():
 ps=subprocess.check_output(['ps','-axo','command='],text=True).splitlines();assert any(x.endswith('Python work/build_astroobject1584_rest.py')or x=='python3 work/build_astroobject1584_rest.py'for x in ps),'Rest builder ended; inspect actual log'
 time.sleep(5)
assert json.loads((w/'astroobject1584_full_entry_audit_report.json').read_text())['status']=='PASS'
for n in ['build_astroobject1584_native.py','run_astroobject1584_checks.py']:
 with(w/(n+'.log')).open('w')as f:subprocess.run(['python3',str(w/n)],stdout=f,stderr=subprocess.STDOUT,check=True)
print('PASS complete native entry checks',flush=True)
