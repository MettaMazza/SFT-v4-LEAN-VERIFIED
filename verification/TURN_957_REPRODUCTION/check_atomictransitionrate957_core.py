from pathlib import Path
from fractions import Fraction as F
import sys,json,subprocess,os,shutil,re,itertools
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v=Path('/Volumes/One Touch/ernos-labs-sft-platform')
for part in ['laws','validation','execution']:shutil.copy2(v/f'sft/physics/atomic_transition_rate_successor_{part}_v1.py',w/f'v3-runtime500/sft/physics/atomic_transition_rate_successor_{part}_v1.py')
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_transition_rate_successor_laws_v1 as src
counts=[False,True,None,-1,0,1,2,3,4,7,17];fractions=[False,True,0,F(-1),F(0),F(1),F(2),F(1,2),F(3,4),F(5,36)];cases=list(itertools.product([F(1,2),F(3,4),F(5,36)],[F(1,3),F(2)],[1,2,3],[1,2,3,4]))+[(g,s,weight,rank) for g,s,weight,rank in [(x,F(1),1,1) for x in fractions]+[(F(1,2),x,1,1) for x in fractions]+[(F(1,2),F(1),x,1) for x in counts]+[(F(1,2),F(1),1,x) for x in counts]]
channels=[(),(F(1,8),F(1,24)),(F(1),),(F(1,3),F(2,3)),(F(0),),(F(-1),),(True,),(F(1),False),(F(1,2),F(1,3),F(1,5))]
def ci(x):
 if isinstance(x,bool):return 'CountArgument.count (.boolean '+str(x).lower()+')'
 if isinstance(x,int):return 'CountArgument.count (.integer ('+str(x)+'))'
 return 'CountArgument.nonInteger'
def fi(x):return f'FoldFirstReturn.Input.fraction (normalize ({x.numerator}) {x.denominator} (by decide))' if isinstance(x,F) else 'FoldFirstReturn.Input.nonFraction'
s='''import SFT.Physics.AtomicTransitionRate
open SFT.Physics SFT.Host.Canonical AtomicTransitionRate LeptonIntervals
set_option maxRecDepth 20000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def result : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok q => frac q
def countResult : Except String Nat → Value
 | .error e => .object [("error",.text e)]
 | .ok n => .integer (.ofNat n)
#eval do
 IO.println (render (.object [
'''
s+='("exponents",.array ['+','.join('countResult (electricMultipoleExponent ('+ci(x)+'))' for x in counts)+']),\n'
s+='("ratios",.array ['+','.join('result (successorMultipoleRatio ('+fi(x)+'))' for x in fractions)+']),\n'
s+='("rates",.array ['+','.join('result (normalizedElectricRate ('+fi(g)+') ('+fi(st)+') ('+ci(we)+') ('+ci(ra)+'))' for g,st,we,ra in cases)+']),\n'
s+='("lifetimes",.array ['+','.join('result (exactLifetime ['+','.join(fi(x) for x in ch)+'])' for ch in channels)+'])]))\n'
p=r/'AtomicTransitionRateCompare957.lean';p.write_text(s);actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean')),text=True))
def call(fn,*args):
 try:
  x=fn(*args);return [x.numerator,x.denominator] if isinstance(x,F) else x
 except ValueError as e:return {'error':str(e)}
expected=dict(exponents=[call(src.electric_multipole_exponent,x) for x in counts],ratios=[call(src.successor_multipole_ratio,x) for x in fractions],rates=[call(src.normalized_electric_rate,*x) for x in cases],lifetimes=[call(src.exact_lifetime,x) for x in channels]);assert actual==expected
(w/'atomictransitionrate957_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,rate_cases=len(cases)),indent=2));print('PASS',len(cases),'rate cases,',len(counts),'exponent cases,',len(fractions),'ratio cases,',len(channels),'complete rate-sum cases')
