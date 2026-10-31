from pathlib import Path
import subprocess,os
r=Path('work/constants-recovery').resolve();out=Path('work/native491').resolve();out.mkdir(exist_ok=True);env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
for m in ['LeptonDecimal','EvolutionMeasuredSource','EvolutionMeasured']:
 subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M2048','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/(m+'.olean')),'-c',str(out/(m+'.c')),'SFT/Physics/'+m+'.lean'],cwd=r,env=env,check=True)
 subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(out/(m+'.c')),'-o',str(out/(m+'.o'))],check=True)
 print(m,'native compile PASS',flush=True)
