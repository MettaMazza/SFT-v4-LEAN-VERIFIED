from pathlib import Path
import subprocess,os,json,re
r=Path('work/constants-recovery');env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve()));compiler='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';modules=['NativeCircuitPaths','NativeCircuitCensus','NativeCircuitDomain','NativeCircuitWitnesses','NativeCircuitGrammar','NativeCircuitEvidence']
names=[]
for m in ['NativeCircuit']+modules:
 t=(r/'SFT/Computation'/(m+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',t,re.M)[1];names += [ns+'.'+n for n in re.findall(r'^(?:def|theorem|abbrev|inductive) (\w+)',t,re.M)]
f=Path('work/AuditCircuit866.lean');f.write_text('import SFT.Computation.NativeCircuitEvidence\nimport SFT.Computation.NativeCircuitDomain\n'+'\n'.join('#print axioms '+n for n in names));p=subprocess.run([compiler,str(f)],capture_output=True,text=True,env=env);Path('work/circuit866_audit.log').write_text(p.stdout+p.stderr);p.check_returncode();assert all("'"+n+"' does not depend on any axioms" in p.stdout for n in names),p.stdout
Path('work/circuit866_staged_config.json').write_text(json.dumps(dict(modules=['NativeCircuit']+modules,declarations=names),indent=2));print('PASS',len(names),'empty axioms',flush=True)
