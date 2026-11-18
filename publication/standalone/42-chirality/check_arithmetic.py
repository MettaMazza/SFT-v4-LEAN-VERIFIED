from pathlib import Path
import ast,types,sys,itertools,json,dataclasses,typing
root=Path(__file__).resolve().parents[1];dest=root
sys.dont_write_bytecode=True
m=types.ModuleType('paper42source');sys.modules[m.__name__]=m;ns=m.__dict__;ns.update(dataclass=dataclasses.dataclass,Union=typing.Union,permutations=itertools.permutations)
exec(compile((root/'v3/sft/engine/exact.py').read_text(),'exact.py','exec'),ns)
def selected(rel,names):
 tree=ast.parse((root/'v3'/rel).read_text());nodes=[n for n in tree.body if getattr(n,'name',None) in names or isinstance(n,ast.Assign) and any(getattr(t,'id',None) in names for t in n.targets) or isinstance(n,ast.ImportFrom) and n.module=='__future__'];exec(compile(ast.Module(body=nodes,type_ignores=[]),rel,'exec'),ns)
selected('sft/claim_evidence/fold_language.py',{'EmptyOne'})
selected('sft/chemistry/stereochemistry_organic_polymer_derivation.py',{'OrientedStructure'})
selected('sft/chemistry/coordination_isomerism_law_v1.py',{'OrientationCell','AdjacencyExtension','FiniteCoordinationForm','_cell','_canonical','_mirror','extend_coordination_form'})
H=ns['HeldLabel'];P=ns['PositiveCount'];E=ns['EmptyOne'];F=ns['FiniteCoordinationForm'];mirror=ns['_mirror'];canonical=ns['_canonical'];extend=ns['extend_coordination_form'];cells=[E(),H('fold-orientation-fibre','fibre-one'),H('fold-orientation-fibre','fibre-two')];words=[w for w in itertools.product(cells,repeat=3) if any(not isinstance(x,E) for x in w)]
def proper(left,right,order):
 edges=lambda f:{tuple(sorted((a.value-1,b.value-1))) for a,b in f.adjacency_pairs}
 return all(left.composition_labels[i]==right.composition_labels[j] and left.attachment_labels[i]==right.attachment_labels[j] and left.orientation_words[i]==right.orientation_words[j] for i,j in enumerate(order)) and {tuple(sorted((order[a],order[b]))) for a,b in edges(left)}==edges(right)
def chiral(f):return not any(proper(f,mirror(f),o) for o in itertools.permutations(range(len(f.composition_labels))))
base=chiral_count=extended=restrictions=0
for same,a,b in itertools.product([False,True],words,words):
 labels=['E','E' if same else 'F'];f=F(tuple(H('coordination-composition-label',x) for x in labels),tuple(H('coordination-attachment-mode','held') for _ in labels),(a,b),((P(1),P(2)),));rf=mirror(f);assert mirror(rf)==f
 c=chiral(f);assert c==(canonical(f)!=canonical(rf));base+=1;chiral_count+=int(c)
 for order in itertools.permutations(range(2)):assert proper(f,rf,order)==proper(rf,f,order)
 for links in [(1,),(2,),(1,2)]:
  args=(H('coordination-composition-label','fresh-element'),H('coordination-attachment-mode','held'),(cells[1],cells[0],cells[0]),tuple(P(x) for x in links));g=extend(f,*args);rg=mirror(g);assert mirror(rg)==g
  reflected_args=(args[0],args[1],(cells[2],cells[0],cells[0]),args[3]);assert rg==extend(rf,*reflected_args)
  assert chiral(g)==(canonical(g)!=canonical(rg));assert chiral(g);extended+=1
  for order in itertools.permutations(range(3)):
   assert proper(g,rg,order)==proper(rg,g,order)
   if proper(g,g,order):assert order[-1]==2 and proper(f,f,order[:-1]);restrictions+=1
constructor=admitted=0
for comp,adj,family in itertools.product([[],[1],[2,1],[1,1]],[[],[(1,2)],[(5,5)],[(1,2),(1,2)]],['molecular-orientation','other']):
 expected=bool(comp and adj and family=='molecular-orientation');constructor+=1
 try:ns['OrientedStructure'](tuple(P(x) for x in comp),tuple((P(a),P(b)) for a,b in adj),H(family,'right'));actual=True
 except ns['InadmissibleExactValue']:actual=False
 assert actual==expected;admitted+=int(actual)
grammars={}
for n in ast.parse((root/'v3/sft/chemistry/stereochemistry_organic_polymer_derivation.py').read_text()).body:
 if isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None) in ['CHIRAL','ENANTIOMER']:
  rows=ast.literal_eval(n.value.args[0]);grammars[n.targets[0].id]=[[r[i] for i in [0,1,3]] for r in rows];assert len(list(itertools.product([False,True],repeat=len(rows))))==256
out={'status':'PASS','orientation_words':len(words),'base_comparisons':base,'base_chiral':chiral_count,'base_achiral':base-chiral_count,'extended_comparisons':extended,'extended_chiral':extended,'successful_self_map_restrictions':restrictions,'constructor_cases':constructor,'constructor_accepted':admitted,'reflection_involution':True,'reflection_extension_commutes':True,'pair_test_symmetry':True,'grammars':grammars,'new_lean_builds':0};dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps({k:v for k,v in out.items() if k!='grammars'}))
