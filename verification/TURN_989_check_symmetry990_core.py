from pathlib import Path
from fractions import Fraction
import sys,os,re,json,subprocess,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');runtime=w/'v3-runtime500';(runtime/'sft/physics/symmetry_action_terminal_law_v1.py').write_bytes((w/'symmetry990_original_law.py').read_bytes());sys.path.insert(0,str(runtime.resolve()))
from sft.physics import symmetry_action_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
s='''import SFT.Physics.SymmetryAction
import SFT.Physics.VacuumLedgerProofs
import SFT.Host.Canonical
open SFT.Physics.SymmetryAction SFT.Physics.VacuumLedgerProofs SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",nv x.den)]
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
expected=[];expr=[]
values=[None,False,True,0,1,Fraction(-1,2),Fraction(0),Fraction(3,2)]+[Fraction(n,d) for d in range(1,25) for n in range(1,d+1)]
for x in values:
 inp='.nonFraction' if not isinstance(x,Fraction) else '.fraction (SFT.Physics.LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))'
 for fn,lean,cv in [('fold_part','foldPart','frac'),('reduced_odd_denominator_core','reducedOddDenominatorCore','nv'),('odd_core_is_conserved','oddCoreIsConserved','Value.boolean')]:
  try:v=canonical_value(getattr(src,fn)(x))
  except ValueError as e:v={'error':str(e)}
  expected.append(v);expr.append('result '+cv+' ('+lean+' ('+inp+'))')
p=w/'constants-recovery/SymmetryCore990.lean';p.write_text(s+'#eval IO.println (render (.array [\n'+',\n'.join(expr)+']))\n');env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'symmetry990_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
code=(r/'SFT/Physics/SymmetryAction.lean').read_text();ns=re.findall(r'^(?:def|theorem) (\w+)',code,re.M);audit=w/'symmetry990_core_audit.lean';audit.write_text('import SFT.Physics.SymmetryAction\n'+''.join('#print axioms SFT.Physics.SymmetryAction.'+n+'\n' for n in ns));out=subprocess.check_output([lean,str(audit)],env=env,text=True);(w/'symmetry990_core_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(ns),out
(w/'symmetry990_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),declarations=ns,axioms=[],source_sha256=hashlib.sha256((w/'symmetry990_original_law.py').read_bytes()).hexdigest(),lean_sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'original cases,',len(ns),'empty declarations')
