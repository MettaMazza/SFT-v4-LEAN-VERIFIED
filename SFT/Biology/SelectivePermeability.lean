import SFT.Host.Text
namespace SFT.Biology.SelectivePermeability
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-SELECTIVE-PERMEABILITY-001","Selective permeability","compartment_identity","boundary-species-state-carrier","species-specific-transition-permission","allowed-and-rejected-paths-retained","condition-bounded-transport-test","Selective permeability is the complete partition of candidate boundary crossings into permitted and rejected species-state paths under declared conditions."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.SelectivePermeability
