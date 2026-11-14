from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import coulomb_gauss_closure
def enc(x):return {k:dict(numerator=v.numerator,denominator=v.denominator) for k,v in x.items()}
cases=[(F(1,8),x) for x in [F(1,4),F(1,2),F(1),F(1,8),F(1,16),F(2),F(0),F(-1),1]]+[(F(0),F(1,2)),(F(-1,8),F(1,2))]
expected=[]
for s,radius in cases:
 try:expected.append(enc(coulomb_gauss_closure(s,radius)))
 except ValueError as e:expected.append(dict(error=str(e)))
o=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'CoulombCompare888.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True)
actual=[json.loads(x) for x in o.splitlines()];assert actual==expected
(w/'coulomb888_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/relativistic_field_laws_v1.py:coulomb_gauss_closure',scope='Three full admitted field/flux/potential records and eight original guard cases.',actual=actual,expected=expected),indent=2));print('PASS11 original operation cases')
