from pathlib import Path
import sys,os
os.environ["LEAN_NUM_THREADS"]="1"
import subprocess,json
import hashlib,datetime
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';base='claims/SFT-PHYS-GRAND-LOCK-TERMINAL-075/'
w=Path('work');cache=w/'pinned1070';ids=json.load(open(cache/'SOURCE_IDENTITIES.json'));assert ids['commit']==pin
blobs={x['path']:x['sha'] for x in ids['files']}
def read(p):
 b=(cache/p).read_bytes();assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==blobs[p]
 return json.loads(b)
source=read(base+'certificate.json')['source_manifest_hash']
output=Path('work/grandlock1100_program_output.json')
root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with output.open('w')as out,(w/'grandlock1100_program_execution.log').open('w')as err:
 subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(root/'GrandLockProgram1100.lean'),source],env=env,stdout=out,stderr=err,check=True)
from collections import deque
with(w/'grandlock1100_program_execution.log').open()as f:last=deque(f,maxlen=1)[0]
resource=json.loads(last);run=json.loads(Path(resource['resource_receipt']).read_text());assert run['exit']==0
assert output.stat().st_mtime>=datetime.datetime.fromisoformat(run['started_utc']).timestamp()
actual=json.loads(output.read_text())
census=read(base+'candidate_census.json');census.pop('claim_id');assert actual['census']==census
receipt=read(base+'elimination_receipt.json');assert actual['decisions']==receipt['decisions'];assert actual['closure']==receipt['closure'];assert actual['controls']==read(base+'controls.json')['controls']
reg=read(base+'registration.json')
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.grand_lock_terminal_law_v1 import SPEC
assert actual['registration']['statement']==SPEC.statement
for k in ['claim_id','title','branch','dependencies']:assert actual['registration'][k]==reg[k],k
assert actual['registration']['source_hash']==source
assert actual['registration']['evidence_mode']=='formal'
assert actual['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING']
assert actual['registration']['axioms']==actual['registration']['free_parameters']==[]
assert actual['registration']['provenance']==[x.value for x in SPEC.provenance]
assert actual['unknown_id']=='StopIteration'
Path('work/grandlock1100_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
report=dict(status='PASS',source_commit=pin,source_manifest_hash=source,candidate_lookup_decisions=len(actual['decisions']),all_census_trace_hashes_match=True,all_decision_proof_hashes_match=True,closure_and_controls_match=True,registration_fields_match=True,static_registration_statement=reg['statement'],executed_registration_statement=SPEC.statement,statement_binding='Original executable SPEC statement retained exactly; distinct static registration wording retained separately',unknown_identifier_rejected=True,fresh_native_lean_execution=True,scope='All GrandLockProgram method output fields; registration, complete4096 candidate decisions, closure, controls and unknown identifier compared to pinned V3')
Path('work/grandlock1064_program_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
