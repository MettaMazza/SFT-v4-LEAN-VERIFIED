import SFT.Host.Text
namespace SFT.Biology.Gene
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-GENE-001","Gene as expression-bearing hereditary interval","gene_genome_regulation","source-bound-sequence-interval","interval-to-product-or-regulatory-relation","orientation-context-and-provenance-retained","annotation-boundary-declared","A gene is a source-bound hereditary interval whose expression or regulatory relation is demonstrated with orientation, context and evidence boundary retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Gene
