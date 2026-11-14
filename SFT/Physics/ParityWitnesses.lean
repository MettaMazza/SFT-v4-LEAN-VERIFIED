import SFT.Physics.ParityFibre
namespace SFT.Physics.ParityWitnesses
open ParityFibre SFT.Foundation
structure Witness where
 name : String
 statement : String
 passed : Bool

def fibreCheck : Bool := match heldFibre with
 | .error _ => false
 | .ok f => f.leftHeld.numerator==1 && f.leftHeld.denominator==4 && f.image.numerator==1 && f.image.denominator==2 && f.rightHeld.numerator==3 && f.rightHeld.denominator==4

def commonImageCheck : Bool := match heldFibre with
 | .error _ => false
 | .ok f => FoldUniformCheck.samePart (ExactOperations.foldPart f.leftHeld) f.image &&
   FoldUniformCheck.samePart (ExactOperations.foldPart f.rightHeld) f.image

def oppositeCheck : Bool := match heldFibre with
 | .error _ => false
 | .ok f => decide (f.leftHeld.numerator*f.image.denominator<f.image.numerator*f.leftHeld.denominator) &&
   decide (f.image.numerator*f.rightHeld.denominator<f.rightHeld.numerator*f.image.denominator)

theorem fibrePass : fibreCheck=true := by unfold fibreCheck;rw [sourceAssembly];rfl
theorem commonImagePass : commonImageCheck=true := by unfold commonImageCheck;rw [sourceAssembly];rfl
theorem oppositePass : oppositeCheck=true := by unfold oppositeCheck;rw [sourceAssembly];rfl
def witnesses : List Witness := [⟨"fibre","The handed fibre has exact lower, image and upper parts.",fibreCheck⟩,⟨"common-image","Both held sides fold to the same image.",commonImageCheck⟩,⟨"opposite-sides","The held parts lie on opposite sides of the common image.",oppositeCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (fibreCheck && (commonImageCheck && (oppositeCheck && true)))=true
 rw [fibrePass,commonImagePass,oppositePass];rfl
end SFT.Physics.ParityWitnesses
