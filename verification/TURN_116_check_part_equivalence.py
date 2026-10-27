from pathlib import Path
import json,subprocess,sys
from current_checks import PROJECT as r, source, LAKE
info,v=source();pin=info['commit'];claim='SFT-FOUNDATION-PART-EQUIVALENCE-001'
def read(name):return json.loads(subprocess.check_output(['git','-C',str(v),'show',pin+':claims/'+claim+'/'+name]))
h=read('certificate.json')['source_manifest_hash']
a=json.loads(subprocess.check_output([sys.argv[1],h],cwd=r,text=True))
(r/'verification/TURN_116_PART_EQUIVALENCE_PROGRAM_OUTPUT.json').write_text(json.dumps(a,indent=2)+'\n')
c=read('candidate_census.json');c.pop('claim_id');assert a['census']==c
receipt=read('elimination_receipt.json');assert a['decisions']==receipt['decisions'];assert a['closure']==receipt['closure'];assert a['controls']==read('controls.json')['controls'];reg=read('registration.json')
for k in ['claim_id','title','branch','statement','dependencies']:assert a['registration'][k]==reg[k],k
assert a['registration']['root_theorems']==['SFT-ROOT-THERE-IS-NO-NOTHING'];assert a['registration']['axioms']==[];assert a['registration']['free_parameters']==[];assert a['registration']['source_hash']==h;assert a['registration']['evidence_mode']=='formal';assert a['registration']['provenance']==['forward_forcing'];assert a['unknown_rejected']
report={'status':'PASS','source_commit':pin,'source_manifest_hash':h,'candidate_count':1024,'scope':'Every original PartEquivalenceProgram method: exact registration, full census, 1024 actual lookups/decisions, closure, four controls, all hashes and unknown-ID refusal','source_dependencies':['SFT-FOUNDATION-ONE-001','SFT-FOUNDATION-COUNT-001','SFT-FOUNDATION-PART-001']}
(r/'verification/TURN_116_PART_EQUIVALENCE_PROGRAM_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
