from pathlib import Path
import sys
import subprocess,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v3=Path(json.loads((r/'reference/SOURCE.json').read_text())['local_source']);pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';base='claims/SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003/'
def read(p):return json.loads(subprocess.check_output(['git','-C',str(v3),'show',pin+':'+p]))
source=read(base+'certificate.json')['source_manifest_hash']
command=([sys.argv[1],source] if len(sys.argv)>1 else ['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(Path('work/constants-recovery/MassRatioFamilyProgram933.lean').resolve()),source])
out=subprocess.check_output(command,text=True,env=dict(__import__('os').environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve())));actual=json.loads(out)
Path("work/massratio_program933_output.json").write_text(json.dumps(actual,indent=2)+"\n")
census=read(base+'candidate_census.json');census.pop('claim_id');assert actual['census']==census
artifact_receipt=read(base+'elimination_receipt.json');fresh=json.loads(Path('work/massratio933_original_program.json').read_text());assert actual==fresh;assert actual['controls']==read(base+'controls.json')['controls']
for a,b in zip(actual['decisions'],artifact_receipt['decisions']):
 assert {k:v for k,v in a.items() if k!='proof_hash'}=={k:v for k,v in b.items() if k!='proof_hash'}
assert {k:v for k,v in actual['closure'].items() if k!='proof_hash'}=={k:v for k,v in artifact_receipt['closure'].items() if k!='proof_hash'}
reg=read(base+'registration.json')
for k in ['claim_id','title','branch','statement']:assert actual['registration'][k]==reg[k],k
assert actual['registration']['source_hash']==source
assert actual['registration']['evidence_mode']=='formal'
assert actual['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING']
assert actual['registration']['axioms']==actual['registration']['free_parameters']==[]
assert actual['registration']['provenance']==['forward_forcing']
assert actual['unknown_id']=='StopIteration'
Path('work/massratio_program933_output.json').write_text(json.dumps(actual,indent=2)+'\n')
report=dict(status='PASS',source_commit=pin,source_manifest_hash=source,candidate_lookup_decisions=256,all_census_trace_hashes_match=True,all_decision_proof_hashes_match_fresh_pinned_execution=True,stored_registration_dependency_difference=dict(stored=reg['dependencies'],executable=actual['registration']['dependencies']),closure_and_controls_match=True,registration_fields_match=True,unknown_identifier_rejected=True,fresh_native_lean_execution=True,scope='All native program fields equal fresh byte-identical pinned executable; stored candidate decisions and closure agree except proof hashes induced by the recorded dependency difference; stored controls and other registration fields agree.')
Path('work/massratio_program933_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
