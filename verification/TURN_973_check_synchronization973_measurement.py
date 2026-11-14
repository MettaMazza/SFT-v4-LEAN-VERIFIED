from pathlib import Path
import sys,json,subprocess,os,itertools,hashlib
from fractions import Fraction as F
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import coupled_ensemble_synchronization_terminal_validation_v1 as src
def enc(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return list(map(enc,x))
 if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
 return x
def arg(x):return f'(LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide))'
s='''import SFT.Physics.CoupledEnsembleSynchronizationMeasurement
import SFT.Host.Canonical
open SFT.Physics CoupledEnsembleSynchronizationMeasurement SFT.Host.Canonical
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def rats (xs : List Rat) : Value := .array (xs.map frac)
def nat (n : Nat) : Value := .integer (.ofNat n)
def recValue (r : Recurrence) : Value := .object [("coupling",frac r.coupling),("region_count_recurrence",.array (r.regionCountRecurrence.map nat)),("final_region_count",nat r.finalRegionCount),("final_points",rats r.finalPoints),("terminal_common_point",match r.terminalCommonPoint with | [p] => frac p | _ => .array [])]
def result : Except String Recurrence → Value | .ok r => recValue r | .error e => .object [("error",.text e)]
def analysisValue (a : Analysis) : Value := .object [("denominator",.integer a.denominator),("member_count",.integer a.memberCount),("step_count",.integer a.stepCount),("region_count",.integer a.regionCount),("couplings",rats a.couplings),("recurrences",.array (a.recurrences.map recValue)),("final_region_counts",.array (a.finalRegionCounts.map nat)),("printed_final_region_counts",.array (a.printedFinalRegionCounts.map Value.integer)),("all_printed_rows_reproduced",.boolean a.allPrintedRowsReproduced),("half_One_uniquely_reaches_one_region",.boolean a.halfOneUniquelyReachesOneRegion),("half_One_recurrence",.array (a.halfOneRecurrence.map nat)),("half_One_terminal_point",match a.halfOneTerminalPoint with | [p] => frac p | _ => .array []),("half_One_terminal_members_identical",.boolean a.halfOneTerminalMembersIdentical),("half_One_first_one_region_step",nat a.halfOneFirstOneRegionStep)]
#eval IO.println (render (.array [
'''
expected=[];fields=[];values=[F(-3),F(-1,3),F(0),F(1,8),F(1,3),F(1,2),F(2,3),F(1),F(3,2),F(2),F(8,3),F(7)]
for name,lean in [('legacy_cast','legacyCast'),('legacy_fold','legacyFold')]:
 for x in values:expected.append(enc(getattr(src,name)(x)));fields.append('frac ('+lean+' '+arg(x)+')')
for a,b in itertools.product(values,values):expected.append(enc(src.legacy_separation(a,b)));fields.append('frac (legacySeparation '+arg(a)+' '+arg(b)+')')
for points in [(),(F(1),),(F(1,2),)*3,(F(1,4),F(1,2),F(3,4)),(F(-1,2),F(3,2)),(F(1,3),F(2,3),F(1,3))]:
 for coupling in [F(0),F(1,3),F(1,2),F(2,3),F(1)]:
  expected.append(enc(src.legacy_step(points,coupling)));fields.append('rats (legacyStep ['+','.join(map(arg,points))+'] '+arg(coupling)+')')
args=[(21,20,15,12,g) for g in [F(1,10),F(1,3),F(1,2),F(7,10),F(9,10)]]+[(d,m,k,r,F(1,2)) for d,m,k,r in [(5,4,1,3),(5,4,3,3),(0,0,1,2),(0,1,1,2),(-5,4,2,3),(5,4,0,3),(5,4,-1,3),(5,0,1,3),(5,-2,1,3),(5,4,2,-3),(5,4,2,0)]]
for d,m,k,r,g in args:
 try:e=enc(src.independent_recurrence(d,m,k,r,g))
 except (ValueError,ZeroDivisionError,IndexError) as ex:e={'error':str(ex)}
 expected.append(e);fields.append('result (independentRecurrence '+' '.join('('+str(n)+')' for n in [d,m,k,r])+' '+arg(g)+')')
target=dict(ensemble_denominator='21',ensemble_member_count='20',coupled_fold_step_count='15',region_count='12',complete_coupling_support=['1/10','1/3','1/2','7/10','9/10'],printed_final_region_counts=['7','7','1','5','5'])
expected.append(enc(src.exact_measurement_analysis(target)));fields.append('match exactMeasurementAnalysis 21 20 15 12 ['+','.join(arg(F(g)) for g in target['complete_coupling_support'])+'] [7,7,1,5,5] with | .ok a => analysisValue a | .error e => .object [("error",.text e)]')
p=w/'constants-recovery/SynchronizationMeasurement973.lean';p.write_text(s+',\n'.join(fields)+']))\n');env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};binary='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);actual=json.loads(out);(w/'synchronization973_measurement_actual.json').write_text(json.dumps(actual));assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
(w/'synchronization973_measurement_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),full_historical_recurrences=5,steps_per_recurrence=15,members_per_recurrence=20,source_sha256=hashlib.sha256((c/'SFT/Physics/CoupledEnsembleSynchronizationMeasurement.lean').read_bytes()).hexdigest()),indent=2));print('PASS',len(expected),'cases, all five complete historical recurrences')
