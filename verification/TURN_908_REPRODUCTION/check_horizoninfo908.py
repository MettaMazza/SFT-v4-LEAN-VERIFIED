from pathlib import Path
from fractions import Fraction as F
import sys,subprocess,json,os,hashlib
w=Path('work');root=w/'v3-runtime500';source='sft/physics/gravity_spacetime_laws_v1.py';assert (root/source).read_bytes()==(w/'original899_gravity_spacetime_laws_v1.py').read_bytes();sys.path.insert(0,str(root.resolve()))
from sft.physics.gravity_spacetime_laws_v1 import horizon_information_ledger
def canon(x):
 if isinstance(x,F):return dict(numerator=x.numerator,denominator=x.denominator)
 if isinstance(x,tuple):return [canon(y) for y in x]
 if isinstance(x,dict):return {k:canon(v) for k,v in x.items()}
 return x
expected=[canon(horizon_information_ledger())]
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str((w/'constants-recovery/HorizonInfoCompare908.lean').resolve())],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True);actual=[json.loads(x) for x in out.splitlines()];assert actual==expected
(w/'horizoninfo908_science_report.json').write_text(json.dumps(dict(status='PASS',source=source,source_sha256=hashlib.sha256((root/source).read_bytes()).hexdigest(),scope='All three original horizon-information fields,all eight ordered labels,local empty record and original inverse flag.',actual=actual,expected=expected),indent=2));print('PASS complete original horizon-information record')
