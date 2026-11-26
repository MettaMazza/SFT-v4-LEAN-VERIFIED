"""Build the unchanged QualitativeDistinction empirical runner, reusing exact consciousness build objects."""
from pathlib import Path
import subprocess,os,re,json,hashlib,time,fcntl,sys
w=Path('work').resolve();r=w/'turn1064_recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';out=w/'qualitativedistinction1433_native1380';out.mkdir(exist_ok=True)
env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r),str(c/'.lake/build/lib/lean')]),LEAN_NUM_THREADS='1')
seen=set();mods=[]
def visit(m):
 if m in seen or not m.startswith('SFT.'):return
 seen.add(m);rel=m.replace('.','/');p=r/(rel+'.lean');p=p if p.exists()else c/(rel+'.lean');assert p.exists(),p
 for dep in re.findall(r'^import (\S+)',p.read_text(),re.M):visit(dep)
 mods.append((m,p))
visit('SFT.Consciousness.QualitativeDistinctionValidation')
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
    proc=subprocess.Popen(args,env=env,start_new_session=True)
    while proc.poll() is None:
     # leanc may spawn clang/linker children: bound the entire command group.
     rows=subprocess.check_output(['ps','-axo','pgid=,rss='],text=True).splitlines()
     rss=sum(int(fields[1]) for row in rows if len(fields:=row.split())==2 and int(fields[0])==proc.pid)
     if rss>8192*1024:
      import signal
      os.killpg(proc.pid,signal.SIGTERM)
      try:proc.wait(timeout=2)
      except subprocess.TimeoutExpired:
       os.killpg(proc.pid,signal.SIGKILL);proc.wait()
      raise RuntimeError('C compiler/executable process group exceeded8192MiB; output remains unverified')
     time.sleep(0.2)
    if proc.returncode:raise subprocess.CalledProcessError(proc.returncode,args)
    return
  time.sleep(5)
if '--execute' in sys.argv:
 receipt=json.loads((w/'qualitativedistinction1433_native_build1380.json').read_text())
 assert receipt['status']=='PASS'
 for row in receipt['modules']:assert H(Path(row['source']))==row['source_sha256'],row['module']
 assert H(w/'QualitativeDistinctionValidationProgram1433.lean')==receipt['runner_sha256']
 assert H(Path(receipt['executable']))==receipt['executable_sha256']
 c_command([receipt['executable']]);raise SystemExit(0)
# Preparation only: keep the existing interpreted comparison running.
# Reuse its result if it finishes before this build becomes necessary.
def source_comparison_complete():
 p=w/'qualitativedistinction1433_empirical_report.json'
 if not p.exists():return False
 a=json.loads(p.read_text())
 return a.get('status')=='PASS' and all(H(r/(k if k.startswith('SFT/') else 'SFT/Consciousness/'+k+'.lean'))==v for k,v in a['source_sha256'].items())
shared_receipt=w/'observation1374_native_build1328.json'
while not shared_receipt.exists():
 if source_comparison_complete():
  print('Original source comparison completed; native preparation unnecessary',flush=True);raise SystemExit(0)
 try:os.kill(17326,0)
 except ProcessLookupError:raise RuntimeError('Existing consciousness native builder ended without a build receipt; preserve work and inspect its actual outcome')
 time.sleep(15)
shared=json.loads(shared_receipt.read_text());assert shared['status']=='PASS'
shared_modules={row['module']:row for row in shared['modules']}
records=[];objects=[]
for module,src in mods:
 if source_comparison_complete():
  print('Original source comparison completed; retaining prepared objects',flush=True);raise SystemExit(0)
 row=shared_modules.get(module)
 if row is not None:
  obj=w/'observation1374_native'/(module+'.o')
  if H(src)==row['source_sha256'] and H(Path(row['generated_c']))==row['generated_c_sha256'] and obj.exists() and H(obj)==row['object_sha256']:
   objects.append(str(obj));records.append(dict(row,reused_object=str(obj)));print('REUSE',module,flush=True);continue
 rel=module.replace('.','/');orig=c/(rel+'.lean');canonical_c=c/'.lake/build/ir'/(rel+'.c');gen=out/(module+'.c')
 reusable=canonical_c.exists()and orig.exists()and src.read_bytes()==orig.read_bytes()and canonical_c.stat().st_mtime>=orig.stat().st_mtime
 if reusable:gen=canonical_c
 else:
  stamp=out/(module+'.c.source.json');digest=H(src)
  if not(gen.exists()and stamp.exists()and json.loads(stamp.read_text())=={'source':digest,'generated':H(gen)}):
   subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-R',str(r if src.is_relative_to(r) else c),'-c',str(gen),str(src)],env=env,check=True)
   assert H(src)==digest;stamp.write_text(json.dumps({'source':digest,'generated':H(gen)}))
 obj=out/(module+'.o');stamp=out/(module+'.o.source.json');digest=H(gen)
 if not(obj.exists()and stamp.exists()and json.loads(stamp.read_text())=={'generated':digest,'object':H(obj)}):
  c_command([str(tc/'bin/leanc'),'-O2','-c',str(gen),'-o',str(obj)])
  assert H(gen)==digest;stamp.write_text(json.dumps({'generated':digest,'object':H(obj)}))
 objects.append(str(obj));records.append({'module':module,'source':str(src),'source_sha256':H(src),'generated_c':str(gen),'generated_c_sha256':H(gen),'object_sha256':H(obj),'reused_c':reusable})
 print('OBJECT',module,flush=True)
program='QualitativeDistinctionValidationProgram1433';src=w/(program+'.lean');gen=out/(program+'.c')
subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-R',str(w),'-c',str(gen),str(src)],env=env,check=True)
flags=['-I',str(tc/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(tc),'-nostdinc','-isystem',str(tc/'include/clang')]
libs=['-L',str(tc/'lib'),'-L',str(tc/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(tc/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']
# Resolve existing symbol spellings only; no implementation substitution.
def symbols(flags):
 text=subprocess.check_output(['nm',flags,*objects],text=True)
 return {line.split()[-1]for line in text.splitlines()if line.strip()and not line.endswith(':')}
exports=symbols('-gU');undefined=symbols('-gu');aliases=[]
for expected in sorted(undefined-exports):
 actual=None
 if expected.startswith('_lp_sft__v4_')and 'SFT_Host_Text' in expected:
  candidate='_l_'+expected[len('_lp_sft__v4_'):]
  if candidate in exports:actual=candidate
 elif expected.startswith('_initialize_')and '_SFT_' in expected:
  suffix=expected[expected.index('_SFT_'):]
  candidates=[n for n in exports if n.startswith('_initialize_')and n.endswith(suffix)]
  if len(candidates)==1:actual=candidates[0]
 if actual:aliases.append([actual,expected])
alias_flags=['-Wl,-alias,'+a+','+b for a,b in aliases]
exe=out/program;c_command([str(tc/'bin/clang'),*flags,str(gen),*objects,*libs,*alias_flags,'-Wl,-stack_size,0x20000000','-o',str(exe)])
(w/'qualitativedistinction1433_native_build1380.json').write_text(json.dumps({'status':'PASS','scope':'compiled executable construction only; original comparison remains required','modules':records,'runner_sha256':H(src),'executable':str(exe),'executable_sha256':H(exe),'link_aliases':aliases},indent=2)+'\n')
print('Native QualitativeDistinction empirical executable prepared; existing comparison still authoritative until executed and compared',flush=True)
