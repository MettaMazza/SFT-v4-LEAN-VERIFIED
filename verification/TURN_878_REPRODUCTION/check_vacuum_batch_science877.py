from pathlib import Path
from fractions import Fraction
import json,subprocess,os
from sft.physics.vacuum_lineage_laws_v1 import complete_returned_cycle,positive_gap
w=Path('work');r=(w/'constants-recovery').resolve()
def conv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:conv(v) for k,v in x.items()}
 if isinstance(x,tuple):return [conv(v) for v in x]
 return x
expected=conv(complete_returned_cycle());a=Fraction(1,2);b=Fraction(1,3);cases=[(a,b),(Fraction(1),b),(False,b),(a,1),(Fraction(0),b),(a,Fraction(0)),(a,a),(b,a),(Fraction(2),b)];guards=[]
for x,y in cases:
 try:guards.append(dict(value=conv(positive_gap(x,y))))
 except ValueError as e:guards.append(dict(error=str(e)))
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'VacuumBatchScience877.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True);actual,actualguards=map(json.loads,out.splitlines());assert actual==expected;assert actualguards==guards
for low,n,data in [('vacuum_cycle',878,dict(actual=actual,expected=expected)),('vacuum_beat_guards',877,dict(actual=actualguards,expected=guards,cases=9))]:
 (w/f'{low}{n}_science_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',fresh_lean_execution=True,fresh_original_execution=True,**data),indent=2))
print('PASS original complete cycle and nine positive-gap guard cases',flush=True)
