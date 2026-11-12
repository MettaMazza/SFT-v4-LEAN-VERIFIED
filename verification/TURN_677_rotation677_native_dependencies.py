from pathlib import Path
import subprocess,re,os,json
r=Path('work/constants-recovery').resolve();ir=r/'.lake/build/ir';archive='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a'
x=subprocess.run(['nm','-gU',archive],capture_output=True,text=True,check=True).stdout
available=set(re.findall(r'\b_initialize_(SFT_\w+)',x));known=set();missing=[]
# Follow only missing initializers reachable from these concrete linker errors.
def visit(mod):
 key=mod.replace('/','_')
 if key in available or mod in known:return
 known.add(mod);p=r/(mod+'.lean');assert p.exists(),mod
 for dep in re.findall(r'^import (SFT[.\w]+)',p.read_text(),re.M):visit(dep.replace('.','/'))
 missing.append(mod)
for mod in ['SFT/Materials/CubicCoordinationProofs','SFT/Mathematics/OrbitOrderIdentity','SFT/Mathematics/OrbitBinaryDepth','SFT/Mathematics/OrbitTilingCount']:visit(mod)
env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
for mod in missing:
 c=ir/(mod+'.c');o=ir/(mod+'.c.o.export');src=r/(mod+'.lean')
 if not c.exists() or c.stat().st_mtime<src.stat().st_mtime:subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-c',str(c),str(src)],cwd=r,env=env,check=True,stdout=subprocess.DEVNULL)
 if not o.exists() or o.stat().st_mtime<c.stat().st_mtime:subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(c),'-o',str(o)],check=True)
Path('work/rotation677_native_dependencies.json').write_text(json.dumps(missing,indent=2));print('Native linker dependencies',missing)
