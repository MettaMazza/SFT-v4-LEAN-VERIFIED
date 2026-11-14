from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import maxwell_closure
expected=[]
for dimension in [2,3,0,1,4,-1,True,False]:
 try:expected.append({k:(dict(numerator=v.numerator,denominator=v.denominator) if isinstance(v,F) else v) for k,v in maxwell_closure(dimension).items()})
 except ValueError as e:expected.append(dict(error=str(e)))
o=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'MaxwellCompare891.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True)
actual=[json.loads(x) for x in o.splitlines()];assert actual==expected
(w/'maxwell891_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/relativistic_field_laws_v1.py:maxwell_closure',scope='Both complete5-field admitted records,all other represented count branches and both boolean rejections.',actual=actual,expected=expected),indent=2));print('PASS8 original Maxwell cases')
