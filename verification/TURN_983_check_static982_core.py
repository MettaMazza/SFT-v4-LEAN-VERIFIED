from pathlib import Path
import sys,json,subprocess,os,hashlib,re
from fractions import Fraction as F
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import static_exterior_clock_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
q=json.dumps
def inp(x):
 if not isinstance(x,F):return '.nonFraction'
 return '(.fraction (normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide)))'
expr=[];expected=[]
def add(exprn,f,*args):
 expr.append(exprn)
 try:expected.append(canonical_value(f(*args)))
 except ValueError as e:expected.append({'error':str(e)})
vals=[F(-1),F(0),F(1,8),F(1,4),F(1,2),F(1),F(2),True,1]
for whole in vals:
 for taken in vals:add('remainderResult (positiveRemainder '+inp(whole)+' '+inp(taken)+')',src.positive_remainder,whole,taken)
for mass in vals:
 add('ratResult (generatedHorizonRadius '+inp(mass)+')',src.generated_horizon_radius,mass)
 for radius in vals+[F(8,7),F(25,18),F(3,4)]:add('stateResult (exteriorState '+inp(mass)+' '+inp(radius)+')',src.exterior_state,mass,radius)
add('clockResult exactClockPair',src.exact_clock_pair)
s='''import SFT.Physics.StaticExteriorClock
import SFT.Host.Canonical
open SFT.Physics.StaticExteriorClock SFT.Physics.LeptonIntervals SFT.Host.Canonical
def frac (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def stateValue (s : State) : Value :=
 let common := [("mass",frac s.mass),("horizon",frac s.horizon),("radius",frac s.radius),("well_share",frac s.wellShare)]
 let ending := [("field",frac s.field),("flux",frac s.flux)]
 match s.coefficient with
 | none => .object (common++[("coefficient",.array []),("clock_record",.array [])]++ending++[("region",.text "boundary")])
 | some q => .object (common++[("coefficient",frac q)]++ending++[("region",.text "exterior")])
def clockValue (c : ClockPair) : Value := .object [("mass",frac c.mass),("near",stateValue c.near),("far",stateValue c.far),("near_rate",frac c.nearRate),("far_rate",frac c.farRate),("far_over_near_rate",frac c.farOverNearRate),("far_clock_faster",.boolean c.farClockFaster)]
def remainderResult : Except String (Option Rat) → Value | .ok none => .array [] | .ok (some q) => frac q | .error e => .object [("error",.text e)]
def ratResult : Except String Rat → Value | .ok q => frac q | .error e => .object [("error",.text e)]
def stateResult : Except String State → Value | .ok s => stateValue s | .error e => .object [("error",.text e)]
def clockResult : Except String ClockPair → Value | .ok s => clockValue s | .error e => .object [("error",.text e)]
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n';p=w/'constants-recovery/StaticCore982.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[i for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
p=r/'SFT/Physics/StaticExteriorClock.lean';s=p.read_text();names=['SFT.Physics.StaticExteriorClock.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)];p=w/'static982_audit.lean';p.write_text('import SFT.Physics.StaticExteriorClock\n'+''.join('#print axioms '+n+'\n' for n in names));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);(w/'static982_audit.log').write_text(out);assert all("'"+n+"' does not depend on any axioms" in out for n in names)
(w/'static982_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expr),declarations=names,axioms=[],source_sha256=hashlib.sha256(s.encode()).hexdigest()),indent=2));(w/'constants-recovery/SFT/Physics/StaticExteriorClock.lean').write_text(s);print('PASS',len(expr),'sourcecases;',len(names),'emptydeclarations')
