import SFT.Physics.MaxwellCurvature
namespace SFT.Physics.MaxwellPlanarEntryWitnesses
open MaxwellCurvature
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def recordCheck : Bool := match maxwellClosure (.integer 2) with
 | .error _ => false
 | .ok x => x.dimension==2 && x.spatialCurvature==4 && x.temporalCurvature==2 && same x.totalRatio ⟨2,1,by decide,by decide⟩ && same x.speedSquare ⟨1,1,by decide,by decide⟩
def witnesses : List Witness := [⟨"planar","Planar curvatures and speed close exactly.",recordCheck⟩]
theorem recordCheckPassed : recordCheck=true := by unfold recordCheck;rw [planarSource];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (recordCheck && true)=true
 rw [recordCheckPassed]
 rfl
end SFT.Physics.MaxwellPlanarEntryWitnesses
