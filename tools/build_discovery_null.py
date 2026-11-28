"""Build native legacy USDE checks, reusing prerequisite objects from build_discovery_usde.py. Never runs original engines."""
from pathlib import Path
import os,subprocess,shutil
r=Path(__file__).resolve().parents[1];b=r/'.lake/build/applications/discovery';s=b/'source';t=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin';env=dict(os.environ,LEAN_PATH=str(s))
for name in ['PythonRandom','USDENull']:
 m='SFT/Applications/Discovery/'+name;dst=s/(m+'.lean');shutil.copyfile(r/(m+'.lean'),dst);c=b/(m.replace('/','_')+'.c');o=c.with_suffix('.o');subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192','-o',str(dst.with_suffix('.olean')),'-c',str(c),str(dst)],env=env,check=True);subprocess.run([str(t/'leanc'),'-O3','-c',str(c),'-o',str(o)],check=True)
name='RandomCheck1606';shutil.copyfile(r/'verification/APPLICATION_DISCOVERY1606'/(name+'.lean'),s/(name+'.lean'));c=b/(name+'.c');o=c.with_suffix('.o');subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192','-c',str(c),str(s/(name+'.lean'))],env=env,check=True);subprocess.run([str(t/'leanc'),'-O3','-c',str(c),'-o',str(o)],check=True)
objects=[str(b/(m.replace('/','_')+'.o'))for m in ['SFT/Host/Text','SFT/Host/SHA256']+['SFT/Applications/Discovery/'+n for n in ['Core','Explorer','Carry','Source','Display','Reports','USDECore','USDEEigenvalues','USDEMatching','USDESweep','PythonRandom','USDENull']]]
subprocess.run([str(t/'leanc'),'-O3','-o',str(b/'random_check')]+objects+[str(o)],check=True)
(b/'work').mkdir(exist_ok=True)
with (b/'random_check1606.log').open('w')as f:subprocess.run([str(b/'random_check')],stdout=f,check=True,cwd=b)
