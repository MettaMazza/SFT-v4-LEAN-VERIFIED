import SFT.Physics.AtomicTransitionRate
namespace SFT.Physics.AtomicTransitionRateEntryWitnesses
open AtomicTransitionRate LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def selectionCheck : Bool := match AtomicTransition.transitionSelection with
 | .error _ => false
 | .ok s => s.orbitalStep==1
def exponentCheck : Bool := [1,2,3,4].map (fun n => (electricMultipoleExponent (.count (.integer (.ofNat n)))).toOption)==[some 3,some 5,some 7,some 9]
def lifetimeCheck : Bool := match exactLifetime [.fraction (normalize 1 8 (by decide)),.fraction (normalize 1 24 (by decide))] with
 | .error _ => false
 | .ok q => q==wholeRatio 6
def suppressionCheck : Bool := (List.range 16).all (fun n => match successorMultipoleRatio (.fraction (normalize (.ofNat (n+1)) 17 (by decide))) with
 | .error _ => false
 | .ok q => (wholeRatio 0).blt q && q.blt (wholeRatio 1))
def witnesses : List Witness := [⟨"elementary-step-retained","The immutable elementary transition remains one orbital unit.",selectionCheck⟩,⟨"electric-exponents","The first four electric multipole exponents are 3,5,7,9.",exponentCheck⟩,⟨"rate-and-lifetime","Complete exact rates force the exact reciprocal lifetime.",lifetimeCheck⟩,⟨"conditional-suppression","Every tested electric-rank successor is strictly suppressed for every exact strict-part gap.",suppressionCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.AtomicTransitionRateEntryWitnesses
