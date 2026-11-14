from pathlib import Path
import subprocess,json,os,copy,time,re
toolchain=Path('/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0')
flags=['-I',str(toolchain/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(toolchain),'-nostdinc','-isystem',str(toolchain/'include/clang')]
libs=['-L',str(toolchain/'lib'),'-L',str(toolchain/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(toolchain/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']
r=Path('work/constants-recovery').resolve(); canonical=Path('/Volumes/One Touch/SFT v4 Full model LEAN'); ir=r/'.lake/build/ir';env=dict(os.environ,LEAN_NUM_THREADS='28',LEAN_HOST_STACK_SIZE='8192',LEAN_PATH=str(r/'.lake/build/lib/lean'))
from concurrent.futures import ThreadPoolExecutor
modules=['PrimePairCensus','PrimePairDerivation']+[f'PrimePairBlock{i}' for i in range(50)]+[f'PrimeTwinBlock{i}' for i in range(10)]+['PrimePairComplete','PrimeTwinCoverage','PrimePairGrammar','PrimePairEvidence']
def compile_one(m):
 src='SFT/Mathematics/'+m;c=ir/(src+'.c');obj=ir/(src+'.c.o.export')
 if not c.exists() or c.stat().st_mtime<(r/(src+'.lean')).stat().st_mtime:subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-c',str(c),src+'.lean'],cwd=r,env=env,check=True)
 if not obj.exists() or obj.stat().st_mtime<c.stat().st_mtime:subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(c),'-o',str(obj)],check=True)
with ThreadPoolExecutor(max_workers=28) as pool:list(pool.map(compile_one,modules))
program='PrimePairProgram861';subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-c',program+'.c',program+'.lean'],cwd=r,env=env,check=True)
seen=set();objects=[]
def visit(m):
 if m in seen or not m.startswith('SFT.'):return
 seen.add(m);rel=m.replace('.','/');p=r/(rel+'.lean')
 if not p.exists():p=canonical/(rel+'.lean')
 for dep in re.findall(r'^import (\S+)',p.read_text(),re.M):visit(dep)
 obj=ir/(rel+'.c.o.export')
 if obj.exists():objects.append(str(obj))
visit('SFT.Mathematics.PrimePairEvidence')

subprocess.run([str(toolchain/'bin/clang'),*flags,str(r/(program+'.c')),*objects,str(canonical/'.lake/build/lib/libsft__v4_SFT.a'),*libs,'-Wl,-stack_size,0x10000000','-o',str(r.parent/program)],env=env,check=True)
subprocess.run(['python3','work/check_prime_program861.py',str(r.parent/program)],env=env,check=True)
