from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/bond_spec570.py').read_text(),ns);sc=ns['namespace'];q=json.dumps
cases=[('A','B',[('joining','one')],True),('A','B',[],True),('A','B',[('joining','one')],False),('A','A',[('joining','one')],True),('','B',[('joining','one')],True),('A','\u2003',[('joining','one')],True),(' A ','A',[('joining','one')],True),('group-A','group-B',[('joining','one'),('joining','two')],True),('A','B',[('joining','one'),('joining','one')],True)]
expected=[];expressions=[]
for left,right,channels,stable in cases:
 try:
  p=sc['BondSupport'](left,right,tuple(sc['HeldLabel'](f,l) for f,l in channels),stable);expected.append({'left':left,'right':right,'count':sc['joining_multiplicity'](p).value,'stable':stable})
 except sc['InadmissibleExactValue'] as e:expected.append({'error':str(e)})
 cc='['+','.join('⟨'+q(f)+','+q(l)+',(by decide),(by decide)⟩' for f,l in channels)+']'
 expressions.append('⟨'+q(left)+','+q(right)+','+cc+','+str(stable).lower()+'⟩')
s='import SFT.Chemistry.BondClosure\nimport SFT.Host.Canonical\nopen SFT.Chemistry.BondClosure SFT.Host.Canonical\ndef result (raw : Raw) : Value := match makeSupport raw with\n | .error e => .object [("error",.text e)]\n | .ok support => .object [("left",.text support.raw.left),("right",.text support.raw.right),("count",.integer (Int.ofNat (joiningMultiplicity support))),("stable",.boolean support.raw.stable)]\ndef main : IO Unit := do\n'+'\n'.join(' IO.println (render (result '+x+'))' for x in expressions)+'\n'
r=Path('work/constants-recovery').resolve();(r/'BondOperations570.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run','BondOperations570.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/bond_operations570.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[json.loads(x) for x in p.stdout.splitlines()];assert actual==expected,(actual,expected);Path('work/bond_operations570_report.json').write_text(json.dumps(dict(status='PASS',source_commit=ns['pin'],cases=len(cases),results=actual,fresh_native_execution=True,compares='original BondSupport constructor guards/retained fields and joining_multiplicity; duplicate channels remain counted'),indent=2));print('PASS',len(cases),'original operation cases')
