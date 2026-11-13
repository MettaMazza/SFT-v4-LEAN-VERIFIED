from pathlib import Path
import re,json,subprocess,os
w=Path('work');root=w/'constants-recovery';modules=['AdmissionAcceptance','AdmissionGrammarCore']+['AdmissionGrammarBlock'+str(i) for i in range(32)]+['AdmissionGrammar','AdmissionControls','AdmissionEvidence'];decl=[];th=[];defs=[]
for m in modules:
 t=(root/'SFT/Foundation'/(m+'.lean')).read_text(); ns=re.search(r'^namespace (\S+)',t,re.M)[1]
 for kind,n in re.findall(r'^\s*(def|theorem|abbrev|structure|inductive) (\w+)',t,re.M):
  name=ns+'.'+n;decl.append(name)
  if kind=='theorem':th.append(name)
  if kind in ['def','theorem','abbrev']:defs.append(name)
f=w/'AuditAdmission857.lean';f.write_text('import SFT.Foundation.AdmissionEvidence\n'+'\n'.join('#print axioms '+n for n in decl)+'\n')
p=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(f)],capture_output=True,text=True,env=dict(os.environ,LEAN_PATH=str((root/'.lake/build/lib/lean').resolve())))
(w/'admission857_audit.log').write_text(p.stdout+p.stderr);p.check_returncode();assert all("'"+n+"' does not depend on any axioms" in p.stdout for n in decl),p.stdout
(w/'admission857_proofs_config.json').write_text(json.dumps(dict(modules=modules,declarations=decl,theorems=th,definitions_and_theorems=defs),indent=2));print('PASS',len(decl),'empty-axiom declarations')
