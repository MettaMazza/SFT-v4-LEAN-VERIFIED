import SFT.Physics.ElectroweakMixing
namespace SFT.Physics.MixingWitnesses
open ElectroweakMixing SFT.Foundation SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
set_option maxRecDepth 20000
structure Witness where
 name : String
 statement : String
 passed : Bool

def preimagesCheck : Bool :=
 match halfOnePreimages with
 | .error _ => false
 | .ok parts => (parts.map fun p => (p.numerator,p.denominator)) == [(1,4),(3,4)]

def returnCheck : Bool :=
 match halfOnePreimages with
 | .error _ => false
 | .ok parts => parts.all (fun p => FoldUniformCheck.samePart (foldPart p) HalfOneDerivation.halfOne)

def partitionCheck : Bool :=
 match mixing with
 | .error _ => false
 | .ok result =>
   let sum := FoldDynamics.sumParts result.sinSquared result.cosSquared
   sum.numerator == sum.denominator

theorem preimagesPass : preimagesCheck = true := by unfold preimagesCheck; rw [nativeFibre]; rfl
theorem returnPass : returnCheck = true := by unfold returnCheck; rw [nativeFibre]; rfl
theorem partitionPass : partitionCheck = true := by unfold partitionCheck; rw [nativeMixing]; rfl

def witnesses : List Witness := [⟨"preimages","The complete half-One fibre is one-quarter and three-quarters.",preimagesCheck⟩,⟨"return","Both channel parts Fold to the same balance carrier.",returnCheck⟩,⟨"partition","The two channel parts reassemble the One.",partitionCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (preimagesCheck && (returnCheck && (partitionCheck && true))) = true
 rw [preimagesPass,returnPass,partitionPass]
 rfl
end SFT.Physics.MixingWitnesses
