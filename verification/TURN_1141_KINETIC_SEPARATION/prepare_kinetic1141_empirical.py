from pathlib import Path
import sys,json,shutil,platform
from types import SimpleNamespace
w=Path('work');runtime=w/'v3-runtime500';stage=w/'pinned1120';sys.path.insert(0,str(runtime.resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.nuchem_fractionation_validation_v1 import KineticIsotopeFractionationValidator
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
for rel in ['census','receipts/engine/model_admitted']:
 dst=stage/rel
 if not dst.exists():shutil.copytree(runtime/rel,dst)
before=snapshot_protected_tree(stage);reference=snapshot_protected_tree(runtime);assert before.file_hashes==reference.file_hashes
# Reuse the already verified extraction, bound to unchanged source bytes and reader.
import hashlib
prior=json.loads((w/'isotopeexchange1125_empirical_report.json').read_text());assert prior['status']=='PASS'
for module,h in prior['source_sha256'].items():
 assert hashlib.sha256((w/'turn1064_recovery/SFT/Chemistry'/f'{module}.lean').read_bytes()).hexdigest()==h
payload=json.loads((w/'radiochemical1122_analysis_input.json').read_text())
import sft.chemistry.nuchem_fractionation_validation_v1 as validator
surface_by_path={}
for x in payload['surfaces']:
 path=stage/x['path'];assert 'sha256:'+hashlib.sha256(path.read_bytes()).hexdigest()==x['snapshot_sha256']
 surface_by_path[path.resolve()]=tuple(x['expected_surface'])
validator._surface=lambda path,kind:surface_by_path[path.resolve()]
(w/'kinetic1141_extraction_reuse.json').write_text(json.dumps({'status':'PASS','previous_native_empirical_report':'isotopeexchange1125_empirical_report.json','unchanged_native_modules':prior['source_sha256'],'source_hashes':{x['path']:x['snapshot_sha256'] for x in payload['surfaces']},'method':'Reuse exact prior verified extraction surfaces for unchanged files; current Python pypdf5.9.0 is not substituted for historical extraction.'},indent=2))
seal='native-kinetic1141';result=KineticIsotopeFractionationValidator(stage).validate(SimpleNamespace(seal_hash=seal));after=snapshot_protected_tree(stage);assert before==after and result.passed
out=canonical_value(result);(w/'kinetic1141_original_empirical.json').write_text(json.dumps(out,indent=2)+'\n')
payload=json.loads((w/'radiochemical1122_analysis_input.json').read_text());payload.update(derivation_seal=seal,host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(after))
(w/'kinetic1141_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n')
(w/'kinetic1141_original_report.json').write_text(json.dumps({'status':'PASS','fields':len(out),'measurements':len(out['measurements']),'protected_tree_unchanged':True,'complete_authority_tree_matches_original':True},indent=2)+'\n');print('Original full empirical validator PASS',len(out),'fields',len(out['measurements']),'messages')
