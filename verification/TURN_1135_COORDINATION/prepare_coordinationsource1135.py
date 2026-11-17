from pathlib import Path
import sys,json
w=Path('work');stage=w/'pinned1135';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import coordination_entity_validation_v1 as v
rows=v._source_rows(stage)
checks=[(p,h,v.hash_file(stage/p))for p,h in [(v.TARGET_PATH,v.TARGET_HASH),(v.PRIMARY_PATH,v.PRIMARY_HASH),*v.SOURCE_FILES]]
(w/'coordinationsource1135_input.json').write_text(json.dumps(dict(checks=checks,identity_hash=v.hash_file(stage/v.IDENTITY_PATH),identities=json.loads((stage/v.IDENTITY_PATH).read_text()),targets=json.loads((stage/v.TARGET_PATH).read_text()))))
(w/'coordinationsource1135_expected.json').write_text(json.dumps(rows)+'\n')
print('Original20source rows with7ordered source identities')
