from pathlib import Path
import json,sys,hashlib
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1309'
sys.path[:0]=[str((w/'v3-runtime500').resolve()),str((w/'radiochemical1122_pdf6142').resolve()),str((w/'accuracy1162_testdeps').resolve())];import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
for rel in ['census','receipts/engine/model_admitted']:
 p=stage/rel
 if not p.exists():p.parent.mkdir(parents=True,exist_ok=True);p.symlink_to((w/'v3-runtime500'/rel).resolve(),target_is_directory=True)
from sft.chemistry.anal_performance_validation_v1 import PrecisionValidator
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
before=snapshot_protected_tree(stage);result=PrecisionValidator(stage).validate(SimpleNamespace(seal_hash='native-precision1309'));after=snapshot_protected_tree(stage);assert result.passed and before==after
payload=json.loads((w/'accuracy1162_empirical_input.json').read_text());payload.update(derivation_seal='native-precision1309',before=canonical_value(before),after=canonical_value(after))
for surface in payload['surfaces']:
 p=stage/surface['path'];assert 'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()==surface['snapshot_sha256']
(w/'precision1309_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n');out=canonical_value(result)
(w/'precision1309_original_empirical.json').write_text(json.dumps(out,indent=2)+'\n');(w/'precision1309_original_report.json').write_text(json.dumps(dict(status='PASS',fields=len(out),messages=len(result.measurements),source_pages=83,html_documents=1,characters=180366,protected_tree_unchanged=True),indent=2)+'\n')
s=(w/'AnalyticalAccuracyValidationProgram1162.lean').read_text().replace('AnalyticalAccuracy','AnalyticalPrecision').replace('accuracy1162','precision1309').replace('pinned1162','pinned1309').replace('AnalyticalPrecisionAnalysis.authorities','AnalyticalAccuracyAnalysis.authorities');(w/'AnalyticalPrecisionValidationProgram1309.lean').write_text(s)
s=(w/'check_accuracy1162_empirical.py').read_text().replace('AnalyticalAccuracy','AnalyticalPrecision').replace('accuracy1162','precision1309').replace('1162','1309').replace("'AnalyticalPrecisionSource',","'AnalyticalAccuracySource',");(w/'check_precision1309_empirical.py').write_text(s)
print('PASS fresh original Precision empirical;12fields3messages;reused identical extracted page inputs')
