from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from chirality_spec623 import namespace,q,pin
terms=[];expected=[];rows=[]
for composition,adjacency,family in itertools.product([[],[1],[2,1],[1,1]], [[],[(1,2)],[(5,5)],[(1,2),(1,2)]], ['molecular-orientation','other']):
 try:
  pc=namespace['PositiveCount'];hl=namespace['HeldLabel']
  namespace['OrientedStructure'](tuple(map(pc,composition)),tuple((pc(a),pc(b)) for a,b in adjacency),hl(family,'right'));v='ok'
 except Exception as e:v=str(e)
 count=lambda n:'⟨'+str(n)+',by decide⟩'
 terms.append('⟨['+','.join(map(count,composition))+'],['+','.join('('+count(a)+','+count(b)+')' for a,b in adjacency)+'],⟨'+q(family)+',"right",rfl,rfl⟩⟩')
 expected.append(v);rows.append(dict(composition=composition,adjacency=adjacency,family=family,expected=v))
p=Path('work/ChiralityCases623.lean');p.write_text('import SFT.Chemistry.Chirality\nopen SFT.Chemistry.Chirality\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/chirality_operations623.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/chirality_operations623_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),cases=rows),indent=2));print('PASS',len(expected),'constructor cases')
