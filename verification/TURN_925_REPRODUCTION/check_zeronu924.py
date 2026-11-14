from pathlib import Path
import subprocess,sys,os,json,re
from fractions import Fraction as F
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_laws_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_laws_v1.py').read_bytes()==(w/'original916_matter_flavour_laws_v1.py').read_bytes()
s=(r/'SFT/Physics/NeutrinolessBounds.lean').read_text();names=['SFT.Physics.NeutrinolessBounds.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive|abbrev) (\w+)',s,re.M)];p=r/'ZeroNuAudit924.lean';p.write_text('import SFT.Physics.NeutrinolessBounds\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'zeronu924_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
values=[F(1,32),F(33,32),F(3203,96),F(1),F(1,2),F(1,4),F(1,100),F(1,4096),F(4),F(9,4),F(100,3),F(0),F(-1),1]
bisects=[((F(1,8),F(1,4)),F(1,32)),((F(1),F(2)),F(33,32)),((F(5),F(6)),F(3203,96)),((F(1,2),F(1)),F(9,16)),((F(-1),F(1)),F(0))]
def rat(x):return '⟨'+str(x.numerator)+','+str(x.denominator)+',by decide,by decide⟩'
inputs=','.join('.fraction '+rat(x) if isinstance(x,F) else '.nonFraction' for x in values)
terms=','.join('bisectSquare ('+rat(b[0])+','+rat(b[1])+') '+rat(v) for b,v in bisects)
p=r/'ZeroNuCompare924.lean';p.write_text('''import SFT.Physics.NeutrinolessBounds
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.NeutrinolessBounds
set_option maxRecDepth 20000
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def bracketValue (b : Bracket) : Value := .array [fraction b.1,fraction b.2]
def outcome (r : Except String Bracket) : Value := match r with
 | .error e => .text ("ValueError: " ++ e)
 | .ok b => bracketValue b
#eval do
 let p ← IO.ofExcept zeroNuNoncancellation
 let values : List SFT.Physics.FoldFirstReturn.Input := ['''+inputs+''']
 let halves : List (Except String Bracket) := ['''+terms+''']
 IO.println (render (.object [("result",.object [("positive_floor_coefficient",fraction p.positiveFloorCoefficient),("ceiling_coefficient",fraction p.ceilingCoefficient),("root_brackets",.array [bracketValue p.rootBrackets.1,bracketValue p.rootBrackets.2.1,bracketValue p.rootBrackets.2.2])]),("sqrt_cases",.array (values.map (fun v => outcome (sqrtBracket v)))),("bisect_cases",.array (halves.map outcome))]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True))
def cv(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 if isinstance(x,(list,tuple)):return list(map(cv,x))
 return x
cases=[]
for x in values:
 try:cases.append(src.sqrt_bracket(x))
 except Exception as e:cases.append(type(e).__name__+': '+str(e))
expected=cv({'result':src.zero_nu_noncancellation(),'sqrt_cases':cases,'bisect_cases':[src.bisect_square(b,v) for b,v in bisects]});assert actual==expected,(actual,expected)
(w/'zeronu924_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_laws_v1.py:sqrt_bracket,bisect_square,zero_nu_noncancellation','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS complete original result,14 root/domain cases,5 bisection cases;',len(names),'empty-axiom declarations')
