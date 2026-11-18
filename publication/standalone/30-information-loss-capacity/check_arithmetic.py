from pathlib import Path
from dataclasses import dataclass
from itertools import product,combinations
import ast,json,hashlib
root=Path(__file__).resolve().parents[1];dest=root
g={'dataclass':dataclass,'product':product,'combinations':combinations,'__name__':'__main__'}
def load(path,selected=None,env=None):
 env=g if env is None else env;t=ast.parse((root/'v3'/path).read_text());nodes=[x for x in t.body if not isinstance(x,(ast.Import,ast.ImportFrom)) and (selected is None or getattr(x,'name',None) in selected)];exec(compile(ast.Module(body=nodes,type_ignores=[]),path,'exec'),env)
load('sft/information_science/generated_law.py',{'Choice','Dimension','Witness','LawSpec','binary_dimension','candidate_records'})
a=g.copy();load('sft/information_science/channels_capacity/law.py',env=a);b=g.copy();load('sft/information_science/conservation_loss_transformation/law.py',env=b)
rows=[]
for env in [a,b]:
 spec=env['SPEC'];spec.validate();r=g['candidate_records'](spec);assert len(r)==1024
 fields=[tuple(d.choices[(k>>(9-i))&1].name for i,d in enumerate(spec.dimensions)) for k in range(1024)]
 assert [x['candidate_id'] for x in r]==['__'.join(f) for f in fields]
 assert sum(all(c==d.admitted_choice.name for c,d in zip(f,spec.dimensions)) for f in fields)==1
 rows.append({'claim_id':spec.claim_id,'candidate_rows':1024,'witnesses':[w.name for w in spec.witnesses]})
channel_count=0;extension_count=0
for n in range(1,4):
 inputs=tuple('abc'[:n]);outputs=('x','y','z');supports=[tuple(outputs[i] for i in range(3) if mask>>i&1) for mask in range(1,8)]
 for support in product(supports,repeat=n):
  relation=tuple((x,y) for x,ys in zip(inputs,support) for y in ys);c=a['FiniteChannel'](inputs,outputs,relation)
  code=[tuple(inputs[i] for i in range(n) if mask>>i&1) for mask in range(1,2**n)];code=[x for x in code if all(set(a['output_support'](c,u)).isdisjoint(a['output_support'](c,v)) for u,v in combinations(x,2))];largest=max(map(len,code));expected=tuple(sorted((x for x in code if len(x)==largest),key=lambda x:tuple(inputs.index(y) for y in x)));assert a['capacity_family'](c)==expected;channel_count+=1
  if n<=2:
   old=set(code)
   for targets in supports:
    ext=a['FiniteChannel'](inputs+('q',),outputs,relation+tuple(('q',y) for y in targets));allcodes={x for k in range(1,n+2) for x in combinations(ext.inputs,k) if a['distinguishable_code'](ext,x)}
    predicted=old|{('q',)}|{x+('q',) for x in old if all(set(a['output_support'](c,u)).isdisjoint(targets) for u in x)};assert allcodes==predicted;extension_count+=1
maps=0;composed=0
for n in range(1,5):
 source=tuple(str(i) for i in range(n));pairs=tuple(combinations(source,2))
 for images in product(('x','y','z'),repeat=n):
  f=tuple(zip(source,images));ledger=b['transformation_ledger'](source,f);ret=tuple(p for p in pairs if images[int(p[0])]!=images[int(p[1])]);closed=tuple(p for p in pairs if p not in ret);labels=tuple(dict.fromkeys(images));fibres=tuple((y,tuple(x for x,v in f if v==y)) for y in labels)
  assert ledger==dict(source_support=source,image_support=labels,retained_distinctions=ret or b['EMPTY_ONE'],closed_distinctions=closed or b['EMPTY_ONE'],predecessor_fibres=fibres)
  assert b['is_reversible'](source,f)==all(len(xs)==1 for _,xs in fibres)
  assert b['reverse_record'](source,f)==tuple((y,xs[0] if len(xs)==1 else ('held-predecessor-labels',xs)) for y,xs in fibres);maps+=1
  for out in product(('u','v'),repeat=len(labels)):
   second=tuple(zip(labels,out));comp=b['compose'](source,f,second);assert comp==tuple((x,dict(second)[y]) for x,y in f);assert b['downstream_retention_law'](source,f,second);composed+=1
# Original literal labels and map order remain admitted.
edge=a['FiniteChannel'](('', 'empty-One'),('', 'unused'),(('', ''),('empty-One','')));assert a['capacity_family'](edge)==(('',),('empty-One',))
assert b['transformation_ledger'](('','empty-One'),(('empty-One','y'),('','x')))['image_support']==('x','y')
r={'status':'PASS','candidate_grammars':rows,'complete_channels_checked':channel_count,'fresh_input_extensions':extension_count,'complete_maps_checked':maps,'map_compositions_checked':composed,'method':'Unchanged pinned V3 class/function bodies; independent bitmask code enumeration and exact all-tie family/order checks, complete five-field ledgers, reverse records and composition outputs. Illustrative finite executions accompany retained arbitrary-carrier native proofs.','source_sha256':{str(p.relative_to(root/'v3')):hashlib.sha256(p.read_bytes()).hexdigest() for p in (root/'v3').rglob('*') if p.is_file() and not p.name.startswith('._')}}
dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(r,indent=2)+'\n');print({k:v for k,v in r.items() if k not in ['source_sha256','method']})
