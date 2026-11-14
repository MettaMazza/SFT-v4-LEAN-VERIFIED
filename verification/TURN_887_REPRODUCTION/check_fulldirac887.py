from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import full_dirac_square,held_difference
def enc(x):
 if isinstance(x,F):return dict(numerator=x.numerator,denominator=x.denominator)
 if isinstance(x,tuple):return [enc(v) for v in x]
 if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
 return x
expected=[enc(full_dirac_square())]+[enc(held_difference(a,b)) for a,b in [(F(1,2),F(1,3)),(F(1,3),F(1,2)),(F(1,3),F(1,3))]]
o=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'FullDiracCompare887.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True);actual=[json.loads(x) for x in o.splitlines()];assert actual==expected;(w/'fulldirac887_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/relativistic_field_laws_v1.py:full_dirac_square,held_difference',scope='Whole four-field original record and all three held-difference orientations;empty records retained as arrays,not numeric zero.',actual=actual,expected=expected),indent=2));print('PASS original full square and three difference cases')
