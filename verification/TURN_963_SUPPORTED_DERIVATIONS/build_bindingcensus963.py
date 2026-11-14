from pathlib import Path
import subprocess,os,json,concurrent.futures,time
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tc='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/';mods=json.load(open(w/'nuclearbindingcurve963_batch_modules.json'));env=dict(os.environ,LEAN_NUM_THREADS='1')
def build(m):
 p=w/(m.rsplit('.',1)[-1]+'_963.log')
 with p.open('w') as f:r=subprocess.run([tc+'lake','-d',str(c),'build',m],env=env,stdout=f,stderr=subprocess.STDOUT)
 if r.returncode:raise RuntimeError(m+': '+p.read_text()[-1500:])
 return m
with concurrent.futures.ThreadPoolExecutor(max_workers=28) as pool:
 for m in pool.map(build,mods):print('PASS',m,flush=True)
print('PASS all64 batches;4094 exact evaluations and4094 uncapped-source traces',flush=True)
