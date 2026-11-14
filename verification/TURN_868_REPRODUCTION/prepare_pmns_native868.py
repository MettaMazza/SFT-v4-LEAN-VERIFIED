from pathlib import Path
import subprocess,os,re,concurrent.futures,json
r=Path('work/constants-recovery').resolve();c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');toolchain=Path('/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0');ir=c/'.lake/build/ir';out=Path('work/circuit866_native_objects').resolve();out.mkdir(exist_ok=True);seen=set();mods=[]
def visit(m):
 if m in seen or not m.startswith('SFT.'):return
 seen.add(m);rel=m.replace('.','/');p=c/(rel+'.lean');assert p.exists(),p
 for dep in re.findall(r'^import (\S+)',p.read_text(),re.M):visit(dep)
 mods.append(rel)
visit('SFT.Physics.PMNSEvidence')
env=dict(os.environ,ELAN_TOOLCHAIN='leanprover/lean4:v4.35.0',LEAN_PATH=str(c/'.lake/build/lib/lean'))
def compile_one(rel):
 src=ir/(rel+'.c');assert src.is_file(),src
 obj=out/(rel.replace('/','_')+'.o')
 if not obj.exists() or obj.stat().st_mtime<src.stat().st_mtime:
  x=subprocess.run([str(toolchain/'bin/leanc'),'-O2','-c',str(src),'-o',str(obj)],env=env,capture_output=True,text=True)
  if x.returncode:raise RuntimeError(rel+'\n'+x.stdout+x.stderr)
 return str(obj)
with concurrent.futures.ThreadPoolExecutor(max_workers=28) as pool:objects=list(pool.map(compile_one,mods))
program='PMNSProgram868';subprocess.run([str(toolchain/'bin/lean'),'-j1','-c',str(out/(program+'.c')),str(r/(program+'.lean'))],env=env,check=True)
flags=['-I',str(toolchain/'include'),'-fstack-clash-protection','-ffp-contract=off','-fdata-sections','-ffunction-sections','-fvisibility=hidden','--sysroot',str(toolchain),'-nostdinc','-isystem',str(toolchain/'include/clang')]
libs=['-L',str(toolchain/'lib'),'-L',str(toolchain/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(toolchain/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip','-Wno-unused-command-line-argument']
subprocess.run([str(toolchain/'bin/clang'),*flags,str(out/(program+'.c')),*objects,*libs,'-Wl,-stack_size,0x10000000','-o',str(out/program)],env=env,check=True)
print('PASS native executable prepared from canonical generated C',len(objects),flush=True)
