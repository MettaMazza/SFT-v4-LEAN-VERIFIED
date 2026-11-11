from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from intermediate_spec604 import namespace,q,pin
terms=[];expected=[]
for species,a,b in itertools.product(['',' ','intermediate'],['',' ','step-a','step-b'],['',' ','step-a','step-b']):
 try:namespace['IntermediateWitness'](species,a,b);v='ok'
 except Exception as e:v=str(e)
 terms.append('⟨'+','.join(map(q,[species,a,b]))+'⟩');expected.append(v)
p=Path('work/IntermediateCases604.lean');p.write_text('import SFT.Chemistry.ReactionIntermediate\nopen SFT.Chemistry.ReactionIntermediate\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/intermediate_operations604.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/intermediate_operations604_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases')
