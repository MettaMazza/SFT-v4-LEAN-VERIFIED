from pathlib import Path
import sys,json,platform
from types import SimpleNamespace
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.astronomy_cosmology.empirical_program import ASTRONOMY_SPECS,BlindAstronomyBoundaryValidator
from sft.physics import generated_empirical_law as e
from sft.engine.canonical import canonical_value
spec=next(x for x in ASTRONOMY_SPECS if x.claim_id=='SFT-ASTRO-MORPHOLOGY-001');snapshots=[];original=e.snapshot_protected_tree
# Recording wrapper returns the exact original snapshot unchanged.
def capture(root):
 value=original(root);snapshots.append(canonical_value(value));return value
e.snapshot_protected_tree=capture
result=BlindAstronomyBoundaryValidator(Path('/Volumes/One Touch/ernos-labs-sft-platform'),spec).validate(SimpleNamespace(seal_hash='native-astromorphology1587'))
assert len(snapshots)==2
(w/'astromorphology1587_empirical_expected.json').write_text(json.dumps(canonical_value(result),indent=2)+'\n')
p=w/'pinned1587'/spec.source_snapshot_path
(w/'astromorphology1587_empirical_input.json').write_text(json.dumps(dict(path=spec.source_snapshot_path,row=json.loads(p.read_text()),before=snapshots[0],after=snapshots[1],derivation='native-astromorphology1587',host=platform.system(),implementation=platform.python_implementation()),indent=2)+'\n')
(w/'astromorphology1587_registration_expected.json').write_text(json.dumps(e.experiment_registration_record(spec),indent=2)+'\n')
print('Original full empirical validator',result.passed,'messages',len(result.measurements),'fields',len(canonical_value(result)))
