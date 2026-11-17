import SFT.Host.Text
namespace SFT.Biology.Development
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-DEVELOPMENT-001","Developmental lineage","multicellular_development","zygote-to-organism-lineage-carrier","ordered-division-differentiation-transition","branching-time-position-and-state-held","stage-boundary-declared","Development is an ordered lineage of division, movement and differentiation transitions from an initiating cell to a multicellular organization with every branch and stage boundary retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Development
