from pathlib import Path
import subprocess,json,os,time
r=Path('work/constants-recovery').resolve();ir=r/'.lake/build/ir/SFT/Physics';out=Path('work/lensing505_repair');out.mkdir(exist_ok=True)
env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_PATH=str(r/'.lake/build/lib/lean'))
mods=['CosmoLensing']
for m in mods:
 setup=ir/(m+'.setup.json');setup.write_text(json.dumps(dict(package='sft_v4',name='SFT.Physics.'+m,isModule=False,options={},plugins=[],importArts={},dynlibs=[])))
 start=time.monotonic()
 with (out/(m+'.log')).open('w') as f:
  cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M16384','--setup',str(setup),'-o',str(r/'.lake/build/lib/lean/SFT/Physics'/(m+'.olean'))]
  if not m.endswith('Proofs'):cmd+=['-c',str(ir/(m+'.c'))]
  subprocess.run(cmd+['SFT/Physics/'+m+'.lean'],cwd=r,env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
  if not m.endswith('Proofs'):
   subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c',str(ir/(m+'.c')),'-o',str(ir/(m+'.c.o.export'))],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
 print(m,'PASS',round(time.monotonic()-start,2),flush=True)
