from pathlib import Path
import json,subprocess,os,datetime
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));mods=json.loads(Path('work/orbit_census381_config.json').read_text())[0]['modules'];mods=['OrbitWitnesses']+[m for m in mods if m!='OrbitWitnesses']
with Path('work/orbit_census381_build.log').open('a') as f:
 for m in mods:
  f.write(datetime.datetime.now(datetime.timezone.utc).isoformat()+' START '+m+'\n');f.flush()
  result=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','2048','-o',str(r/'.lake/build/lib/lean/SFT/Mathematics'/f'{m}.olean'),str(r/'SFT/Mathematics'/f'{m}.lean')],cwd=r,env=env,stdout=f,stderr=f)
  f.write('EXIT '+str(result.returncode)+' '+m+'\n');f.flush()
  if result.returncode:raise SystemExit(result.returncode)
print('Original Orbit 256 grammar, witnesses and controls compiled')
