from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from rate_spec606 import namespace,q,pin
terms=[];expected=[]
for n,d,family in itertools.product([1,2,5],[1,3,7],['reaction-observation-boundary','other']):
 try:namespace['RateWitness'](namespace['PositiveCount'](n),namespace['PositiveCount'](d),namespace['HeldLabel'](family,'observed'));v='ok'
 except Exception as e:v=str(e)
 terms.append('⟨⟨'+str(n)+',by decide⟩,⟨'+str(d)+',by decide⟩,⟨'+q(family)+',"observed",rfl,rfl⟩⟩');expected.append(v)
p=Path('work/RateCases606.lean');p.write_text('import SFT.Chemistry.ReactionRate\nopen SFT.Chemistry.ReactionRate\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/rate_operations606.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/rate_operations606_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases')
