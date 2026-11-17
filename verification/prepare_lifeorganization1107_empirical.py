from pathlib import Path
import sys,json,shutil,platform
from types import SimpleNamespace
w=Path('work');runtime=w/'v3-runtime500';stage=w/'pinned1105';sys.path.insert(0,str(runtime.resolve()))
import sft.biology
sft.biology.__path__=[str((stage/'sft/biology').resolve())]+list(sft.biology.__path__)
from sft.biology.generated_law import BIOLOGY_SPECS,BlindBiologyAuthorityValidator
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
for rel in ['census','receipts/engine/model_admitted']:
 dst=stage/rel
 if not dst.exists():shutil.copytree(runtime/rel,dst)
before=snapshot_protected_tree(stage);reference=snapshot_protected_tree(runtime);assert before.file_hashes==reference.file_hashes
spec=next(x for x in BIOLOGY_SPECS if x.claim_id=='SFT-BIO-LIFE-ORGANIZATION-001');result=BlindBiologyAuthorityValidator(stage,spec).validate(SimpleNamespace(seal_hash='native-lifeorganization1107'));after=snapshot_protected_tree(stage);assert before==after and result.passed
out=canonical_value(result);(w/'lifeorganization1107_original_empirical.json').write_text(json.dumps(out,indent=2)+'\n')
source=json.loads((w/'lifeorganization1106_source_input.json').read_text());seal=json.loads((w/'lifeorganization1106_seal_input.json').read_text());files={x['path']:x for x in source['files']+seal['files']};payload={'files':list(files.values()),'pre_source_payload':seal['payload'],'derivation_seal':'native-lifeorganization1107','host':platform.system(),'implementation':platform.python_implementation(),'before':canonical_value(before),'after':canonical_value(after)}
(w/'lifeorganization1107_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n');(w/'lifeorganization1107_original_report.json').write_text(json.dumps({'status':'PASS','fields':len(out),'measurements':len(out['measurements']),'protected_tree_unchanged':True,'complete_authority_tree_matches_original':True,'registered_snapshot_restoration':'biology_snapshot_restoration1106.json'},indent=2)+'\n');print('Original biology validator PASS:',len(out),'fields,',len(out['measurements']),'messages; full protected authority unchanged.')
