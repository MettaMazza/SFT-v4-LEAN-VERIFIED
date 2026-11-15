from pathlib import Path
from types import SimpleNamespace
import json,subprocess,sys
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.parker_proton_energy_terminal_law_v1 import SPEC
from sft.physics.structural_constants import StructuralPhysicsProgram
from sft.physics.parker_proton_energy_terminal_validation_v1 import ParkerProtonEnergyValidator,source_hashes
import hashlib
from sft.engine.canonical import canonical_value
root=Path('work/v3-runtime500').resolve();w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def read(name):return json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/'+SPEC.claim_id+'/'+name]))
for rel,expected in source_hashes().items():
 f=root/rel
 if not f.is_file():
  f.parent.mkdir(parents=True,exist_ok=True);f.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]))
 assert 'sha256:'+hashlib.sha256(f.read_bytes()).hexdigest()==expected
frozen=read('empirical_validation.json');actual=canonical_value(ParkerProtonEnergyValidator(root).validate(SimpleNamespace(claim_id=SPEC.claim_id,seal_hash=frozen['validated_seal_hash'])));frozen.pop('claim_id');assert actual==frozen;(w/'parker1008_original_empirical.json').write_text(json.dumps(actual,indent=2));print('PASS fresh original complete Parker empirical validator')
