"""Bound resource use of one authorized SFT compiler; this is not a proof check."""
import sys,os,time,json,subprocess,re,datetime,fcntl
from pathlib import Path
args=sys.argv[1:]
if not args:raise SystemExit('Pass the pinned Lean command and arguments.')
def compilers():
 rows=[]
 for line in subprocess.check_output(['ps','-axo','pid,rss,command'],text=True).splitlines()[1:]:
  a=line.strip().split(None,2)
  if len(a)!=3 or not re.search(r'^\S*/bin/lean(?:\s|$)',a[2]):continue
  rows.append((int(a[0]),int(a[1])))
 return rows
launch_lock=Path("work/lean_launch.lock").open("a")
pending=Path('work')/f'lean_pending_{os.getpid()}.json'
queued_at=time.time()
pending.write_text(json.dumps({'controller_pid':os.getpid(),'state':'waiting for compiler capacity','queued_at':queued_at,'command':args},indent=2)+'\n')
def first_waiter():
 candidates=[]
 for item in Path('work').glob('lean_pending_*.json'):
  try:
   row=json.loads(item.read_text())
   if row.get('state')!='waiting for compiler capacity':continue
   os.kill(row['controller_pid'],0)
   candidates.append((row.get('queued_at',getattr(item.stat(),'st_birthtime',item.stat().st_mtime)),row['controller_pid']))
  except (OSError,ValueError,KeyError):continue
 return min(candidates)[1] if candidates else os.getpid()
while True:
 fcntl.flock(launch_lock,fcntl.LOCK_EX)
 rows=compilers();pressure=subprocess.check_output(['memory_pressure','-Q'],text=True);m=re.search(r'memory free percentage:\s*(\d+)%',pressure)
 if first_waiter()==os.getpid() and len(rows)<8 and sum(x[1]for x in rows)<=40*1024*1024 and m and int(m[1])>=25:
  p=subprocess.Popen(args)
  fcntl.flock(launch_lock,fcntl.LOCK_UN)
  pending.write_text(json.dumps({'controller_pid':os.getpid(),'state':'launched','compiler_pid':p.pid,'command':args},indent=2)+'\n')
  break
 fcntl.flock(launch_lock,fcntl.LOCK_UN)
 pending.write_text(json.dumps({'controller_pid':os.getpid(),'state':'waiting for compiler capacity','queued_at':queued_at,'live_compilers':[pid for pid,_ in rows],'command':args},indent=2)+'\n')
 time.sleep(5)
launch_lock.close()
started=time.time();peak=0;reason=None;receipt=Path('work')/f'lean_resource_{p.pid}.json';receipt.parent.mkdir(exist_ok=True)
def save(code=None):
 receipt.write_text(json.dumps({'pid':p.pid,'command':args,'started_utc':datetime.datetime.fromtimestamp(started,datetime.timezone.utc).isoformat(),'seconds':round(time.time()-started,2),'peak_rss_mib':round(peak/1024,2),'resource_stop':reason,'exit':code},indent=2)+'\n')
save()
while p.poll() is None:
 rows=compilers();rss=next((v for pid,v in rows if pid==p.pid),0);peak=max(peak,rss)
 if rss>8*1024*1024 or sum(v for _,v in rows)>40*1024*1024:
  reason='Actual RSS exceeded8GiB per process or40GiB aggregate; retained proof/log, do not repeat unchanged reduction.';p.terminate()
  try:p.wait(timeout=2)
  except subprocess.TimeoutExpired:p.kill();p.wait()
  break
 save();time.sleep(1)
code=p.wait();save(code)
print(json.dumps({'resource_receipt':str(receipt),'exit':code,'peak_rss_mib':round(peak/1024,2),'resource_stop':reason}),file=sys.stderr,flush=True)
sys.exit(code if code>=0 else 128-code)
