import SFT.Physics.CoulombGauss
namespace SFT.Physics.CoulombWitnesses
open CoulombGauss
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def innerCheck : Bool := match coulombGaussClosure sourceEighth (.fraction innerRadius) with
 | .error _ => false
 | .ok x => same (BoundaryGrowth.asFraction x.flux) sourceEighth && same x.retainedPotential ⟨1,2,by decide,by decide⟩
def outerCheck : Bool := match coulombGaussClosure sourceEighth (.fraction outerRadius) with
 | .error _ => false
 | .ok x => same (BoundaryGrowth.asFraction x.flux) sourceEighth && same x.retainedPotential ⟨3,4,by decide,by decide⟩
def witnesses : List Witness := [⟨"inner","The inner shell reconstructs source and half-One potential.",innerCheck⟩,⟨"outer","The outer shell reconstructs source and three-quarter potential.",outerCheck⟩]
theorem innerCheckPassed : innerCheck=true := by unfold innerCheck;rw [innerSourceRecord];rfl
theorem outerCheckPassed : outerCheck=true := by unfold outerCheck;rw [outerSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (innerCheck && outerCheck && true)=true
 rw [innerCheckPassed,outerCheckPassed]
 rfl
end SFT.Physics.CoulombWitnesses
