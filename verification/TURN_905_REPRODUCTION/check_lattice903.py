from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os,hashlib
w=Path('work');root=w/'v3-runtime500';source='sft/physics/gravity_spacetime_laws_v1.py';assert (root/source).read_bytes()==(w/'original899_gravity_spacetime_laws_v1.py').read_bytes();sys.path.insert(0,str(root.resolve()))
from sft.physics.gravity_spacetime_laws_v1 import square_lattice_curvature,lattice_laplacian
cases=[((1, 2), (1, 8)), ((1, 2), (1, 16)), ((3, 7), (1, 11)), ((7, 3), (2, 5)), ((1, 2), (1, 2)), ((1, 2), (3, 4)), ((1, 2), (0, 1)), (None, (1, 8))]
cases=[(F(*a) if a is not None else 1,F(*b)) for a,b in cases]
dims=[1, 2, 3, True, False, 0, 4, -1]
def canon(x):
 if isinstance(x,F):return dict(numerator=x.numerator,denominator=x.denominator)
 if isinstance(x,tuple):return [canon(y) for y in x]
 if isinstance(x,dict):return {k:canon(v) for k,v in x.items()}
 return x
expected=[]
for fn,args in [(square_lattice_curvature,a) for a in cases]+[(lattice_laplacian,(d,F(1,8))) for d in dims]:
 try:expected.append(canon(fn(*args)))
 except ValueError as e:expected.append(dict(error=str(e)))
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str((w/'constants-recovery/LatticeCompare903.lean').resolve())],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True);actual=[json.loads(x) for x in out.splitlines()];assert actual==expected
(w/'lattice903_science_report.json').write_text(json.dumps(dict(status='PASS',source=source,source_sha256=hashlib.sha256((root/source).read_bytes()).hexdigest(),scope='Original arbitrary-spacing curvature and complete dimension family including original boolean-True behavior and rejected guards;16 cases.',actual=actual,expected=expected),indent=2));print('PASS16 original lattice cases')
