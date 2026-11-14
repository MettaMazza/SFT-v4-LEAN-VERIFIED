from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_ckmfibres917.py').read_text().replace('CKM_FIBRE_SPEC','MAGNETIC_ANOMALY_SPEC').replace('ckmfibres917','magneticanomaly925').replace('ckmfibres_witness917','magneticanomaly_witness925').replace('CKMFibreEntry','MagneticAnomalyEntry').replace('CKMFibres','MagneticAnomaly')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.MagneticAnomaly
namespace SFT.Physics.MagneticAnomalyEntryWitnesses
open MagneticAnomaly
structure Witness where
 name : String
 statement : String
 passed : Bool
def leadingCheck : Bool := match magneticAnomalyStructure with
 | .error _ => false
 | .ok f => decide (f.phaseNormalizedLeadingAnomaly=originalRecord.phaseNormalizedLeadingAnomaly)
def bareCheck : Bool := match magneticAnomalyStructure with
 | .error _ => false
 | .ok f => decide (f.bareG=2)
def witnesses : List Witness := [WITNESS_ROWS]
theorem leadingCheckPassed : leadingCheck=true := rfl
theorem bareCheckPassed : bareCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MagneticAnomalyEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['matrixCheck']","['leadingCheck','bareCheck']");(w/'prepare_magneticanomaly925.py').write_text(s)
for kind in ['entry','program','independent','original']:
 s=(w/f'check_ckmfibres_{kind}917.py').read_text().replace('917','925').replace('ckmfibres','magneticanomaly').replace('CKMFibreEntry','MagneticAnomalyEntry').replace('CKMFibres','MagneticAnomaly').replace('MATTER-CKM-FIBRE','QED-LEPTON-MAGNETIC-ANOMALY').replace('CKM_FIBRE_SPEC','MAGNETIC_ANOMALY_SPEC');(w/f'check_magneticanomaly_{kind}925.py').write_text(s)
s=(w/'prepare_ckmfibres_native917.py').read_text().replace('917','925').replace('CKMFibreEntry','MagneticAnomalyEntry').replace('CKMFibresProgram','MagneticAnomalyProgram');(w/'prepare_magneticanomaly_native925.py').write_text(s)
(r/'MagneticAnomalyProgram925.lean').write_text((r/'CKMFibresProgram917.lean').read_text().replace('CKMFibreEntry','MagneticAnomalyEntry'))
