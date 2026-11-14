import SFT.Physics.OpticalOperations
namespace SFT.Physics.OpticalEntryWitnesses
open OpticalOperations
structure Witness where
 name : String
 statement : String
 passed : Bool
def walkCheck : Bool := match exactOpticalOperations with
 | .error _ => false
 | .ok x => x.propagation.length==8 && x.propagation.all (same ⟨1,3,by decide,by decide⟩)
def polarizationCheck : Bool := match exactOpticalOperations with
 | .error _ => false
 | .ok x => x.polarization==["transverse-left","transverse-right"]
def interferenceCheck : Bool := match exactOpticalOperations with
 | .error _ => false
 | .ok x => same x.brightSupport ⟨1,1,by decide,by decide⟩ && x.darkRecord.isEmpty
def mixingCheck : Bool := match exactOpticalOperations with
 | .error _ => false
 | .ok x => same x.mixing.sum ⟨7,12,by decide,by decide⟩ && same x.mixing.positiveDifference ⟨1,12,by decide,by decide⟩
def witnesses : List Witness := [⟨"walk","Eight One-speed ticks retain the phase.",walkCheck⟩,⟨"polarization","The two transverse labels remain held.",polarizationCheck⟩,⟨"interference","Bright is One and dark is structural absence.",interferenceCheck⟩,⟨"mixing","Exact nonlinear outputs are generated without fitting.",mixingCheck⟩]
theorem walkCheckPassed : walkCheck=true := by unfold walkCheck;rw [completeSourceRecord];rfl
theorem polarizationCheckPassed : polarizationCheck=true := by unfold polarizationCheck;rw [completeSourceRecord];rfl
theorem interferenceCheckPassed : interferenceCheck=true := by unfold interferenceCheck;rw [completeSourceRecord];rfl
theorem mixingCheckPassed : mixingCheck=true := by unfold mixingCheck;rw [completeSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (walkCheck && (polarizationCheck && (interferenceCheck && (mixingCheck && true))))=true
 rw [walkCheckPassed,polarizationCheckPassed,interferenceCheckPassed,mixingCheckPassed]
 rfl
end SFT.Physics.OpticalEntryWitnesses
