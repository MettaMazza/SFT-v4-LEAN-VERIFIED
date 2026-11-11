from pathlib import Path
import sys,json,os,subprocess
sys.path.insert(0,'work')
from order_spec607 import namespace,q,pin
terms=[];expected=[]
for name in ['', ' ', 'reactant']:
 for families in [[],['kinetic-dependency'],['kinetic-dependency','kinetic-dependency'],['other'],['kinetic-dependency','other']]:
  labels=[namespace['HeldLabel'](f,'same-label') for f in families]
  try:namespace['DependencyOrderWitness'](name,tuple(labels));v='ok'
  except Exception as e:v=str(e)
  terms.append('⟨'+q(name)+',['+','.join('⟨'+q(f)+',"same-label",rfl,rfl⟩' for f in families)+']⟩');expected.append(v)
p=Path('work/OrderCases607.lean');p.write_text('import SFT.Chemistry.KineticOrder\nopen SFT.Chemistry.KineticOrder\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/order_operations607.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/order_operations607_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases including Empty and repeated labels')
