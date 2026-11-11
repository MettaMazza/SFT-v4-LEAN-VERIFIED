from pathlib import Path
import os,subprocess
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_PATH=str(r/'.lake/build/lib/lean'))
for module in ['AtomicOrbitCapacityWitnesses','AtomicOrbitCapacityControls','AtomicOrbitCapacityEvidence']:
 rel='SFT/Physics/'+module
 subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M65536',rel+'.lean','-o',str(r/'.lake/build/lib/lean'/ (rel+'.olean')),'-i',str(r/'.lake/build/lib/lean'/(rel+'.ilean')),'-c',str(r/'.lake/build/ir'/(rel+'.c'))],cwd=r,env=env,check=True)
 print('PASS '+module,flush=True)
