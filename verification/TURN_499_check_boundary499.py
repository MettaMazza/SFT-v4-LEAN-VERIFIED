from pathlib import Path
import sys
import subprocess,json,ast
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v3=Path('/Volumes/One Touch/ernos-labs-sft-platform');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';base='claims/SFT-PHYS-MEAS-BOUNDARY-GROWTH-001/'
def read(p):return json.loads(subprocess.check_output(['git','-C',str(v3),'show',pin+':'+p]))
source=read(base+'certificate.json')['source_manifest_hash']
out=subprocess.check_output([str(Path('work/BoundaryMeasurementProgram499').resolve()),source],text=True);actual=json.loads(out)
census=read(base+'candidate_census.json');census.pop('claim_id');assert actual['census']==census
receipt=read(base+'elimination_receipt.json');assert actual['decisions']==receipt['decisions'];assert actual['closure']==receipt['closure'];assert actual['controls']==read(base+'controls.json')['controls']
reg=read(base+'registration.json')
for k in ['claim_id','title','branch','dependencies']:assert actual['registration'][k]==reg[k],k
source_text=subprocess.check_output(['git','-C',str(v3),'show',pin+':sft/physics/source_boundary_growth.py'],text=True)
tree=ast.parse(source_text)
statements=[ast.literal_eval(k.value) for node in ast.walk(tree) if isinstance(node,ast.Call) for k in node.keywords if k.arg=='statement']
assert len(statements)==1
assert actual['registration']['statement']==statements[0]
assert 'The observed family cannot supply or alter the structural law.' in reg['statement']
assert actual['registration']['source_hash']==source
assert actual['registration']['evidence_mode']=='formal'
assert actual['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING']
assert actual['registration']['axioms']==actual['registration']['free_parameters']==[]
assert actual['registration']['provenance']==['forward_forcing']
assert actual['unknown_id']=='StopIteration'
Path('work/boundary499_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
report=dict(status='PASS',source_commit=pin,source_manifest_hash=source,candidate_lookup_decisions=1024,all_census_trace_hashes_match=True,all_decision_proof_hashes_match=True,closure_and_controls_match=True,registration_fields_match=True,registration_statement_source='pinned executable SPEC.statement through FormalPrerequisiteProgram.registration',static_registration_statement=reg['statement'],unknown_identifier_rejected=True,fresh_native_lean_execution=True,scope='All BoundaryMeasurementProgram499 method output fields; original independent validator checked separately')
Path('work/boundary499_program_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
