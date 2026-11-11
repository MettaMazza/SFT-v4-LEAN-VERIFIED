from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from thermochemistry_spec609 import namespace,q,pin
terms=[];expected=[]
for n,d,orientation,conditions in itertools.product([1,2,5],[1,3,7],['energy-transfer-orientation','other'],['thermochemical-conditions','other']):
 try:namespace['EnergyLedger'](namespace['PositiveCount'](n),namespace['PositiveCount'](d),namespace['HeldLabel'](orientation,'held'),namespace['HeldLabel'](conditions,'held'));v='ok'
 except Exception as e:v=str(e)
 terms.append('⟨⟨'+str(n)+',by decide⟩,⟨'+str(d)+',by decide⟩,⟨'+q(orientation)+',"held",rfl,rfl⟩,⟨'+q(conditions)+',"held",rfl,rfl⟩⟩');expected.append(v)
p=Path('work/ThermochemistryCases609.lean');p.write_text('import SFT.Chemistry.ReactionThermochemistry\nopen SFT.Chemistry.ReactionThermochemistry\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/thermochemistry_operations609.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/thermochemistry_operations609_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases')
