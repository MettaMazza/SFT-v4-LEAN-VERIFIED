"""Exact assembly control artifacts and finite-set semantics; source stays read-only."""
import ast,itertools,json
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit();base=src/'claims/SFT-FOUNDATION-FOLD-ASSEMBLY-001'
source_hash=json.loads((base/'certificate.json').read_text())['source_manifest_hash']
actual=[json.loads(line) for line in run('env','lean','--run','verification/AssemblyControlCases.lean',source_hash).splitlines()]
assert actual[0]['controls']==json.loads((base/'controls.json').read_text())['controls']
tree=ast.parse((src/'sft/foundation/fold_assembly.py').read_text());values={}
for node in tree.body:
 if isinstance(node,ast.Assign):
  try:values[node.targets[0].id]=ast.literal_eval(node.value)
  except (ValueError,AttributeError):pass
def literal(node):
 if isinstance(node,ast.JoinedStr):return ''.join(literal(n) for n in node.values)
 if isinstance(node,ast.FormattedValue):return values[node.value.id]
 return ast.literal_eval(node)
fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='closure_record')
closure={literal(k):literal(v) for k,v in zip(fn.body[0].value.keys,fn.body[0].value.values)}
assert actual[0]['closure']==closure
proposals=[]
for n in [0,1,2]:
 support=[()]
 for _ in range(n):support=[w+(label,) for w in support for label in values['LABELS']]
 alphabet=support+([('held-a',),('outside',)] if n==0 else [(),('outside',)])
 proposals.extend(ws for size in range(4) for ws in itertools.product(alphabet,repeat=size))
 if n==2:proposals.append(tuple(support))
assert len(actual)==len(proposals)+1
for (passed,distinct),ws in zip(actual[1:],proposals):
 ds=[tuple(w) for w in distinct]
 assert passed==(len(ws)==len(set(ws)))
 assert set(ds)==set(ws) and len(ds)==len(set(ds))
report={'status':'PASS','source_commit':info['commit'],**audit,'controls':4,'closure_fields':len(closure),'finite_set_cases':len(proposals),'scope':'all source control fields/hashes, exact closure text and original finite-set cardinality semantics; universal set equivalence and uniqueness theorems audited separately'}
(OUTPUT/'ASSEMBLY_CONTROLS_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
