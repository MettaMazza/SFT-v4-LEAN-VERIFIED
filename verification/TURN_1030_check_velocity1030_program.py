from pathlib import Path
import sys,os
os.environ["LEAN_NUM_THREADS"]="24"
import subprocess,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v3=Path(json.loads((r/'reference/SOURCE.json').read_text())['local_source']);pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';base='claims/SFT-PHYS-SPACETIME-VELOCITY-COMPOSITION-TERMINAL-033/'
def read(p):return json.loads(subprocess.check_output(['git','-C',str(v3),'show',pin+':'+p]))
source=read(base+'certificate.json')['source_manifest_hash']
out=subprocess.check_output([str(Path(sys.argv[1]).resolve()),source],cwd=r,text=True);actual=json.loads(out)
Path("work/velocity1030_program_output.json").write_text(json.dumps(actual,indent=2)+"\n")
census=read(base+'candidate_census.json');census.pop('claim_id');assert actual['census']==census
receipt=read(base+'elimination_receipt.json');assert actual['decisions']==receipt['decisions'];assert actual['closure']==receipt['closure'];assert actual['controls']==read(base+'controls.json')['controls']
reg=read(base+'registration.json')
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.velocity_composition_terminal_law_v1 import SPEC
assert actual['registration']['statement']==SPEC.statement
for k in ['claim_id','title','branch','dependencies']:assert actual['registration'][k]==reg[k],k
assert actual['registration']['source_hash']==source
assert actual['registration']['evidence_mode']=='formal'
assert actual['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING']
assert actual['registration']['axioms']==actual['registration']['free_parameters']==[]
assert actual['registration']['provenance']==['forward_forcing','observational_derivation']
assert actual['unknown_id']=='StopIteration'
Path('work/velocity1030_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
report=dict(status='PASS',source_commit=pin,source_manifest_hash=source,candidate_lookup_decisions=2048,all_census_trace_hashes_match=True,all_decision_proof_hashes_match=True,closure_and_controls_match=True,registration_fields_match=True,static_registration_statement=reg['statement'],executed_registration_statement=SPEC.statement,statement_binding='Original executable SPEC statement retained exactly; distinct static registration wording retained separately',unknown_identifier_rejected=True,fresh_native_lean_execution=True,scope='All VelocityCompositionProgram method output fields; registration, complete2048 candidate decisions, closure, controls and unknown identifier compared to pinned V3')
Path('work/velocity1030_program_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
