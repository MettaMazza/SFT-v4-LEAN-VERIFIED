from pathlib import Path
import sys,json,hashlib,platform
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1234';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.medicine;sft.medicine.__path__=[str((stage/'sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.empirical_program import MEDICINE_SPECS,BlindMedicineAuthorityValidator
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
pin=json.loads((w/'patient1234_source_pin.json').read_text());restored=[]
for row in pin['files']:
 if row.get('matches_registered')is not False:continue
 if row.get('registered_bytes_recovered'):
  assert 'sha256:'+hashlib.sha256((stage/row['path']).read_bytes()).hexdigest()==row['registered_execution_sha256']
  continue
 rel=row['path'];p=stage/rel;b=p.read_bytes();raw=w/'patient1234_raw_git'/rel;raw.parent.mkdir(parents=True,exist_ok=True);raw.write_bytes(b);candidate=(w/'medicine1234_restored'/rel).read_bytes();assert 'sha256:'+hashlib.sha256(candidate).hexdigest()==row['registered_execution_sha256'];assert candidate.replace(b'\r\n',b'\n')==b
 p.write_bytes(candidate);row.update(raw_git_copy=str(raw),materialized_sha256=hashlib.sha256(candidate).hexdigest(),registered_bytes_recovered=True,materialization='Restore original CRLF; CDC line674 retains LF; exact registered SHA256 confirmed.');restored.append(dict(path=rel,original_git_sha256=hashlib.sha256(b).hexdigest(),registered_sha256=hashlib.sha256(candidate).hexdigest(),restored_cr=candidate.count(b'\r')-b.count(b'\r')))
(w/'patient1234_source_pin.json').write_text(json.dumps(pin,indent=2)+'\n')
if restored:(w/'medicine1234_snapshot_restoration.json').write_text(json.dumps(dict(status='EXACT_REGISTERED_BYTES_RECOVERED',files=restored,canonical_v3_unchanged=True),indent=2)+'\n')
else:restored=json.loads((w/'medicine1234_snapshot_restoration.json').read_text())['files']
for rel in ['census','receipts/engine/model_admitted']:
 p=stage/rel
 if not p.exists():p.parent.mkdir(parents=True,exist_ok=True);p.symlink_to((w/'v3-runtime500'/rel).resolve(),target_is_directory=True)
before=snapshot_protected_tree(stage);reference=snapshot_protected_tree(w/'v3-runtime500');assert before.file_hashes==reference.file_hashes
spec=next(x for x in MEDICINE_SPECS if x.claim_id=='SFT-MED-PATIENT-IDENTITY-001');out=BlindMedicineAuthorityValidator(stage,spec).validate(SimpleNamespace(seal_hash='native-patient1234'));after=snapshot_protected_tree(stage);assert before==after and out.passed
out=canonical_value(out);(w/'patient1234_original_empirical.json').write_text(json.dumps(out,indent=2)+'\n')
files=[]
for row in pin['files']:
 p=stage/row['path'];files.append(dict(path=row['path'],local=str(p.resolve()),sha256=hashlib.sha256(p.read_bytes()).hexdigest()))
payload=dict(files=files,pre_source_payload=json.loads((stage/'experiments/sealed_predictions/medicine_foundation_complete_pre_source.json').read_text()),derivation_seal='native-patient1234',host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(after));(w/'patient1234_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n')
report=dict(status='PASS',fields=len(out),messages=len(out['measurements']),protected_tree_unchanged=True,complete_authority_tree_matches_original=True,source_records=13,captured=11,failed=2,restored_registered_snapshots=len(restored));(w/'patient1234_original_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
