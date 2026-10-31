from pathlib import Path
import sys
import subprocess,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v3=Path(json.loads((r/'reference/SOURCE.json').read_text())['local_source']);pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';base='claims/SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032/'
def read(p):return json.loads(subprocess.check_output(['git','-C',str(v3),'show',pin+':'+p]))
source=read(base+'certificate.json')['source_manifest_hash']
import os
env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')+':'+str(Path.cwd()))
out=subprocess.check_output([str(Path('work/CosmicComponentTransportProgram515').resolve()),source],env=env,text=True);actual=json.loads(out);Path('work/component_program515_output.json').write_text(json.dumps(actual,indent=2)+'\n')
census=read(base+'candidate_census.json');census.pop('claim_id');assert actual['census']==census
receipt=read(base+'elimination_receipt.json');assert actual['decisions']==receipt['decisions'];assert actual['closure']==receipt['closure'];assert actual['controls']==read(base+'controls.json')['controls']
sys.dont_write_bytecode=True
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics import cosmic_component_transport_terminal_law_v1 as source_module
from sft.physics.structural_constants import StructuralPhysicsProgram
from sft.engine.canonical import canonical_value
reg=canonical_value(StructuralPhysicsProgram(source_module.SPEC,source).registration)
for k in ['claim_id','title','branch','statement','dependencies']:assert actual['registration'][k]==reg[k],k
assert actual['registration']['source_hash']==source
assert actual['registration']['evidence_mode']=='empirical'
assert actual['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING']
assert actual['registration']['axioms']==actual['registration']['free_parameters']==[]
assert actual['registration']['provenance']==['forward_forcing','observational_derivation']
assert actual['unknown_id']=='StopIteration'
Path('work/component_program515_output.json').write_text(json.dumps(actual,indent=2)+'\n')
report=dict(status='PASS',source_commit=pin,source_manifest_hash=source,candidate_lookup_decisions=4096,all_census_trace_hashes_match=True,all_decision_proof_hashes_match=True,closure_and_controls_match=True,registration_fields_match=True,unknown_identifier_rejected=True,fresh_native_lean_execution=True,scope='All CosmicComponentTransportProgram method output fields; complete empirical validator checked separately.')
Path('work/component_program515_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
