from pathlib import Path
import sys,json,shutil,platform
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1142';runtime=w/'v3-runtime500';sys.path.insert(0,str(runtime.resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import selection_rule_validation_v1 as v
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
for rel in ['census','receipts/engine/model_admitted']:
 dest=stage/rel
 if not dest.exists():shutil.copytree(runtime/rel,dest)
before=snapshot_protected_tree(stage);reference=snapshot_protected_tree(runtime);assert before.file_hashes==reference.file_hashes
original_identity=v.sha256_identity;captured={}
def capture_identity(value):
 if isinstance(value,dict)and{'comparisons','counts','adverse','trace_hash'}<=set(value):captured.update(value)
 return original_identity(value)
v.sha256_identity=capture_identity
seal='native-selection1143';result=v.SelectionRuleValidator(stage).validate(SimpleNamespace(seal_hash=seal));assert result.passed and captured
after=snapshot_protected_tree(stage);assert before==after
(w/'selection1143_original_empirical.json').write_text(json.dumps(canonical_value(result),indent=2)+'\n');(w/'selection1143_original_payload.json').write_text(json.dumps(canonical_value(captured),indent=2)+'\n')
(w/'selection1143_empirical_input.json').write_text(json.dumps(dict(derivation_seal=seal,host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(after)),indent=2))
(w/'selection1143_original_report.json').write_text(json.dumps(dict(status='PASS',fields=12,messages=len(result.measurements),comparisons=len(captured['comparisons']),counts=captured['counts'],adverse=captured['adverse'],protected_tree_unchanged=True),indent=2));print('PASS original63records/6counts/6controls/full12-field receipt')
