import SFT.Physics.StellarCertificate
namespace SFT.Physics.StellarObservationWitnesses
open StellarCertificate StellarResponses
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "all_radial_restoring")
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(match stellarLuminosityExponents with | .error _=>false | .ok a=>a==(3,4))
def witness2 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "all_flat_rows_require_growth")
def witness3 : Bool := match theoremCertificate with | .error _=>false | .ok c=>(flag c "all_tidal_rows_lock")
def witnesses : List Witness := [⟨"formal-radial","The formal perfect-power radial responses restore before measurement.",witness0⟩,⟨"formal-stellar","The formal terminal endpoint powers are three and four.",witness1⟩,⟨"formal-galactic","Every formal flat-curve row forces additional enclosed support.",witness2⟩,⟨"formal-tidal","Every registered isolated finite mismatch terminates at one-to-one.",witness3⟩]
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
end SFT.Physics.StellarObservationWitnesses
