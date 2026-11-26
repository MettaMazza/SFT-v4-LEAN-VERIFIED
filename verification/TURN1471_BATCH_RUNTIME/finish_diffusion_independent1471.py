from pathlib import Path
import ast,copy,hashlib,json,subprocess,sys
w=Path('work'); tag='diffusionlimit1357'; cid='SFT-CHEM-DIFFUSION-LIMITED-REACTION-BOUNDARY-011'
src=w/'pinned1357/claims'/cid/'independent_validator.py'
original=src.read_text(); tree=ast.parse(original)
class Alias(ast.NodeTransformer):
 def visit_ImportFrom(self,node):
  if node.module=='itertools':
   for n in node.names:
    if n.name=='product': n.asname='cartesian_product'
  return node
 def visit_Call(self,node):
  self.generic_visit(node)
  if isinstance(node.func,ast.Name) and node.func.id=='product':node.func.id='cartesian_product'
  return node
adapted=ast.fix_missing_locations(Alias().visit(tree)); text=ast.unparse(adapted)+'\n'
# Invert precisely the two identifier substitutions and require identical AST.
check=ast.parse(text)
for node in ast.walk(check):
 if isinstance(node,ast.ImportFrom) and node.module=='itertools':
  for n in node.names:
   if n.name=='product':assert n.asname=='cartesian_product';n.asname=None
 if isinstance(node,ast.Call) and isinstance(node.func,ast.Name) and node.func.id=='cartesian_product': node.func.id='product'
assert ast.dump(check)==ast.dump(ast.parse(original))
adapter=w/'diffusionlimit1357_independent_adapter1471.py';adapter.write_text(text)
actual=json.loads((w/(tag+'_program_output.json')).read_text()); report=json.loads((w/(tag+'_program_report.json')).read_text());assert report['status']=='PASS'
cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-diffusionlimit1357'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/(tag+'_independent_'+case+'.json');f.write_text(json.dumps(sealed))
 p=subprocess.run([sys.executable,str(adapter),str(f)],capture_output=True,text=True,check=True)
 result=json.loads(p.stdout);assert result['passed']==(case=='original'),result
 cases.append(dict(case=case,result=result))
receipt=dict(status='PASS',original_sha256=hashlib.sha256(src.read_bytes()).hexdigest(),adapter_sha256=hashlib.sha256(adapter.read_bytes()).hexdigest(),inverse_AST_identical=True,change='Alias imported itertools.product and its sole call; retain local product state and all original checks.',cases=[dict(case=x['case'],passed=x['result']['passed']) for x in cases])
(w/(tag+'_independent_adapter1471_report.json')).write_text(json.dumps(receipt,indent=2)+'\n')
(w/(tag+'_independent_report.json')).write_text(json.dumps(cases,indent=2)+'\n')
print(json.dumps(receipt))
