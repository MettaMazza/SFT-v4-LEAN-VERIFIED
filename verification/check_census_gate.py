"""Fresh census gate comparisons; reads pinned V3 but never executes its modules."""
import json,itertools
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit()
good='sha256:'+'a'*64
sequences=[[],['a'],['a','b'],['a','a'],['a','b','a'],[''],[' \t'],['α','β'],['α','α']]
def valid(s):return s.startswith('sha256:') and len(s[7:])==64 and all(c in '0123456789abcdef' for c in s[7:])
def violations(rule,boundary,count,ids,form,trace,cert):
 out=[]
 if not rule.strip():out.append('candidate generation rule is missing')
 if not boundary.strip():out.append('candidate grammar boundary is missing')
 if isinstance(count,bool) or count<1:out.append('expected candidate cardinality must be a positive count')
 if len(ids)!=count:out.append('generated candidate count does not match the registered cardinality')
 if len(set(ids))!=len(ids):out.append('candidate census contains duplicate identifiers')
 if any(not id.strip() or not form.strip() for id in ids):out.append('candidate identifiers and exact forms must be named')
 if ids and not valid(trace):out.append('every candidate requires a canonical trace hash')
 if not valid(cert):out.append('candidate census lacks a completeness certificate hash')
 return out
expected=[violations(*c) for c in itertools.product(['generate',' \t'],['operational',''],[-1,0,1,2,3],sequences,['exact','\n'],[good,'invalid'],[good,'invalid'])]
count=len(expected)
expected.extend([[],['generated candidate count does not match the registered cardinality'],['candidate census contains duplicate identifiers']])
output=run('env','lean','--run','verification/CensusGateCases.lean');actual=[json.loads(x) for x in output.splitlines()]
assert len(actual)==len(expected),(len(actual),len(expected))
for i,(a,e) in enumerate(zip(actual,expected)):assert a==e,(i,a,e)
report={'status':'PASS','source_commit':info['commit'],**audit,'census_cases':count,'root_cases':3,'scope':'source-annotated CandidateCensus fields; importer validation of untyped Python values remains separate'}
(OUTPUT/'CENSUS_GATE_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
