from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import lorentz_transfer
cases=[(force,F(1,2)) for force in [F(1,4),F(3),F(0),F(-1),1]]+[(F(1,4),speed) for speed in [F(1,3),F(3,4),F(1),F(0),1]];expected=[]
for force,speed in cases:
 try:expected.append({k:dict(numerator=v.numerator,denominator=v.denominator) for k,v in lorentz_transfer(force,speed).items()})
 except ValueError as e:expected.append(dict(error=str(e)))
o=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'LorentzCompare890.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True)
actual=[json.loads(x) for x in o.splitlines()];assert actual==expected
(w/'lorentz890_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/relativistic_field_laws_v1.py:lorentz_transfer',scope='All three returned fields for original and further admitted operations including force aboveOne,and exact force/speed rejection precedence.',actual=actual,expected=expected),indent=2));print('PASS10 original Lorentz cases')
