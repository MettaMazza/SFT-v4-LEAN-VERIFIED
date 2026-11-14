import SFT.Physics.GravitySourceProofs
namespace SFT.Physics.GravityFluxEntryWitnesses
open GravityFlux
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def innerCheck : Bool := match weakGravity (.fraction ⟨1,8,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) with
 | .error _ => false
 | .ok x => same x.flux ⟨1,8,by decide,by decide⟩ && same x.clockPotential ⟨1,2,by decide,by decide⟩
def outerCheck : Bool := match weakGravity (.fraction ⟨1,8,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩) with
 | .error _ => false
 | .ok x => same x.flux ⟨1,8,by decide,by decide⟩ && same x.clockPotential ⟨3,4,by decide,by decide⟩
def witnesses : List Witness := [⟨"inner","Inner shell retains source and half-One potential.",innerCheck⟩,⟨"outer","Outer shell retains source and three-quarter potential.",outerCheck⟩]
theorem innerCheckPassed : innerCheck=true := by unfold innerCheck;rw [innerSourceRecord];rfl
theorem outerCheckPassed : outerCheck=true := by unfold outerCheck;rw [outerSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (innerCheck && outerCheck && true)=true
 rw [innerCheckPassed,outerCheckPassed]
 rfl
end SFT.Physics.GravityFluxEntryWitnesses
