from pathlib import Path
import subprocess,os,json,re
r=Path('work/constants-recovery');env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve()));compiler='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';modules=['NativePnpWitnesses','NativePnpGrammar','NativePnpEvidence']
names=[]
for m in ['NativeVerification']+modules:
 t=(r/'SFT/Computation'/(m+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',t,re.M)[1];names += [ns+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',t,re.M)]
f=Path('work/AuditPnp865.lean');f.write_text('import SFT.Computation.NativePnpEvidence\n'+'\n'.join('#print axioms '+n for n in names));p=subprocess.run([compiler,str(f)],capture_output=True,text=True,env=env);Path('work/pnp865_audit.log').write_text(p.stdout+p.stderr);p.check_returncode();assert all("'"+n+"' does not depend on any axioms" in p.stdout for n in names),p.stdout
Path('work/pnp865_staged_config.json').write_text(json.dumps(dict(modules=['NativeVerification']+modules,declarations=names),indent=2));print('PASS',len(names),'empty axioms',flush=True)
