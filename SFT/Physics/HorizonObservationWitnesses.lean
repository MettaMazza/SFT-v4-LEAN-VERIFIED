import SFT.Physics.CompactHorizon
namespace SFT.Physics.HorizonObservationWitnesses
open CompactHorizon
open StellarCertificate (flag)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "all_exclusion_scalings_close")
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "two_pre_horizon_families")
def witness2 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "reference_cross_closes" && flag c "all_evaporation_traces_close")
def witnesses : List Witness := [⟨"formal-exclusion","The q^4/q^6 scaling was sealed before target release.",witness0⟩,⟨"formal-endpoints","Exactly two pre-horizon families were sealed before target release.",witness1⟩,⟨"formal-horizon","The reference radius, quarter-area and mT relation were sealed before target release.",witness2⟩]
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 change (witness0 && (witness1 && (witness2 && true))) = true
 rw [witness0Passed,witness1Passed,witness2Passed]
 rfl
#print axioms allWitnessesPass
end SFT.Physics.HorizonObservationWitnesses
