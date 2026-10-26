"""Fresh comparison of source-typed registration constraints, preserving diagnostic order."""
import itertools,json
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit()
root='SFT-ROOT-THERE-IS-NO-NOTHING';good='sha256:'+'a'*64;other='sha256:'+'b'*64
base=dict(claim_id=root,title='Premise-free operational root theorem',branch='foundation',statement='statement',roots=[],deps=[],axioms=[],params=[],provenance=['direct_forcing'],source=good)
def valid(s):return s.startswith('sha256:') and len(s[7:])==64 and all(c in '0123456789abcdef' for c in s[7:])
def check(r,known=False,executed=None):
 out=[]
 for field in ['claim_id','title','branch','statement']:
  if not r[field].strip():out.append(field+' is missing')
 if r['claim_id']==root:
  if r['roots']:out.append('the root theorem cannot cite itself as a premise')
  if r['deps']:out.append('the root theorem cannot depend on a prior model claim')
 elif r['roots']!=[root]:out.append('foundation trace must contain exactly the single self-proven root theorem')
 if r['axioms']:out.append('axioms are forbidden')
 if r['params']:out.append('free, fitted or learned parameters are forbidden')
 if len(set(r['deps']))!=len(r['deps']):out.append('dependency list contains duplicates')
 missing=[x for x in r['deps'] if not (known and x=='a')]
 if missing:out.append('dependencies lack model-admitted receipts: '+', '.join(sorted(missing)))
 if not r['provenance']:out.append('derivation provenance is unclassified')
 if not valid(r['source']):out.append('source hash is not a canonical SHA-256 identity')
 if executed is not None:
  if not valid(executed):out.append('executed source manifest hash is invalid')
  elif r['source']!=executed:out.append('registered source hash differs from the files loaded by the official runner')
 return out
expected=[]
for id,roots,deps,known in itertools.product([root,'downstream'],[[],[root],['other'],[root,root]],[[],['a'],['b','a'],['a','a'],['β','α','a'],['β','β','a']],[False,True]):
 expected.append(check(dict(base,claim_id=id,roots=roots,deps=deps),known))
for axioms,params,provenance,sourcehash,executed in itertools.product([[],['injected']],[[],['fitted']],[[],['direct_forcing'],['forward_forcing','constitutional_relation','observational_derivation']],[good,'bad',other],[None,good,'invalid',other]):
 expected.append(check(dict(base,axioms=axioms,params=params,provenance=provenance,source=sourcehash),False,executed))
for mode in ['formal','empirical']:
 for mask in range(16):
  r=base.copy()
  for i,key in enumerate(['claim_id','title','branch','statement']):
   if mask//2**i%2:r[key]=[' \t','','\n',' '][i]
  expected.append(check(r))
output=run('env','lean','--run','verification/RegistrationGateCases.lean');actual=[json.loads(x) for x in output.splitlines()]
assert len(actual)==len(expected),(len(actual),len(expected))
for i,(a,e) in enumerate(zip(actual,expected)):assert a==e,(i,a,e)
report={'status':'PASS','source_commit':info['commit'],**audit,'registration_cases':len(expected),'scope':'source-typed fields with AuthorityLedger.contains supplied as lookup; full receipt admission integration remains pending'}
(OUTPUT/'REGISTRATION_GATE_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
