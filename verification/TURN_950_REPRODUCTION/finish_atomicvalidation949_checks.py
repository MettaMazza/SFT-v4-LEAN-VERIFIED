from pathlib import Path
import subprocess,time,os,re,json,hashlib
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
while True:
 log=(w/'atomicvalidation949_build.log').read_text()
 if 'Build completed successfully' in log:break
 if 'error:' in log:raise RuntimeError(log[-5000:])
 time.sleep(3)
for tag,n in [('CubicPostsealValidation',949),('HydrogenPostsealValidation',950)]:
 low=tag.lower();mods=['AtomicPostsealRecords','AtomicPostsealMeasurement']+[tag+x for x in ['Witnesses','Grammar','Evidence','Experiment','Validation']];decls=[];ths=[];hashes={}
 for m in mods:
  p=r/'SFT/Physics'/f'{m}.lean';s=p.read_text();hashes[m]=hashlib.sha256(p.read_bytes()).hexdigest()
  for kind,name in re.findall(r'^(def|theorem) (\w+)',s,re.M):
   full='SFT.Physics.'+m+'.'+name;decls.append(full)
   if kind=='theorem':ths.append(full)
 audit=r/f'{tag}Audit{n}.lean';audit.write_text('import SFT.Physics.'+tag+'Validation\n'+''.join('#print axioms '+x+'\n' for x in decls));out=subprocess.check_output([lean,'-j1',str(audit)],env=env,text=True);(w/f'{low}{n}_audit.log').write_text(out);assert all("'"+x+"' does not depend on any axioms" in out for x in decls),out
 (w/f'{low}{n}_proofs_config.json').write_text(json.dumps(dict(modules=mods,declarations=decls,theorems=ths,definitions_and_theorems=decls,source_sha256=hashes),indent=2));print('PASS',tag,len(decls),'empty axioms',flush=True)
 for command in [[f'prepare_{low}_native{n}.py'],[f'check_{low}_program{n}.py',str((w/'circuit866_native_objects'/f'{tag}Program{n}').resolve())],[f'check_{low}_independent{n}.py'],[f'prepare_{low}_empirical_native{n}.py'],[f'check_{low}_empirical{n}.py']]:
  subprocess.run(['python3',str(w/command[0]),*command[1:]],check=True)
 print('PASS',tag,'complete checks',flush=True)
