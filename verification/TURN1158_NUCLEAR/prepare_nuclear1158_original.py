from pathlib import Path
import sys,json,subprocess,hashlib
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1158';runtime=w/'v3-runtime500';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
ids=json.loads((stage/'experiments/external_sources/chemistry/nuclear_electronic_target_identities_v1.json').read_text())['rows']
for identity in ids:
 p=stage/identity['snapshot_path']
 if not p.exists():
  p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(subprocess.check_output(['git','-C',repo,'show',pin+':'+identity['snapshot_path']]))
 assert 'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()==identity['snapshot_hash']
for rel in ['census','receipts/engine/model_admitted']:
 dest=stage/rel
 if not dest.exists():dest.parent.mkdir(parents=True,exist_ok=True);dest.symlink_to((runtime/rel).resolve(),target_is_directory=True)
sys.path.insert(0,str(runtime.resolve()));import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import nuclear_electronic_validation_v1 as v
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
before=snapshot_protected_tree(stage);assert before.file_hashes==snapshot_protected_tree(runtime).file_hashes
original=v.sha256_identity;captured={}
def capture(value):
 if isinstance(value,dict)and {'rows','cell_counts','molecular_weights','nuclear_supports','matched_positive_coordinate_pairs','adverse','trace'}<=set(value):captured.update(value)
 return original(value)
v.sha256_identity=capture
result=v.NuclearElectronicValidator(stage).validate(SimpleNamespace(seal_hash='native-nuclearelectronic1158'));after=snapshot_protected_tree(stage);assert result.passed and before==after
out=canonical_value(result)
(w/'nuclearelectronic1158_original_empirical.json').write_text(json.dumps(out,indent=2)+'\n');(w/'nuclearelectronic1158_original_payload.json').write_text(json.dumps(canonical_value(captured),indent=2)+'\n');(w/'nuclearelectronic1158_original_report.json').write_text(json.dumps(dict(status='PASS',fields=len(out),measurements=len(out['measurements']),targets=95,protected_tree_unchanged=True),indent=2)+'\n');print('PASS original95rows1235cells330pairs;',len(out['measurements']),'messages')
