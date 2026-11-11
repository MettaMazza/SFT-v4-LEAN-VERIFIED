from pathlib import Path
import ast,sys,itertools,typing,json,os,subprocess
sys.path.insert(0,'work')
from chirality_spec623 import namespace,raw,pin,q
ns=dict(namespace);ns['Union']=typing.Union;ns['permutations']=itertools.permutations
src=raw('sft/claim_evidence/fold_language.py');tree=ast.parse(src);exec(compile(ast.Module(body=[n for n in tree.body if isinstance(n,ast.ClassDef) and n.name=='EmptyOne'],type_ignores=[]),'pinned-empty','exec'),ns)
src=raw('sft/chemistry/coordination_isomerism_law_v1.py');tree=ast.parse(src);names={'OrientationCell','AdjacencyExtension','FiniteCoordinationForm','_cell','_canonical','_mirror'}
nodes=[n for n in tree.body if getattr(n,'name',None) in names or isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None) in names or isinstance(n,ast.ImportFrom) and n.module=='__future__'];exec(compile(ast.Module(body=nodes,type_ignores=[]),'pinned-coordination','exec'),ns)
H=ns['HeldLabel'];P=ns['PositiveCount'];E=ns['EmptyOne'];F=ns['FiniteCoordinationForm'];cells=[E(),H('fold-orientation-fibre','fibre-one'),H('fold-orientation-fibre','fibre-two')]
words=[w for w in itertools.product(range(3),repeat=3) if any(w)]
leanCell=['.emptyOne','.held firstFibre','.held secondFibre']
word=lambda w:'('+','.join(leanCell[x] for x in w)+')'
terms=[];expected=[]
for same,a,b in itertools.product([False,True],words,words):
 labels=['E','E' if same else 'F'];f=F(tuple(H('coordination-composition-label',x) for x in labels),tuple(H('coordination-attachment-mode','held') for _ in labels),(tuple(cells[x] for x in a),tuple(cells[x] for x in b)),((P(1),P(2)),));mirror=ns['_mirror'](f)
 expected.append('true' if ns['_canonical'](f)!=ns['_canonical'](mirror) else 'false')
 terms.append('⟨⟨["a","b"],['+','.join(map(q,labels))+'],[("a","b")],[]⟩,[("a",'+word(a)+'),("b",'+word(b)+')]⟩')
p=Path('work/ChiralityReflectionCases624.lean');p.write_text('import SFT.Chemistry.Chirality\nopen SFT.Chemistry.Chirality\nset_option maxRecDepth 100000\ndef cases : List OrientedMolecule := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun m => IO.println (chiral m)\n')
env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/chirality_reflection624.log').write_text(o.stdout+o.stderr);assert o.returncode==0,(o.stdout+o.stderr)[-3000:];actual=o.stdout.splitlines();assert actual==expected,[(i,x,y) for i,(x,y) in enumerate(zip(actual,expected)) if x!=y][:10]
Path('work/chirality_reflection624_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,source_operation='coordination_isomerism_law_v1._canonical(form) != _canonical(_mirror(form))',cases=len(expected),scope='All26 nonempty three-axis Fold words at each of two occurrences; equal and unequal composition labels; identical held attachment labels; one complete bond. Full source _canonical and _mirror executed, not stored output.',chiral=expected.count('true'),achiral=expected.count('false')),indent=2));print('PASS',len(expected),'source reflection and complete-map comparisons')
