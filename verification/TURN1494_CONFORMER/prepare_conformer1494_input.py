from pathlib import Path
import sys,json,platform
w=Path('work');pin=w/'pinned_conformer1493';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((pin/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import conformer_generation_equivalence_validation_v1 as v
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
before=snapshot_protected_tree(pin)
payload=dict(identities=json.loads((pin/v.IDENTITY_PATH).read_text()),targets=json.loads((pin/v.TARGET_PATH).read_text()),primary=json.loads((pin/v.PRIMARY_PATH).read_text()),derivation_seal='native-conformer1493',host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(before))
(w/'conformer1493_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n')
