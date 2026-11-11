from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from adsorption_spec620 import namespace,q,pin
terms=[];expected=[]
for first,last,label,count in itertools.product(['phase','other'],['phase','other'],['adsorption','changed'],[1,3,5]):
 try:namespace['InterfaceWitness'](namespace['HeldLabel'](first,'adsorption'),namespace['HeldLabel'](last,label),namespace['PositiveCount'](count));v='ok'
 except Exception as e:v=str(e)
 terms.append('⟨⟨'+q(first)+',"adsorption",rfl,rfl⟩,⟨'+q(last)+','+q(label)+',rfl,rfl⟩,⟨'+str(count)+',by decide⟩⟩');expected.append(v)
p=Path('work/AdsorptionCases620.lean');p.write_text('import SFT.Chemistry.SurfaceAdsorption\nopen SFT.Chemistry.SurfaceAdsorption\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/adsorption_operations620.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/adsorption_operations620_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases')
