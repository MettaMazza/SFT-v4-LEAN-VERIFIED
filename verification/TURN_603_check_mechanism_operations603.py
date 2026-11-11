from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from mechanism_spec603 import namespace,q,pin
Step=namespace['ElementaryStep'];terms=[];expected=[]
for ident,a,b in itertools.product(['',' ','step'],['',' ','a','b'],['',' ','a','b']):
 try:Step(ident,a,b);v='ok'
 except Exception as e:v=str(e)
 terms.append('⟨'+','.join(map(q,[ident,a,b]))+'⟩');expected.append(v)
rawcount=len(terms);stepcases=['⟨'+','.join(map(q,[f's{i}',a,b]))+'⟩' for i,(a,b) in enumerate([('a','b'),('b','c'),('b','a'),('c','d')])]
source=[Step(f's{i}',a,b) for i,(a,b) in enumerate([('a','b'),('b','c'),('b','a'),('c','d')])]
chains=[]
for n in range(4):
 for ids in itertools.product(range(4),repeat=n):
  try:namespace['MechanismTrace'](namespace['_REACTION'],tuple(source[i] for i in ids));v='ok'
  except Exception as e:v=str(e)
  expected.append(v);chains.append('['+','.join('⟨'+stepcases[i]+',rfl⟩' for i in ids)+']')
p=Path('work/MechanismCases603.lean');p.write_text('import SFT.Chemistry.ReactionMechanism\nopen SFT.Chemistry.ReactionMechanism\ndef cases : List RawStep := ['+','.join(terms)+']\ndef chains : List (List Step) := ['+','.join(chains)+']\ndef main : IO Unit := do\n cases.forM fun x => IO.println (match admitStep x with | .ok _ => "ok" | .error e => e)\n chains.forM fun x => IO.println (match admit ⟨⟨SFT.Chemistry.ReactionIdentity.originalRaw,rfl⟩,x⟩ with | .ok _ => "ok" | .error e => e)\n')
env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/mechanism_operations603.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/mechanism_operations603_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,step_constructor_cases=rawcount,mechanism_constructor_cases=len(chains),constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases')
