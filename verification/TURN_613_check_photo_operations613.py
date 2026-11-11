from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from photo_spec613 import namespace,q,pin
terms=[];expected=[]
for family,ground,excited,channel in itertools.product(['photon-carrier','other'],['ground','',' '],['excited','ground',''],['channel','']):
 try:namespace['PhotochemicalWitness'](namespace['HeldLabel'](family,'photon'),ground,excited,channel);v='ok'
 except Exception as e:v=str(e)
 terms.append('⟨⟨'+q(family)+',"photon",rfl,rfl⟩,'+','.join(map(q,[ground,excited,channel]))+'⟩');expected.append(v)
p=Path('work/PhotoCases613.lean');p.write_text('import SFT.Chemistry.Photochemistry\nopen SFT.Chemistry.Photochemistry\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/photo_operations613.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/photo_operations613_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases')
