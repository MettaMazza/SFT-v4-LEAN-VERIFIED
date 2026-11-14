from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os,hashlib
w=Path('work');root=w/'v3-runtime500';source='sft/physics/gravity_spacetime_laws_v1.py';assert (root/source).read_bytes()==(w/'original899_gravity_spacetime_laws_v1.py').read_bytes();sys.path.insert(0,str(root.resolve()))
from sft.physics.gravity_spacetime_laws_v1 import exact_interval,interval_witness
cases=[((1, 1), (3, 5)), ((1, 1), (1, 1)), ((2, 1), (6, 5)), ((3, 2), (1, 2)), ((1, 2), (3, 4)), ((1, 1), (0, 1)), ((0, 1), (1, 1)), ((-1, 1), (-2, 1))]
cases=[(F(*a),F(*b)) for a,b in cases]
def canon(x):
 if isinstance(x,F):return dict(numerator=x.numerator,denominator=x.denominator)
 if isinstance(x,tuple):return [canon(y) for y in x]
 if isinstance(x,dict):return {k:canon(v) for k,v in x.items()}
 return x
expected=[]
for args in cases:
 try:expected.append(canon(exact_interval(*args)))
 except ValueError as e:expected.append(dict(error=str(e)))
expected.append(canon(interval_witness()))
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str((w/'constants-recovery/IntervalCompare900.lean').resolve())],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True);actual=[json.loads(x) for x in out.splitlines()];assert actual==expected
(w/'interval900_science_report.json').write_text(json.dumps(dict(status='PASS',source=source,source_sha256=hashlib.sha256((root/source).read_bytes()).hexdigest(),scope='Complete original causal interval,empty boundary,positive take,proper witness and rejected-domain outputs;9 cases.',actual=actual,expected=expected),indent=2));print('PASS9 original interval cases')
