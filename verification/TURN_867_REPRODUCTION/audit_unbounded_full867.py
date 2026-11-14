from pathlib import Path
import subprocess,os,json,re
r=Path('work/constants-recovery');env=dict(os.environ,LEAN_PATH=str((r/'.lake/build/lib/lean').resolve()));compiler='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';modules=['UnboundedFaults','UnboundedComposition','UnboundedWitnesses','UnboundedGrammar','UnboundedEvidence'];names=[];th=[];dt=[]
for m in modules:
 t=(r/'SFT/QuantumComputation'/(m+'.lean')).read_text();ns=re.search(r'^namespace (\S+)',t,re.M)[1]
 for kind,n in re.findall(r'^(def|theorem|abbrev|inductive) (\w+)',t,re.M):
  names.append(ns+'.'+n)
  if kind=='theorem':th.append(ns+'.'+n)
  if kind in ['def','theorem']:dt.append(ns+'.'+n)
f=Path('work/AuditUnboundedFull867.lean');f.write_text('import SFT.QuantumComputation.UnboundedEvidence\nimport SFT.QuantumComputation.UnboundedComposition\n'+'\n'.join('#print axioms '+n for n in names));p=subprocess.run([compiler,str(f)],capture_output=True,text=True,env=env);Path('work/unbounded867_audit.log').write_text(p.stdout+p.stderr);p.check_returncode();bad=[n for n in names if "'"+n+"' does not depend on any axioms" not in p.stdout];assert not bad,bad
Path('work/unbounded867_proofs_config.json').write_text(json.dumps(dict(modules=modules,declarations=names,theorems=th,definitions_and_theorems=dt),indent=2));print('PASS',len(names),'empty axioms')
