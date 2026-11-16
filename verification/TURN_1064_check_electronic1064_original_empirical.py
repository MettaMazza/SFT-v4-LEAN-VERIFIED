from pathlib import Path
import sys,json,subprocess,types
w=Path('work');runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry.electronic_structure_batch_1 import ELECTRONIC_STRUCTURE_BATCH_1_SPECS
from sft.chemistry.generated_observational_law import BlindObservationalChemistryValidator
from sft.engine.canonical import canonical_value
spec=ELECTRONIC_STRUCTURE_BATCH_1_SPECS[0];pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
for rel in [spec.observation_registry_path]+[x.snapshot_path for x in spec.target_rows]:
 p=runtime/rel
 if not p.exists():p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]))
expected=json.load(open(w/'electronic_validation1064_expected.json'));actual=canonical_value(BlindObservationalChemistryValidator(runtime,spec).validate(types.SimpleNamespace(seal_hash=expected['validated_seal_hash'])))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'electronic1064_original_empirical_report.json').write_text(json.dumps(dict(status='PASS',source_pin=pin,all_fields_match=True,fresh_original_validator=True),indent=2));print('PASS fresh original entire empirical validator',flush=True)
