"""Fresh nested-generation/pairing comparison; never executes V3 modules."""
import json
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit()
traces=[[],['a'],['a','b'],['','λ','x,y'],['a','a']]
expected=[]
for xs in traces:
 for ys in traces:
  cells=[f'({a},{b})' for a in xs for b in ys]
  paired=len(xs)==len(ys) and all(i<len(xs) and j<len(ys) for i,j in zip(range(len(xs)),range(len(ys))))
  expected.append([cells,paired,cells,cells])
actual=[json.loads(x) for x in run('env','lean','--run','verification/CommonRefinementCases.lean').splitlines()]
assert actual==expected,(actual,expected)
report={'status':'PASS','source_commit':info['commit'],**audit,'cases':len(expected),'scope':'pair_cells, both lift functions and generated index-pairing execution; universal native pairing and refinement proofs audited separately; candidate grammar checked separately by fresh parity'}
(OUTPUT/'COMMON_REFINEMENT_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
