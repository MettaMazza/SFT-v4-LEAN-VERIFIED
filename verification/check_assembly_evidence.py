"""Fresh complete Assembly program outputs versus pinned V3 artifacts."""
import json
from current_checks import OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit();base=src/'claims/SFT-FOUNDATION-FOLD-ASSEMBLY-001'
source_hash=json.loads((base/'certificate.json').read_text())['source_manifest_hash']
actual=json.loads(run('env','lean','--run','verification/AssemblyEvidenceParity.lean',source_hash))
(OUTPUT/'ASSEMBLY_EVIDENCE.json').write_text(json.dumps(actual,indent=2)+'\n')
census=json.loads((base/'candidate_census.json').read_text());census.pop('claim_id')
assert actual['census']==census,'census fields or hashes differ'
receipt=json.loads((base/'elimination_receipt.json').read_text())
assert actual['decisions']==receipt['decisions'],'lookup decisions or hashes differ'
assert actual['closure']==receipt['closure'],'closure fields or hashes differ'
assert actual['controls']==json.loads((base/'controls.json').read_text())['controls']
registration=json.loads((base/'registration.json').read_text())
for key in ['claim_id','title','branch','statement','dependencies']:assert actual['registration'][key]==registration[key],key
assert actual['registration']['source_hash']==source_hash
assert actual['registration']['evidence_mode']=='formal'
assert actual['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING']
assert actual['registration']['axioms']==actual['registration']['free_parameters']==[]
assert actual['registration']['provenance']==['forward_forcing']
assert actual['unknown_id']=='KeyError: unregistered'
report={'status':'PASS','source_commit':info['commit'],**audit,'candidate_rows':len(receipt['decisions']),'source_manifest_hash':source_hash,'scope':'registration fields, complete census and 192 actual lookup decisions, closure and four controls match all artifact fields/hashes; unknown ID rejected; full admission integration remains separate'}
(OUTPUT/'ASSEMBLY_EVIDENCE_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
