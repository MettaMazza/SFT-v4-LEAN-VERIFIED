from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_magneticanomaly925.py').read_text().replace('matter_flavour_laws_v1','matter_flavour_completion_laws_v1').replace('MAGNETIC_ANOMALY_SPEC','BARYON_PHOTON_SPEC').replace('magneticanomaly925','baryonphoton931').replace('magneticanomaly_witness925','baryonphoton_witness931').replace('MagneticAnomalyEntry','BaryonPhotonEntry').replace('MagneticAnomaly','BaryonPhotonTransport')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.BaryonPhotonTransport
namespace SFT.Physics.BaryonPhotonEntryWitnesses
open BaryonPhotonTransport
structure Witness where
 name : String
 statement : String
 passed : Bool
def halfCheck : Bool := match baryonPhotonRelation with
 | .error _ => false
 | .ok result => decide (result.imbalanceShare=LeptonIntervals.normalize 1 2 (by decide))
def witnesses : List Witness := [WITNESS_ROWS]
theorem halfCheckPassed : halfCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.BaryonPhotonEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['leadingCheck','bareCheck']","['halfCheck']");exec(compile(s,'baryon-photon-original-generator','exec'),dict(globals()))
for kind in ['entry','program','independent','original']:
 s=(w/f'check_magneticanomaly_{kind}925.py').read_text().replace('925','931').replace('magneticanomaly','baryonphoton').replace('MagneticAnomalyEntry','BaryonPhotonEntry').replace('MagneticAnomaly','BaryonPhotonTransport').replace('QED-LEPTON-MAGNETIC-ANOMALY','MATTER-BARYON-PHOTON').replace('MAGNETIC_ANOMALY_SPEC','BARYON_PHOTON_SPEC').replace('matter_flavour_laws_v1','matter_flavour_completion_laws_v1').replace('matter_flavour_validator_v1','matter_flavour_completion_validator_v1');(w/f'check_baryonphoton_{kind}931.py').write_text(s)
s=(w/'prepare_magneticanomaly_native925.py').read_text().replace('925','931').replace('MagneticAnomalyEntry','BaryonPhotonEntry').replace('MagneticAnomalyProgram','BaryonPhotonTransportProgram');(w/'prepare_baryonphoton_native931.py').write_text(s)
(r/'BaryonPhotonTransportProgram931.lean').write_text((r/'MagneticAnomalyProgram925.lean').read_text().replace('MagneticAnomalyEntry','BaryonPhotonEntry'))
