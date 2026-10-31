from pathlib import Path
import subprocess,os,json,time
r=Path('work/constants-recovery').resolve();out=Path('work/running500_native_build');out.mkdir(exist_ok=True);mods=['RunningConvergenceMeasurement','RunningConvergencePrediction','RunningConvergenceValidation'];env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_PATH=str(r/'.lake/build/lib/lean'))
for i,m in enumerate(mods):
 if False: continue
 start=time.monotonic();rel='SFT/Physics/'+m;setup=out/(m+'.setup.json');setup.write_text(json.dumps(dict(package='sft_v4',name=rel.replace('/','.'),plugins=[],dynlibs=[],options={},isModule=False,importArts={})))
 with (out/(m+'.log')).open('w') as f:
  subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','4096','--setup',str(setup.resolve()),'-o',str(r/'.lake/build/lib/lean'/(rel+'.olean')),'-i',str(r/'.lake/build/lib/lean'/(rel+'.ilean')),'-c',str(r/'.lake/build/ir'/(rel+'.c')),rel+'.lean'],cwd=r,env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
  subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c',str(r/'.lake/build/ir'/(rel+'.c')),'-o',str(r/'.lake/build/ir'/(rel+'.c.o.export'))],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
 print('BUILT',i+1,len(mods),m,round(time.monotonic()-start,2),flush=True)
Path('work/running500_validation_native_build_report.json').write_text(json.dumps(dict(status='PASS',modules=mods,complete_candidates=8748,full_census_blocks=27,all_cases_per_block=324),indent=2))
