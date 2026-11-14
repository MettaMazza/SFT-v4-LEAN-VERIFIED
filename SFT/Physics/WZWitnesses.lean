import SFT.Physics.WZRelation
namespace SFT.Physics.WZWitnesses
open WZRelation SFT.Foundation
structure Witness where
 name : String
 statement : String
 passed : Bool

def ratioCheck : Bool := match squaredRatio with
 | .error _ => false
 | .ok p => p.numerator==3 && p.denominator==4

def partitionCheck : Bool := match squaredRatio with
 | .error _ => false
 | .ok p => match ElectroweakMixing.mixing with
  | .error _ => false
  | .ok m => let sum := FoldDynamics.sumParts p m.sinSquared
             sum.numerator==sum.denominator

theorem ratioPass : ratioCheck=true := by unfold ratioCheck;rw [sourceAssembly];rfl
theorem partitionPass : partitionCheck=true := by unfold partitionCheck;rw [sourceAssembly,ElectroweakMixing.nativeMixing];rfl
def witnesses : List Witness := [⟨"ratio","The squared ratio is the forced upper channel part.",ratioCheck⟩,⟨"partition","The squared ratio and lower channel part reassemble the One.",partitionCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (ratioCheck && (partitionCheck && true))=true
 rw [ratioPass,partitionPass];rfl
end SFT.Physics.WZWitnesses
