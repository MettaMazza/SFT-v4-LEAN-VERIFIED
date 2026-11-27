from pathlib import Path
import json,os,subprocess,hashlib
w=Path('work').resolve();r=w/'turn1064_recovery';tc=Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0';out=w/'waterphaseresolved1535_native';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
env=dict(os.environ,LEAN_PATH=':'.join([str(tc/'lib/lean'),str(r),'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean']),LEAN_NUM_THREADS='1')
a=json.load(open(w/'waterphaseresolved1535_native_build.json'));assert a['status']=='PASS';objects=[]
for row in a['modules']:
 obj=Path(row.get('reused_object',str(Path(row['generated_c']).with_suffix('.o'))));assert H(Path(row['source']))==row['source_sha256'] and H(obj)==row['object_sha256'];objects.append(str(obj))
src=r/'EarthWaterPhaseHandoffProgram1479.lean';gen=out/'WaterPhaseProgramme1535.c';exe=out/'WaterPhaseProgramme1535'
def run(args,**kw):return subprocess.run(['python3',str(w/'run_lean_guarded.py'),*map(str,args)],env=env,check=True,**kw)
with (w/'waterphase_programme1535_native_build.log').open('w')as log:
 run([tc/'bin/lean','-j1','-M8192','-R',w,'-c',gen,src],stdout=log,stderr=subprocess.STDOUT)
 flags=['-I',str(tc/'include'),'--sysroot',str(tc),'-nostdinc','-isystem',str(tc/'include/clang')]
 libs=['-L',str(tc/'lib'),'-L',str(tc/'lib/libc'),'-fuse-ld=/usr/bin/ld','-L',str(tc/'lib/lean'),'-lleancpp','-lInit','-lStd','-lLean','-lleanrt','-lc++','-lLake','-lLeanExport','-lgmp','-luv','-lssl','-lcrypto','-Wl,-dead_strip']
 aliases=['-Wl,-alias,'+x+','+y for x,y in a['link_aliases']]
 run([tc/'bin/clang',*flags,gen,*objects,*libs,*aliases,'-Wl,-stack_size,0x20000000','-o',exe],stdout=log,stderr=subprocess.STDOUT)
print('Native complete programme ready',flush=True)
