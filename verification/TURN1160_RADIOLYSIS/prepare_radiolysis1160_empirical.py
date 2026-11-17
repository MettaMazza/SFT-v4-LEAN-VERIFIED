from pathlib import Path
import sys,json,platform,hashlib
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1160';sys.path[:0]=[str((w/'v3-runtime500').resolve()),str((w/'radiochemical1122_pdf6142').resolve())]
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
import sft.chemistry.nuchem_terminal_validation_v1 as validator
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
prior=json.loads((w/'radiotracer1140_empirical_report.json').read_text());assert prior['status']=='PASS'
for module,h in prior['source_sha256'].items():assert hashlib.sha256((w/'turn1064_recovery/SFT/Chemistry'/f'{module}.lean').read_bytes()).hexdigest()==h
payload=json.loads((w/'radiotracer1140_empirical_input.json').read_text());surface_by_path={}
for x in payload['surfaces']:
 p=stage/x['path'];assert 'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()==x['snapshot_sha256'];surface_by_path[p.resolve()]=tuple(x['expected_surface'])
validator._surface=lambda path:surface_by_path[path.resolve()]
(w/'radiolysis1160_extraction_reuse.json').write_text(json.dumps({'status':'PASS','source_native_report':'radiotracer1140_empirical_report.json','unchanged_native_modules':prior['source_sha256'],'source_hashes':{x['path']:x['snapshot_sha256']for x in payload['surfaces']},'method':'Exact prior source extraction reused for unchanged four PDFs; new original012analysis and empirical receipt computed.'},indent=2))
before=snapshot_protected_tree(stage);reference=snapshot_protected_tree(w/'v3-runtime500');assert before.file_hashes==reference.file_hashes
seal='native-radiolysis1160';result=validator.RadiolysisValidator(stage).validate(SimpleNamespace(seal_hash=seal));after=snapshot_protected_tree(stage);assert before==after and result.passed
payload.update(derivation_seal=seal,host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(after));(w/'radiolysis1160_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False))
out=canonical_value(result);(w/'radiolysis1160_original_empirical.json').write_text(json.dumps(out,indent=2));(w/'radiolysis1160_original_report.json').write_text(json.dumps({'status':'PASS','fields':len(out),'messages':len(out['measurements']),'protected_tree_unchanged':True,'source_extraction_reused':True},indent=2));print('PASS original012 empirical12fields with unchanged source extraction reused')
