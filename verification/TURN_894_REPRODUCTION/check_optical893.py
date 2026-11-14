from pathlib import Path
from fractions import Fraction
import sys,subprocess,json,os
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import exact_optical_operations

def canon(x):
 if isinstance(x,Fraction):return dict(numerator=x.numerator,denominator=x.denominator)
 if isinstance(x,dict):return {k:canon(v) for k,v in x.items()}
 if isinstance(x,tuple):return [canon(v) for v in x]
 return x
expected=canon(exact_optical_operations())
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'OpticalCompare893.lean')],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True);actual=json.loads(out);assert actual==expected
(w/'optical893_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/relativistic_field_laws_v1.py:exact_optical_operations',scope='Every returned field including all five mixing values and complete eight-element propagation record.',actual=actual,expected=expected),indent=2));print('PASS complete original optical record')
