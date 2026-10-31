from pathlib import Path
import subprocess,os
r=Path('work/constants-recovery').resolve();out=Path('work/native493').resolve();out.mkdir(exist_ok=True);env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
m='MassEnergyMeasured'
subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M1024','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/(m+'.olean')),'-c',str(out/(m+'.c')),'SFT/Physics/'+m+'.lean'],cwd=r,env=env,check=True)
subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(out/(m+'.c')),'-o',str(out/(m+'.o'))],check=True)
print('MassEnergyMeasured native compile PASS')
