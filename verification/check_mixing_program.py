from pathlib import Path
import sys
import subprocess,json,ast
r=Path(__file__).resolve().parents[1];v3=Path(json.loads((r/'reference/SOURCE.json').read_text())['local_source']);pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';base='claims/SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002/'
def read(p):return json.loads(subprocess.check_output(['git','-C',str(v3),'show',pin+':'+p]))
source=read(base+'certificate.json')['source_manifest_hash']
out=subprocess.check_output(['/Users/dolltrading/.elan/bin/lake','env','lean','--run','verification/TURN_279_MixingProgram.lean',source],cwd=r,text=True);actual=json.loads(out)
census=read(base+'candidate_census.json');census.pop('claim_id');assert actual['census']==census
receipt=read(base+'elimination_receipt.json');assert actual['decisions']==receipt['decisions'];assert actual['closure']==receipt['closure'];assert actual['controls']==read(base+'controls.json')['controls']
reg=read(base+'registration.json')
for k in ['claim_id','title','branch','dependencies']:assert actual['registration'][k]==reg[k],k
tree=ast.parse(subprocess.check_output(['git','-C',str(v3),'show',pin+':sft/physics/lineage_particle_laws.py'],text=True))
spec=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='ELECTROWEAK_MIXING_SPEC')
statement=ast.literal_eval(next(k.value for k in spec.keywords if k.arg=='statement'))
assert actual['registration']['statement']==statement
assert ' '.join(statement.split())==' '.join(reg['statement'].split())
assert actual['registration']['source_hash']==source
assert actual['registration']['evidence_mode']=='formal'
assert actual['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING']
assert actual['registration']['axioms']==actual['registration']['free_parameters']==[]
assert actual['registration']['provenance']==['forward_forcing']
assert actual['unknown_id']=='StopIteration'
(r/'verification/TURN_279_PROGRAM_OUTPUT.json').write_text(json.dumps(actual,indent=2)+'\n')
report=dict(status='PASS',source_commit=pin,source_manifest_hash=source,candidate_lookup_decisions=256,all_census_trace_hashes_match=True,all_decision_proof_hashes_match=True,closure_and_controls_match=True,registration_fields_match=True,unknown_identifier_rejected=True,fresh_native_lean_execution=True,statement_source='Exact pinned SPEC.statement; separate registration JSON whitespace retained',scope='Every registered MixingProgram method field/hash, original controls and unknown-ID behavior; the actual scientific derivation is documented in TURN_279_MIXING_COMPLETION.json.')
(r/'verification/TURN_279_PROGRAM_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
