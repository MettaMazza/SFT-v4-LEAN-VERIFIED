"""Reuse the established generated-C execution path for the unchanged root comparison."""
from pathlib import Path
import subprocess,os,re,json,hashlib,time,fcntl,sys
w=Path('work').resolve();r=w/'turn1064_recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';out=w/'observation1374_native';out.mkdir(exist_ok=True)
env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r),str(c/'.lake/build/lib/lean')]),LEAN_NUM_THREADS='1')
seen=set();mods=[]
def visit(m):
 if m in seen or not m.startswith('SFT.'):return
 seen.add(m);rel=m.replace('.','/');p=r/(rel+'.lean');p=p if p.exists()else c/(rel+'.lean');assert p.exists(),p
 for dep in re.findall(r'^import (\S+)',p.read_text(),re.M):visit(dep)
 mods.append((m,p))
visit('SFT.Consciousness.ObservationActValidation')
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
# Existing Lean gate counts Lean processes. Hold its launch lock for the whole
# single C compiler/link operation so another launch cannot exceed four jobs.
def c_command(args):
 while True:
  with(w/'lean_launch.lock').open('a')as lock:
   fcntl.flock(lock,fcntl.LOCK_EX)
   live=[]
   for line in subprocess.check_output(['ps','-axo','pid,rss,command'],text=True).splitlines()[1:]:
    a=line.strip().split(None,2)
    if len(a)==3 and re.search(r'^\S*/bin/lean(?:\s|$)',a[2]):live.append(int(a[1]))
   pressure=subprocess.check_output(['memory_pressure','-Q'],text=True);m=re.search(r'memory free percentage:\s*(\d+)%',pressure)
   if len(live)<4 and sum(live)<=32*1024*1024 and m and int(m[1])>=25:
    proc=subprocess.Popen(args,env=env)
    while proc.poll() is None:
     rss=subprocess.run(['ps','-p',str(proc.pid),'-o','rss='],capture_output=True,text=True).stdout.strip()
     if rss and int(rss)>8192*1024:
      proc.terminate();proc.wait();raise RuntimeError('C compiler/executable exceeded8192MiB; output remains unverified')
     time.sleep(0.2)
    if proc.returncode:raise subprocess.CalledProcessError(proc.returncode,args)
    return
  time.sleep(5)
if '--execute' in sys.argv:
 receipt=json.loads((w/'observation1374_native_build1328.json').read_text())
 assert receipt['status']=='PASS'
 for row in receipt['modules']:assert H(Path(row['source']))==row['source_sha256'],row['module']
 assert H(w/'ObservationActValidationProgram1374.lean')==receipt['runner_sha256']
 assert H(Path(receipt['executable']))==receipt['executable_sha256']
 c_command([receipt['executable']]);raise SystemExit(0)
records=[];objects=[]
for module,src in mods:
 rel=module.replace('.','/');orig=c/(rel+'.lean');canonical_c=c/'.lake/build/ir'/(rel+'.c');gen=out/(module+'.c')
 reusable=canonical_c.exists()and orig.exists()and src.read_bytes()==orig.read_bytes()and canonical_c.stat().st_mtime>=orig.stat().st_mtime
 if reusable:gen=canonical_c
 else:
  stamp=out/(module+'.c.source.json');digest=H(src)
  if not(gen.exists()and stamp.exists()and json.loads(stamp.read_text())=={'source':digest,'generated':H(gen)}):
   subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-c',str(gen),str(src)],env=env,check=True)
   assert H(src)==digest;stamp.write_text(json.dumps({'source':digest,'generated':H(gen)}))
 obj=out/(module+'.o');stamp=out/(module+'.o.source.json');digest=H(gen)
 if not(obj.exists()and stamp.exists()and json.loads(stamp.read_text())=={'generated':digest,'object':H(obj)}):
  c_command([str(tc/'bin/leanc'),'-O2','-c',str(gen),'-o',str(obj)])
  assert H(gen)==digest;stamp.write_text(json.dumps({'generated':digest,'object':H(obj)}))
 objects.append(str(obj));records.append({'module':module,'source':str(src),'source_sha256':H(src),'generated_c':str(gen),'generated_c_sha256':H(gen),'object_sha256':H(obj),'reused_c':reusable})
 print('OBJECT',module,flush=True)
program='ObservationActValidationProgram1374';src=w/(program+'.lean');gen=out/(program+'.c')
subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-c',str(gen),str(src)],env=env,check=True)
flags=['-I',str(tc/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(tc),'-nostdinc','-isystem',str(tc/'include/clang')]
libs=['-L',str(tc/'lib'),'-L',str(tc/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(tc/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']
exe=out/program;c_command([str(tc/'bin/clang'),*flags,str(gen),*objects,*libs,'-Wl,-stack_size,0x20000000','-o',str(exe)])
(w/'observation1374_native_build1328.json').write_text(json.dumps({'status':'PASS','scope':'compiled executable construction only; original comparison remains required','modules':records,'runner_sha256':H(src),'executable':str(exe),'executable_sha256':H(exe)},indent=2)+'\n')
print('Native root comparison executable prepared',flush=True)
