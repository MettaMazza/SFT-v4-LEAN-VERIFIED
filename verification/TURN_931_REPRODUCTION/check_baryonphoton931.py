from pathlib import Path
import subprocess,sys,os,json,re
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_completion_laws_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_completion_laws_v1.py').read_bytes()==(w/'original931_matter_flavour_completion_laws_v1.py').read_bytes()
s=(r/'SFT/Physics/BaryonPhotonTransport.lean').read_text();names=['SFT.Physics.BaryonPhotonTransport.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'BaryonPhotonTransportAudit931.lean';p.write_text('import SFT.Physics.BaryonPhotonTransport\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'baryonphoton931_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'BaryonPhotonTransportCompare931.lean';p.write_text('''import SFT.Physics.BaryonPhotonTransport
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.BaryonPhotonTransport
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let p ← IO.ofExcept baryonPhotonRelation
 IO.println (render (.object [("cp_measure",.text p.cpMeasure),("imbalance_share",fraction p.imbalanceShare),("eta_relation",.text p.etaRelation),("root_policy",.text p.rootPolicy)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True));expected={k:([v.numerator,v.denominator] if isinstance(v,Fraction) else v) for k,v in src.baryon_photon_relation().items()};assert actual==expected
(w/'baryonphoton931_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_completion_laws_v1.py:baryon_photon_relation','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS all original4 fields;',len(names),'empty-axiom declarations')
