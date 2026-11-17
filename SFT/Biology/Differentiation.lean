import SFT.Host.Text
namespace SFT.Biology.Differentiation
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-DIFFERENTIATION-001","Cell differentiation","multicellular_development","common-lineage-cell-state-carrier","stable-state-divergence","genome-identity-expression-and-function-held","developmental-window-declared","Differentiation is a stable lineage-related divergence of cellular state and function while hereditary carrier identity and transition provenance remain reconstructible."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Differentiation
