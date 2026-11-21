from pathlib import Path
import sys,json,copy
w=Path('work');base=w/'pinned1374';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft;sft.__path__.insert(0,str((base/'sft').resolve()))
from sft.consciousness_cognitive_science.empirical_program import CONSCIOUSNESS_SPECS,validate_pre_source_seal,_target_row
from sft.engine.canonical import sha256_identity,canonical_value
spec=next(s for s in CONSCIOUSNESS_SPECS if s.claim_id=='SFT-CONSC-OBSERVATION-ACT-001')
sealpath='experiments/sealed_predictions/consciousness_foundation_complete_pre_source.json';auditpath='experiments/consciousness/source_feature_audit.json';targetpath='experiments/consciousness/claim_specific_external_targets.json'
paths=[x['path']for x in json.loads((w/'consciousness1374_source_pin.json').read_text())['files']]
rows=[];expected=[]
for case in ['original','seal_identity','opened_source','claim_count','candidate_count','prediction_set','sealed_file','audit_identity','target_identity']:
 root=w/'consciousness1374_source_cases'/case;root.mkdir(parents=True,exist_ok=True)
 for rel in paths:
  p=root/rel;p.parent.mkdir(parents=True,exist_ok=True)
  if not p.exists():p.symlink_to((base/rel).resolve())
 seal=json.loads((base/sealpath).read_text());audit=json.loads((base/auditpath).read_text());targets=json.loads((base/targetpath).read_text())
 if case=='seal_identity':seal['complete_branch_pre_source_seal_hash']='changed'
 if case=='opened_source':seal['external_outcomes_opened']=True
 if case=='claim_count':seal['required_claim_count']+=1
 if case=='candidate_count':seal['candidate_count']+=1
 if case=='prediction_set':seal['claim_prediction_set_hash']='changed'
 if case=='sealed_file':seal['sealed_files'][next(iter(seal['sealed_files']))]='changed'
 if case in ['opened_source','claim_count','candidate_count','prediction_set','sealed_file']:
  seal.pop('complete_branch_pre_source_seal_hash');seal['complete_branch_pre_source_seal_hash']=sha256_identity(seal)
 if case=='audit_identity':audit['audit_hash']='changed'
 if case=='target_identity':targets['targets_hash']='changed'
 for rel,payload in [(sealpath,seal),(auditpath,audit),(targetpath,targets)]:
  p=root/rel
  if p.is_symlink():p.unlink()
  # Preserve original raw bytes unless intentionally modified.
  original=json.loads((base/rel).read_text())
  p.write_bytes((base/rel).read_bytes()if payload==original else (json.dumps(payload,indent=2)+'\n').encode())
 try:
  sealhash=validate_pre_source_seal(root);row,extraction=_target_row(root,spec)
  result={'ok':{'seal':sealhash,'row':canonical_value(row),'extraction':extraction}}
 except ValueError as e:result={'error':str(e)}
 rows.append({'case':case,'root':str(root),'claim_id':spec.claim_id,'target_id':spec.target_id,'expected_label':spec.expected_external_label,'seal':seal,'audit':audit,'targets':targets,'files':[{'path':rel,'local':str(root/rel)}for rel in paths]});expected.append(result)
(w/'consciousness1374_source_inputs.json').write_text(json.dumps(rows)+'\n');(w/'consciousness1374_source_expected.json').write_text(json.dumps(expected,indent=2)+'\n');print('Original source operation cases',len(rows),'successful',sum('ok'in x for x in expected))
