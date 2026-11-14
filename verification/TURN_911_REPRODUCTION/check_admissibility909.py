from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os,hashlib
w=Path('work');root=w/'v3-runtime500';source='sft/physics/gravity_spacetime_laws_v1.py';assert (root/source).read_bytes()==(w/'original899_gravity_spacetime_laws_v1.py').read_bytes();sys.path.insert(0,str(root.resolve()))
from sft.physics.gravity_spacetime_laws_v1 import wormhole_admissible,warp_admissible,closed_timelike_admissible
worm=[((1, 4), True, True), ((1, 4), False, True), ((1, 4), True, False), ((1, 4), False, False), ((0, 1), True, True), ((-1, 1), True, True), (None, True, True), ((3, 1), True, True)]
warp=[((1, 4), (1, 4), True), ((1, 4), (1, 2), True), ((1, 4), (1, 4), False), ((0, 1), (0, 1), True), ((-1, 1), (-1, 1), True), (None, (1, 4), True), ((1, 4), None, True), ((3, 1), (3, 1), True)]
ctc=[(['state', 'proof'], ['state', 'proof'], True), (['state', 'proof'], ['changed-state', 'proof'], True), (['state', 'proof'], ['state', 'proof'], False), ([], [], True), (['state'], ['state', 'proof'], True), (['state', 'proof'], ['state', 'changed-proof'], True)]
def canon(x):
 if isinstance(x,F):return dict(numerator=x.numerator,denominator=x.denominator)
 if isinstance(x,tuple):return [canon(y) for y in x]
 if isinstance(x,dict):return {k:canon(v) for k,v in x.items()}
 return x
conv=lambda q: F(*q) if q is not None else 1
expected=[wormhole_admissible(conv(q),a,b) for q,a,b in worm]+[warp_admissible(conv(q),conv(p),a) for q,p,a in warp]+[closed_timelike_admissible(tuple(a),tuple(b),c) for a,b,c in ctc]
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str((w/'constants-recovery/AdmissibilityCompare909.lean').resolve())],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True);actual=[json.loads(x) for x in out.splitlines()];assert actual==expected
(w/'admissibility909_science_report.json').write_text(json.dumps(dict(status='PASS',source=source,source_sha256=hashlib.sha256((root/source).read_bytes()).hexdigest(),scope='All three original spacetime admissibility operations:complete/omitted traces,exact source equality,nonempty recurrence,positive/type guards and above-One admitted sources;22 cases.',actual=actual,expected=expected),indent=2));print('PASS22 original admissibility cases')
