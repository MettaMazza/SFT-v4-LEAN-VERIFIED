from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_magneticanomaly925.py').read_text().replace('matter_flavour_laws_v1','matter_flavour_completion_laws_v1').replace('MAGNETIC_ANOMALY_SPEC','CONFINEMENT_LIFT_SPEC').replace('magneticanomaly925','confinement937').replace('magneticanomaly_witness925','confinement_witness937').replace('MagneticAnomalyEntry','ConfinementLiftEntry').replace('MagneticAnomaly','ConfinementLift')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.ConfinementLift
namespace SFT.Physics.ConfinementLiftEntryWitnesses
open ConfinementLift
structure Witness where
 name : String
 statement : String
 passed : Bool
def productsCheck : Bool := match sharpenedQuarkProducts with
 | .error _ => false
 | .ok p => match confinementLift with
   | .error _ => false
   | .ok r => p.down == LeptonIntervals.normalize 3 1454 (by decide) && p.up == LeptonIntervals.normalize 3 13118 (by decide) && r.lightestCarrierLift == 2
def witnesses : List Witness := [WITNESS_ROWS]
theorem productsCheckPassed : productsCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.ConfinementLiftEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['leadingCheck','bareCheck']","['productsCheck']");exec(compile(s,'mixing-original-generator','exec'),dict(globals()))
for kind in ['entry','program','independent','original']:
 s=(w/f'check_baryonphoton_{kind}931.py').read_text().replace('931','937').replace('baryonphoton','confinement').replace('BaryonPhotonEntry','ConfinementLiftEntry').replace('BaryonPhotonTransport','ConfinementLift').replace('MATTER-BARYON-PHOTON','MATTER-CONFINEMENT-LIFT').replace('BARYON_PHOTON_SPEC','CONFINEMENT_LIFT_SPEC');(w/f'check_confinement_{kind}937.py').write_text(s)
s=(w/'prepare_baryonphoton_native931.py').read_text().replace('931','937').replace('BaryonPhotonEntry','ConfinementLiftEntry').replace('BaryonPhotonTransportProgram','ConfinementLiftProgram');(w/'prepare_confinement_native937.py').write_text(s)
(r/'ConfinementLiftProgram937.lean').write_text((r/'BaryonPhotonTransportProgram931.lean').read_text().replace('BaryonPhotonEntry','ConfinementLiftEntry'))
