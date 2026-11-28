from pathlib import Path
import subprocess,time,json
w=Path('work')
while not(w/'astropopulation1586_full_entry_audit_report.json').exists():
 ps=subprocess.check_output(['ps','-axo','command='],text=True).splitlines();assert any(x.endswith('Python work/build_astropopulation1586_rest.py')or x=='python3 work/build_astropopulation1586_rest.py'for x in ps),'Rest builder ended; inspect actual log'
 time.sleep(5)
assert json.loads((w/'astropopulation1586_full_entry_audit_report.json').read_text())['status']=='PASS'
for n in ['build_astropopulation1586_native.py','run_astropopulation1586_checks.py']:
 with(w/(n+'.log')).open('w')as f:subprocess.run(['python3',str(w/n)],stdout=f,stderr=subprocess.STDOUT,check=True)
print('PASS complete native entry checks',flush=True)
