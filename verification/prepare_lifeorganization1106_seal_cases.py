from pathlib import Path
import json,sys,copy,tempfile,shutil
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.biology
sft.biology.__path__=[str((w/'pinned1105/sft/biology').resolve())]+list(sft.biology.__path__)
from sft.biology.generated_law import validate_pre_source_seal,PRE_SOURCE_SEAL_PATH
from sft.engine.canonical import sha256_identity
s=json.loads((w/'lifeorganization1106_seal_input.json').read_text());cases=[]
for name in ['original','missing_hash','wrong_hash','source_selected','target_opened','claim_count','candidate_count','prediction_set','source_file_hash']:
 p=copy.deepcopy(s['payload'])
 if name=='missing_hash':p.pop('sealed_payload_hash')
 elif name=='wrong_hash':p['sealed_payload_hash']='sha256:changed'
 elif name!='original':
  k,v={'source_selected':('external_source_identities_selected',True),'target_opened':('external_target_content_opened',True),'claim_count':('required_claim_count',74),'candidate_count':('candidate_count',19199),'prediction_set':('claim_prediction_set_hash','sha256:changed'),'source_file_hash':('derivation_hash','sha256:changed')}[name]
  p[k]=v;p.pop('sealed_payload_hash');p['sealed_payload_hash']=sha256_identity(p)
 with tempfile.TemporaryDirectory(prefix='sft-biology-seal-')as temp:
  root=Path(temp)
  for f in s['files']:
   dst=root/f['path'];dst.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(f['local'],dst)
  (root/PRE_SOURCE_SEAL_PATH).write_text(json.dumps(p))
  try:expected={'ok':validate_pre_source_seal(root)}
  except (KeyError,ValueError)as e:expected={'error':('KeyError: '+str(e).strip("'"))if isinstance(e,KeyError)else str(e)}
 cases.append({'name':name,'payload':p,'expected':expected})
s['cases']=cases;(w/'lifeorganization1106_seal_input.json').write_text(json.dumps(s,ensure_ascii=False)+'\n');print('Prepared nine original pre-source seal outcomes.')
