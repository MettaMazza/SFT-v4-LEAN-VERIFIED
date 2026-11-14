from pathlib import Path
import json,sys,re,subprocess,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_completion_laws_v1 import mass_ratio_family
s=(r/'SFT/Physics/MassRatioFamily.lean').read_text();names=['SFT.Physics.MassRatioFamily.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';a=subprocess.check_output([lean,'-j1',str(r/'MassRatioFamilyAudit933.lean')],env=env,text=True);(w/'massratio933_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'MassRatioFamilyCompare933.lean';p.write_text('''import SFT.Physics.MassRatioFamily
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.MassRatioFamily SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def result (r : Result) : Value := .object [("support",.integer (.ofNat r.support)),("light",fraction r.light),("central",fraction r.central),("heavy",fraction r.heavy),("heavy_over_light",fraction r.heavyOverLight)]
#eval do
 let values : List GeneratorOperations.CountInput := [.boolean false,.boolean true,.integer (-2),.integer 0,.integer 1,.integer 2,.integer 3,.integer 4,.integer 5,.integer 7,.integer 12]
 let rows := values.map fun v => match massRatioFamily v with
  | .error e => Value.object [("error",.text e)]
  | .ok r => result r
 IO.println (render (.array rows))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 return x
expected=[]
for x in [False,True,-2,0,1,2,3,4,5,7,12]:
 try:expected.append(cv(mass_ratio_family(x)))
 except ValueError as e:expected.append({'error':str(e)})
assert actual==expected
(w/'massratio933_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/matter_flavour_completion_laws_v1.py:mass_ratio_family,MASS_RATIO_FAMILY_SPEC',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS complete five-field records and rejected boolean/nonpositive domains;',len(names),'empty-axiom declarations')
