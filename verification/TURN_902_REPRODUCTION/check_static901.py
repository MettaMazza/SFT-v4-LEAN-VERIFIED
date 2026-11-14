from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os,hashlib
w=Path('work');root=w/'v3-runtime500';source='sft/physics/gravity_spacetime_laws_v1.py';assert (root/source).read_bytes()==(w/'original899_gravity_spacetime_laws_v1.py').read_bytes();sys.path.insert(0,str(root.resolve()))
from sft.physics.gravity_spacetime_laws_v1 import static_clock,exact_clock_rate
cases=[(1, 8), (7, 16), (1, 1), (1, 2), (1, 4), (3, 4), (1, 3), (2, 3), (0, 1), (-1, 1), (2, 1), None]
cases=[F(*a) if a is not None else 1 for a in cases]
def canon(x):
 if isinstance(x,F):return dict(numerator=x.numerator,denominator=x.denominator)
 if isinstance(x,tuple):return [canon(y) for y in x]
 if isinstance(x,dict):return {k:canon(v) for k,v in x.items()}
 return x
expected=[]
for arg in cases:
 try:expected.append(canon(static_clock(arg)))
 except ValueError as e:expected.append(dict(error=str(e)))
expected.append(canon(exact_clock_rate()))
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str((w/'constants-recovery/StaticCompare901.lean').resolve())],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True);actual=[json.loads(x) for x in out.splitlines()];assert actual==expected
(w/'static901_science_report.json').write_text(json.dumps(dict(status='PASS',source=source,source_sha256=hashlib.sha256((root/source).read_bytes()).hexdigest(),scope='Complete original static-clock records,covariance,rate,horizon,half-boundary and rejected guards;13 cases.',actual=actual,expected=expected),indent=2));print('PASS13 original static-clock cases')
