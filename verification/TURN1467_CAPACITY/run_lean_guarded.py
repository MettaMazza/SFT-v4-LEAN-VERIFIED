"""Bound resource use of one authorized SFT compiler; this is not a proof check."""
import sys,os,time,json,subprocess,re,datetime,fcntl,signal
from pathlib import Path
args=sys.argv[1:]
if not args:raise SystemExit('Pass the pinned Lean command and arguments.')
# The original Catalytic bundle contains a439MiB source ZIP; its verified list hash needs more than8GiB.
large_source_runner=str((Path('work')/'catalytic1356_chunked1466/CatalyticTurnoverValidationProgram1466').resolve())
process_limit_gib=16 if str(Path(args[0]).resolve())==large_source_runner else 8
def compilers():
 processes={}
 for line in subprocess.check_output(['ps','-axo','pid,pgid,rss,command'],text=True).splitlines()[1:]:
  a=line.strip().split(None,3)
  if len(a)==4: processes[int(a[0])]=(int(a[1]),int(a[2]),a[3])
 rows={pid:rss for pid,(_,rss,cmd) in processes.items() if re.search(r'^\S*/bin/lean(?:\s|$)',cmd)}
 for controller,(_,_,command_line) in processes.items():
  if not re.search(r'(?:^|\s)\S*run_lean_guarded\.py(?:\s|$)',command_line): continue
  marker=Path('work')/f'lean_pending_{controller}.json'
  try:
   item=json.loads(marker.read_text());pid=item.get('compiler_pid')
   if item.get('state')!='launched' or pid not in processes: continue
   command=item.get('command',[])
   if not command or not processes[pid][2].startswith(str(command[0])): continue
   if item.get('process_group')==pid:
    rows[pid]=sum(rss for pgid,rss,_ in processes.values() if pgid==pid)
   elif re.search(r'^\S*/bin/lean(?:\s|$)',processes[pid][2]): rows[pid]=processes[pid][1]
  except (OSError,ValueError,KeyError): continue
 return list(rows.items())
launch_lock=Path("work/lean_launch.lock").open("a")
pending=Path('work')/f'lean_pending_{os.getpid()}.json'
queued_at=time.time()
pending.write_text(json.dumps({'controller_pid':os.getpid(),'state':'waiting for compiler capacity','queued_at':queued_at,'job_limit':24,'command':args},indent=2)+'\n')
def first_waiter(active_count):
 candidates=[]
 for item in Path('work').glob('lean_pending_*.json'):
  try:
   row=json.loads(item.read_text())
   if row.get('state')!='waiting for compiler capacity':continue
   if row.get('job_limit',16)<=active_count:continue
   os.kill(row['controller_pid'],0)
   candidates.append((row.get('queued_at',getattr(item.stat(),'st_birthtime',item.stat().st_mtime)),row['controller_pid']))
  except (OSError,ValueError,KeyError):continue
 return min(candidates)[1] if candidates else os.getpid()
while True:
 fcntl.flock(launch_lock,fcntl.LOCK_EX)
 rows=compilers();pressure=subprocess.check_output(['memory_pressure','-Q'],text=True);m=re.search(r'memory free percentage:\s*(\d+)%',pressure)
 if first_waiter(len(rows))==os.getpid() and len(rows)<24 and sum(x[1]for x in rows)<=40*1024*1024 and m and int(m[1])>=25:
  p=subprocess.Popen(args,start_new_session=True)
  pending.write_text(json.dumps({'controller_pid':os.getpid(),'state':'launched','compiler_pid':p.pid,'process_group':p.pid,'job_limit':24,'command':args},indent=2)+'\n')
  fcntl.flock(launch_lock,fcntl.LOCK_UN)
  break
 fcntl.flock(launch_lock,fcntl.LOCK_UN)
 pending.write_text(json.dumps({'controller_pid':os.getpid(),'state':'waiting for compiler capacity','queued_at':queued_at,'live_compilers':[pid for pid,_ in rows],'job_limit':24,'command':args},indent=2)+'\n')
 time.sleep(5)
launch_lock.close()
started=time.time();peak=0;reason=None;receipt=Path('work')/f'lean_resource_{p.pid}.json';receipt.parent.mkdir(exist_ok=True)
def save(code=None):
 receipt.write_text(json.dumps({'pid':p.pid,'job_limit':24,'command':args,'started_utc':datetime.datetime.fromtimestamp(started,datetime.timezone.utc).isoformat(),'seconds':round(time.time()-started,2),'peak_rss_mib':round(peak/1024,2),'process_limit_gib':process_limit_gib,'resource_stop':reason,'exit':code},indent=2)+'\n')
save()
while p.poll() is None:
 rows=compilers();rss=next((v for pid,v in rows if pid==p.pid),0);peak=max(peak,rss)
 if rss>process_limit_gib*1024*1024 or sum(v for _,v in rows)>40*1024*1024:
  reason=f'Actual RSS exceeded{process_limit_gib}GiB per process or40GiB aggregate; retained proof/log, do not repeat unchanged reduction.';os.killpg(p.pid,signal.SIGTERM)
  try:p.wait(timeout=2)
  except subprocess.TimeoutExpired:os.killpg(p.pid,signal.SIGKILL);p.wait()
  break
 save();time.sleep(1)
code=p.wait();save(code)
print(json.dumps({'resource_receipt':str(receipt),'exit':code,'peak_rss_mib':round(peak/1024,2),'process_limit_gib':process_limit_gib,'resource_stop':reason}),file=sys.stderr,flush=True)
sys.exit(code if code>=0 else 128-code)
