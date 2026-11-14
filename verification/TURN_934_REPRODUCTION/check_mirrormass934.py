from pathlib import Path
import json,sys,re,subprocess,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_completion_laws_v1 import mirror_mass_closure
s=(r/'SFT/Physics/MirrorMassClosure.lean').read_text();names=['SFT.Physics.MirrorMassClosure.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'MirrorMassClosureAudit934.lean';p.write_text('import SFT.Physics.MirrorMassClosure\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'mirrormass934_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'MirrorMassClosureCompare934.lean';p.write_text('''import SFT.Physics.MirrorMassClosure
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.MirrorMassClosure SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let r ← IO.ofExcept mirrorMassClosure
 IO.println (render (.object [("positions",.array (r.positions.map fraction)),("shortfalls",.array (r.shortfalls.map fraction)),("position_sum",fraction r.positionSum),("shortfall_sum",fraction r.shortfallSum),("mirror_closed",.boolean r.mirrorClosed)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return [cv(y) for y in x]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 return x
expected=cv(mirror_mass_closure());assert actual==expected
(w/'mirrormass934_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/matter_flavour_completion_laws_v1.py:mirror_mass_closure,MIRROR_MASS_SPEC',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS complete five-field mirror record;',len(names),'empty-axiom declarations')
