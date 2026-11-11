import subprocess,os
from pathlib import Path
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
for m in ['SourceText','SourceExtraction']:
 p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-o',str(r/'.lake/build/lib/lean/SFT/Chemistry'/(m+'.olean')),'SFT/Chemistry/'+m+'.lean'],cwd=r,env=env,capture_output=True,text=True);Path('work/build555_'+m+'.log').write_text(p.stdout+p.stderr);print(m,p.returncode,p.stdout[-2000:],p.stderr[-1000:],flush=True)
 if p.returncode:break
