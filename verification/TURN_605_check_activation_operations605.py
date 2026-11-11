from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from activation_spec605 import namespace,q,pin
terms=[];expected=[];families=['reactant-boundary','transition-boundary','product-boundary','other']
for n,a,b,c in itertools.product([1,3],families,families,families):
 labels=[namespace['HeldLabel'](x,'boundary') for x in [a,b,c]]
 try:namespace['BarrierWitness'](namespace['PositiveCount'](n),*labels);v='ok'
 except Exception as e:v=str(e)
 terms.append('⟨⟨'+str(n)+',by decide⟩,'+','.join('⟨'+q(x)+',"boundary",rfl,rfl⟩' for x in [a,b,c])+'⟩');expected.append(v)
p=Path('work/ActivationCases605.lean');p.write_text('import SFT.Chemistry.ReactionActivation\nopen SFT.Chemistry.ReactionActivation\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/activation_operations605.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/activation_operations605_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases including all family permutations')
