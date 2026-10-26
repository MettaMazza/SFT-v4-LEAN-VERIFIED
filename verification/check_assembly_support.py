"""Fresh concrete-support relation classification against pinned V3 decisions."""
import itertools,json
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit()
base=src/'claims/SFT-FOUNDATION-FOLD-ASSEMBLY-001'
decisions={d['candidate_id']:d for d in json.loads((base/'elimination_receipt.json').read_text())['decisions']}
expected=[];seen=set()
for n in [0,1,2]:
 support=[()]
 for _ in range(n):support=[w+(label,) for w in support for label in ['held-a','held-b']]
 alphabet=support+([('held-a',),('outside',)] if n==0 else [(),('outside',)])
 proposals=[ws for size in range(4) for ws in itertools.product(alphabet,repeat=size)]
 if n==2:proposals.append(tuple(support))
 for ws in proposals:
  length='consistent-length' if all(len(w)==n for w in ws) else 'inconsistent-length'
  complete='support-complete' if set(support)<=set(ws) else 'support-incomplete'
  unique='words-unique' if len(ws)==len(set(ws)) else 'words-duplicated'
  for coverage,transition,ret,rule_extra in itertools.product(['none','proper','complete'],['transitions-absent','transitions-present'],['returns-absent','returns-present'],[False,True]):
   extra='no-extra' if set(ws)<=set(support) and not rule_extra else 'has-extra'
   name='__'.join([coverage,length,complete,unique,transition,ret,extra]);d=decisions[name]
   expected.append([name,d['survives'],d['reason']]);seen.add(name)
actual=[json.loads(line) for line in run('env','lean','--run','verification/AssemblySupportCases.lean').splitlines()]
assert actual==expected,next(((i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e),(len(actual),len(expected)))
report={'status':'PASS','source_commit':info['commit'],**audit,'proposal_relation_cases':len(expected),'source_classes_reached':len(seen),'scope':'concrete proposed supports crossed with independent source trace relations; native acceptance equivalence applies to all finite supports; arbitrary transition/return record classification remains separate'}
(OUTPUT/'ASSEMBLY_SUPPORT_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
