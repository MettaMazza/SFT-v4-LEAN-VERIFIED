import SFT.Physics.MagneticAnomaly
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
def witnesses : List Witness := [⟨"leading","The leading normalized anomaly is an exact positive terminal-alpha part.",leadingCheck⟩,⟨"bare","Bare g remains the generated binary count.",bareCheck⟩]
theorem leadingCheckPassed : leadingCheck=true := rfl
theorem bareCheckPassed : bareCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MagneticAnomalyEntryWitnesses
