from pathlib import Path
import subprocess,sys,os,json,re
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_laws_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_laws_v1.py').read_bytes()==(w/'original916_matter_flavour_laws_v1.py').read_bytes()
s=(r/'SFT/Physics/MajoranaStructure.lean').read_text();names=['SFT.Physics.MajoranaStructure.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'MajoranaAudit923.lean';p.write_text('import SFT.Physics.MajoranaStructure\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'majorana923_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
p=r/'MajoranaCompare923.lean';p.write_text('''import SFT.Physics.MajoranaStructure
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.MajoranaStructure SFT.Physics.FoldFirstReturn
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def optionalValue : Option Rat → Value | none => .array [] | some r => fraction r
def takeValue (a b : Input) : Value := match positiveTake a b with
 | .error e => .text ("ValueError: " ++ e)
 | .ok r => optionalValue r
#eval do
 let p ← IO.ofExcept majoranaStructure
 let one : Input := .fraction ⟨1,1,by decide,by decide⟩
 let half : Input := .fraction ⟨1,2,by decide,by decide⟩
 let zero : Input := .fraction ⟨0,1,by decide,by decide⟩
 let negative : Input := .fraction ⟨-1,1,by decide,by decide⟩
 let cases := [takeValue one half,takeValue one one,takeValue half one,takeValue one zero,takeValue one negative,takeValue negative half,takeValue .nonFraction half,takeValue one .nonFraction]
 IO.println (render (.object [("record",.object [("left_hand",fraction p.leftHand),("right_hand",fraction p.rightHand),("dirac_pair_separation",optionalValue p.diracPairSeparation),("single_hand_count",.integer (.ofNat p.singleHandCount)),("self_antipodal_lock",.boolean p.selfAntipodalLock),("generic_hand_self_antipodal",.boolean p.genericHandSelfAntipodal),("class",.text p.classification)]),("take_cases",.array cases)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 if isinstance(x,(list,tuple)):return list(map(cv,x))
 return x
F=Fraction;cases=[]
for a,b in [(F(1),F(1,2)),(F(1),F(1)),(F(1,2),F(1)),(F(1),F(0)),(F(1),F(-1)),(F(-1),F(1,2)),(1,F(1,2)),(F(1),1)]:
 try:cases.append(src.positive_take(a,b))
 except Exception as e:cases.append(type(e).__name__+': '+str(e))
expected=cv({'record':src.majorana_structure(),'take_cases':cases});assert actual==expected,(actual,expected)
(w/'majorana923_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_laws_v1.py:positive_take,majorana_structure','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS all original7 fields and8 positive-take cases;',len(names),'empty-axiom declarations')
