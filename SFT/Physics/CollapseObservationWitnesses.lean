import SFT.Physics.PostNewtonianRecords
import SFT.Physics.StellarCollapseCertificate
namespace SFT.Physics.CollapseObservationWitnesses
open StellarCollapseCertificate
open StellarCertificate (flag)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "all_chains_strict")
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag (PostNewtonianRecords.getDefault c "support_loss") "collapse_forced_when_no_other_support")
def witness2 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "all_thermonuclear_finite")
def witness3 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "all_neutral_capture_closed")
def witnesses : List Witness := [⟨"formal-stage","Every formal stage successor has strictly greater access.",witness0⟩,⟨"formal-collapse","Fusion support closes at the unique peak while inward gravity remains.",witness1⟩,⟨"formal-thermonuclear","Every linked-fuel recurrence exhausts finite fuel.",witness2⟩,⟨"formal-capture","Neutral capture and recorded rebalance close at every registered depth.",witness3⟩]
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
theorem witness3Passed : witness3=true := rfl
#print axioms witness3Passed
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 change (witness0 && (witness1 && (witness2 && (witness3 && true)))) = true
 rw [witness0Passed,witness1Passed,witness2Passed,witness3Passed]
 rfl
#print axioms allWitnessesPass
end SFT.Physics.CollapseObservationWitnesses
