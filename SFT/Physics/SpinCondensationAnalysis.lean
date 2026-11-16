import SFT.Host.Canonical
namespace SFT.Physics.SpinCondensationAnalysis
open SFT.Host.Canonical
structure Target where
 becCenter : Int
 becUncertainty : Int
 becDenominator : Int
 correction : Int
 spinStates : Int
 collisionFactor : Int
 forced : Int
 spinCenter : Int
 spinUncertainty : Int
 finite : Bool
 ground : Bool
 cooling : Bool
 transition : Bool
 pauli : Bool
 oneTurn : Bool
 twoTurns : Bool
 allRows : Bool

-- Exact original integer analysis; flags retain Python singleton-Boolean tests.
def exactAnalysis (t : Target) : Value :=
 let b := (t.becCenter-t.becUncertainty,t.becCenter+t.becUncertainty)
 let s := (t.spinCenter-t.spinUncertainty,t.spinCenter+t.spinUncertainty)
 let positive := [b.1,b.2,t.becUncertainty,t.becDenominator,t.correction,t.spinStates,t.collisionFactor,t.forced,t.spinUncertainty,s.1,s.2].all (fun x => @decide (0<x) (Int.decLt 0 x))
 .object [
 ("positive_exact_carriers",.boolean positive),
 ("bec_interval",.array [.integer b.1,.integer b.2]),
 ("spinor_interval",.array [.integer s.1,.integer s.2]),
 ("bec_interval_ordered",.boolean (decide (b.1≤b.2) && decide (b.2<t.becDenominator+1))),
 ("bec_finite_population",.boolean t.finite),
 ("bec_ground_measured",.boolean t.ground),
 ("bec_cooling_direction",.boolean t.cooling),
 ("bec_transition_observed",.boolean t.transition),
 ("pauli_observed",.boolean t.pauli),
 ("pauli_two_spin_states",.boolean (decide (t.spinStates=2))),
 ("pauli_reported_factor_retained",.boolean (decide (t.collisionFactor=2))),
 ("spinor_interval_contains_forced_return",.boolean (decide (s.1≤t.forced) && decide (t.forced≤s.2))),
 ("spinor_one_turn_changes",.boolean t.oneTurn),
 ("spinor_two_turns_restore",.boolean t.twoTurns),
 ("all_rows_retained",.boolean t.allRows)]
def registeredTarget : Target := ⟨94,5,100,3,2,2,720,704,38,true,true,true,true,true,true,true,true⟩
theorem originalBECInterval : (registeredTarget.becCenter-registeredTarget.becUncertainty,registeredTarget.becCenter+registeredTarget.becUncertainty)=(89,99) := rfl
theorem originalSpinInterval : (registeredTarget.spinCenter-registeredTarget.spinUncertainty,registeredTarget.spinCenter+registeredTarget.spinUncertainty)=(666,742) := rfl
theorem originalTwoTurnsContained : (decide ((666:Int)≤registeredTarget.forced) && decide (registeredTarget.forced≤742))=true := rfl
theorem originalTamperedSpinorRejected : (decide ((600:Int)-registeredTarget.spinUncertainty≤registeredTarget.forced) && decide (registeredTarget.forced≤600+registeredTarget.spinUncertainty))=false := rfl
theorem originalCompleteTargetAnalysis : exactAnalysis registeredTarget = .object [("positive_exact_carriers",.boolean true),("bec_interval",.array [.integer (89),.integer (99)]),("spinor_interval",.array [.integer (666),.integer (742)]),("bec_interval_ordered",.boolean true),("bec_finite_population",.boolean true),("bec_ground_measured",.boolean true),("bec_cooling_direction",.boolean true),("bec_transition_observed",.boolean true),("pauli_observed",.boolean true),("pauli_two_spin_states",.boolean true),("pauli_reported_factor_retained",.boolean true),("spinor_interval_contains_forced_return",.boolean true),("spinor_one_turn_changes",.boolean true),("spinor_two_turns_restore",.boolean true),("all_rows_retained",.boolean true)] := rfl
end SFT.Physics.SpinCondensationAnalysis
