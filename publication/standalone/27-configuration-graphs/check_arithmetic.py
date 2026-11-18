from pathlib import Path
from fractions import Fraction
import ast,types,sys,json,hashlib,itertools
from html.parser import HTMLParser
root=Path(__file__).resolve().parents[1];dest=root
sys.dont_write_bytecode=True
def load(name,relative,bindings=None,stop=None,selected=None):
 p=root/'v3'/relative;tree=ast.parse(p.read_text(),filename=relative);body=[]
 for node in tree.body:
  if isinstance(node,ast.ImportFrom) and (node.module or '').startswith('sft.'):continue
  if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='DEPENDENCIES' for t in node.targets):break
  if stop and isinstance(node,ast.ClassDef) and node.name==stop:break
  if selected and not (isinstance(node,(ast.ClassDef,ast.FunctionDef)) and node.name in selected):continue
  body.append(node)
 tree.body=body;m=types.ModuleType(name);sys.modules[name]=m;m.__dict__.update(bindings or {});exec(compile(tree,relative,'exec'),m.__dict__);return m
exact=load('paper27exact','sft/engine/exact.py');b={n:getattr(exact,n) for n in ['HeldLabel','PositiveCount','InadmissibleExactValue']};fold=load('paper27fold','sft/claim_evidence/fold_language.py',b,'FoldOpcode');b.update({n:getattr(fold,n) for n in ['PositiveRatio','EMPTY_ONE','EmptyOne']});law=load('paper27law','sft/chemistry/configuration_order_law_v1.py',b)
H=exact.HeldLabel;E=fold.EMPTY_ONE;Q=fold.PositiveRatio
heights=[E,Q.from_pair(1,2),Q.from_pair(1,1),Q.from_pair(2,1)];checked=0
for left,centre,right in itertools.product(heights,repeat=3):
 nodes=tuple(law.ConfigurationNode(H('molecular-carrier','M'),H('configuration-coordinate',str(i)),h,H('configuration-record',str(i))) for i,h in enumerate([left,centre,right]));p=law.ConfigurationPath(nodes)
 expected_min=(left is not E and right is not E) if centre is E else (False if left is E or right is E else centre.fraction<left.fraction and centre.fraction<right.fraction)
 expected_bar=(centre is not E and (left is E or right is E)) if centre is E or left is E or right is E else centre.fraction>left.fraction and centre.fraction>right.fraction
 assert p.local_minimum(1)==expected_min and p.local_barrier(1)==expected_bar;checked+=1
 for index in [0,2,-1,3]:
  for op in [p.local_minimum,p.local_barrier]:
   try:op(index)
   except exact.InadmissibleExactValue:pass
   else:raise AssertionError('Endpoint guard')
# Reconstruct every source row with the original parser and hash guards.
constants={}
for relative in ['sft/chemistry/configuration_order_batch_v1.py','sft/chemistry/configuration_order_validation_v1.py']:
 for node in ast.parse((root/'v3'/relative).read_text()).body:
  if isinstance(node,ast.Assign) and isinstance(node.value,ast.Constant):
   for t in node.targets:
    if isinstance(t,ast.Name):constants[t.id]=node.value.value
bindings={**b,**constants,'HTMLParser':HTMLParser,'Path':Path,'Fraction':Fraction,'json':json,'hash_file':lambda p:'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()}
v=load('paper27validation','sft/chemistry/configuration_order_validation_v1.py',bindings,selected={'Parser','_rows','_exact'})
rows=v._rows(root/'v3');assert len(rows)==50;counts=dict(positive=0,absence=0,basin=0,barrier=0,ordinary=0,recurrence_duplicate=0);paths=[]
for group in [1,2]:
 path=[r for r in rows if r['torsion_index']==group];assert len(path)==25
 assert path[0]['angle_inscription_degrees']=='0' and path[-1]['angle_inscription_degrees']=='360'
 values=[Fraction(r['energy_inscription_kj_mol']) for r in path];assert values[0]==values[-1]
 unique=values[:-1];minima=[];maxima=[]
 for i,x in enumerate(unique):
  l,u=unique[(i-1)%24],unique[(i+1)%24]
  kind='basin' if x<l and x<u else ('barrier' if x>l and x>u else 'ordinary');counts[kind]+=1
  if kind=='basin':minima.append(path[i]['angle_inscription_degrees'])
  if kind=='barrier':maxima.append(path[i]['angle_inscription_degrees'])
 for row,x in zip(path,values):
  assert (v._exact(row['energy_inscription_kj_mol']) is E)==(v._exact(row['energy_inscription_cm_inverse']) is E)
  counts['absence' if x==0 else 'positive']+=1
 counts['recurrence_duplicate']+=1;paths.append({'torsion':group,'minima_degrees':minima,'barriers_degrees':maxima})
assert counts==dict(positive=46,absence=4,basin=6,barrier=6,ordinary=36,recurrence_duplicate=2)
out={'status':'PASS','original_height_triples':checked,'invalid_position_checks':checked*8,'original_parser_rows':len(rows),'source_hash_guards':3,'counts':counts,'paths':paths,'new_lean_builds':0};dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out))
