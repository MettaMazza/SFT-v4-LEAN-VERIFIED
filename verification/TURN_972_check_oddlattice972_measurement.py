from pathlib import Path
import sys,json,itertools,subprocess,os
from fractions import Fraction as F
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import odd_lattice_all_region_terminal_validation_v1 as src
s='''import SFT.Physics.OddLatticeMeasurement
import SFT.Host.Canonical
open SFT.Physics OddLatticeMeasurement SFT.Host.Canonical
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def ns (xs : List Nat) : Value := .array (xs.map (fun n => .integer (.ofNat n)))
def analysis (a : Analysis) : Value := .object [
 ("member_count",.integer a.memberCount),("step_count",.integer a.stepCount),("region_count",.integer a.regionCount),
 ("complete_recurrence_vector",ns a.completeRecurrenceVector),("first_step_vector",ns a.firstStepVector),
 ("depth_invariant",.boolean a.depthInvariant),("all_regions_occupied",.boolean a.allRegionsOccupied),
 ("complete_member_total_retained",.boolean a.completeMemberTotalRetained),("exact_balance_span_is_One",.boolean a.exactBalanceSpanIsOne),
 ("legacy_acceptance_rule_passed",.boolean a.legacyAcceptanceRulePassed)]
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
'''
fields=[];expected=[]
def arg(n):return '(.boolean '+str(n).lower()+')' if isinstance(n,bool) else '(.integer ('+str(n)+'))'
for n,t,r in list(itertools.product([False,True,-1,0,1,2,3,5,8,9,15],[0,1,2,3],[0,1,2,3,8,16]))+[(255,1,8),(255,11,8),(255,12,8),(255,12,7)]:
 try:e=list(src.independent_observation(n,t,r))
 except ValueError as ex:e={'error':str(ex)}
 expected.append(e);fields.append('result ns (independentObservation '+' '.join(map(arg,(n,t,r)))+')')
for p in [F(-1),F(0),F(1,9),F(1,2),F(2,3),F(1),F(2)]:
 try:q=src.legacy_fold(p);e=[q.numerator,q.denominator]
 except ValueError as ex:e={'error':str(ex)}
 expected.append(e);fields.append(f'result frac (legacyFold (LeptonIntervals.normalize ({p.numerator}) {p.denominator} (by decide)))')
for n,t,r in [(255,12,8),(9,3,5),(8,2,3),(3,2,8)]:
 e=src.exact_measurement_analysis(dict(lattice_member_count=str(n),fold_step_count=str(t),region_count=str(r)));expected.append(json.loads(json.dumps(e)));fields.append(f'result analysis (exactMeasurementAnalysis {n} {t} {r})')
p=w/'constants-recovery/OddLatticeMeasurement972.lean';p.write_text(s+'\n#eval IO.println (render (.array [\n'+',\n'.join(fields)+']))\n')
o=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')},text=True);a=json.loads(o);assert a==expected,[(i,x,y) for i,(x,y) in enumerate(zip(a,expected)) if x!=y][:5];(w/'oddlattice972_measurement_output.json').write_text(json.dumps(a,indent=2));(w/'oddlattice972_measurement_report.json').write_text(json.dumps({'status':'PASS','cases':len(expected),'full_historical_vector':a[-4]},indent=2));print('PASS',len(expected),'original independent observation and analysis cases')
