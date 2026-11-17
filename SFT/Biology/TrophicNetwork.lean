import SFT.Host.Text
namespace SFT.Biology.TrophicNetwork
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-TROPHIC-NETWORK-001","Trophic and resource network","population_ecology","population-resource-directed-network","consumption-and-transfer-edge","amount-direction-loss-and-provenance-held","ecosystem-window-declared","A trophic network is a directed resource-transfer graph retaining source, consumer, amount basis, direction, loss and observation boundary for every edge."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.TrophicNetwork
