from pathlib import Path
import sys,json,shutil,platform
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1135';runtime=w/'v3-runtime500';sys.path.insert(0,str(runtime.resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import coordination_entity_validation_v1 as v
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
for rel in ['census','receipts/engine/model_admitted']:
 dest=stage/rel
 if not dest.exists():shutil.copytree(runtime/rel,dest)
before=snapshot_protected_tree(stage);reference=snapshot_protected_tree(runtime);assert before.file_hashes==reference.file_hashes
original=v.sha256_identity;captured={}
def capture(value):
 if isinstance(value,dict)and {'registration','sealed','prediction','analysis','comparisons','controls','trace'}<=set(value):captured.update(value)
 return original(value)
v.sha256_identity=capture
seal='native-coordination1136';result=v.CoordinationEntityValidator(stage).validate(SimpleNamespace(seal_hash=seal));after=snapshot_protected_tree(stage);assert before==after and result.passed
out=canonical_value(result);(w/'coordination1136_original_empirical.json').write_text(json.dumps(out,indent=2)+'\n')
(w/'coordination1136_original_payload.json').write_text(json.dumps(canonical_value(captured),indent=2)+'\n')
files=[(p,h)for p,h in [(v.TARGET_PATH,v.TARGET_HASH),(v.PRIMARY_PATH,v.PRIMARY_HASH),*v.SOURCE_FILES]]
payload=dict(identities=json.loads((stage/v.IDENTITY_PATH).read_text()),targets=json.loads((stage/v.TARGET_PATH).read_text()),primary=json.loads((stage/v.PRIMARY_PATH).read_text()),source_files=files,identity_path=v.IDENTITY_PATH,derivation_seal=seal,host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(after))
(w/'coordination1136_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n')
report=dict(status='PASS',fields=len(out),measurements=len(out['measurements']),targets=20,protected_tree_unchanged=True,original_source=True)
(w/'coordination1136_original_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
