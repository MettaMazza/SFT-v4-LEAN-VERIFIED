from pathlib import Path
from types import SimpleNamespace
import json,subprocess
import sys
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.matter_flavour_validation_v1 import MAJORANA_SPEC,VALIDATOR_BY_ID
VALIDATION_SPECS=(MAJORANA_SPEC,)
from sft.physics.generated_empirical_law import GeneratedEmpiricalPhysicsProgram
from sft.engine.canonical import canonical_value
root=Path('work/v3-runtime500').resolve();w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
for spec,low,n in zip(VALIDATION_SPECS,['majoranastatusvalidation'],range(929,930)):
 def read(name):return json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/'+spec.claim_id+'/'+name]))
 source=read('certificate.json')['source_manifest_hash'];program=GeneratedEmpiricalPhysicsProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
 native=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'));(w/f'{low}{n}_original_program.json').write_text(json.dumps(native,indent=2))
 frozen=read('empirical_validation.json');result=canonical_value(VALIDATOR_BY_ID[spec.claim_id](root).validate(SimpleNamespace(seal_hash=frozen['validated_seal_hash'])));frozen.pop('claim_id');assert result==frozen;(w/f'{low}{n}_original_empirical.json').write_text(json.dumps(result,indent=2));print(spec.claim_id,'fresh original entire program and empirical validator PASS',flush=True)
