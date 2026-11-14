import SFT.Physics.GravitySelfSource
namespace SFT.Physics.GravitySelfSourceEntryWitnesses
open GravitySelfSource
structure Witness where
 name : String
 statement : String
 passed : Bool
def sourceCheck : Bool := match nonlinearGravity with
 | .error _ => false
 | .ok x => !x.selfSourceCorrection.blt ⟨1,72,by decide,by decide⟩ && !(⟨1,72,by decide,by decide⟩ : Rat).blt x.selfSourceCorrection
def witnesses : List Witness := [⟨"self-source","The complete exact nonlinear ledger closes.",sourceCheck⟩]
theorem sourceCheckPassed : sourceCheck=true := by unfold sourceCheck;rw [completeSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (sourceCheck && true)=true
 rw [sourceCheckPassed]
 rfl
end SFT.Physics.GravitySelfSourceEntryWitnesses
