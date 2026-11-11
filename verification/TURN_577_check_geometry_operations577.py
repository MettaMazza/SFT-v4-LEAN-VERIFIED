from pathlib import Path
import json,subprocess,os,itertools
ns={};exec(Path('work/geometry_spec577.py').read_text(),ns);n=ns['namespace'];q=lambda x:json.dumps(x,ensure_ascii=False);cases=[]
for key in ['_DIATOMIC','_TRIATOMIC','_CHAIN']:
 c=n[key];pairs=list(itertools.combinations(c.occurrence_ids,2))
 for mask in range(1<<len(pairs)):
  rows=[n['GeometryRelation'](a,b,n['HeldLabel']('orientation','ray')) for i,(a,b) in enumerate(pairs) if mask>>i&1];cases.append((c,rows))
c=n['_TRIATOMIC'];base=list(n['_GEOMETRY'])
cases += [(c,base),(c,base+[base[0]]),(c,base+[n['GeometryRelation']('outside','centre',n['HeldLabel']('orientation','ray'))]),(c,[n['GeometryRelation'](x.right_occurrence,x.left_occurrence,x.orientation) for x in base])]
def relation(x):return '⟨'+q(x.left_occurrence)+','+q(x.right_occurrence)+',⟨'+q(x.orientation.family)+','+q(x.orientation.label)+',rfl,rfl⟩⟩'
def carrier(c):return '⟨'+q(list(c.occurrence_ids))+','+q(list(c.element_labels))+',['+','.join('('+q(a)+','+q(b)+')' for a,b in c.bonds)+'],[]⟩'
s='import SFT.Chemistry.MolecularGeometry\nopen SFT.Chemistry\ndef main : IO Unit := do\n'
expected=[]
for c,rows in cases:
 expected.append(n['complete_geometry'](c,tuple(rows)))
 s+=' IO.println (if MolecularGeometry.completeGeometry ('+carrier(c)+') ['+','.join(map(relation,rows))+'] then "true" else "false")\n'
r=Path('work/constants-recovery').resolve();(r/'GeometryOperations577.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','GeometryOperations577.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/geometry_operations577.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[json.loads(x) for x in p.stdout.splitlines()];assert actual==expected
Path('work/geometry_operations577_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'cases':len(cases),'expected':expected,'actual':actual},indent=2));print('PASS',len(cases),'original geometry comparisons')
