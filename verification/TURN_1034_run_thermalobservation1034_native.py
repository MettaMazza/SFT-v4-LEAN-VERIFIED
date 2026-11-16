from pathlib import Path
import subprocess,json,os,copy,time,re
toolchain=Path('/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0')
flags=['-I',str(toolchain/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(toolchain),'-nostdinc','-isystem',str(toolchain/'include/clang')]
libs=['-L',str(toolchain/'lib'),'-L',str(toolchain/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(toolchain/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN'); canonical=Path('/Volumes/One Touch/SFT v4 Full model LEAN'); ir=r/'.lake/build/ir';env=dict(os.environ,LEAN_NUM_THREADS='28',LEAN_HOST_STACK_SIZE='1024',LEAN_PATH=str(r/'.lake/build/lib/lean'))
from concurrent.futures import ThreadPoolExecutor
modules=[]
seenmodules=set()
def collect(name):
 if name in seenmodules or not name.startswith('SFT.'):return
 seenmodules.add(name)
 p=r/(name.replace('.','/')+'.lean')
 for dep in re.findall(r'^import (\S+)',p.read_text(),re.M):collect(dep)
 if name in ['SFT.Physics.VacuumDensity','SFT.Physics.VacuumLedgerProofs','SFT.Physics.LeptonIntervals','SFT.Physics.LeptonRatios'] or name.startswith('SFT.Foundation.AdmissionGrammarBlock') or (name.startswith('SFT.Physics.VelocityComposition') or name.startswith('SFT.Physics.ThermalObservation')) or name in ['SFT.Foundation.AdmissionControls','SFT.Foundation.AdmissionGrammar','SFT.Foundation.AdmissionGrammarCore','SFT.Foundation.AdmissionAcceptance','SFT.Mathematics.FoldScalar']:modules.append(name.replace('.','/'))
collect('SFT.Physics.ThermalObservationEvidence')

def compile_one(m):
 src=m;c=ir/(src+'.c');obj=ir/(src+'.c.o.export')
 if not c.exists() or c.stat().st_mtime<(r/(src+'.lean')).stat().st_mtime:subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-c',str(c),'--setup',str(ir/(src+'.setup.json')),src+'.lean'],cwd=r,env=env,check=True)
 if not obj.exists() or obj.stat().st_mtime<c.stat().st_mtime:subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(c),'-o',str(obj)],check=True)
with ThreadPoolExecutor(max_workers=20) as pool:list(pool.map(compile_one,modules))
program='ThermalObservationProgram1034';subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-c',program+'.c',program+'.lean'],cwd=r,env=env,check=True)
seen=set();objects=[]
def visit(m):
 if m in seen or not m.startswith('SFT.'):return
 seen.add(m);rel=m.replace('.','/');p=r/(rel+'.lean')
 if not p.exists():p=canonical/(rel+'.lean')
 for dep in re.findall(r'^import (\S+)',p.read_text(),re.M):visit(dep)
 obj=ir/(rel+'.c.o.export')
 if not obj.exists():
  obj=Path('work/constants-recovery').resolve()/'.lake/build/ir'/(rel+'.c.o.export')
 if obj.exists():objects.append(str(obj))
visit('SFT.Physics.ThermalObservationEvidence')
objects=[str(Path('work/stackdecode500/TextPackaged.o').resolve()) if Path(obj).name=='Text.c.o.export' and '/SFT/Host/' in obj else obj for obj in objects]
objects.append(str(Path('work/stackdecode500/StackDecode.o').resolve()))
subprocess.run([str(toolchain/'bin/clang'),*flags,str(r/(program+'.c')),*objects,str(canonical/'.lake/build/lib/libsft__v4_SFT.a'),*libs,'-Wl,-stack_size,0x20000000','-o',str(Path('work').resolve()/program)],env=env,check=True)
subprocess.run(['python3','work/check_thermalobservation1034_program.py',str(Path('work').resolve()/program)],env=env,check=True)
