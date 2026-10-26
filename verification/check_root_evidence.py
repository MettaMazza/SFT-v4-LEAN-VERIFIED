"""Read-only V3 artifact comparison and independent Python-standard-library host checks.
Does not import or execute V3. Full verification of the algorithms remains separate.
"""
from pathlib import Path
import hashlib,json,subprocess,shutil
p=Path(__file__).resolve().parents[1]
s=json.loads((p/'reference/SOURCE.json').read_text()); src=Path(s['local_source'])
assert subprocess.check_output(['git','-C',str(src),'rev-parse','HEAD'],text=True).strip()==s['commit']
lake=shutil.which('lake') or str(Path.home()/'.elan/bin/lake')
b=src/'claims/SFT-ROOT-THERE-IS-NO-NOTHING'
source_hash=json.loads((b/'certificate.json').read_text())['source_manifest_hash']
def run(file,*args):return subprocess.check_output([lake,'env','lean','--run',file,*args],cwd=p,text=True)
a=json.loads(run('EvidenceParity.lean',source_hash));(p/'verification/TURN_007_EVIDENCE.json').write_text(json.dumps(a,indent=2)+'\n')
c=json.loads((b/'candidate_census.json').read_text());c.pop('claim_id') # artifact envelope, absent from CandidateCensus dataclass
assert a['census']==c,'census fields/hashes differ'
e=json.loads((b/'elimination_receipt.json').read_text())
assert a['decisions']==e['decisions'],'decisions differ'
assert a['closure']==e['closure'],'closure differs'
assert a['controls']==json.loads((b/'controls.json').read_text())['controls'],'controls differ'
r=json.loads((b/'registration.json').read_text())
for k in ['claim_id','title','branch','statement','dependencies']:assert a['registration'][k]==r[k],k
assert a['registration']['source_hash']==source_hash
assert a['registration']['evidence_mode']=='formal'
assert a['registration']['provenance']==['direct_forcing']
for k in ['axioms','free_parameters','root_theorems']:assert a['registration'][k]==[]
lines=run('verification/HostChecks.lean').splitlines();(p/'verification/TURN_007_HOST_CHECKS.tsv').write_text('\n'.join(lines)+'\n')
sha_count=json_count=0
for line in lines:
 parts=line.split('\t')
 if parts[0]=='sha':
  n=int(parts[1]);assert parts[2]==hashlib.sha256(bytes((i*73+19)%256 for i in range(n))).hexdigest();sha_count+=1
 elif parts[0]=='json':
  payload=parts[1];assert json.dumps(json.loads(payload),ensure_ascii=True,sort_keys=True,separators=(',',':'))==payload
  assert parts[2]=='sha256:'+hashlib.sha256(payload.encode()).hexdigest();json_count+=1
 else:assert line=='unknown-id\trejected'
assert (sha_count,json_count)==(16,10)
audit=(p/'verification/TURN_007_ALL_DECLARATIONS_AUDIT.log').read_text()
assert audit.count('does not depend on any axioms')==104
assert 'depends on axioms:' not in audit and 'error:' not in audit
result={'audited_definitions_and_theorems':104,'axiom_dependencies':0,'status':'PASS','source_commit':s['commit'],'source_manifest_hash':source_hash,'root_evidence':'census, decisions, closure and four controls match all stored fields and hashes; registration fields checked','sha256_vectors':sha_count,'canonical_json_vectors':json_count,'invalid_candidate_id':'rejected','native_theorems':14,'full_claim_complete':False,'pending':'General algorithm correspondence proofs, complete source operational semantics and engine admission integration'}
(p/'verification/TURN_007_EVIDENCE_REPORT.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
