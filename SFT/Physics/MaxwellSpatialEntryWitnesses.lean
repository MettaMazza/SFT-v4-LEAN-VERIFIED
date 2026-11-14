import SFT.Physics.MaxwellCurvature
namespace SFT.Physics.MaxwellSpatialEntryWitnesses
open MaxwellCurvature
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def recordCheck : Bool := match maxwellClosure (.integer 3) with
 | .error _ => false
 | .ok x => x.dimension==3 && x.spatialCurvature==6 && x.temporalCurvature==2 && same x.totalRatio ⟨3,1,by decide,by decide⟩ && same x.speedSquare ⟨1,1,by decide,by decide⟩
def witnesses : List Witness := [⟨"three-space","Three-space curvatures and speed close exactly.",recordCheck⟩]
theorem recordCheckPassed : recordCheck=true := by unfold recordCheck;rw [spatialSource];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (recordCheck && true)=true
 rw [recordCheckPassed]
 rfl
end SFT.Physics.MaxwellSpatialEntryWitnesses
