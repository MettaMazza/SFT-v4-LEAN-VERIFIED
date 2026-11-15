from pathlib import Path
from types import SimpleNamespace
import json,subprocess,sys
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.landauer_demon_empirical_v1 import SPEC
from sft.physics.generated_empirical_law import GeneratedEmpiricalPhysicsProgram,BlindExternalMeasurementValidator
from sft.engine.canonical import canonical_value
root=Path('work/v3-runtime500').resolve();w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def read(name):return json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/'+SPEC.claim_id+'/'+name]))
source=read('certificate.json')['source_manifest_hash'];p=GeneratedEmpiricalPhysicsProgram(SPEC,source);census=p.generate_candidates();decisions=tuple(p.decide_candidate(c) for c in census.candidates)
actual=canonical_value(dict(registration=p.registration,census=census,decisions=decisions,closure=p.closure_evidence(decisions),controls=p.run_controls(),unknown_id='StopIteration'));(w/'landauervalidation994_original_program.json').write_text(json.dumps(actual,indent=2))
frozen=read('empirical_validation.json');actual=canonical_value(BlindExternalMeasurementValidator(root,SPEC).validate(SimpleNamespace(seal_hash=frozen['validated_seal_hash'])));frozen.pop('claim_id');assert actual==frozen;(w/'landauervalidation994_original_empirical.json').write_text(json.dumps(actual,indent=2));print('PASS fresh original256programme and full4row empiricalvalidator')
