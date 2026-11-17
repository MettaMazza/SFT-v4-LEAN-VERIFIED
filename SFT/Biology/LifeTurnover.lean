import SFT.Host.Text
namespace SFT.Biology.LifeTurnover
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-LIFE-IDENTITY-TURNOVER-001","Identity through constituent turnover","life_boundary","lineage-bound-organization-carrier","replacement-with-relation-preservation","organization-and-provenance-retained","scale-and-time-declared","Biological identity persists through constituent replacement exactly when the lineage-bound organization and its required transition relations remain reconstructible."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.LifeTurnover
