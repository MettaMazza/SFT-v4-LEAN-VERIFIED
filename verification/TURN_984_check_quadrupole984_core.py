from pathlib import Path
import sys,subprocess,json,os,hashlib,re,itertools
from fractions import Fraction as F
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import quadrupole_radiated_power_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
q=json.dumps
rat=lambda x:'(normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))'
inp=lambda x:'.fraction '+rat(x) if isinstance(x,F) else '.nonFraction'
count=lambda x:'.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
expr=[];expected=[]
def case(call,code):
 try:v=canonical_value(call())
 except ValueError as e:v={'error':str(e)}
 expected.append(v);expr.append(code)
seqs=[(),(F(1),),(1,2),(F(0),F(1)),(F(-1),F(1)),(F(1),F(1)),(F(1),F(2),F(1))]+list(itertools.product([F(1,3),F(1),F(2)],repeat=3))+[tuple(F(k**3) for k in range(1,n+1)) for n in [4,5,8,12]]
for xs in seqs:
 ls='['+','.join(inp(x) for x in xs)+']';case(lambda:src.positive_difference_record(xs),'listResult (positiveDifferenceRecord '+ls+')')
 for order in [False,True,-1,0,1,2,3,4,5]:case(lambda:src.generated_difference_record(xs,order),'listResult (generatedDifferenceRecord '+ls+' ('+count(order)+'))')
 for coupling in [F(1,2),F(1),F(1,3),F(0)]:case(lambda:src.quadrupole_power_record(xs,coupling),'powerResult (quadrupolePowerRecord '+ls+' '+rat(coupling)+')')
lengths=[False,True,-2,0,1,2,3,4,5,8,12]
for a in [False,1,F(-1),F(0),F(1,3),F(1),F(2)]:
 for n in lengths:case(lambda:src.generated_quadrupole_trace(a,n),'listResult (generatedQuadrupoleTrace ('+inp(a)+') ('+count(n)+'))')
for n in lengths:case(lambda:src.static_quadrupole_trace(n),'listResult (staticQuadrupoleTrace ('+count(n)+'))')
for n in [False,True,-2,0,1,2,3,10,30,100]:case(lambda:src.cubic_opposition_identity(n),'identityResult (cubicOppositionIdentity ('+count(n)+'))')
s='''import SFT.Physics.QuadrupoleRadiatedPower
import SFT.Host.Canonical
open SFT.Physics.QuadrupoleRadiatedPower SFT.Physics.LeptonIntervals SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",nv x.den)]
def listResult : Except String (List Rat) → Value
 | .error e => .object [("error",.text e)]
 | .ok xs => .array (xs.map frac)
def powerResult : Except String (Option Rat) → Value
 | .error e => .object [("error",.text e)]
 | .ok none => .array []
 | .ok (some x) => frac x
def identityValue (x : CubicIdentity) : Value := .object [("index",nv x.index),("left",nv x.left),("right",nv x.right),("identity_holds",.boolean x.identityHolds),("successor_left_increment",nv x.successorLeftIncrement),("successor_right_increment",nv x.successorRightIncrement),("generated_successor_increment",nv x.generatedSuccessorIncrement),("successor_preserves_identity",.boolean x.successorPreservesIdentity)]
def identityResult : Except String CubicIdentity → Value | .error e => .object [("error",.text e)] | .ok x => identityValue x
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n';p=w/'constants-recovery/QuadrupoleCore984.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};proc=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True,capture_output=True);(w/'quadrupole984_core_lean.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,proc.stdout[:2000];actual=json.loads(proc.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:2]
p=r/'SFT/Physics/QuadrupoleRadiatedPower.lean';code=p.read_text();names=re.findall(r'^(?:def|theorem) (\w+)',code,re.M);audit=w/'quadrupole984_core_audit.lean';audit.write_text('import SFT.Physics.QuadrupoleRadiatedPower\n'+''.join('#print axioms SFT.Physics.QuadrupoleRadiatedPower.'+n+'\n' for n in names));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(audit)],env=env,text=True);(w/'quadrupole984_core_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names) and 'depends on axioms:' not in out
(w/'quadrupole984_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),declarations=names,axioms=[],source_sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'source operation cases;',len(names),'empty declarations')
