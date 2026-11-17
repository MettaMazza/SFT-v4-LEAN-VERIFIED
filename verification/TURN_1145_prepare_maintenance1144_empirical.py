from pathlib import Path
import sys,json,shutil,platform,hashlib
from types import SimpleNamespace
w=Path('work');runtime=w/'v3-runtime500';stage=w/'pinned1144';sys.path.insert(0,str(runtime.resolve()))
import sft.biology
sft.biology.__path__=[str((stage/'sft/biology').resolve())]+list(sft.biology.__path__)
from sft.biology.generated_law import BIOLOGY_SPECS,BlindBiologyAuthorityValidator
from sft.biology.sources import SOURCE_BY_ID
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
pinfile=w/'maintenance1144_source_pin.json';pin=json.loads(pinfile.read_text());materialized=[]
for source in SOURCE_BY_ID.values():
 rel=source.snapshot_path;p=stage/rel;b=p.read_bytes()
 if 'sha256:'+hashlib.sha256(b).hexdigest()!=source.snapshot_hash:
  restored=(w/'pinned1105'/rel).read_bytes();assert 'sha256:'+hashlib.sha256(restored).hexdigest()==source.snapshot_hash
  raw=w/'maintenance1144_raw_git'/rel;raw.parent.mkdir(parents=True,exist_ok=True);raw.write_bytes(b)
  item=next(x for x in pin['files']if x['path']==rel)
  assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==item['git_blob']
  item.update(raw_git_copy=str(raw),registered_execution_sha256=source.snapshot_hash,materialization_evidence='work/biology_snapshot_restoration1106.json')
  p.write_bytes(restored);materialized.append(rel)
pinfile.write_text(json.dumps(pin,indent=2)+'\n')
for rel in ['census','receipts/engine/model_admitted']:
 dst=stage/rel
 if not dst.exists():shutil.copytree(runtime/rel,dst)
before=snapshot_protected_tree(stage);reference=snapshot_protected_tree(runtime);assert before.file_hashes==reference.file_hashes
spec=next(x for x in BIOLOGY_SPECS if x.claim_id=='SFT-BIO-LIFE-MAINTENANCE-001')
result=BlindBiologyAuthorityValidator(stage,spec).validate(SimpleNamespace(seal_hash='native-maintenance1144'));after=snapshot_protected_tree(stage);assert before==after and result.passed
out=canonical_value(result);(w/'maintenance1144_original_empirical.json').write_text(json.dumps(out,indent=2)+'\n')
source=json.loads((w/'lifeorganization1106_source_input.json').read_text());seal=json.loads((w/'lifeorganization1106_seal_input.json').read_text());files={x['path']:dict(x,local=str((stage/x['path']).resolve())) for x in source['files']+seal['files']}
for file in files.values():
 assert Path(file['local']).exists()
 if 'sha256'in file:assert hashlib.sha256(Path(file['local']).read_bytes()).hexdigest()==file['sha256']
payload={'files':list(files.values()),'pre_source_payload':json.loads((stage/'experiments/sealed_predictions/biology_foundation_complete_pre_source.json').read_text()),'derivation_seal':'native-maintenance1144','host':platform.system(),'implementation':platform.python_implementation(),'before':canonical_value(before),'after':canonical_value(after)}
(w/'maintenance1144_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n')
report=dict(status='PASS',fields=len(out),measurements=len(out['measurements']),protected_tree_unchanged=True,complete_authority_tree_matches_original=True,reused_exact_registered_materialization=materialized)
(w/'maintenance1144_original_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
