from pathlib import Path
from fractions import Fraction
from itertools import product
import sys,os,re,json,subprocess,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import symmetry_action_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
s='''import SFT.Physics.SymmetryActionDyadic
import SFT.Physics.LeptonIntervals
import SFT.Host.Canonical
open SFT.Physics.SymmetryAction SFT.Physics.SymmetryActionDyadic SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",nv x.den)]
def trace (xs : List Rat) : Value := .array (xs.map frac)
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
''';expected=[];expr=[]
def rat(v):return '(SFT.Physics.LeptonIntervals.normalize ('+str(v.numerator)+') '+str(v.denominator)+' (by decide))'
def case(call,code):
 try:v=canonical_value(call())
 except ValueError as e:v={'error':str(e)}
 expected.append(v);expr.append(code)
values=[None,False,True,0,1,Fraction(-1,2),Fraction(0),Fraction(3,2)]+[Fraction(n,d) for d in range(1,25) for n in range(1,d+1)]+[Fraction(n,2**d) for d in range(1,9) for n in range(1,2**d,2)]
for x in values:
 inp='.nonFraction' if not isinstance(x,Fraction) else '.fraction '+rat(x)
 rankinp=('.otherEqualOne' if x==1 else '.other') if not isinstance(x,Fraction) else '.fraction '+rat(x)
 case(lambda x=x:src.dyadic_fold_descent(x),'result trace (dyadicFoldDescent ('+inp+'))')
 case(lambda x=x:src.dyadic_denominator_rank(x),'result nv (dyadicDenominatorRank ('+rankinp+'))')
traces=[(),(Fraction(1),)]+[src.dyadic_fold_descent(Fraction(n,2**d)) for d in range(1,9) for n in range(1,2**d,2)]+list(product([Fraction(1,4),Fraction(1,2),Fraction(3,4),Fraction(1),Fraction(1,3)],repeat=3))
for xs in traces:case(lambda xs=xs:src.descent_rank_strictly_falls(xs),'result Value.boolean (descentRankStrictlyFalls ['+','.join(rat(x) for x in xs)+'])')
p=w/'constants-recovery/SymmetryDyadic990.lean';p.write_text(s+'#eval IO.println (render (.array [\n'+',\n'.join(expr)+']))\n');env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'symmetry990_dyadic_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
code=(r/'SFT/Physics/SymmetryActionDyadic.lean').read_text();ns=re.findall(r'^(?:def|theorem) (\w+)',code,re.M);audit=w/'symmetry990_dyadic_audit.lean';audit.write_text('import SFT.Physics.SymmetryActionDyadic\n'+''.join('#print axioms SFT.Physics.SymmetryActionDyadic.'+n+'\n' for n in ns));out=subprocess.check_output([lean,str(audit)],env=env,text=True);(w/'symmetry990_dyadic_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(ns),out
(w/'symmetry990_dyadic_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),trace_cases=len(traces),declarations=ns,axioms=[],lean_sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'original dyadic/rank cases;',len(ns),'empty declarations')
