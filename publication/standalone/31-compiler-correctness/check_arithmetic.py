from pathlib import Path
from fractions import Fraction
import ast,types,sys,json,itertools
root=Path(__file__).resolve().parents[1];dest=root
sys.dont_write_bytecode=True
def load(name,relative,functions_only=False):
 tree=ast.parse((root/'v3'/relative).read_text());body=[]
 for n in tree.body:
  if isinstance(n,ast.ImportFrom) and (n.module or '').startswith('sft.'):continue
  if functions_only and not isinstance(n,(ast.Import,ast.ImportFrom,ast.FunctionDef)):continue
  body.append(n)
 tree.body=body;m=types.ModuleType(name);sys.modules[name]=m;m.__dict__['EMPTY_ONE']=('empty-One',);exec(compile(tree,relative,'exec'),m.__dict__);return m
op=load('paper31operations','sft/computation/operations.py');q=load('paper31support','sft/information_science/quantum_information_correspondence/law.py',True)
# This event adapter follows the inspected EvaluationTrace.run constructor order.
# Each result is independently checked against the original Python evaluator.
def execute(e,env):
 events=[('enter',repr(e))]
 try:
  if len(dict(env))!=len(env):raise ValueError('binding identity occurs twice')
  if e[0]=='join':
   l,le=execute(e[1],env);events+=le
   if l[0]=='error':raise ValueError(l[1])
   r,re=execute(e[2],env);events+=re
   if r[0]=='error':raise ValueError(r[1])
   result=('ok',l[1]+r[1])
  else:result=('ok',op.evaluate_expression(e,env))
 except ValueError as error:result=('error',str(error))
 events.append(('leave',repr(e),repr(result)))
 try:expected=('ok',op.evaluate_expression(e,env))
 except ValueError as error:expected=('error',str(error))
 assert result==expected
 return result,events
v=lambda a,b:('value',Fraction(a,b));x=('name','x')
programs=[('join',x,v(1,3)),('join',v(1,3),x),('join',x,('join',v(1,6),v(1,6)))]
inputs=[(('x',Fraction(2,3)),),(('x',Fraction(1,2)),)]
rows=[]
for env in inputs:
 runs=[execute(e,env) for e in programs];assert len({r[0] for r in runs})==1
 assert [len(r[1]) for r in runs]==[6,6,10]
 for result,events in runs:
  ledger=op.resource_ledger(tuple(repr(e) for e in events),('x',));assert ledger['time_count']==len(events) and tuple(s for _,s in ledger['time_trace'])==tuple(repr(e) for e in events)
 rows.append({'input':str(env[0][1]),'observations':[str(r[0][1]) for r in runs],'event_counts':[len(r[1]) for r in runs]})
# Actual negative semantic row and original runtime guards.
bad=('join',x,v(1,2));assert all(execute(bad,env)[0]!=execute(programs[0],env)[0] for env in inputs)
errors=[]
for e,env in [(x,()),(v(0,1),()),(('outside',),()),(x,(('x',Fraction(1,2)),('x',Fraction(1,3))))]:
 result,events=execute(e,env);assert result[0]=='error';errors.append(result[1])
H=('held-a','held-b');total_names=0
for depth in range(1,9):
 positions=tuple('p'+str(i) for i in range(depth));support=q.complete_fold_support(H,positions)
 assert support==tuple(itertools.product(H,repeat=depth)) and len(set(support))==2**depth
 basis=q.basis_correspondence(support);assert len({n for w,n in basis})==len(support)
 for word,name in basis:assert tuple(name[len('basis:'):].split(':'))==word
 total_names+=len(basis)
 units=q.information_unit_trace(H,positions);assert len(units)==depth
 for i,row in enumerate(units):assert row[0]==positions[i] and sum(a!=b for a,b in zip(row[2],row[3]))==1 and row[2][i]!=row[3][i]
 branch=q.superposition_equivalent_support(H,positions);assert branch['complete_branch_support']==support
 for word,prov in branch['branch_provenance']:assert tuple(a for a,b in prov)==positions and tuple(b for a,b in prov)==word
 extended=q.complete_fold_support(H,positions+('fresh',));assert extended==tuple(w+(a,) for w in support for a in H)
support=q.complete_fold_support(H,('p1','p2','p3'));obs=tuple((w,w[0]) for w in support);record=q.observe_support(support,obs,H[0]);assert len(record['retained_branches'])==len(record['closed_alternatives'])==4 and q.reconstruct_support(record['reconstruction_record'])==support
joint=q.joint_support(((H[0],),(H[1],)),(('x',),('y',)));assert len(joint)==4 and all(c==a+b for a,b,c in joint)
raw=q.complete_fold_support(('a','a:a'),('p','q'));bn=dict(q.basis_correspondence(raw));assert bn[('a','a:a')]==bn[('a:a','a')]=='basis:a:a:a'
g={}
for node in ast.parse((root/'v3/sft/computation/catalog.py').read_text()).body:
 if isinstance(node,ast.Assign) and isinstance(node.value,ast.Dict):
  for k,vv in zip(node.value.keys,node.value.values):
   if isinstance(k,ast.Constant) and k.value=='semantics':g['compilation']=ast.literal_eval(vv)
for node in ast.parse((root/'v3/sft/information_science/quantum_information_correspondence/law.py').read_text()).body:
 if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='SPEC' for t in node.targets):
  dims=next(k.value for k in node.value.keywords if k.arg=='dimensions');g['basis']=[[ast.literal_eval(c.args[i]) for i in [0,2,4]] for c in dims.elts]
assert len(g['compilation'])==8 and len(g['basis'])==10
out={'status':'PASS','worked_programs':3,'input_environments':2,'execution_rows':rows,'failed_semantic_rows':2,'runtime_guard_errors':errors,'canonical_basis_words':total_names,'canonical_depths':8,'support_extensions':8,'observed_retained':4,'observed_closed':4,'reconstruction_branches':8,'joint_cells':4,'raw_delimiter_behavior_preserved':True,'grammars':g,'new_lean_builds':0}
dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps({k:v for k,v in out.items() if k!='grammars'}))
