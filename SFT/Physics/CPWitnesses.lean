import SFT.Physics.CPPhase
namespace SFT.Physics.CPWitnesses
open CPPhase SFT.Foundation
structure Witness where
 name : String
 statement : String
 passed : Bool

def phaseCheck : Bool := match phasePosition with
 | .error _ => false
 | .ok p => p.numerator==1 && p.denominator==2

def returnCheck : Bool := match phasePosition with
 | .error _ => false
 | .ok p => FoldUniformCheck.samePart (ExactOperations.foldPart p) ExactOperations.one

def antipodeCheck : Bool := match phasePosition with
 | .error _ => false
 | .ok p => match HalfOneDerivation.complement p with
  | .error _ => false
  | .ok q => FoldUniformCheck.samePart p q

theorem phasePass : phaseCheck=true := by unfold phaseCheck;rw [sourceAssembly];rfl
theorem returnPass : returnCheck=true := by unfold returnCheck;rw [sourceAssembly];rfl
theorem antipodePass : antipodeCheck=true := by unfold antipodeCheck;rw [sourceAssembly];rfl
def witnesses : List Witness := [⟨"phase","The generated phase carrier is exactly one-half.",phaseCheck⟩,⟨"return","The half-One folds to the One.",returnCheck⟩,⟨"antipode","The held complement of the half-One is itself.",antipodeCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (phaseCheck && (returnCheck && (antipodeCheck && true)))=true
 rw [phasePass,returnPass,antipodePass];rfl
end SFT.Physics.CPWitnesses
