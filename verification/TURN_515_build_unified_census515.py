from pathlib import Path
import subprocess,json,os,time,re,concurrent.futures,hashlib,datetime
r=Path('work/constants-recovery').resolve();ir=r/'.lake/build/ir/SFT/Physics';out=Path('work/unified515_build');out.mkdir(exist_ok=True)
env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_PATH=str(r/'.lake/build/lib/lean'))
mods=json.load(open('work/unified515_census_modules.json'));wanted=set(mods);passed=set()
deps={m:{x for x in re.findall(r'^import SFT\.Physics\.(\w+)',(r/'SFT/Physics'/(m+'.lean')).read_text(),re.M) if x in wanted} for m in mods}
record=dict(workers=28,threads_per_worker=1,memory_mib_per_worker=12288,census_heartbeat_limit=100000000,preserved_completed=sorted(passed),passed={},failed={},started_at=datetime.datetime.now(datetime.timezone.utc).isoformat())
def save():Path('work/unified515_build_status.json').write_text(json.dumps(record,indent=2)+'\n')
def build(m):
 setup=ir/(m+'.setup.json');setup.write_text(json.dumps(dict(package='sft_v4',name='SFT.Physics.'+m,isModule=False,options={},plugins=[],importArts={},dynlibs=[])))
 start=time.monotonic();src=r/'SFT/Physics'/(m+'.lean');sha=hashlib.sha256(src.read_bytes()).hexdigest()
 with (out/(m+'.log')).open('w') as f:
  cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--setup',str(setup),'-o',str(r/'.lake/build/lib/lean/SFT/Physics'/(m+'.olean'))]
  if not m.endswith('Proofs'):cmd+=['-c',str(ir/(m+'.c'))]
  res=subprocess.run(cmd+['SFT/Physics/'+m+'.lean'],cwd=r,env=env,stdout=f,stderr=subprocess.STDOUT)
  if res.returncode==0 and not m.endswith('Proofs'):res=subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O3','-c',str(ir/(m+'.c')),'-o',str(ir/(m+'.c.o.export'))],env=env,stdout=f,stderr=subprocess.STDOUT)
 return dict(exit_code=res.returncode,seconds=round(time.monotonic()-start,2),source_sha256=sha,log=str(out/(m+'.log')))
pending=wanted-passed;running={};save()
print('START 28 workers; 12288 MiB per worker; retained',len(passed),'completed modules',flush=True)
with concurrent.futures.ThreadPoolExecutor(max_workers=28) as pool:
 while pending or running:
  ready=[m for m in mods if m in pending and deps[m]<=passed]
  for m in ready[:28-len(running)]:pending.remove(m);running[pool.submit(build,m)]=m
  if not running:break
  done,_=concurrent.futures.wait(running,return_when=concurrent.futures.FIRST_COMPLETED)
  for future in done:
   m=running.pop(future);result=future.result();bucket='passed' if result['exit_code']==0 else 'failed';record[bucket][m]=result
   if result['exit_code']==0:passed.add(m)
   print(m,bucket.upper(),result['seconds'],flush=True)
  record['running']=sorted(running.values());record['pending']=sorted(pending);save()
record['running']=[];record['pending']=sorted(pending);record['finished_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();save()
print('FINISH',len(record['passed']),'passed;',len(record['failed']),'failed;',len(pending),'dependent modules pending',flush=True)
