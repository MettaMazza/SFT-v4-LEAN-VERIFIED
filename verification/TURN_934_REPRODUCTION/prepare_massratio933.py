from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_magneticanomaly925.py').read_text().replace('matter_flavour_laws_v1','matter_flavour_completion_laws_v1').replace('MAGNETIC_ANOMALY_SPEC','MASS_RATIO_FAMILY_SPEC').replace('magneticanomaly925','massratio933').replace('magneticanomaly_witness925','massratio_witness933').replace('MagneticAnomalyEntry','MassRatioFamilyEntry').replace('MagneticAnomaly','MassRatioFamily')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.MassRatioFamily
namespace SFT.Physics.MassRatioFamilyEntryWitnesses
open MassRatioFamily
structure Witness where
 name : String
 statement : String
 passed : Bool
def prefixCheck : Bool := match ([1,2,3].mapM fun d => do let r ← massRatioFamily (.integer (.ofNat d)); pure r.heavyOverLight) with
 | .error _ => false
 | .ok ratios => decide (ratios=[VacuumLedgerProofs.wholeRatio 5,VacuumLedgerProofs.wholeRatio 17,VacuumLedgerProofs.wholeRatio 53])
def witnesses : List Witness := [WITNESS_ROWS]
theorem prefixCheckPassed : prefixCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MassRatioFamilyEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['leadingCheck','bareCheck']","['prefixCheck']");exec(compile(s,'mixing-original-generator','exec'),dict(globals()))
for kind in ['entry','program','independent','original']:
 s=(w/f'check_baryonphoton_{kind}931.py').read_text().replace('931','933').replace('baryonphoton','massratio').replace('BaryonPhotonEntry','MassRatioFamilyEntry').replace('BaryonPhotonTransport','MassRatioFamily').replace('MATTER-BARYON-PHOTON','MATTER-MASS-RATIO-FAMILY').replace('BARYON_PHOTON_SPEC','MASS_RATIO_FAMILY_SPEC');(w/f'check_massratio_{kind}933.py').write_text(s)
s=(w/'prepare_baryonphoton_native931.py').read_text().replace('931','933').replace('BaryonPhotonEntry','MassRatioFamilyEntry').replace('BaryonPhotonTransportProgram','MassRatioFamilyProgram');(w/'prepare_massratio_native933.py').write_text(s)
(r/'MassRatioFamilyProgram933.lean').write_text((r/'BaryonPhotonTransportProgram931.lean').read_text().replace('BaryonPhotonEntry','MassRatioFamilyEntry'))
