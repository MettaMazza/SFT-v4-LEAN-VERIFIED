from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from selectivity_spec617 import namespace,q,pin
terms=[];expected=[]
for species_count,reaction_count,family in itertools.product([0,1,2],[0,1,2],['species','other']):
 species=tuple(namespace['HeldLabel'](family,'a') for _ in range(species_count))
 reactions=tuple((namespace['PositiveCount'](i+1),namespace['PositiveCount'](i+2)) for i in range(reaction_count))
 try:namespace['NetworkWitness'](species,reactions);v='ok'
 except Exception as e:v=str(e)
 terms.append('⟨['+','.join('⟨'+q(family)+',"a",rfl,rfl⟩' for _ in species)+'],['+','.join('(⟨'+str(i+1)+',by decide⟩,⟨'+str(i+2)+',by decide⟩)' for i in range(reaction_count))+']⟩');expected.append(v)
p=Path('work/SelectivityCases617.lean');p.write_text('import SFT.Chemistry.CatalyticSelectivity\nopen SFT.Chemistry.CatalyticSelectivity\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run',str(p)],env=env,capture_output=True,text=True);Path('work/selectivity_operations617.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/selectivity_operations617_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,constructor_cases=len(expected),outputs=expected),indent=2));print('PASS',len(expected),'constructor cases')
