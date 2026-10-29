from pathlib import Path
import json,hashlib,subprocess
r=Path(__file__).resolve().parents[1]
import sys,shutil
root=Path(sys.argv[1]).resolve()
source_path='claims/SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001/empirical_validation.json'
pinned=subprocess.check_output(['git','-C',str(root),'show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+source_path])
y=json.loads(pinned)
lake=shutil.which('lake') or str(Path.home()/'.elan/bin/lake')
def fresh(program,args):
 return json.loads(subprocess.check_output([lake,'env','lean','--run','verification/'+program,*args],cwd=r,text=True))
c=fresh('TURN_278_CustodyProgram.lean',[y['validated_seal_hash'],str(root/'experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt')])
x=fresh('TURN_278_ValidationProgram.lean',[y['validated_seal_hash'],str(root)])
y.pop('claim_id');assert x['validation']==y,[(k,y[k],x['validation'].get(k)) for k in y if y[k]!=x['validation'].get(k)]
def ident(v):return 'sha256:'+hashlib.sha256(json.dumps(v,sort_keys=True,separators=(',',':'),ensure_ascii=True).encode()).hexdigest()
assert c['registration_hash']==y['experiment_registration_hash'];iso=y['isolation_certificate']
for k in ['program_hash','input_manifest_hash','output_hash','trace_hash']:assert c['execution'][k]==iso[k],k
assert c['prediction_seal']['seal_hash']==iso['prediction_seal_hash'];assert c['commitment']['target_identity_hash']==iso['registered_target_identity_hash'];assert c['release']['release_hash']==y['target_custody_certificate']['target_release_manifest_hash']
assert len(c['execution']['trace'])==4 and x['trace']==c['execution']['trace']
rows=[]
for rel in ['census','receipts/engine/model_admitted']:
 for p in sorted(z for z in (root/rel).rglob('*') if z.is_file()):rows.append([p.relative_to(root).as_posix(),'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()])
snapshot={'root_identity':root.name,'file_hashes':rows};snapshot['snapshot_hash']=ident(snapshot)
assert x['snapshot_before_hash']==x['snapshot_after_hash']==snapshot['snapshot_hash']
audit={'auditor_id':'sft-v3-hostile-empirical-package-auditor/1','package_hash':ident(c['program_document']),'program_hash':iso['program_hash'],'executable_source_present':False,'additional_fields_present':False,'protected_tree_unchanged':True,'passed':True};audit['certificate_hash']=ident(audit);assert x['audit']==audit
assert len(x['comparison_rows'])==2 and all(z['passed'] for z in x['comparison_rows']) and x['numeric_passed']
assert x['tampered_control']=={'target_id':'deliberately-tampered-unfavorable-control','predicted':c['registration']['expected_observation_label'],'observed':'changed-external-observation','passed':True}
expected={'changed_tree':'HostilePackageHalt: empirical package failed data-only or protected-tree audit','changed_source':'ValueError: external measurement snapshot differs from registration','wrong_prediction_family':'ValueError: prediction emitted an invalid physical observation label','pair_prediction':'ValueError: prediction emitted an invalid physical observation label','missing_row':'KeyError: NIST-CODATA-2022-MUON-ELECTRON-MASS-RATIO','numeric_disagreement':'ValueError: terminal numeric interval result differs from sealed label comparison','executable_key':True,'extra_field':True,'missing_field':True,'changed_predictions_fail':True,'registered_spec':'ok','vault_empty_identity':'CustodyHalt: target vault requires experiment, custodian and nonce identities','vault_empty_targets':'CustodyHalt: target vault requires complete named target support','vault_invalid_envelope':'CustodyHalt: target vault requires the preregistered prediction-envelope identity','release_invalid_identity':'CustodyHalt: release target identity is invalid'}
assert x['checks']==expected
checks=c['checks'];assert {k for k,v in checks.items() if v=='ok'}=={'exchange','context','source'}
assert len(checks)==15
for k,v in checks.items():
 if k not in ['exchange','context','source']:assert v.startswith(('CustodyHalt:','ValueError:','TargetAccessViolation:')),(k,v)
report={'status':'PASS','source_commit':'76f1b34e9e9682989adcbb088797b4ae4ce4fcf1','empirical_receipt_source':source_path,'empirical_receipt_source_sha256':hashlib.sha256(pinned).hexdigest(),'empirical_receipt_all_fields_equal':True,'complete_prediction_trace_rows':4,'native_custody_and_validation_checks':len(checks)+len(expected),'protected_tree_file_count':len(rows),'protected_snapshot_identity':snapshot['snapshot_hash'],'numeric_and_label_results_agree':True,'actual_v3_scientific_python_executed':False,'metadata_scope':'Darwin/CPython are the original pinned V3 receipt metadata, replayed for byte correspondence; execution is native Lean.'}
for name,val in [('CUSTODY_OUTPUT',c),('VALIDATION_OUTPUT',x),('VALIDATION_REPORT',report)]: (r/('verification/TURN_278_'+name+'.json')).write_text(json.dumps(val,indent=2)+'\n')
print(json.dumps(report,indent=2))
