from pathlib import Path
from fractions import Fraction
import sys,json,re,subprocess,os,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import mediator_range_channel_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
expected=[];expr=[]
def case(f,s):
 try:v=canonical_value(f())
 except ValueError as e:v={'error':str(e)}
 expected.append(v);expr.append(s)
def rat(x):
 x=Fraction(x);return '(SFT.Physics.LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))'
def inp(x):return '(.fraction '+rat(x)+')' if isinstance(x,Fraction) else '.nonFraction'
def ordered(x):return '('+('.fraction ' if isinstance(x,Fraction) else '.nonFractionNumber ')+rat(x)+')'
values=[False,True,0,1]+[Fraction(n,d) for d in range(1,13) for n in range(-1,d+2)]
for x in values:
 for f,lean,render in [(src.preserved_mass_record,'preservedMassRecord','record'),(src.broken_channel_mass,'brokenChannelMass','rational'),(src.positive_forward_trace,'positiveForwardTrace','rationals'),(src.finite_reach_count,'finiteReachCount','natural'),(src.forward_rest_ledger,'forwardRestLedger','ledger'),(src.ledger_conserves_one,'ledgerConservesOne','Value.boolean'),(src.reciprocal_range_scale,'reciprocalRangeScale','rational')]:case(lambda f=f,x=x:f(x),'result '+render+' ('+lean+' '+inp(x)+')')
for x in [Fraction(-1),Fraction(0),Fraction(1,7),Fraction(1,3),Fraction(2,3),Fraction(1),Fraction(3),1,2,False]:
 for y in [Fraction(0),Fraction(1,2),Fraction(1),Fraction(3),1,2,True]:
  case(lambda:src.larger_mass_shorter_range(x,y),'result Value.boolean (largerMassShorterRange '+ordered(x)+' '+ordered(y)+')')
  case(lambda:src.massless_inverse_square(x,y),'result rational (masslessInverseSquare '+inp(x)+' '+inp(y)+')')
for d in [False,True,-1,0,1,2,8,20]:case(lambda:src.massless_forward_trace(d),'result rationals (masslessForwardTrace ('+('.boolean '+str(d).lower() if isinstance(d,bool) else '.integer ('+str(d)+')')+'))')
s='''import SFT.Physics.MediatorRangeChannel
import SFT.Host.Canonical
open SFT.Physics.MediatorRangeChannel SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def natural (n : Nat) : Value := .integer (.ofNat n)
def rationals (xs : List Rat) : Value := .array (xs.map rational)
def record : MassRecord → Value | .emptyOne => .array [.text "empty-One"] | .positive q => rational q
def ledger (xs : List (Rat × MassRecord)) : Value := .array (xs.map (fun (q,r) => .array [rational q,record r]))
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n';p=w/'constants-recovery/MediatorRange995.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'mediatorrange995_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2500:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:4]
code=(r/'SFT/Physics/MediatorRangeChannel.lean').read_text();names=['SFT.Physics.MediatorRangeChannel.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)];p=w/'mediatorrange995_core_audit.lean';p.write_text('import SFT.Physics.MediatorRangeChannel\n'+''.join('#print axioms '+n+'\n' for n in names));out=subprocess.check_output([lean,str(p)],env=env,text=True);(w/'mediatorrange995_core_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names),out
(w/'mediatorrange995_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'originalcases;',len(names),'emptydeclarations')
