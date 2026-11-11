from pathlib import Path
import os,subprocess
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
for m in ['LengthExperiment','LengthValidation']:
 p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-o',str(r/'.lake/build/lib/lean/SFT/Chemistry'/(m+'.olean')),'SFT/Chemistry/'+m+'.lean'],cwd=r,env=env,text=True,capture_output=True);Path('work/build575_'+m+'.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;print(m,'built',flush=True)
