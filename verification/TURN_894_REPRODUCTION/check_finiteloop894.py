from pathlib import Path
import sys,subprocess,json,os
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import finite_loop_sum
expected=[]
for x in list(range(17))+[-1,True,False]:
 try:
  q=finite_loop_sum(x);expected.append(dict(numerator=q.numerator,denominator=q.denominator))
 except ValueError as e:expected.append(dict(error=str(e)))
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'FiniteLoopCompare894.lean')],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True);actual=[json.loads(x) for x in out.splitlines()];assert actual==expected
(w/'finiteloop894_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/relativistic_field_laws_v1.py:finite_loop_sum',scope='All sixteen original witness depths and original zero/negative/Boolean input guards.',actual=actual,expected=expected),indent=2));print('PASS20 original finite-loop cases')
