from pathlib import Path
import sys,subprocess,json,os
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import two_hand_dirac_square
expected={k:dict(numerator=v.numerator,denominator=v.denominator) for k,v in two_hand_dirac_square().items()};out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'TwoHandCompare886.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True);actual=json.loads(out);assert actual==expected;(w/'twohand886_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/relativistic_field_laws_v1.py:two_hand_dirac_square',scope='Entire original three-field generated record',actual=actual,expected=expected),indent=2));print('PASS entire original two-hand square record')
