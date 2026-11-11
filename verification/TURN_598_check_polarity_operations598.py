from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from polarity_spec598 import namespace,q,pin
H=namespace['HeldLabel'];A=namespace['_AFFINITY'];cases=[];expected=[];terms=[]
for name,family,label in itertools.product(['',' ','bond-a-b','other-bond'],['bond-polarity','other-family'],['toward-atom-b','arbitrary-held-label']):
 try:namespace['PolarBondRecord'](name,A,H(family,label));result='ok'
 except Exception as e:result=str(e)
 cases.append([name,family,label]);expected.append(result);terms.append('⟨'+q(name)+',SFT.Chemistry.AffinityComparison.original,⟨'+q(family)+','+q(label)+',rfl,rfl⟩⟩')
p=Path('work/PolarityCases598.lean');p.write_text('import SFT.Chemistry.BondPolarity\nopen SFT.Chemistry.BondPolarity\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n')
env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/polarity_operations598.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/polarity_operations598_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',constructor_cases=len(cases),cases=cases,outputs=expected),indent=2));print('PASS',len(cases),'constructor cases')
