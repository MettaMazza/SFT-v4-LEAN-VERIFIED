from pathlib import Path
import sys,json,subprocess,os
from fractions import Fraction
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');r=w/'constants-recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.hydrogen_rydberg_successor_laws_v1 import terminal_line_ratio_interval
values=[True,False,0,1,Fraction(-1),Fraction(0),Fraction(1),Fraction(2),Fraction(1,100000),Fraction(3,4),Fraction(5,36),Fraction(99999,100000)]
def expr(x):return f'.fraction (LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide))' if isinstance(x,Fraction) else '.nonFraction'
p=r/'HydrogenRydbergLines955.lean';p.write_text('''import SFT.Physics.HydrogenRydberg
open SFT.Physics SFT.Host.Canonical HydrogenRydberg
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def result : Except String (Rat × Rat) → Value
 | .error e => .object [("error",.text e)]
 | .ok p => .array [frac p.1,frac p.2]
#eval do
 let inputs : List FoldFirstReturn.Input := ['''+','.join(expr(x) for x in values)+''']
 IO.println (render (.array (inputs.map fun x => result (terminalLineRatioInterval x))))
''')
actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),text=True))
expected=[]
for x in values:
 try:expected.append([[q.numerator,q.denominator] for q in terminal_line_ratio_interval(x)])
 except ValueError as e:expected.append({'error':str(e)})
assert actual==expected
(w/'hydrogenrydberg955_line_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected),indent=2));print('PASS original12gap input cases and both immutable line operations')
