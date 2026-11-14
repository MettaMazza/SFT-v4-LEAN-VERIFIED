from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os,hashlib
w=Path('work');root=w/'v3-runtime500';source='sft/physics/gravity_spacetime_laws_v1.py';assert (root/source).read_bytes()==(w/'original899_gravity_spacetime_laws_v1.py').read_bytes();sys.path.insert(0,str(root.resolve()))
from sft.physics.gravity_spacetime_laws_v1 import redshift_equivalence
cases=[(F(1,8),F(1,4)),(F(1,8),F(1,2)),(F(1,8),F(1)),(F(1,8),F(2)),(F(1,2),F(1,2)),(F(0),F(1,2)),(1,F(1,2)),(F(1,8),1)]
def canon(x):
 if isinstance(x,F):return dict(numerator=x.numerator,denominator=x.denominator)
 if isinstance(x,tuple):return [canon(y) for y in x]
 if isinstance(x,dict):return {k:canon(v) for k,v in x.items()}
 return x
expected=[]
for fn in [redshift_equivalence]:
 for args in cases:
  try:expected.append(canon(fn(*args)))
  except ValueError as e:expected.append(dict(error=str(e)))
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str((w/'constants-recovery/RedshiftCompare902.lean').resolve())],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True);actual=[json.loads(x) for x in out.splitlines()];assert actual==expected
(w/'redshift902_science_report.json').write_text(json.dumps(dict(status='PASS',source=source,source_sha256=hashlib.sha256((root/source).read_bytes()).hexdigest(),scope='Complete original two-field equivalence records and exact positive-domain guards,including carriers above One;8 cases.',actual=actual,expected=expected),indent=2));print('PASS8 original redshift cases')
