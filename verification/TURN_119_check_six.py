"""Run all existing complete program drivers against pinned V3; no scientific Python execution."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import json,subprocess,hashlib,resource,sys
from current_checks import PROJECT as r, LAKE, source
info,v=source();pin=info['commit'];out=r/'verification/current/batch119';out.mkdir(parents=True,exist_ok=True)
def read(claim,file):return json.loads(subprocess.check_output(['git','-C',str(v),'show',pin+':claims/'+claim+'/'+file]))
def check(item):
 claim,driver=item;log=(out/(claim+'.log')).open('w');cp=out/(claim+'.c');exe=out/claim
 try:
  for command in [[LAKE,'env','lean','-c',str(cp),str(driver)],[LAKE,'env','leanc','-o',str(exe),str(cp),str(r/'.lake/build/lib/libsft__v4_SFT.a')]]:subprocess.run(command,cwd=r,check=True,stdout=log,stderr=subprocess.STDOUT)
  source_hash=read(claim,'certificate.json')['source_manifest_hash'];raw=subprocess.check_output([str(exe),source_hash],cwd=r,text=True,stderr=log);actual=json.loads(raw)
  (out/(claim+'.output.json')).write_text(json.dumps(actual,indent=2)+'\n')
  census=read(claim,'candidate_census.json');census.pop('claim_id');receipt=read(claim,'elimination_receipt.json');reg=read(claim,'registration.json')
  expected={'census':census,'decisions':receipt['decisions'],'closure':receipt['closure'],'controls':read(claim,'controls.json')['controls']}
  for k,value in expected.items():assert actual[k]==value,k+' differs'
  for k in ['claim_id','title','branch','statement','dependencies']:assert actual['registration'][k]==reg[k],k+' differs'
  rr=actual['registration'];assert rr['source_hash']==source_hash and rr['evidence_mode']=='formal';assert rr['axioms']==rr['free_parameters']==[];assert rr['root_theorems']==([] if claim=='SFT-ROOT-THERE-IS-NO-NOTHING' else ['SFT-ROOT-THERE-IS-NO-NOTHING']);assert rr['provenance']==reg['provenance_classes'],'provenance differs from pinned registration'
  if 'unknown_rejected' in actual:assert actual['unknown_rejected'] is True
  if 'unknown_id' in actual:assert actual['unknown_id']=='StopIteration' or actual['unknown_id'].startswith('KeyError:')
  result={'claim_id':claim,'status':'PASS','candidate_rows':len(actual['decisions']),'source_manifest_hash':source_hash,'driver':str(driver.relative_to(r)),'driver_sha256':hashlib.sha256(driver.read_bytes()).hexdigest(),'matched':['registration','complete census','all decisions','closure','four controls','every embedded hash'],'unknown_identifier_check':'PASS' if 'unknown_id' in actual or 'unknown_rejected' in actual else 'separate Root HostChecks'}
 except Exception as exc:result={'claim_id':claim,'status':'FAIL','error':str(exc)}
 finally:log.close()
 (out/(claim+'.report.json')).write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True);return result
entries=[('SFT-FOUNDATION-EXACT-OPERATIONS-001', 'TURN_119_ExactOperationsProgram.lean'), ('SFT-FOUNDATION-HALF-ONE-001', 'TURN_119_HalfOneProgram.lean'), ('SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001', 'TURN_119_MeasurementEvidenceProgram.lean'), ('SFT-FOUNDATION-FOLD-DYNAMICS-001', 'TURN_119_FoldDynamicsEvidenceProgram.lean'), ('SFT-FOUNDATION-PRIMITIVE-MAP-UNIQUENESS-001', 'TURN_119_PrimitiveMapEvidenceProgram.lean'), ('SFT-FOUNDATION-DERIVATION-TRACE-001', 'TURN_119_DerivationTraceEvidenceProgram.lean')]
entries=[(claim,r/"verification"/driver) for claim,driver in entries]
with ThreadPoolExecutor(max_workers=3) as pool: results=list(pool.map(check,entries))
report={"status":"PASS" if all(x["status"]=="PASS" for x in results) else "FAIL", "source_commit":pin,"results":results}
(out/"REPORT.json").write_text(json.dumps(report,indent=2)+"\n")
assert report["status"]=="PASS"
