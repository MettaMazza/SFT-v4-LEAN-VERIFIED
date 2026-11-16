from pathlib import Path
from types import SimpleNamespace
import json,subprocess,sys,hashlib
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root));pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v3='/Volumes/One Touch/ernos-labs-sft-platform'
from sft.physics.charged_lepton_validation import TERMINAL_VALIDATION_SPEC as SPEC,ChargedLeptonTerminalValidationExternalValidator,comparison_record
from sft.physics.terminal_lepton_law import terminal_product_invariant
from sft.physics.generated_empirical_law import GeneratedEmpiricalPhysicsProgram
from sft.engine.canonical import canonical_value
def read(name):return json.loads(subprocess.check_output(['git','-C',v3,'show',pin+':claims/'+SPEC.claim_id+'/'+name]))
for rel in ['sft/physics/charged_lepton_validation.py','sft/physics/terminal_lepton_law.py','sft/physics/generated_empirical_law.py',SPEC.source_snapshot_path]:
 b=subprocess.check_output(['git','-C',v3,'show',pin+':'+rel]);assert (root/rel).read_bytes()==b,rel
assert 'sha256:'+hashlib.sha256((root/SPEC.source_snapshot_path).read_bytes()).hexdigest()==SPEC.source_snapshot_hash
source=read('certificate.json')['source_manifest_hash'];p=GeneratedEmpiricalPhysicsProgram(SPEC,source);census=p.generate_candidates();decisions=tuple(p.decide_candidate(c) for c in census.candidates)
actual=canonical_value(dict(registration=p.registration,census=census,decisions=decisions,closure=p.closure_evidence(decisions),controls=p.run_controls(),unknown_id='StopIteration'));(w/'leptonvalidation1040_original_program.json').write_text(json.dumps(actual,indent=2))
frozen=read('empirical_validation.json');actual=canonical_value(ChargedLeptonTerminalValidationExternalValidator(root).validate(SimpleNamespace(claim_id=SPEC.claim_id,seal_hash=frozen['validated_seal_hash'])));frozen.pop('claim_id');assert actual==frozen;(w/'leptonvalidation1040_original_empirical.json').write_text(json.dumps(actual,indent=2))
(w/'leptonvalidation1040_original_numeric.json').write_text(json.dumps(comparison_record(root,terminal_product_invariant()),indent=2));print('PASS fresh original256programme, both exact numeric intervals and complete original empiricalvalidator/pinnedrecord')
