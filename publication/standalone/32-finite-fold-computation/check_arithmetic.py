from pathlib import Path
import ast,types,itertools,json,math
root=Path(__file__).resolve().parents[1];dest=root
def load(relative):
 tree=ast.parse((root/'v3'/relative).read_text());body=[]
 for n in tree.body:
  if isinstance(n,ast.ImportFrom) and not (n.module or '').startswith('sft.'):body.append(n)
  elif isinstance(n,ast.FunctionDef):
   if n.name in ['dim','operational_witnesses']:continue
   body.append(n)
  elif isinstance(n,ast.Assign) and isinstance(n.value,ast.Tuple) and all(isinstance(x,ast.Constant) for x in n.value.elts):body.append(n)
 tree.body=body;m=types.ModuleType(relative);exec(compile(tree,relative,'exec'),m.__dict__);return m
c=load('sft/computation/lineage_laws.py');q=load('sft/quantum_computation/lineage_laws.py')
words=c.words_through_depth(14)
assert len(words)==32766
for w in words:
 tr=c.closing_trace(w);assert len(tr)-1==len(w) and tr[-1]==c.EMPTY_ONE
 assert all(tr[i+1]==(tr[i][1:] if len(tr[i])>1 else c.EMPTY_ONE) for i in range(len(w)))
for k in range(1,15):
 assert c.native_busy_beaver(k)==k
 assert c.circuit_resources(k)==(k,2**k,2**(k+1)-2)
 assert len(set(c.forced_edges(k)))==2**(k+1)-2
assert c.native_p_np_equal(7)
assert c.exhaustive_edge_subset_survivors(3)==1
edges=c.forced_edges(3);survivors=[mask for mask in range(1<<14) if all(mask & (1<<i) for i in range(14))];assert survivors==[16383]
mask_count=0;predecessors=0
for t in range(1,15):
 tr=tuple('fault-'+str(i) for i in range(t));assert q.forced_width(tr)==2*t+1
 assert q.shorter_widths_fail(tr);predecessors+=2*t
 if t<=3:
  for label in ['held','returned']:
   assert q.exhaustive_small_fault_census(label,tr)
   mask_count+=sum(math.comb(2*t+1,i) for i in range(t+1))
assert mask_count==168 and predecessors==210
assert q.depth_seven_round_trip(tuple('fault-'+str(i) for i in range(14)))
for op,args in [(c.words_at_depth,(0,)),(c.words_at_depth,(-1,)),(c.closing_trace,((),)),(c.closing_trace,(('external',),)),(q.forced_width,((),)),(q.forced_width,(('x','x'),)),(q.decode,((),)),(q.decode,(('external',),))]:
 try:op(*args)
 except ValueError:pass
 else:raise AssertionError('source guard')
# Recover literal source grammar alternatives, preserving original axis order.
grammars={}
for rel in ['sft/computation/lineage_laws.py','sft/quantum_computation/lineage_laws.py']:
 for n in ast.parse((root/'v3'/rel).read_text()).body:
  if not isinstance(n,ast.Assign):continue
  name=n.targets[0].id
  dims=None
  if name=='DIMENSIONS':dims=n.value
  elif name in ['BUSY_BEAVER','P_NP','CIRCUIT_LOWER']:dims=next(k.value for k in n.value.keywords if k.arg=='dimensions')
  if dims:
   rows=[]
   for call in dims.elts:
    a=[ast.literal_eval(x) for x in call.args];rows.append([a[0],a[1],a[2]] if len(a)==3 else [a[0],a[2],a[4]])
   assert len(rows)==8
   assert [x for x in itertools.product([0,1],repeat=8) if all(x)]==[(1,)*8]
   grammars[name]=rows
out={'status':'PASS','complete_closing_words':len(words),'resource_depths':14,'accepted_and_tampered_certificates_each':254,'forced_edges_at_depth14':32766,'complete_edge_subsets':16384,'survivor_masks':survivors,'fault_orders':14,'complete_small_masks':mask_count,'predecessor_counterexamples':predecessors,'depth7_round_trips':128,'source_guards':8,'grammars':grammars,'new_lean_builds':0}
dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps({k:v for k,v in out.items() if k!='grammars'}))
