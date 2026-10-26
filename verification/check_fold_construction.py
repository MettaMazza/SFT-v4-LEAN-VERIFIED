"""Fresh literal Fold controls and assembly execution versus pinned V3 source."""
import ast,json
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit()
base=src/'claims/SFT-FOUNDATION-FOLD-001'
source_hash=json.loads((base/'certificate.json').read_text())['source_manifest_hash']
actual=[json.loads(x) for x in run('env','lean','--run','verification/FoldConstructionCases.lean',source_hash).splitlines()]
tree=ast.parse((src/'sft/foundation/fold.py').read_text())
fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='closure_record')
closure=ast.literal_eval(fn.body[0].value)
expected=[{'controls':json.loads((base/'controls.json').read_text())['controls'],'closure':closure}]
support=[[]]
for n in range(7):
 expected.append({'support':support,'returns':[w[:-1] if w else None for w in support]})
 support=[w+[label] for w in support for label in ['held-a','held-b']]
for words in [[],[[]],[['x'],['λ','held-a']],[['x'],['x']]]:
 expected.append([w+[label] for w in words for label in ['held-a','held-b']])
for n in [-2,-1,0,1,2,3]:
 support=[[]]
 for _ in range(max(n,0)):support=[w+[label] for w in support for label in ['held-a','held-b']]
 expected.append(None if n<0 else support)
assert actual==expected,next(((i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e),(len(actual),len(expected)))
report={'status':'PASS','source_commit':info['commit'],**audit,'fold_controls':4,'closure_fields':len(closure),'assembly_depths':7,'arbitrary_word_cases':4,'signed_extension_inputs':6,'scope':'exact Fold control fields and hashes, literal closure strings, current assembly construction and returns; native all-finite proofs audited separately; full entry integration pending'}
(OUTPUT/'FOLD_CONSTRUCTION_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
