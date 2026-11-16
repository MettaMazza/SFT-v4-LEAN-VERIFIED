import SFT.Physics.ChirpRingdown
namespace SFT.Physics.ChirpObservationWitnesses
open ChirpRingdown
open StellarCertificate (flag)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "all_chirps_close")
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "merger_closes")
def witness2 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "all_ringdowns_close")
def witnesses : List Witness := [⟨"formal-chirp","The exact chirp ordering was sealed before withheld target binding.",witness0⟩,⟨"formal-merger","The exact two-to-one contact successor was sealed.",witness1⟩,⟨"formal-ringdown","The positive finite damping class was sealed.",witness2⟩]
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
end SFT.Physics.ChirpObservationWitnesses
