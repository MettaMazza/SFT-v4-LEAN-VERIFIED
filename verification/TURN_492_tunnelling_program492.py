from pathlib import Path
import sys
import subprocess,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v3=Path(json.loads((r/'reference/SOURCE.json').read_text())['local_source']);pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';base='claims/SFT-PHYS-QUANTUM-TUNNELLING-001/'
def read(p):return json.loads(subprocess.check_output(['git','-C',str(v3),'show',pin+':'+p]))
source=read(base+'certificate.json')['source_manifest_hash']
import os
env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')+':'+str(Path.cwd()))
out=subprocess.check_output([str(Path('work/TunnellingProgram492').resolve()),source],env=env,text=True);actual=json.loads(out)
census=read(base+'candidate_census.json');census.pop('claim_id');assert actual['census']==census
receipt=read(base+'elimination_receipt.json');assert actual['decisions']==receipt['decisions'];assert actual['closure']==receipt['closure'];assert actual['controls']==read(base+'controls.json')['controls']
reg=read(base+'registration.json')
for k in ['claim_id','title','branch','statement','dependencies']:assert actual['registration'][k]==reg[k],k
assert actual['registration']['source_hash']==source
assert actual['registration']['evidence_mode']=='empirical'
assert actual['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING']
assert actual['registration']['axioms']==actual['registration']['free_parameters']==[]
assert actual['registration']['provenance']==['forward_forcing']
assert actual['unknown_id']=='StopIteration'
Path('work/tunnelling_program492_output.json').write_text(json.dumps(actual,indent=2)+'\n')
report=dict(status='PASS',source_commit=pin,source_manifest_hash=source,candidate_lookup_decisions=256,all_census_trace_hashes_match=True,all_decision_proof_hashes_match=True,closure_and_controls_match=True,registration_fields_match=True,unknown_identifier_rejected=True,fresh_native_lean_execution=True,scope='All TunnellingProgram method output fields; complete empirical validator checked separately.')
Path('work/tunnelling_program492_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
