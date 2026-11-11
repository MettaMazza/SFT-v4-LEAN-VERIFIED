from pathlib import Path
import subprocess,os
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
for m in ['MaterialExperiment','MaterialValidation']:
 p='SFT/Materials/'+m;cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',p+'.lean','-o','.lake/build/lib/lean/'+p+'.olean','-i','.lake/build/lib/lean/'+p+'.ilean','-c','.lake/build/ir/'+p+'.c'];print(cmd,flush=True);subprocess.run(cmd,cwd=r,env=env,check=True);print('PASS',m,flush=True)
