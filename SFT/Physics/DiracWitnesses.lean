import SFT.Physics.DiracG
namespace SFT.Physics.DiracWitnesses
open DiracG
structure Witness where
 name : String
 statement : String
 passed : Bool

def bareCheck : Bool := match factor with
 | .error _ => false
 | .ok n => n==2

def binaryCheck : Bool := match factor with
 | .error _ => false
 | .ok n => match AlphaCovers.binaryCount with
  | .error _ => false
  | .ok b => n==b

theorem barePass : bareCheck=true := by unfold bareCheck;rw [sourceAssembly];rfl
theorem binaryPass : binaryCheck=true := by unfold binaryCheck;rw [sourceAssembly,AlphaCovers.binaryCountTwo];rfl
def witnesses : List Witness := [⟨"bare-g","The exact reciprocal of the half-One is two.",bareCheck⟩,⟨"binary-lock","The bare value equals the independently generated binary count.",binaryCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (bareCheck && (binaryCheck && true))=true
 rw [barePass,binaryPass];rfl
end SFT.Physics.DiracWitnesses
