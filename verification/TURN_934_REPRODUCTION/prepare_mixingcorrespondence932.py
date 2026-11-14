from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_magneticanomaly925.py').read_text().replace('matter_flavour_laws_v1','matter_flavour_completion_laws_v1').replace('MAGNETIC_ANOMALY_SPEC','MIXING_CORRESPONDENCE_SPEC').replace('magneticanomaly925','mixingcorrespondence932').replace('magneticanomaly_witness925','mixingcorrespondence_witness932').replace('MagneticAnomalyEntry','MixingCorrespondenceEntry').replace('MagneticAnomaly','MixingCorrespondence')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.MixingCorrespondence
namespace SFT.Physics.MixingCorrespondenceEntryWitnesses
open MixingCorrespondence
structure Witness where
 name : String
 statement : String
 passed : Bool
def rowCheck : Bool := match mixingCorrespondence with
 | .error _ => false
 | .ok result => decide (result.leptonMatrix.headD []=originalLeptonMatrix.headD [])
def witnesses : List Witness := [WITNESS_ROWS]
theorem rowCheckPassed : rowCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MixingCorrespondenceEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['leadingCheck','bareCheck']","['rowCheck']");exec(compile(s,'mixing-original-generator','exec'),dict(globals()))
for kind in ['entry','program','independent','original']:
 s=(w/f'check_baryonphoton_{kind}931.py').read_text().replace('931','932').replace('baryonphoton','mixingcorrespondence').replace('BaryonPhotonEntry','MixingCorrespondenceEntry').replace('BaryonPhotonTransport','MixingCorrespondence').replace('MATTER-BARYON-PHOTON','MATTER-MIXING-CORRESPONDENCE').replace('BARYON_PHOTON_SPEC','MIXING_CORRESPONDENCE_SPEC');(w/f'check_mixingcorrespondence_{kind}932.py').write_text(s)
s=(w/'prepare_baryonphoton_native931.py').read_text().replace('931','932').replace('BaryonPhotonEntry','MixingCorrespondenceEntry').replace('BaryonPhotonTransportProgram','MixingCorrespondenceProgram');(w/'prepare_mixingcorrespondence_native932.py').write_text(s)
(r/'MixingCorrespondenceProgram932.lean').write_text((r/'BaryonPhotonTransportProgram931.lean').read_text().replace('BaryonPhotonEntry','MixingCorrespondenceEntry'))
