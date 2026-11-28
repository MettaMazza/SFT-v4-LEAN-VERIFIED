from pathlib import Path
import os,subprocess,shutil
root=Path(__file__).resolve().parents[1];b=root/'.lake/build/applications/discovery';s=b/'source';s.mkdir(parents=True,exist_ok=True)
t=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin';env=dict(os.environ,LEAN_PATH=str(s));objects=[]
for m in ['SFT/Host/Text']+['SFT/Applications/Discovery/'+n for n in ['Core','Inputs','Sweep','Explorer','Main']]:
 dst=s/(m+'.lean');dst.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(root/(m+'.lean'),dst);c=b/(m.replace('/','_')+'.c');o=c.with_suffix('.o')
 subprocess.run([str(t/'lean'),'-R',str(s),'-j1','-M8192','-o',str(dst.with_suffix('.olean')),'-c',str(c),str(dst)],env=env,check=True)
 subprocess.run([str(t/'leanc'),'-O3','-c',str(c),'-o',str(o)],check=True);objects.append(str(o))
subprocess.run([str(t/'leanc'),'-O3','-o',str(b/'discovery_lean')]+objects,check=True)
subprocess.run([str(b/'discovery_lean')],check=True)
