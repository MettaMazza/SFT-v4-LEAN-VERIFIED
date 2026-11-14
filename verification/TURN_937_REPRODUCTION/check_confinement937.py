from pathlib import Path
import json,sys,re,subprocess,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_completion_laws_v1 import confinement_lift
s=(r/'SFT/Physics/ConfinementLift.lean').read_text();names=['SFT.Physics.ConfinementLift.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'ConfinementLiftAudit937.lean';p.write_text('import SFT.Physics.ConfinementLift\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'confinement937_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'ConfinementLiftCompare937.lean';p.write_text('''import SFT.Physics.ConfinementLift
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.ConfinementLift SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let r ← IO.ofExcept confinementLift
 IO.println (render (.object [("down_sharpened_product",fraction r.downSharpenedProduct),("up_sharpened_product",fraction r.upSharpenedProduct),("lightest_carrier_lift",.integer (.ofNat r.lightestCarrierLift)),("acted_carrier",.text r.actedCarrier),("retained_carriers",.array (r.retainedCarriers.map Value.text))]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return [cv(y) for y in x]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 return x
expected=cv(confinement_lift());assert actual==expected
(w/'confinement937_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/matter_flavour_completion_laws_v1.py:confinement_lift,CONFINEMENT_LIFT_SPEC',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS complete five-field confinement record;',len(names),'empty-axiom declarations')
