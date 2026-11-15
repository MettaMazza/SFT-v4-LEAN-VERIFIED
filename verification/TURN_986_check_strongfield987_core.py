from pathlib import Path
import sys,subprocess,json,os,hashlib,re
from fractions import Fraction as F
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import strong_field_nonlinear_fixed_point_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
q=json.dumps;rat=lambda x:'(normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))';inp=lambda x:'.fraction '+rat(x) if isinstance(x,F) else '.nonFraction';count=lambda x:'.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
s='''import SFT.Physics.StrongFieldNonlinearFixedPoint
import SFT.Host.Canonical
open SFT.Physics.StrongFieldNonlinearFixedPoint SFT.Physics.LeptonIntervals SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",nv x.den)]
def rs (xs : List Rat) : Value := .array (xs.map frac)
def strongValue (x : Strong) : Value := .object [("sources",rs x.sources),("corrections",rs x.corrections),("source_strictly_grows",.boolean x.sourceStrictlyGrows),("correction",frac x.correction),("all_corrections_binary",.boolean x.allCorrectionsBinary),("corrections_do_not_shrink",.boolean x.correctionsDoNotShrink),("field_appears_in_its_source_update",.boolean x.fieldAppearsInItsSourceUpdate),("carrier_self_source_record",.array (x.carrierSelfSourceRecord.map Value.text))]
def neutralValue (x : Neutral) : Value := .object [("sources",rs x.sources),("self_source_record",rs x.selfSourceRecord),("correction_record",rs x.correctionRecord),("source_held",.boolean x.sourceHeld),("fixed_point",frac x.fixedPoint),("field_absent_from_source_update",.boolean x.fieldAbsentFromSourceUpdate)]
def fixedValue (x : FixedPointTest) : Value := .object [("candidate",frac x.candidate),("successor",frac x.successor),("successor_strictly_above_candidate",.boolean x.successorStrictlyAboveCandidate),("is_fixed_point",.boolean x.isFixedPoint),("finite_candidate",.boolean x.finiteCandidate)]
def boundValue (x : BoundWitness) : Value := .object [("bound",frac x.bound),("witness_successors",nv x.witnessSuccessors),("witness_source",frac x.witnessSource),("source_exceeds_bound",.boolean x.sourceExceedsBound),("finite_witness",.boolean x.finiteWitness)]
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
(w/'strongfield987_serializers.txt').write_text(s[s.index('def nv'):s.index('def result')]);expected=[];expr=[]
def case(call,code):
 try:v=canonical_value(call())
 except ValueError as e:v={'error':str(e)}
 expected.append(v);expr.append(code)
for n in [False,True,-5,-1,0,1,2,3,4,8,12,16,20,33]:
 case(lambda:src.strong_source_iteration(n),'result strongValue (strongSourceIteration ('+count(n)+'))');case(lambda:src.neutral_source_iteration(n),'result neutralValue (neutralSourceIteration ('+count(n)+'))')
for b in [False,True,1,F(0),F(-1),F(-2,3)]+[F(n,d) for n in [1,2,3,7,16,32,99] for d in [1,2,3,8,17]]:
 case(lambda:src.strong_source_exceeds_positive_bound(b),'result boundValue (strongSourceExceedsPositiveBound ('+inp(b)+'))')
 case(lambda:src.colour_self_source_successor(b),'result frac (colourSelfSourceSuccessor ('+inp(b)+'))')
 case(lambda:src.finite_strong_fixed_point_test(b),'result fixedValue (finiteStrongFixedPointTest ('+inp(b)+'))')
s+='#eval IO.println (render (.array [\n'+',\n'.join(expr)+']))\n';p=w/'constants-recovery/StrongFieldCore987.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};proc=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True,capture_output=True);(w/'strongfield987_core_lean.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,proc.stdout[:2000];actual=json.loads(proc.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:2]
p=r/'SFT/Physics/StrongFieldNonlinearFixedPoint.lean';code=p.read_text();names=re.findall(r'^(?:def|theorem) (\w+)',code,re.M);audit=w/'strongfield987_core_audit.lean';audit.write_text('import SFT.Physics.StrongFieldNonlinearFixedPoint\n'+''.join('#print axioms SFT.Physics.StrongFieldNonlinearFixedPoint.'+n+'\n' for n in names));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(audit)],env=env,text=True);(w/'strongfield987_core_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names) and 'depends on axioms:' not in out
(w/'strongfield987_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),declarations=names,axioms=[],source_sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'complete operation and domain cases;',len(names),'empty declarations')
