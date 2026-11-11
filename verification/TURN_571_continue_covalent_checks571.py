from pathlib import Path
import subprocess,time,os,concurrent.futures
while True:
 try: os.kill(27131,0)
 except ProcessLookupError: break
 time.sleep(2)
assert Path('work/covalent571_build_report.json').exists(), 'grammar build failed; inspect original handle'
def run(cmd,log):
 with open(log,'w') as f: p=subprocess.run(cmd,stdout=f,stderr=subprocess.STDOUT)
 assert p.returncode==0,log
 print('PASS',log,flush=True)
def protocol():
 run(['python3','work/build_covalent_protocol571.py'],'work/build_covalent_protocol571.log')
 run(['python3','work/check_covalent_validation571.py'],'work/check_covalent_validation571.log')
 run(['python3','work/audit_covalent571.py'],'work/audit_covalent571.log')
def program():
 run(['python3','work/run_covalent571.py'],'work/run_covalent571.log')
 run(['python3','work/check_chemistry_independent571.py','covalent','SFT-CHEM-BOND-COVALENT-001'],'work/independent_covalent571.log')
with concurrent.futures.ThreadPoolExecutor(max_workers=2) as ex:
 futures=[ex.submit(f) for f in (protocol,program)]
 for f in futures: f.result()
print('ALL CHECKS FINISHED',flush=True)
