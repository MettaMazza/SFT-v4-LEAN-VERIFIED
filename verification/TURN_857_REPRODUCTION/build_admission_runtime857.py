from pathlib import Path
import subprocess,os,json,concurrent.futures
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));w=Path('work')
def build(m):
 log=w/f'admission857_{m}_build.log';cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','SFT/Foundation/'+m+'.lean','-o',str(r/'.lake/build/lib/lean/SFT/Foundation'/(m+'.olean')),'-c',str(r/'.lake/build/ir/SFT/Foundation'/(m+'.c'))];result=subprocess.run(cmd,cwd=r,env=env,capture_output=True,text=True);log.write_text(result.stdout+result.stderr);print(m,result.returncode,flush=True);return {'module':m,'command':cmd,'exit':result.returncode,'log':str(log)}
for m in ['AdmissionControls','AdmissionEvidence']:
 row=build(m);assert row['exit']==0
