from pathlib import Path
import ast,types,sys,json,itertools
root=Path(__file__).resolve().parents[1];dest=root
sys.dont_write_bytecode=True
def load(name,relative,bindings=None,stop=None):
 p=root/'v3'/relative;tree=ast.parse(p.read_text(),filename=relative);body=[]
 for node in tree.body:
  if isinstance(node,ast.ImportFrom) and (node.module or '').startswith('sft.'):continue
  if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='DEPENDENCIES' for t in node.targets):break
  if stop and isinstance(node,ast.ClassDef) and node.name==stop:break
  body.append(node)
 tree.body=body;m=types.ModuleType(name);sys.modules[name]=m;m.__dict__.update(bindings or {});exec(compile(tree,relative,'exec'),m.__dict__);return m
exact=load('sft25exact','sft/engine/exact.py');b={n:getattr(exact,n) for n in ['PositiveCount','HeldLabel','InadmissibleExactValue']};fold=load('sft25fold','sft/claim_evidence/fold_language.py',b,'FoldOpcode');b.update({n:getattr(fold,n) for n in ['FoldWord','PositiveRatio','EmptyOne','EMPTY_ONE']})
def law(n):return load('sft25_'+n,'sft/chemistry/'+n+'.py',b)
m=law('multicentre_support_law_v1');sp=law('electron_count_spin_law_v1');px=law('pair_exchange_law_v1');jc=law('joint_correlation_law_v1');re=law('resonance_equivalent_representation_law_v1')
P=exact.PositiveCount;H=exact.HeldLabel;graphs=attachments=0
for n in range(3,7):
 centres=tuple(H('molecular-centre',str(i)) for i in range(n));pairs=list(itertools.combinations(range(n),2))
 # Exhaust all graphs through five centres; retain every sixth-centre path/cycle instance below.
 if n<=5:
  for bits in range(1<<len(pairs)):
   edges=tuple(m.SupportEdge(centres[i],centres[j]) for k,(i,j) in enumerate(pairs) if bits>>k&1)
   reached={centres[0]}
   while True:
    after=reached|{e.right for e in edges if e.left in reached}|{e.left for e in edges if e.right in reached}
    if after==reached:break
    reached=after
   connected=len(reached)==n;assert m._connected(centres,edges)==connected;graphs+=1
   if connected:
    for anchor in centres:
     fresh=H('molecular-centre','fresh');assert m._connected(centres+(fresh,),edges+(m.SupportEdge(anchor,fresh),));attachments+=1
for n in range(3,33):
 labels=tuple(str(i) for i in range(n))
 for s in [m.ribbon_support('M',labels),m.surface_cycle_support('M',labels)]:
  assert s.electron_support.cells==s.centres and s.irreducible_to_one_localized_pair
assert m.tetrahedral_volume_support('T',('a','b','c','d')).positive_edge_count.value==6
spin=0
for n in range(1,65):
 for width in range(1,n+2):
  admitted=(n-(width-1))%2==0
  try:s=sp.build_complete_spin_organization('M',P(n),P(width))
  except exact.InadmissibleExactValue:assert not admitted
  else:
   assert admitted and len(s.electron_occurrence_ids)==n
   assert sum(len(c.occupants) for c in s.cells)==n;spin+=1
for w in [1,3]:
 s=px.pair_state_from_multiplicity('M','state'+str(w),P(w));assert s.total_exchange==px.ALTERNATING_EXCHANGE
for a,c in itertools.product([px.PRESERVING_EXCHANGE,px.ALTERNATING_EXCHANGE],repeat=2):assert px.exchange_product(a,c)==(px.PRESERVING_EXCHANGE if a==c else px.ALTERNATING_EXCHANGE)
s=jc.complete_separated_pair_support('H2','left','right');assert len(s.joint_words)==2
first=re.encoding('first','M',('a','b','c'),((1,2),(2,3)),('fold-fibre-one','fold-fibre-two'));second=re.encoding('second','M',('a','b','c'),((1,2),(2,3)),('fold-fibre-two','fold-fibre-one'));pair=re.equivalent_pair('M',first,second)
for i in range(32):
 old=pair;pair=re.append_shared_successor(pair,'fresh'+str(i));assert pair.first.atoms[:-1]==old.first.atoms and pair.first.adjacency[:-1]==old.first.adjacency
 assert pair.first.atoms==pair.second.atoms and pair.first.adjacency==pair.second.adjacency and re.complement_labels(pair.first.fibres)==pair.second.fibres
out={'status':'PASS','original_source_functions_and_value_classes':True,'graphs_checked':graphs,'connected_fresh_attachments':attachments,'ribbon_and_cycle_constructions':60,'tetrahedral_edges':6,'admitted_spin_organizations':spin,'exchange_table_cases':4,'joint_words':2,'resonance_shared_successors':32,'new_lean_builds':0};dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out))
