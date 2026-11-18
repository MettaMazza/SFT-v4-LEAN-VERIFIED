import os,subprocess,time,json
from pathlib import Path
w=Path('work');root=w/'turn1064_recovery'
while subprocess.run(['kill','-0','90472'],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL).returncode==0:time.sleep(5)
env=dict(os.environ,LEAN_PATH=':'.join([str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean'),str(root.resolve()),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']),LEAN_NUM_THREADS='1')
cmd=['python3','work/run_lean_guarded.py',str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192']
for name in ['MolecularCorrespondence','MolecularCorrespondenceDerivation']:
 p=root/'SFT/Chemistry'/(name+'.lean')
 with(w/(name+'_binding1192.log')).open('w')as log:subprocess.run(cmd+['-o',str(p.with_suffix('.olean')),str(p)],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 print('PASS',name,flush=True)
