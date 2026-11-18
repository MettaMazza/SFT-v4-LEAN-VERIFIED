import SFT.Host.Text
namespace SFT.Biology.ExpressionRegulation
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-EXPRESSION-REGULATION-001","Expression and regulation","gene_genome_regulation","gene-product-condition-carrier","condition-dependent-production-transition","regulator-context-time-and-output-held","assay-bounded","Gene expression is a recorded transition from a hereditary interval to a product; regulation is a reproducible condition-dependent difference in that transition with regulator, context and time retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.ExpressionRegulation
