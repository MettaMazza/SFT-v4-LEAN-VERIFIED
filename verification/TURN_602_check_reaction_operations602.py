from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from reaction_spec602 import namespace,q,pin
H=namespace['HeldLabel'];cases=[];expected=[];terms=[]
for a,b,cf,rf in itertools.product([[],['a'],[' '],['a','b'],['a','a']],[[],['c'],[' ']],['empty','chemical-carrier','other'],['empty','chemical-relation-change','other']):
 carriers=[] if cf=='empty' else [H(cf,'one')];relations=[] if rf=='empty' else [H(rf,'change')]
 try:namespace['ReactionTrace'](tuple(a),tuple(b),tuple(carriers),tuple(relations));result='ok'
 except Exception as e:result=str(e)
 cases.append([a,b,cf,rf]);expected.append(result)
 labels=lambda family,name:'[]' if family=='empty' else '[⟨'+q(family)+','+q(name)+',rfl,rfl⟩]'
 terms.append('⟨['+','.join(q(x) for x in a)+'],['+','.join(q(x) for x in b)+'],'+labels(cf,'one')+','+labels(rf,'change')+'⟩')
p=Path('work/ReactionCases602.lean');p.write_text('import SFT.Chemistry.ReactionIdentity\nopen SFT.Chemistry.ReactionIdentity\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/reaction_operations602.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/reaction_operations602_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',constructor_cases=len(cases),cases=cases,outputs=expected),indent=2));print('PASS',len(cases),'constructor cases')
