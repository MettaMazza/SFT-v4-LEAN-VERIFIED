from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os,hashlib
w=Path('work');root=w/'v3-runtime500';source='sft/physics/gravity_spacetime_laws_v1.py';assert (root/source).read_bytes()==(w/'original899_gravity_spacetime_laws_v1.py').read_bytes();sys.path.insert(0,str(root.resolve()))
from sft.physics.gravity_spacetime_laws_v1 import positive_differences,gravitational_wave_trace
cases=[[], [1], [1, 2, 3, 4], [1, 8, 27, 64], [7, 19, 37], [1, 1], [2, 1], [-2, -1], [0, 1]]
def canon(x):
 if isinstance(x,F):return dict(numerator=x.numerator,denominator=x.denominator)
 if isinstance(x,tuple):return [canon(y) for y in x]
 if isinstance(x,dict):return {k:canon(v) for k,v in x.items()}
 return x
expected=[]
for ns in cases:
 try:expected.append(canon(positive_differences(tuple(ns))))
 except ValueError as e:expected.append(dict(error=str(e)))
expected.append(canon(gravitational_wave_trace()))
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str((w/'constants-recovery/GravityWaveCompare906.lean').resolve())],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True);actual=[json.loads(x) for x in out.splitlines()];assert actual==expected
(w/'gravitywave906_science_report.json').write_text(json.dumps(dict(status='PASS',source=source,source_sha256=hashlib.sha256((root/source).read_bytes()).hexdigest(),scope='Complete original gravitational-wave record and ordered-difference behavior,including source-admitted zero/negative starting values and rejected traces;10 cases.',actual=actual,expected=expected),indent=2));print('PASS10 original gravity-wave cases')
