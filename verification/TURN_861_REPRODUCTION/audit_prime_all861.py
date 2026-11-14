from pathlib import Path
import re,json,subprocess,os
w=Path('work');root=w/'constants-recovery';modules=['PrimePairCensus','PrimePairDerivation']+[f'PrimePairBlock{i}' for i in range(50)]+[f'PrimeTwinBlock{i}' for i in range(10)]+['PrimePairComplete','PrimeTwinCoverage','PrimePairGrammar','PrimePairEvidence'];decl=[];th=[];defs=[]
for m in modules:
 t=(root/'SFT/Mathematics'/(m+'.lean')).read_text(); ns=re.search(r'^namespace (\S+)',t,re.M)[1]
 for kind,n in re.findall(r'^\s*(def|theorem|abbrev|structure|inductive) (\w+)',t,re.M):
  name=ns+'.'+n;decl.append(name)
  if kind=='theorem':th.append(name)
  if kind in ['def','theorem','abbrev']:defs.append(name)
f=w/'AuditPrime861.lean';f.write_text('import SFT.Mathematics.PrimePairEvidence\nimport SFT.Mathematics.PrimeTwinCoverage\n'+'\n'.join('#print axioms '+n for n in decl)+'\n')
p=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(f)],capture_output=True,text=True,env=dict(os.environ,LEAN_PATH=str((root/'.lake/build/lib/lean').resolve())))
(w/'prime861_audit.log').write_text(p.stdout+p.stderr);p.check_returncode();assert all("'"+n+"' does not depend on any axioms" in p.stdout for n in decl),p.stdout
(w/'prime861_proofs_config.json').write_text(json.dumps(dict(modules=modules,declarations=decl,theorems=th,definitions_and_theorems=defs),indent=2));print('PASS',len(decl),'empty-axiom declarations')
