import SFT.Physics.AtomicTransition
namespace SFT.Physics.AtomicTransitionEntryWitnesses
open AtomicTransition LeptonIntervals
structure Witness where
 name : String
 statement : String
 passed : Bool
def stepCheck : Bool := match transitionSelection with
 | .error _ => false
 | .ok r => r.orbitalStep == 1
def magneticCheck : Bool := match transitionSelection with
 | .error _ => false
 | .ok r => r.magneticOrientations == 2
def electricCheck : Bool := match transitionSelection with
 | .error _ => false
 | .ok r => r.completeSpatialOrientations == 6
def witnesses : List Witness := [⟨"one-step","The elementary transition carries one generated unit.",stepCheck⟩,⟨"magnetic-binary","The Fold fibre supplies two magnetic orientations.",magneticCheck⟩,⟨"electric-cubic","The complete cubic direction support contains six orientations.",electricCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.AtomicTransitionEntryWitnesses
