from pathlib import Path
from types import SimpleNamespace
import json,subprocess,platform,sys
sys.path.insert(0,str(Path("work/v3-runtime500").resolve()))
from sft.physics.gravity_spacetime_laws_v1 import CTC_SPEC
from sft.physics.structural_constants import StructuralPhysicsProgram
from sft.engine.canonical import canonical_value
root=Path('work/v3-runtime500').resolve();w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
for spec,validator,low,n in [(CTC_SPEC,None,'timelike',911)]:
 def read(name):return json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/'+spec.claim_id+'/'+name]))
 source=read('certificate.json')['source_manifest_hash'];program=StructuralPhysicsProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
 native=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
 (w/f'{low}{n}_original_program.json').write_text(json.dumps(native,indent=2))
 print(spec.claim_id,'fresh original complete program PASS',flush=True)
