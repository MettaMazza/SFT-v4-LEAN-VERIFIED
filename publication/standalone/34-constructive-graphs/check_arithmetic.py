from pathlib import Path
import ast,types,sys,itertools,json
root=Path(__file__).resolve().parents[1];dest=root
sys.dont_write_bytecode=True
def load(name,rel):
 tree=ast.parse((root/'v3'/rel).read_text());body=[]
 for n in tree.body:
  if isinstance(n,ast.ImportFrom) and (n.module or '').startswith('sft.'):continue
  if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='SPEC' for t in n.targets):break
  body.append(n)
 tree.body=body;m=types.ModuleType(name);sys.modules[name]=m;exec(compile(tree,rel,'exec'),m.__dict__);return m
G=load('paper34graph','sft/mathematics/graph_network/law.py');T=load('paper34geometry','sft/mathematics/geometry_topology/law.py')
V=('a','b','c');pairs=tuple(itertools.product(V,repeat=2));reach=cuts=0;cyclecount=0
for mask in range(512):
 edges=tuple(e for i,e in enumerate(pairs) if mask&(1<<i));g=G.GeneratedGraph(V,edges)
 paths=[p for n in range(1,4) for p in itertools.product(V,repeat=n) if G.path_is_valid(g,p)]
 for a,b in pairs:
  expected=any(p[0]==a and p[-1]==b for p in paths);assert G.reachable(g,a,b)==expected;reach+=1
 cyclic=any(p[0]==p[-1] and G.path_is_valid(g,p) for n in range(2,5) for p in itertools.product(V,repeat=n));assert G.directed_cycle_exists(g)==cyclic;cyclecount+=int(cyclic)
 for held_mask in range(1,8):
  held=tuple(v for i,v in enumerate(V) if held_mask&(1<<i));assert G.crossing_cut(g,held)==tuple(e for e in edges if ((e[0] in held)+(e[1] in held))==1);cuts+=1
V4=('a','b','c','d');pairs4=tuple(itertools.combinations(V4,2));distance=0
for mask in range(64):
 edges=tuple(e for i,e in enumerate(pairs4) if mask&(1<<i))
 for a,b in itertools.product(V4,repeat=2):
  out=T.path_distance(V4,edges,a,b);distance+=1
  if a==b:assert out==T.EMPTY_ONE;continue
  valid=[p for n in range(2,5) for p in itertools.permutations(V4,n) if p[0]==a and p[-1]==b and all((u,v) in edges or (v,u) in edges for u,v in zip(p,p[1:]))]
  if not valid:assert out is None
  else:assert out in valid and len(out)==min(map(len,valid))
# Preserve raw endpoint-only domain and ordered tie decisions.
assert T.path_distance(('a','c'),(('a','x'),('x','c')),'a','c')==('a','x','c')
left=(('a','b'),('a','c'),('b','d'),('c','d'));right=(('a','c'),('a','b'),('b','d'),('c','d'))
assert T.path_distance(V4,left,'a','d')==('a','b','d') and T.path_distance(V4,right,'a','d')==('a','c','d')
dims=0
for mask in range(64):
 boundary=tuple(e for i,e in enumerate(pairs4) if mask&(1<<i));assert T.incidence_is_well_formed(V4,boundary)
 for c in V4:
  chains=[p for n in range(1,5) for p in itertools.permutations(V4,n) if p[-1]==c and all(e in boundary for e in zip(p,p[1:]))];assert T.cell_dimension(V4,boundary,c)==max(map(len,chains));dims+=1
try:T.cell_dimension(V, (('a','b'),('b','c'),('c','a')),'a')
except ValueError as e:assert str(e)=='boundary descent cannot contain a return cycle'
else:raise AssertionError('cycle guard')
subsets=tuple(tuple(v for i,v in enumerate(V) if mask&(1<<i)) for mask in range(8));topologies=[]
for fam in range(256):
 sets=tuple(s for i,s in enumerate(subsets) if fam&(1<<i));opens=tuple(s or T.EMPTY_ONE for s in sets)
 expected=() in sets and V in sets and all(tuple(v for v in V if v in a or v in b) in sets and tuple(v for v in V if v in a and v in b) in sets for a in sets for b in sets)
 assert T.is_finite_topology(V,opens)==expected
 if expected:topologies.append((sets,opens))
continuous_checks=0;continuous_pass=0
for S,SO in topologies:
 for U,UO in topologies:
  for images in itertools.product(V,repeat=3):
   mapping=tuple(zip(V,images));expected=all(tuple(v for v,im in mapping if im in target) in S for target in U);assert T.is_continuous(V,SO,UO,mapping)==expected;continuous_checks+=1;continuous_pass+=int(expected)
assert T.is_continuous(('a','b'),(T.EMPTY_ONE,('a',),('b',),('a','b')),(('a',),), (('a','b'),('a','a'),('b','b')))
assert G.internal_balance((('i',),),(('o',),)) and not G.internal_balance((),()) and not G.internal_balance((('i',),('i',)),(('o',),('p',)))
grammars={}
for label,rel in [('graph','sft/mathematics/graph_network/law.py'),('geometry','sft/mathematics/geometry_topology/law.py')]:
 for n in ast.parse((root/'v3'/rel).read_text()).body:
  if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='SPEC' for t in n.targets):
   dimsarg=next(k.value for k in n.value.keywords if k.arg=='dimensions');grammars[label]=[[ast.literal_eval(c.args[i]) for i in [0,2,4]] for c in dimsarg.elts]
out={'status':'PASS','directed_graphs':512,'reachability_pairs':reach,'cycle_positive_graphs':cyclecount,'crossing_cuts':cuts,'undirected_graphs':64,'distance_pairs':distance,'dag_complexes':64,'dimension_checks':dims,'open_families':256,'topologies':len(topologies),'continuity_checks':continuous_checks,'continuous_maps':continuous_pass,'endpoint_only_domain_preserved':True,'ordered_tie_decisions_preserved':True,'cycle_and_balance_controls':True,'last_mapping_row_preserved':True,'grammars':grammars,'new_lean_builds':0};dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps({k:v for k,v in out.items() if k!='grammars'}))
