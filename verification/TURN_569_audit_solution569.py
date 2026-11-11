from pathlib import Path
import subprocess,os,re,json
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
modules=['SolutionSupport','SolutionGrammar','SolutionEvidence','SolutionExperiment','SolutionValidation'];names=[];ths=[];defs=[]
for m in modules:
 s=(r/'SFT/Chemistry'/(m+'.lean')).read_text()
 for kind,n in re.findall(r'^(def|theorem|structure|inductive|abbrev) (\w+)',s,re.M):
  name='SFT.Chemistry.'+m+'.'+n;names.append(name)
  if kind=='theorem':ths.append(name)
  if kind in ['def','theorem']:defs.append(name)
p=Path('work/AuditSolution569.lean');p.write_text('\n'.join('import SFT.Chemistry.'+m for m in modules)+'\n'+'\n'.join('#print axioms '+n for n in names)+'\n');o=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=env,text=True,capture_output=True);Path('work/solution569_audit.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert all("'"+n+"' does not depend on any axioms" in o.stdout for n in names),o.stdout;Path('work/solution569_audit_config.json').write_text(json.dumps(dict(modules=modules,declarations=names,theorems=ths,definitions_and_theorems=defs),indent=2));print('PASS',len(names),'zero-axiom declarations')
