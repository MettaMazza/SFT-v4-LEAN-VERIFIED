import SFT.Host.Text
namespace SFT.Biology.Regeneration
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-REGENERATION-001","Biological regeneration","multicellular_development","damaged-organization-lineage-carrier","loss-to-restored-organization-transition","residual-source-path-and-function-held","extent-and-time-bounded","Regeneration is a lineage-supported transition from a recorded loss state to restored organization and function, with residual source, path, extent and failures retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Regeneration
