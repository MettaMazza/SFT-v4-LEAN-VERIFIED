from pathlib import Path
import sys,json,time,subprocess,os,hashlib,shutil
w=Path('work');r=w/'turn1064_recovery'
# Preserve the live old-source comparison; install the audited equivalent loop
# only after its original check has finished with that source unchanged.
receipt=w/'lean_resource_80127.json';report=w/'stateenergy1085_empirical_report.json'
while True:
 try:d=json.loads(receipt.read_text())
 except (FileNotFoundError,json.JSONDecodeError):time.sleep(2);continue
 if d['exit'] is not None:break
 time.sleep(2)
assert d['exit']==0,d
for _ in range(30):
 if report.exists():break
 time.sleep(1)
assert report.exists(),(w/'stateenergy1085_empirical_driver.log').read_text()[-1800:]
assert json.loads(report.read_text())['status']=='PASS'
shutil.copyfile(report,w/'stateenergy1085_empirical_prior_loop_report.json')
shutil.copyfile(r/'SFT/Chemistry/StateEnergyValidation.lean',w/'StateEnergyValidation1085PriorLoop.lean')
fixed=w/'StateEnergyValidation1085Fixed.lean';log=(w/'stateenergy1085_validation_fixed.log').read_text();assert 'depends on axioms:'not in log and 'error:'not in log
shutil.copyfile(fixed,r/'SFT/Chemistry/StateEnergyValidation.lean')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'stateenergy1085_validation_final.log').open('w')as out:
 subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','-o',str(r/'SFT/Chemistry/StateEnergyValidation.olean'),str(r/'SFT/Chemistry/StateEnergyValidation.lean')],env=env,stdout=out,stderr=subprocess.STDOUT,check=True)
print('Original live comparison PASS; installed zero-axiom loop and starting affected native rerun.',flush=True)
with(w/'stateenergy1085_empirical_final_driver.log').open('w')as out:subprocess.run([sys.executable,'work/check_stateenergy1085_empirical.py'],stdout=out,stderr=subprocess.STDOUT,check=True)
print('PASS final zero-axiom empirical pipeline',flush=True)
