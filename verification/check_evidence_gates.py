"""Fresh closure/control gate comparison on source-annotated field domains."""
import json,itertools
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit()
good='sha256:'+'a'*64
scopes=['conditional_grammar','finite_complete','depth_independent'];kinds=['false_premise','tampered_source','tampered_artifact','boundary']
def valid(s):return isinstance(s,str) and s.startswith('sha256:') and len(s[7:])==64 and all(c in '0123456789abcdef' for c in s[7:])
def closure(c):
 scope,boundary,minimum,unique,proof,general=c;out=[]
 if not boundary.strip():out.append('closure boundary is missing')
 if not minimum:out.append('minimality gate failed')
 if not unique:out.append('named-shape uniqueness gate failed')
 if not valid(proof):out.append('closure proof hash is invalid')
 if scope=='depth_independent' and not valid(general):out.append('depth-independent closure lacks a generality certificate')
 return out
def controls(cs):
 out=[];ks=[c[0] for c in cs];missing=set(kinds)-set(ks)
 if missing:out.append('missing required controls: '+', '.join(sorted(missing)))
 if len(set(ks))!=len(ks):out.append('control kinds must not be duplicated')
 for kind,passed,expect,observed,digest in cs:
  if not passed:out.append('control failed: '+kind)
  if not expect.strip() or not observed.strip():out.append('control lacks expected or observed behavior: '+kind)
  if not valid(digest):out.append('control receipt hash is invalid: '+kind)
 return out
expected=[closure(c) for c in itertools.product(scopes,['operational','',' \t'],[False,True],[False,True],[good,'bad','sha256:'+'A'*64],[None,good,'','bad'])];closure_count=len(expected)
sequences=[[k for i,k in enumerate(kinds) if n//2**i%2==1] for n in range(16)]+[list(reversed(kinds)),kinds+['boundary']]
for sequence,mode,expect,observed,digest in itertools.product(sequences,range(4),['reject',' \t'],['rejected',''],[good,'invalid']):
 cs=[(k,True if mode==0 else i!=0 if mode==1 else i+1!=len(sequence) if mode==2 else False,expect,observed,digest) for i,k in enumerate(sequence)]
 expected.append(controls(cs))
control_count=len(expected)-closure_count
expected.extend([[],['minimality gate failed'],['depth-independent closure lacks a generality certificate'],[],['control failed: '+k for k in kinds]])
output=run('env','lean','--run','verification/EvidenceGateCases.lean');actual=[json.loads(x) for x in output.splitlines()]
assert len(actual)==len(expected),(len(actual),len(expected))
for i,(a,e) in enumerate(zip(actual,expected)):assert a==e,(i,a,e)
report={'status':'PASS','source_commit':info['commit'],**audit,'closure_cases':closure_count,'control_cases':control_count,'root_cases':5,'scope':'source-typed enum/dataclass fields; full engine admission remains pending'}
(OUTPUT/'EVIDENCE_GATES_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
