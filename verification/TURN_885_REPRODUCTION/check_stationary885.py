from pathlib import Path
import sys,subprocess,json,os
w=Path('work');r=(w/'constants-recovery').resolve();sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import stationary_spectrum
expected=[]
for depth in [1,2,3,4,5,6,0,-1,True]:
 try:expected.append({'ok':[[x.numerator,x.denominator] for x in stationary_spectrum(depth)]})
 except ValueError as e:expected.append({'error':str(e)})
o=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'StationaryCompare885.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True);actual=[json.loads(x) for x in o.splitlines()];assert actual==expected
(w/'stationary885_science_report.json').write_text(json.dumps(dict(status='PASS',scope='Original complete spectra at depths1–6 and zero/negative/boolean guards;exact reduced pairs retained.',actual=actual,expected=expected),indent=2));print('PASS9 original complete spectrum and guard cases')
