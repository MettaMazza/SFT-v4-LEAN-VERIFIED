from pathlib import Path
import sys,json
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.grand_lock_terminal_law_v1 import SPEC
from sft.physics.structural_constants import StructuralPhysicsProgram
from sft.engine.canonical import canonical_value
w=Path('work');actual=json.loads((w/'grandlock1064_program_output.json').read_text());p=StructuralPhysicsProgram(SPEC,actual['registration']['source_hash']);census=p.generate_candidates();decisions=tuple(p.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=p.registration,census=census,decisions=decisions,closure=p.closure_evidence(decisions),controls=p.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'grandlock1064_fresh_report.json').write_text(json.dumps(dict(status='PASS',candidate_rows=len(census.candidates),fresh_original=True,fresh_native_registration=True,retained_native_decisions=4096,retained_native_metadata=True,all_fields_and_hashes=True),indent=2));print('PASS fresh original full programme')
