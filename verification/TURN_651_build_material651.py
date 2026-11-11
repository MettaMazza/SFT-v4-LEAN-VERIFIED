from pathlib import Path
import subprocess,os
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
for m in ['MaterialIdentity','MaterialGrammar','MaterialEvidence']:
 p='SFT/Materials/'+m; (r/('.lake/build/lib/lean/'+p)).parent.mkdir(parents=True,exist_ok=True);(r/('.lake/build/ir/'+p)).parent.mkdir(parents=True,exist_ok=True)
 cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',p+'.lean','-o','.lake/build/lib/lean/'+p+'.olean','-i','.lake/build/lib/lean/'+p+'.ilean','-c','.lake/build/ir/'+p+'.c']
 print(cmd,flush=True);subprocess.run(cmd,cwd=r,env=env,check=True);print('PASS',m,flush=True)
