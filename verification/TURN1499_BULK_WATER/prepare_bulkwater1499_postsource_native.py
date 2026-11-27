"""Build the unchanged thermal1345 empirical runner, reusing exact retained polarizability and consciousness build objects."""
from pathlib import Path
import subprocess,os,re,json,hashlib,time,fcntl,sys
w=Path('work').resolve();r=w/'turn1064_recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';out=w/'bulkwater1499_postsource_native';out.mkdir(exist_ok=True)
env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r),str(c/'.lake/build/lib/lean')]),LEAN_NUM_THREADS='1')
seen=set();mods=[]
def visit(m):
 if m in seen or not m.startswith('SFT.'):return
 seen.add(m);rel=m.replace('.','/');p=(w/'solvation_chunked1442_source'/(rel+'.lean')) if m=='SFT.Host.Canonical' else ((w/'streaming1468'/(rel+'.lean')) if m=='SFT.Host.SHA256Chunks' else ((w/'optimized1469'/(rel+'.lean')) if m in ['SFT.Host.SHA256','SFT.Host.SHA256Window','SFT.Host.SHA256Streaming'] else r/(rel+'.lean')));p=p if p.exists()else c/(rel+'.lean');assert p.exists(),p
 for dep in re.findall(r'^import (\S+)',p.read_text(),re.M):visit(dep)
 mods.append((m,p))
visit('SFT.Materials.BulkWaterValidation')
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
# The existing shared gate counts Lean and native process groups within eight jobs.
def c_command(args):
 subprocess.run([sys.executable,str(w/'run_lean_guarded.py'),*map(str,args)],env=env,check=True)
if '--execute' in sys.argv:
 receipt=json.loads((w/'bulkwater1499_postsource_native_build.json').read_text())
 assert receipt['status']=='PASS'
 for row in receipt['modules']:assert H(Path(row['source']))==row['source_sha256'],row['module']
 assert H(w/'BulkWaterPostSource1499.lean')==receipt['runner_sha256']
 assert H(Path(receipt['executable']))==receipt['executable_sha256']
 c_command([receipt['executable'],*sys.argv[sys.argv.index('--execute')+1:]]);raise SystemExit(0)
# Preparation only: keep the existing interpreted comparison running.
# Reuse its result if it finishes before this build becomes necessary.
def source_comparison_complete():
 p=w/'bulkwater1499_postsource_report.json'
 return p.exists() and json.loads(p.read_text()).get('status')=='PASS'
shared_receipt=w/'crossproperty1327_native_build1365.json'
while not shared_receipt.exists():
 if source_comparison_complete():
  print('Original source comparison completed; native preparation unnecessary',flush=True);raise SystemExit(0)
 try:os.kill(17326,0)
 except ProcessLookupError:raise RuntimeError('Existing consciousness native builder ended without a build receipt; preserve work and inspect its actual outcome')
 time.sleep(15)
shared=json.loads(shared_receipt.read_text());assert shared['status']=='PASS'
shared_modules={row['module']:row for row in shared['modules']}
for receipt_name in ['electronaffinity1321_native_build1392.json', 'html1402_linear_native_build.json', 'affinity1403_native_build.json', 'affinity1405_native_build.json', 'rotational1323_native_build1404.json', 'rotational1323_native_build1392.json', 'heatwork1331_program_native_build1413.json', 'phase1338_program_native_build1413.json', 'freeenergy1334_empirical_native_build1413.json', 'gas1337_empirical_native_build1413.json', 'activity1336_empirical_native_build1413.json', 'solvation1342_empirical_native_build1413.json', 'diagram1340_empirical_native_build1413.json', 'diffusion1343_program_native_build1413.json', 'viscous1344_program_native_build1413.json', 'thermal1345_program_native_build1413.json', 'thermal1345_empirical_native_build1413.json', 'solvation1342_chunked_build1442.json', 'thermal1345_chunked_build1453.json', 'coupled1346_chunked_build1462.json', 'sequential1353_chunked_build1463.json', 'parallel1354_chunked_build1464.json', 'reversible1355_chunked_build1465.json', 'catalytic1356_chunked_build1466.json', 'catalytic1356_streaming_build1468.json', 'hash_optimized1469_build.json', 'search1360_empirical_native_build1413.json', 'catalytic1356_optimized_build1470.json', 'coordgeometry1446_optimized_build1472.json', 'coordisomer1474_program_optimized_build1474.json', 'coordisomer1474_optimized_build1474.json', 'complexspin1477_program_optimized_build1477.json', 'complexspin1477_optimized_build1477.json', 'colour1478_program_optimized_build1478.json', 'colour1478_optimized_build1478.json', 'inorgmag1479_program_optimized_build1479.json', 'inorgmag1479_optimized_build1479.json', 'metalcarbon1480_program_optimized_build1480.json', 'metalcarbon1480_optimized_build1480.json', 'electronaccount1481_program_optimized_build1481.json', 'electronaccount1481_optimized_build1481.json', 'oxidative1482_program_optimized_build1482.json', 'oxidative1482_optimized_build1482.json', 'insertion1483_program_optimized_build1483.json', 'insertion1483_optimized_build1483.json', 'metalcluster1484_program_optimized_build1484.json', 'metalcluster1484_optimized_build1484.json', 'solidlocal1487_program_optimized_build1487.json', 'solidlocal1487_optimized_build1487.json', 'defect1489_program_optimized_build1489.json', 'defect1489_optimized_build1489.json', 'inorgnetwork1490_program_optimized_build1490.json', 'inorgnetwork1490_optimized_build1490.json', 'aromatic1491_program_optimized_build1491.json', 'aromatic1491_optimized_build1491.json', 'antiaromatic1492_program_optimized_build1492.json', 'antiaromatic1492_optimized_build1492.json', 'conformer1494_program_optimized_build1492.json', 'conformerpopulation1495_program_native_build.json', 'electrophilic1498_validation_native_build.json', 'bulkwater1499_program_native_build.json', 'bulkwater1499_validation_native_build.json']:
 extra=json.loads((w/receipt_name).read_text());assert extra['status']=='PASS'
 for row in extra['modules']:
  shared_modules[row['module']]=row

records=[];objects=[]
for module,src in mods:
 if source_comparison_complete():
  print('Original source comparison completed; retaining prepared objects',flush=True);raise SystemExit(0)
 row=shared_modules.get(module)
 if row is not None:
  obj=Path(row.get('reused_object',str(Path(row['generated_c']).with_suffix('.o'))))
  if H(src)==row['source_sha256'] and H(Path(row['generated_c']))==row['generated_c_sha256'] and obj.exists() and H(obj)==row['object_sha256']:
   objects.append(str(obj));records.append(dict(row,reused_object=str(obj)));print('REUSE',module,flush=True);continue
 rel=module.replace('.','/');orig=c/(rel+'.lean');canonical_c=c/'.lake/build/ir'/(rel+'.c');gen=out/(module+'.c')
 reusable=False # Reuse hash-bound shared objects; avoid waiting One Touch filesystem access.
 if reusable:gen=canonical_c
 else:
  stamp=out/(module+'.c.source.json');digest=H(src)
  if not(gen.exists()and stamp.exists()and json.loads(stamp.read_text())=={'source':digest,'generated':H(gen)}):
   subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-R',str(src.resolve().parents[len(module.split('.'))-1]),'-c',str(gen),str(src.resolve())],env=env,check=True)
   assert H(src)==digest;stamp.write_text(json.dumps({'source':digest,'generated':H(gen)}))
 obj=out/(module+'.o');stamp=out/(module+'.o.source.json');digest=H(gen)
 if not(obj.exists()and stamp.exists()and json.loads(stamp.read_text())=={'generated':digest,'object':H(obj)}):
  c_command([str(tc/'bin/leanc'),'-O2','-c',str(gen),'-o',str(obj)])
  assert H(gen)==digest;stamp.write_text(json.dumps({'generated':digest,'object':H(obj)}))
 objects.append(str(obj));records.append({'module':module,'source':str(src),'source_sha256':H(src),'generated_c':str(gen),'generated_c_sha256':H(gen),'object_sha256':H(obj),'reused_c':reusable})
 print('OBJECT',module,flush=True)
program='BulkWaterPostSource1499';src=w/(program+'.lean');gen=out/(program+'.c')
subprocess.run(['python3','work/run_lean_guarded.py',str(tc/'bin/lean'),'-j1','-M8192','-R',str(w),'-c',str(gen),str(src)],env=env,check=True)
flags=['-I',str(tc/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(tc),'-nostdinc','-isystem',str(tc/'include/clang')]
libs=['-L',str(tc/'lib'),'-L',str(tc/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(tc/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']
# Resolve existing symbol spellings only; no implementation substitution.
def symbols(flags):
 text=subprocess.check_output(['nm',flags,*objects],text=True)
 return {line.split()[-1]for line in text.splitlines()if line.strip()and not line.endswith(':')}
exports=symbols('-gU');undefined=symbols('-gu');undefined.update('_'+n for n in re.findall(r'\b(lp_sft__v4_[A-Za-z0-9_]+)\s*\(',gen.read_text()));aliases=[]
for expected in sorted(undefined-exports):
 actual=None
 if expected.startswith('_lp_sft__v4_'):
  candidate='_l_'+expected[len('_lp_sft__v4_'):]
  if candidate in exports:actual=candidate
 elif expected.startswith('_initialize_')and '_SFT_' in expected:
  suffix=expected[expected.index('_SFT_'):]
  candidates=[n for n in exports if n.startswith('_initialize_')and n.endswith(suffix)]
  if len(candidates)==1:actual=candidates[0]
 if actual:aliases.append([actual,expected])
alias_flags=['-Wl,-alias,'+a+','+b for a,b in aliases]
exe=out/program;c_command([str(tc/'bin/clang'),*flags,str(gen),*objects,*libs,*alias_flags,'-Wl,-stack_size,0x20000000','-o',str(exe)])
(w/'bulkwater1499_postsource_native_build.json').write_text(json.dumps({'status':'PASS','scope':'compiled executable construction only; original comparison remains required','modules':records,'runner_sha256':H(src),'executable':str(exe),'executable_sha256':H(exe),'link_aliases':aliases},indent=2)+'\n')
print('Native entryORG004 executable prepared; execute and compare to pinned source',flush=True)
