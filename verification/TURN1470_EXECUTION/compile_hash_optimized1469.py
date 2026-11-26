from pathlib import Path
import subprocess,os
w=Path('work').resolve();r=w/'optimized1469';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';env=dict(os.environ,LEAN_PATH=str(tc/'lib/lean')+':'+str(r))
for module in ['SHA256','SHA256Window','SHA256Streaming']:
 p=r/'SFT/Host'/(module+'.lean')
 subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-o',str(p.with_suffix('.olean')),str(p)],env=env,check=True)
