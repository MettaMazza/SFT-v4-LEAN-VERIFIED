from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_magneticanomaly925.py').read_text().replace('matter_flavour_laws_v1','matter_flavour_completion_laws_v1').replace('MAGNETIC_ANOMALY_SPEC','INTER_ENTRY_SPEC').replace('magneticanomaly925','mixingrow935').replace('magneticanomaly_witness925','mixingrow_witness935').replace('MagneticAnomalyEntry','MixingRowCouplingEntry').replace('MagneticAnomaly','MixingRowCoupling')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.MixingRowCoupling
namespace SFT.Physics.MixingRowCouplingEntryWitnesses
open MixingRowCoupling
structure Witness where
 name : String
 statement : String
 passed : Bool
def locksCheck : Bool := match interEntryCouplings with
 | .error _ => false
 | .ok result => result.quarkLock == LeptonIntervals.normalize 2 3 (by decide) && result.leptonLock == LeptonIntervals.normalize 1 2 (by decide)
def witnesses : List Witness := [WITNESS_ROWS]
theorem locksCheckPassed : locksCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MixingRowCouplingEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['leadingCheck','bareCheck']","['locksCheck']");exec(compile(s,'mixing-original-generator','exec'),dict(globals()))
for kind in ['entry','program','independent','original']:
 s=(w/f'check_baryonphoton_{kind}931.py').read_text().replace('931','935').replace('baryonphoton','mixingrow').replace('BaryonPhotonEntry','MixingRowCouplingEntry').replace('BaryonPhotonTransport','MixingRowCoupling').replace('MATTER-BARYON-PHOTON','MATTER-INTER-ENTRY-COUPLING').replace('BARYON_PHOTON_SPEC','INTER_ENTRY_SPEC');(w/f'check_mixingrow_{kind}935.py').write_text(s)
s=(w/'prepare_baryonphoton_native931.py').read_text().replace('931','935').replace('BaryonPhotonEntry','MixingRowCouplingEntry').replace('BaryonPhotonTransportProgram','MixingRowCouplingProgram');(w/'prepare_mixingrow_native935.py').write_text(s)
(r/'MixingRowCouplingProgram935.lean').write_text((r/'BaryonPhotonTransportProgram931.lean').read_text().replace('BaryonPhotonEntry','MixingRowCouplingEntry'))
