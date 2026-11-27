from pathlib import Path
import json,sys,platform
w=Path('work');stage=w/'pinned_inorgnetwork1490';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import inorganic_acid_base_redox_network_validation_v1 as v
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
before=snapshot_protected_tree(stage)
payload=dict(identities=json.loads((stage/v.IDENTITY_PATH).read_text()),targets=json.loads((stage/v.TARGET_PATH).read_text()),primary=json.loads((stage/v.PRIMARY_PATH).read_text()),derivation_seal='native-inorgnetwork1490',host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(before));(w/'inorgnetwork1490_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False)+'\n')
