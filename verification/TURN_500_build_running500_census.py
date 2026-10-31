from pathlib import Path
import subprocess,os,json,time
r=Path('work/constants-recovery').resolve();out=Path('work/running500_build');out.mkdir(exist_ok=True);mods=json.load(open('work/running500_modules.json'));env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_STACK_SIZE_KB='262144',LEAN_PATH=str(r/'.lake/build/lib/lean'))
for m in mods[3:]:
 start=time.monotonic();rel='SFT/Physics/'+m
 with (out/(m+'.log')).open('w') as f:
  subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','2048','-o',str(r/'.lake/build/lib/lean'/(rel+'.olean')),'-i',str(r/'.lake/build/lib/lean'/(rel+'.ilean')),rel+'.lean'],cwd=r,env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
 print('BUILT',m,round(time.monotonic()-start,2),flush=True)
Path('work/running500_census_build_report.json').write_text(json.dumps(dict(status='PASS',complete_candidates=8748,modules=mods[3:]),indent=2))
