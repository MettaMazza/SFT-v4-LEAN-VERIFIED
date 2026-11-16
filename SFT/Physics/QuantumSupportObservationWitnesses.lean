import SFT.Physics.QuantumSupportWitnesses
namespace SFT.Physics.QuantumSupportObservationWitnesses
open QuantumSupportCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalWalsh : Bool := QuantumSupportWitnesses.readFlag Certificate.walsh theoremCertificate
def formalJoints : Bool := QuantumSupportWitnesses.readFlag Certificate.joints theoremCertificate
def formalBell : Bool := QuantumSupportWitnesses.readFlag Certificate.bell theoremCertificate
def witnesses : List Witness := [⟨"support","The complete dyadic support census is closed.",formalWalsh⟩,⟨"joint","The complete joint-factorability censuses and projections are closed.",formalJoints⟩,⟨"bell","Every local response pair obeys three-of-four while setting-inclusive support preserves no signalling.",formalBell⟩]
end SFT.Physics.QuantumSupportObservationWitnesses
