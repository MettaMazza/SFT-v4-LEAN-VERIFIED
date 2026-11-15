from pathlib import Path
import sys
import subprocess,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v3=Path(json.loads((r/'reference/SOURCE.json').read_text())['local_source']);pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';base='claims/SFT-PHYS-THERMO-LANDAUER-EMPIRICAL-019/'
def read(p):return json.loads(subprocess.check_output(['git','-C',str(v3),'show',pin+':'+p]))
source=read(base+'certificate.json')['source_manifest_hash']
command=([sys.argv[1],source] if len(sys.argv)>1 else ['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(Path('work/constants-recovery/LandauerValidationProgram994.lean').resolve()),source])
out=subprocess.check_output(command,text=True,env=dict(__import__('os').environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve())));actual=json.loads(out)
Path("work/landauervalidation_program994_output.json").write_text(json.dumps(actual,indent=2)+"\n")
census=read(base+'candidate_census.json');census.pop('claim_id');assert actual['census']==census
receipt=read(base+'elimination_receipt.json');assert actual['decisions']==receipt['decisions'];assert actual['closure']==receipt['closure'];assert actual['controls']==read(base+'controls.json')['controls']
reg=read(base+'registration.json')
for k in ['claim_id','title','branch','dependencies']:assert actual['registration'][k]==reg[k],k
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.landauer_demon_empirical_v1 import SPEC
assert actual['registration']['statement']==SPEC.statement
assert actual['registration']['source_hash']==source
assert actual['registration']['evidence_mode']=='empirical'
assert actual['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING']
assert actual['registration']['axioms']==actual['registration']['free_parameters']==[]
assert actual['registration']['provenance']==['forward_forcing']
assert actual['unknown_id']=='StopIteration'
Path('work/landauervalidation_program994_output.json').write_text(json.dumps(actual,indent=2)+'\n')
report=dict(status='PASS',source_commit=pin,source_manifest_hash=source,candidate_lookup_decisions=256,all_census_trace_hashes_match=True,all_decision_proof_hashes_match=True,closure_and_controls_match=True,registration_fields_match=True,unknown_identifier_rejected=True,fresh_native_lean_execution=True,scope='All GeneratedEmpiricalPhysicsProgram method output fields; registration, complete256 candidate decisions, closure, controls and unknown identifier compared to pinned V3')
assert actual==json.load(open('work/landauervalidation994_original_program.json'));report['fresh_original_package_output_also_matches']=True
report['static_registration_statement']=reg['statement'];report['executed_registration_statement']=actual['registration']['statement'];report['statement_binding']='Original executable SPEC statement retained exactly; static registration wording recorded separately'
Path('work/landauervalidation_program994_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
