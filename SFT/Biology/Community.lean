import SFT.Host.Text
namespace SFT.Biology.Community
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-COMMUNITY-001","Ecological community","population_ecology","co-located-population-carrier","interpopulation-interaction-network","species-identities-and-observation-effort-held","place-time-scale-bounded","A community is a place- and time-bounded network of distinguishable populations and their observed interactions, including absent and unresolved links."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Community
