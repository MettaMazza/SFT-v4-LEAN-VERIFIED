from pathlib import Path
import subprocess,time,json,shutil,os
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=w/'constants-recovery'
while True:
 cfg=json.loads((w/'collatz863_proofs_config.json').read_text())
 if len(cfg.get('modules',[]))==104:break
 time.sleep(3)
subprocess.run(['python3','work/check_collatz_program863.py'],check=True)
subprocess.run(['python3','work/check_collatz_independent863.py'],check=True)
for m in json.loads((w/'collatz863_proofs_config.json').read_text())['modules']:
 shutil.copy2(rec/'SFT/Mathematics'/(m+'.lean'),r/'SFT/Mathematics'/(m+'.lean'))
env=dict(os.environ,LEAN_NUM_THREADS='28',ELAN_TOOLCHAIN='leanprover/lean4:v4.35.0')
with (w/'collatz863_canonical_build.log').open('w') as log:
 p=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lake','build','SFT.Mathematics.CollatzEvidence'],cwd=r,stdout=log,stderr=subprocess.STDOUT,env=env)
p.check_returncode()
print('PASS original program, independent validator and canonical build',flush=True)
