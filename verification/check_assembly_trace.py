"""Fresh canonical finite Fold traces; never executes V3 Python modules."""
import ast,json
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit()
tree=ast.parse((src/'sft/foundation/fold_assembly.py').read_text())
labels=next(ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id=='LABELS')
expected=[]
for n in range(6):
 support=[[]];stages=[support];transitions=[]
 for _ in range(n):
  new=[]
  for word in support:
   for label in labels:
    child=word+[label];new.append(child);transitions.append([word,label,child])
  support=new;stages.append(support)
 expected.append({'stages':stages,'transitions':transitions,'returns':[[t[2],t[0]] for t in transitions]})
actual=[json.loads(line) for line in run('env','lean','--run','verification/AssemblyTraceCases.lean').splitlines()]
assert actual==expected,(actual,expected)
report={'status':'PASS','source_commit':info['commit'],**audit,'finite_trace_depths':6,'scope':'canonical full-stage, transition and return traces preserve source held-label generation order; universal semantic properties proved separately; arbitrary-proposal classification and full evidence integration pending'}
(OUTPUT/'ASSEMBLY_TRACE_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
