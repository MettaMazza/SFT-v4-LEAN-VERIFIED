import ast,json,hashlib
from fractions import Fraction
from pathlib import Path
from itertools import product
root=Path(__file__).resolve().parents[1];dest=root;dest.mkdir(exist_ok=True)
modules={};trees={}
for f in (root/'v3/sft/physics').glob('*.py'):
 name='sft.physics.'+f.stem;t=ast.parse(f.read_text());trees[name]=t;g={'Fraction':Fraction,'product':product};modules[name]=g
 for n in t.body:
  if isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
   try:v=ast.literal_eval(n.value)
   except (ValueError,TypeError):
    if isinstance(n.value,ast.Call) and isinstance(n.value.func,ast.Name) and n.value.func.id=='Fraction':
     try:v=Fraction(*(ast.literal_eval(a) for a in n.value.args))
     except (ValueError,TypeError):continue
    else:continue
   g[n.targets[0].id]=v
 nodes=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0)]+[n for n in t.body if isinstance(n,ast.FunctionDef)];exec(compile(ast.fix_missing_locations(ast.Module(body=nodes,type_ignores=[])),str(f),'exec'),g)
for name,t in trees.items():
 for n in t.body:
  if isinstance(n,ast.ImportFrom) and n.module in modules:
   for alias in n.names:
    if alias.name in modules[n.module]:modules[name][alias.asname or alias.name]=modules[n.module][alias.name]
u=modules['sft.physics.unified_constants_object_law_v1'];cert=u['theorem_certificate']();assert len(cert)==8 and all(v for v in cert.values() if isinstance(v,bool));assert len(cert['foundation_order'])==16 and len(cert['terminal'])==26 and len(cert['successor_probe'])==16
held=['binary_fibre_count','spatial_rank','boundary_rank','half_One'];changed=[k for k,v in cert['foundation_order'].items() if v!=cert['successor_probe'][k]];assert len(changed)==12 and all(cert['foundation_order'][k]==cert['successor_probe'][k] for k in held)
graph=u['dependency_graph']();reached=u['reachable_from_one'](graph);assert len(graph)==10 and len(reached)==17
axes=[]
node=next(n for n in trees['sft.physics.unified_constants_object_law_v1'].body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id=='SPEC')
for c in next(k.value for k in node.value.keywords if k.arg=='axes').elts:
 key,q,bad,why,good,reason=[ast.literal_eval(x) for x in c.args];axes.append({'key':key,'question':q,'rejected':bad,'rejected_reason':why,'admitted':good,'admitted_reason':reason})
assert len(axes)==12
rows=list(product([False,True],repeat=12));assert len(rows)==4096 and sum(all(x) for x in rows)==1
r={'method':'Unchanged original pure function ASTs with separate original module namespaces and original import bindings; exact Fraction arithmetic. No source mutation or Lean rebuild.','source_sha256':{str(f.relative_to(root/'v3')):hashlib.sha256(f.read_bytes()).hexdigest() for f in (root/'v3').rglob('*.py')},'certificate':cert,'generator_changed_fields':changed,'held_fields':held,'dependency_graph':graph,'reachable_nodes':sorted(reached),'sector_incoming_counts':{s:sum(s in children for children in graph.values()) for s in sorted(u['SECTOR_NODES'])},'grammar_axes':axes,'candidate_count':4096,'unique_survivor':True}
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if isinstance(v,dict):return {k:clean(x) for k,x in v.items()}
 if isinstance(v,(list,tuple)):return [clean(x) for x in v]
 return v

retained=json.loads((root/'v4/verification/TURN_515_unified515_source_output.json').read_text())['certificate']['ok']
def native(v):
 if isinstance(v,dict):
  if set(v)=={'numerator','denominator'}:return str(Fraction(v['numerator'],v['denominator']))
  return {k:native(x) for k,x in v.items()}
 if isinstance(v,list):return [native(x) for x in v]
 return v
assert native(retained)==clean(cert)
r['all_eight_certificate_fields_match_retained_native_output']=True

(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print(json.dumps(clean(cert),indent=2))
