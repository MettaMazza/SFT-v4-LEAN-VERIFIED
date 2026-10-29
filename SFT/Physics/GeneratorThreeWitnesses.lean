import SFT.Physics.GeneratorOperations
namespace SFT.Physics.GeneratorThreeWitnesses
open FoldFirstReturn FoldReturnCarrier GeneratorThreeDerivation
structure Witness where
  name : String
  statement : String
  passed : Bool

def binaryCheck : Bool := match firstReturn (unitPart 2 (by decide)) with
 | .ok trace => trace.map key == [(2,3),(1,3)]
 | .error _ => false

def ternaryCheck : Bool := match firstReturn (unitPart 3 (by decide)) with
 | .ok trace => trace.map key == [(2,7),(4,7),(1,7)]
 | .error _ => false

def generatorCheck : Bool := match generatorPeriod with
 | .ok count => count == 3
 | .error _ => false

def witnesses : List Witness := [⟨"binary-orbit","The depth-two predecessor unit part returns in exactly two Folds.",binaryCheck⟩,⟨"generator-three-orbit","The depth-three predecessor unit part returns in exactly three Folds.",ternaryCheck⟩,⟨"least-distinct-period","The witnessed period three is the positive successor of the binary period two.",generatorCheck⟩]
theorem binaryCheckPassed : binaryCheck = true := by
  unfold binaryCheck
  rw [depthTwoUnit,binaryNative]
  rfl

theorem ternaryCheckPassed : ternaryCheck = true := by
  unfold ternaryCheck
  rw [depthThreeUnit,ternaryNative]
  rfl

theorem generatorCheckPassed : generatorCheck = true := by
  unfold generatorCheck
  rw [generatorPeriodThree]
  rfl

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
  change (binaryCheck && (ternaryCheck && (generatorCheck && true))) = true
  rw [binaryCheckPassed,ternaryCheckPassed,generatorCheckPassed]
  rfl
end SFT.Physics.GeneratorThreeWitnesses
