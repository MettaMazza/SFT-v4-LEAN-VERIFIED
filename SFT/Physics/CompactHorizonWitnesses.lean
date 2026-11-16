import SFT.Physics.CompactHorizon
namespace SFT.Physics.CompactHorizonWitnesses
open CompactHorizon
open StellarCertificate (flag)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>flag c "all_exclusion_scalings_close"
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>flag c "two_pre_horizon_families"
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
def witness2 : Bool := match theoremCertificate with | .error _=>false | .ok c=>flag c "reference_cross_closes"
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
def witness3 : Bool := match theoremCertificate with | .error _=>false | .ok c=>flag c "all_evaporation_traces_close"
theorem witness3Passed : witness3=true := rfl
#print axioms witness3Passed
def witnesses : List Witness := [⟨"exclusion-scaling","Perfect-cube exclusion and gravity exponents close at every registered depth.",witness0⟩,⟨"endpoint-census","The binary fibre supplies exactly two pre-horizon families.",witness1⟩,⟨"reference-horizon","The admitted quarter-One witness cross-closes radius and temperature.",witness2⟩,⟨"inverse-temperature","Every registered finite emission trace preserves mT=1/16 and positive support.",witness3⟩]
end SFT.Physics.CompactHorizonWitnesses
