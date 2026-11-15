from pathlib import Path
from fractions import Fraction
from itertools import permutations
import sys,os,re,json,subprocess,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import symmetry_action_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
s='''import SFT.Physics.SymmetryActionClasses
import SFT.Physics.LeptonIntervals
import SFT.Host.Canonical
open SFT.Physics.SymmetryActionClasses SFT.Host.Canonical
def ints (xs : List Int) : Value := .array (xs.map Value.integer)
def perms (xs : List (List Int)) : Value := .array (xs.map ints)
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
''';expected=[];expr=[]
def case(call,code):
 try:v=canonical_value(call())
 except ValueError as e:v={'error':str(e)}
 except IndexError as e:v={'error':'IndexError: '+str(e)}
 expected.append(v);expr.append(code)
def rat(v):return '(SFT.Physics.LeptonIntervals.normalize ('+str(v.numerator)+') '+str(v.denominator)+' (by decide))'
def edge(es):return '['+','.join('('+str(a)+','+str(b)+','+rat(q)+')' for a,b,q in es)+']'
def ls(xs):return json.dumps(list(xs),ensure_ascii=False)
charges_cases=[()]+[tuple('a' for _ in range(n)) for n in range(1,7)]+[tuple(str(i) for i in range(n)) for n in range(1,6)]+[('a','a','b','b'),('é','α','é'),('','x','')]
for charges in charges_cases:
 case(lambda charges=charges:src.charge_preserving_bijections(charges),'result perms (chargePreservingBijections '+ls(charges)+')')
 for p in [(),(0,),(-1,),tuple(range(len(charges))),tuple(reversed(range(len(charges)))),tuple(0 for _ in charges),tuple(len(charges) for _ in charges)]:
  case(lambda p=p,charges=charges:src.symmetry_preserves_charge(p,charges),'result Value.boolean (symmetryPreservesCharge '+ls(p)+' '+ls(charges)+')')
for charges in [(),('a',),('a','a'),('a','a','b','b'),('a','a','a')]:
 for es in [(),((0,0,Fraction(1)),),((0,1,Fraction(1,4)),(1,0,Fraction(1,4))),((0,1,Fraction(1,4)),(1,0,Fraction(1,4)),(2,3,Fraction(1,4)),(3,2,Fraction(1,4))),((-1,-1,Fraction(1,3)),),((0,0,Fraction(-1,4)),),((0,0,Fraction(1,3)),(0,0,Fraction(1,3))),((8,0,Fraction(1)),)]:
  case(lambda charges=charges,es=es:src.complete_symmetry_class(charges,es),'result perms (completeSymmetryClass '+ls(charges)+' '+edge(es)+')')
  for p in [tuple(range(len(charges))),tuple(reversed(range(len(charges))))]:
   case(lambda p=p,es=es:src.preserves_edges_and_carriers(p,es),'result Value.boolean (preservesEdgesAndCarriers '+ls(p)+' '+edge(es)+')')
p=w/'constants-recovery/SymmetryClasses990.lean';p.write_text(s+'#eval IO.println (render (.array [\n'+',\n'.join(expr)+']))\n');env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'symmetry990_classes_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
mods=['SymmetryActionIndexArrangements','SymmetryActionClasses'];ns=[];sha={}
for m in mods:
 code=(r/f'SFT/Physics/{m}.lean').read_text();ns+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)];sha[m]=hashlib.sha256(code.encode()).hexdigest()
audit=w/'symmetry990_classes_audit.lean';audit.write_text('import SFT.Physics.SymmetryActionClasses\n'+''.join('#print axioms '+n+'\n' for n in ns));out=subprocess.check_output([lean,str(audit)],env=env,text=True);(w/'symmetry990_classes_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(ns),out
(w/'symmetry990_classes_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),declarations=ns,axioms=[],lean_sha256=sha),indent=2));print('PASS',len(expected),'complete original symmetry-class cases;',len(ns),'empty declarations')
