from pathlib import Path
import subprocess,json,hashlib,re,sys,dataclasses
w=Path('work');stage=w/'pinned1235';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-CHEM-MOLECULAR-QUANTUM-MEASUREMENT-REDUCTION-014';rows={}
def fetch(rel):
 b=subprocess.check_output(['git','-C',repo,'show',pin+':'+rel]);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);rows[rel]=dict(path=rel,sha256=hashlib.sha256(b).hexdigest());return p
for name in ['execution.py','certificate.json','independent_validator.py']:fetch('claims/'+cid+'/'+name)
src=(stage/'claims'/cid/'execution.py').read_text().split(';h=')[0];files=re.findall(r'root\s*/\s*"([^"]+)"',src)
for f in files:fetch(f)
for kind in ['target_identities','withheld_targets']:
 rel='experiments/external_sources/chemistry/molecular_measurement_'+kind+'_v1.json';fetch(rel)
# The source module's ROOT is its sft directory: preserve that lookup by an explicit local link.
p=stage/'sft/experiments'
if not p.exists():p.symlink_to('../experiments',target_is_directory=True)
ids=json.loads((stage/'experiments/external_sources/chemistry/molecular_measurement_target_identities_v1.json').read_text());source=ids['source']
for c in source['components']:
 p=fetch(c['snapshot_path']);b=p.read_bytes()
 if 'sha256:'+hashlib.sha256(b).hexdigest()!=c['snapshot_hash']:
  restored=b.replace(b'\r\n',b'\n').replace(b'\n',b'\r\n');assert 'sha256:'+hashlib.sha256(restored).hexdigest()==c['snapshot_hash']
  raw=w/'quantum1235_raw_git'/c['snapshot_path'];raw.parent.mkdir(parents=True,exist_ok=True);raw.write_bytes(b);p.write_bytes(restored)
  rows[c['snapshot_path']].update(registered_sha256=c['snapshot_hash'],materialized_sha256=hashlib.sha256(restored).hexdigest(),restoration='CRLF original bytes, exact registered SHA256')
p=fetch(source['metadata_snapshot_path']);assert 'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()==source['metadata_snapshot_hash']
for rel in ['census','receipts/engine/model_admitted']:
 p=stage/rel
 if not p.exists():p.parent.mkdir(parents=True,exist_ok=True);p.symlink_to((w/'v3-runtime500'/rel).resolve(),target_is_directory=True)
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.molecular_measurement_batch_v1 import MOLECULAR_MEASUREMENT_SPEC as spec
from sft.chemistry.molecular_measurement_validation_v1 import MolecularMeasurementValidator,_rows
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
from types import SimpleNamespace
spec.validate();cert=json.loads((stage/'claims'/cid/'certificate.json').read_text());assert build_source_manifest(stage,[stage/f for f in files]).manifest_hash==cert['source_manifest_hash']
(w/'quantum1235_spec.json').write_text(json.dumps(dataclasses.asdict(spec),indent=2)+'\n')
before=snapshot_protected_tree(stage);result=MolecularMeasurementValidator(stage).validate(SimpleNamespace(seal_hash='native-quantum1235'));after=snapshot_protected_tree(stage);assert result.passed and before==after
(w/'quantum1235_original_empirical.json').write_text(json.dumps(canonical_value(result),indent=2)+'\n')
(w/'quantum1235_source_pin.json').write_text(json.dumps(dict(commit=pin,execution_files=files,files=list(rows.values())),indent=2)+'\n')
(w/'quantum1235_original_report.json').write_text(json.dumps(dict(status='PASS',rows=330,cells=796,components=9,messages=len(result.measurements),protected_tree_unchanged=True),indent=2)+'\n')
print('PASS pinned source manifest,9 components,330 rows,796 cells,original empirical validator',flush=True)
