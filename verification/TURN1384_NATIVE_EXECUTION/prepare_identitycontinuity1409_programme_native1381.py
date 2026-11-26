"""Build the unchanged IdentityContinuity programme runner, reusing exact consciousness build objects."""
from pathlib import Path
import subprocess,os,re,json,hashlib,time,fcntl,sys
w=Path('work').resolve();r=w/'turn1064_recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';out=w/'identitycontinuity1409_programme_native1381';out.mkdir(exist_ok=True)
env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r),str(c/'.lake/build/lib/lean')]),LEAN_NUM_THREADS='1')
seen=set();mods=[]
def visit(m):
 if m in seen or not m.startswith('SFT.'):return
 seen.add(m);rel=m.replace('.','/');p=r/(rel+'.lean');p=p if p.exists()else c/(rel+'.lean');assert p.exists(),p
 for dep in re.findall(r'^import (\S+)',p.read_text(),re.M):visit(dep)
 mods.append((m,p))
visit('SFT.Consciousness.IdentityContinuityEvidence')
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
# The existing shared gate counts Lean and native process groups within eight jobs.
def c_command(args):
 subprocess.run([sys.executable,str(w/'run_lean_guarded.py'),*map(str,args)],env=env,check=True)
if '--execute' in sys.argv:
 receipt=json.loads((w/'identitycontinuity1409_programme_native_build1381.json').read_text())
 assert receipt['status']=='PASS'
 for row in receipt['modules']:assert H(Path(row['source']))==row['source_sha256'],row['module']
 assert H(r/'IdentityContinuityProgram1409.lean')==receipt['runner_sha256']
 assert H(Path(receipt['executable']))==receipt['executable_sha256']
 c_command([receipt['executable'],*sys.argv[sys.argv.index('--execute')+1:]]);raise SystemExit(0)
# Preparation only: keep the existing interpreted comparison running.
# Reuse its result if it finishes before this build becomes necessary.
def source_comparison_complete():
 return False # Existing worker reuses finished programme checks before invoking this builder.
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
 reusable=False # Reuse hash-bound shared objects; avoid waiting One Touch filesystem access.
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
program='IdentityContinuityProgram1409';src=r/(program+'.lean');gen=out/(program+'.c')
subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-R',str(r),'-c',str(gen),str(src)],env=env,check=True)
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
(w/'identitycontinuity1409_programme_native_build1381.json').write_text(json.dumps({'status':'PASS','scope':'compiled executable construction only; original comparison remains required','modules':records,'runner_sha256':H(src),'executable':str(exe),'executable_sha256':H(exe),'link_aliases':aliases},indent=2)+'\n')
print('Native IdentityContinuity programme executable prepared; existing comparison still authoritative until executed and compared',flush=True)
