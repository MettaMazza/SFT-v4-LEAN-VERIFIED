from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_magneticanomaly925.py').read_text().replace('matter_flavour_laws_v1','matter_flavour_completion_laws_v1').replace('MAGNETIC_ANOMALY_SPEC','MIRROR_MASS_SPEC').replace('magneticanomaly925','mirrormass934').replace('magneticanomaly_witness925','mirrormass_witness934').replace('MagneticAnomalyEntry','MirrorMassClosureEntry').replace('MagneticAnomaly','MirrorMassClosure')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.MirrorMassClosure
namespace SFT.Physics.MirrorMassClosureEntryWitnesses
open MirrorMassClosure
structure Witness where
 name : String
 statement : String
 passed : Bool
def mirrorCheck : Bool := match mirrorMassClosure with
 | .error _ => false
 | .ok result => result.mirrorClosed
def witnesses : List Witness := [WITNESS_ROWS]
theorem mirrorCheckPassed : mirrorCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MirrorMassClosureEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['leadingCheck','bareCheck']","['mirrorCheck']");exec(compile(s,'mixing-original-generator','exec'),dict(globals()))
for kind in ['entry','program','independent','original']:
 s=(w/f'check_baryonphoton_{kind}931.py').read_text().replace('931','934').replace('baryonphoton','mirrormass').replace('BaryonPhotonEntry','MirrorMassClosureEntry').replace('BaryonPhotonTransport','MirrorMassClosure').replace('MATTER-BARYON-PHOTON','MATTER-MIRROR-MASS-CLOSURE').replace('BARYON_PHOTON_SPEC','MIRROR_MASS_SPEC');(w/f'check_mirrormass_{kind}934.py').write_text(s)
s=(w/'prepare_baryonphoton_native931.py').read_text().replace('931','934').replace('BaryonPhotonEntry','MirrorMassClosureEntry').replace('BaryonPhotonTransportProgram','MirrorMassClosureProgram');(w/'prepare_mirrormass_native934.py').write_text(s)
(r/'MirrorMassClosureProgram934.lean').write_text((r/'BaryonPhotonTransportProgram931.lean').read_text().replace('BaryonPhotonEntry','MirrorMassClosureEntry'))
