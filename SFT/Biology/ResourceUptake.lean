import SFT.Host.Text
namespace SFT.Biology.ResourceUptake
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-RESOURCE-UPTAKE-001","Biological resource uptake","metabolism_resource","external-resource-and-boundary-carrier","external-to-internal-transfer","source-identity-and-path-retained","availability-and-time-bounded","Resource uptake is a source-bound permitted transition from an external support into a biological compartment with identity, amount, route and condition retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.ResourceUptake
