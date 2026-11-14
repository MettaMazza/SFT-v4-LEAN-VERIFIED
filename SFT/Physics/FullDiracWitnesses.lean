import SFT.Physics.FullDiracSquare
namespace SFT.Physics.FullDiracWitnesses
open FullDiracSquare
structure Witness where
 name : String
 statement : String
 passed : Bool
def sameOne (a : Rat) : Bool := !a.blt (⟨1,1,by decide,by decide⟩ : Rat) && !(⟨1,1,by decide,by decide⟩ : Rat).blt a
def directCheck : Bool := match fullDiracSquare with
 | .error _ => false
 | .ok x => sameOne x.directSquare
def polarizedCheck : Bool := match fullDiracSquare with
 | .error _ => false
 | .ok x => sameOne x.polarizedSquare
def absenceCheck : Bool := match fullDiracSquare with
 | .error _ => false
 | .ok x => x.heldEqualDifferences.length == 2 && x.heldEqualDifferences.all (fun d => match d with | .empty => true | .left _ => false | .right _ => false)
def witnesses : List Witness := [⟨"direct","The four component squares sum to One.",directCheck⟩,⟨"polarized","The polarized route also closes at One.",polarizedCheck⟩,⟨"absence","Equal differences are structural empty records.",absenceCheck⟩]
theorem directCheckPassed : directCheck=true := by unfold directCheck;rw [sourceAssembly];rfl
theorem polarizedCheckPassed : polarizedCheck=true := by unfold polarizedCheck;rw [sourceAssembly];rfl
theorem absenceCheckPassed : absenceCheck=true := by unfold absenceCheck;rw [sourceAssembly];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (directCheck && polarizedCheck && absenceCheck && true)=true
 rw [directCheckPassed,polarizedCheckPassed,absenceCheckPassed]
 rfl
end SFT.Physics.FullDiracWitnesses
