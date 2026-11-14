from pathlib import Path
import subprocess,sys,os,json,re
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_laws_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_laws_v1.py').read_bytes()==(w/'original916_matter_flavour_laws_v1.py').read_bytes()
s=(r/'SFT/Physics/NeutrinoLadder.lean').read_text();names=['SFT.Physics.NeutrinoLadder.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'NeutrinoLadderAudit920.lean';p.write_text('import SFT.Physics.NeutrinoLadder\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'neutrinoladder920_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
p=r/'NeutrinoLadderCompare920.lean';p.write_text('''import SFT.Physics.NeutrinoLadder
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.NeutrinoLadder
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def outputCount (x : SFT.Physics.GeneratorOperations.CountInput) : Value := match mersenneCount x with
 | .ok n => .integer (.ofNat n)
 | .error e => .text e
#eval do
 let s ← IO.ofExcept neutrinoSplittingStructure
 let m ← IO.ofExcept neutrinoMassSquares
 let counts := ([.integer 1,.integer 2,.integer 5,.integer 10,.integer 16,.integer 0,.integer (-1),.boolean true,.boolean false] : List SFT.Physics.GeneratorOperations.CountInput).map outputCount
 IO.println (render (.object [("splitting",.object [("solar_rung",.integer (.ofNat s.solarRung)),("atmospheric_rung",.integer (.ofNat s.atmosphericRung)),("rung_ratio",fraction s.rungRatio),("translation_ratio",fraction s.translationRatio)]),("mass",.object [("lightest",fraction m.lightest),("middle",fraction m.middle),("heavy",fraction m.heavy)]),("counts",.array counts)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 return x
counts=[]
for x in [1,2,5,10,16,0,-1,True,False]:
 try:counts.append(src.mersenne_count(x))
 except Exception as e:counts.append(type(e).__name__+': '+str(e))
expected=cv({'splitting':src.neutrino_splitting_structure(),'mass':src.neutrino_mass_squares(),'counts':counts});assert actual==expected,(actual,expected)
(w/'neutrinoladder920_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_laws_v1.py:mersenne_count,neutrino_splitting_structure,neutrino_mass_squares','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS complete original splitting,mass fields and9 count/guard cases;',len(names),'empty-axiom declarations')
