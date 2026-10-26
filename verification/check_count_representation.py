"""Compare concrete finite proposal classification to pinned V3 Count records."""
import itertools,json
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit()
base=src/'claims/SFT-FOUNDATION-COUNT-001'
decisions={d['candidate_id']:d for d in json.loads((base/'elimination_receipt.json').read_text())['decisions']}
expected=[];seen=set()
for size in [1,2,3]:
 for length in range(5):
  for proposal in itertools.product(range(size+1),repeat=length):
   retained=[x for x in proposal if x<size]
   extra='has-extra' if size in proposal else 'no-extra'
   coverage='none' if not retained else 'complete' if set(retained)==set(range(size)) else 'proper'
   multiplicity='not-applicable' if not retained else 'duplicated' if len(set(retained))!=len(retained) else 'once'
   name=f'{coverage}-coverage__{multiplicity}__{extra}';d=decisions[name]
   expected.append([name,d['survives'],d['reason']]);seen.add(name)
output=run('env','lean','--run','verification/CountRepresentationCases.lean');actual=[json.loads(x) for x in output.splitlines()]
assert actual==expected,next(((i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e),(len(actual),len(expected)))
assert seen==set(decisions),(seen,set(decisions))
report={'status':'PASS','source_commit':info['commit'],**audit,'concrete_proposals':len(expected),'source_classes_reached':len(seen),'scope':'bounded execution check supplements universal Lean exact-retention equivalence; not full model-entry completion'}
(OUTPUT/'COUNT_REPRESENTATION_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
