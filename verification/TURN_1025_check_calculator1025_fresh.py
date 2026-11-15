from pathlib import Path
import sys,json
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.mathematics.calculator_complete.law import SPEC
from sft.mathematics.generated_law import GeneratedMathematicsProgram
from sft.engine.canonical import canonical_value
w=Path('work');actual=json.loads((w/'calculator1025_program_output.json').read_text());p=GeneratedMathematicsProgram(SPEC,actual['registration']['source_hash']);census=p.generate_candidates();decisions=tuple(p.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=p.registration,census=census,decisions=decisions,closure=p.closure_evidence(decisions),controls=p.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'calculator1025_fresh_report.json').write_text(json.dumps(dict(status='PASS',candidate_rows=1024,fresh_original=True,fresh_native=True,all_fields_and_hashes=True),indent=2));print('PASS fresh original full programme')
