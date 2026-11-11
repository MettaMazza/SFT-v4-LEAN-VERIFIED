from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from phase_spec611 import namespace,q,pin
terms=[];expected=[]
for name,size,family in itertools.product(['phase-a','','  ','phase b'],[0,1,2],['phase-boundary','other']):
 rows=[namespace['HeldLabel']('intensive-trace','same') for _ in range(size)]
 try:namespace['PhaseWitness'](name,tuple(rows),namespace['HeldLabel'](family,'held'));v='ok'
 except Exception as e:v=str(e)
 terms.append('⟨'+q(name)+',['+','.join('⟨"intensive-trace","same",rfl,rfl⟩' for _ in rows)+'],⟨'+q(family)+',"held",rfl,rfl⟩⟩');expected.append(v)
p=Path('work/PhaseCases611.lean');p.write_text('import SFT.Chemistry.ChemicalPhase\nopen SFT.Chemistry.ChemicalPhase\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/phase_operations611.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/phase_operations611_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases')
