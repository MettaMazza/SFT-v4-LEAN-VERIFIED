import SFT.Physics.ChirpRingdown
namespace SFT.Physics.ChirpRingdownWitnesses
open ChirpRingdown
open StellarCertificate (flag)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match theoremCertificate with | .error _=>false | .ok c=>flag c "all_chirps_close"
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
def witness1 : Bool := match theoremCertificate with | .error _=>false | .ok c=>flag c "merger_closes"
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
def witness2 : Bool := match theoremCertificate with | .error _=>false | .ok c=>flag c "all_ringdowns_close"
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
def witness3 : Bool := match theoremCertificate with | .error _=>false | .ok c=>RunningConvergenceMeasurement.sameValue (PostNewtonianRecords.getDefault c "unique_ordered_sequence") (.array [.text "inspiral-rising-chirp",.text "merger",.text "damped-ringdown"])
theorem witness3Passed : witness3=true := rfl
#print axioms witness3Passed
def witnesses : List Witness := [⟨"chirp","Every registered finite inspiral has shrinking separation and rising squared wave frequency.",witness0⟩,⟨"merger","First horizon contact joins two sources to one remnant without erasing the radiation ledger.",witness1⟩,⟨"ringdown","Every finite remnant trace holds its tone and halves positive amplitude.",witness2⟩,⟨"sequence","The complete causal ordering contains exactly the three forced stages.",witness3⟩]
end SFT.Physics.ChirpRingdownWitnesses
