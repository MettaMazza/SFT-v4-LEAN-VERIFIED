from pathlib import Path
from types import SimpleNamespace
import json,subprocess,sys
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.collective_radiation_empirical_v1 import SPEC,ObservationalEmpiricalPhysicsProgram
from sft.physics.collective_radiation_validation_v1 import CollectiveRadiationValidator,source_hashes
import hashlib
from sft.engine.canonical import canonical_value
root=Path('work/v3-runtime500').resolve();w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def read(name):return json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/'+SPEC.claim_id+'/'+name]))
for rel,expected in source_hashes().items():
 f=root/rel
 if not f.is_file():
  f.parent.mkdir(parents=True,exist_ok=True);f.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]))
 assert 'sha256:'+hashlib.sha256(f.read_bytes()).hexdigest()==expected
source=read('certificate.json')['source_manifest_hash'];p=ObservationalEmpiricalPhysicsProgram(SPEC,source);census=p.generate_candidates();decisions=tuple(p.decide_candidate(c) for c in census.candidates)
actual=canonical_value(dict(registration=p.registration,census=census,decisions=decisions,closure=p.closure_evidence(decisions),controls=p.run_controls(),unknown_id='StopIteration'));(w/'collectiveobservation1035_original_program.json').write_text(json.dumps(actual,indent=2))
frozen=read('empirical_validation.json');actual=canonical_value(CollectiveRadiationValidator(root).validate(SimpleNamespace(claim_id=SPEC.claim_id,seal_hash=frozen['validated_seal_hash'])));frozen.pop('claim_id');assert actual==frozen;(w/'collectiveobservation1035_original_empirical.json').write_text(json.dumps(actual,indent=2));print('PASS fresh original256programme and full5row empiricalvalidator')
