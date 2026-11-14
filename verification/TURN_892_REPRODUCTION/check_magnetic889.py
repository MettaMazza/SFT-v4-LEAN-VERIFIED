from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import magnetic_relativistic_factor
expected=[]
for speed in [F(1,2),F(1,3),F(2,3),F(3,4),F(7,10),F(71,100),F(1),F(2),F(0),F(-1),1]:
 try:expected.append({k:dict(numerator=v.numerator,denominator=v.denominator) for k,v in magnetic_relativistic_factor(speed).items()})
 except ValueError as e:expected.append(dict(error=str(e)))
o=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'MagneticCompare889.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True)
actual=[json.loads(x) for x in o.splitlines()];assert actual==expected
(w/'magnetic889_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/relativistic_field_laws_v1.py:magnetic_relativistic_factor',scope='Six full admitted source records on both sides of the Fold branch and five original guard cases.',actual=actual,expected=expected),indent=2));print('PASS11 original magnetic cases')
