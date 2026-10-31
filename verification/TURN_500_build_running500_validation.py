from pathlib import Path
import subprocess,os,re,json
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_PATH=str(r/'.lake/build/lib/lean'));mods=['RunningConvergenceMeasurement','RunningConvergencePrediction','RunningConvergenceValidation'];names=[]
for m in mods:
 p=r/'SFT/Physics'/(m+'.lean');s=p.read_text();ns=re.search(r'^namespace (\S+)',s,re.M)[1];names.extend(ns+'.'+n for _,n in re.findall(r'^(def|theorem|structure|abbrev) (\w+)',s,re.M))
 with Path('work/'+m+'500_build.log').open('w') as f:subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','2048','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/(m+'.olean')),str(p)],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
 print('BUILT',m,flush=True)
Path('work/Running500ValidationAudit.lean').write_text('\n'.join('import SFT.Physics.'+m for m in mods)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n');Path('work/running500_validation_declarations.json').write_text(json.dumps(names,indent=2))
res=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','2048','work/Running500ValidationAudit.lean'],env=env,text=True,capture_output=True);Path('work/running500_validation_audit.log').write_text(res.stdout+res.stderr);assert res.returncode==0
for n in names:assert "'"+n+"' does not depend on any axioms" in res.stdout,n
print('VALIDATION AXIOM AUDIT PASS',flush=True)
