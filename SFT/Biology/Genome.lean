import SFT.Host.Text
namespace SFT.Biology.Genome
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-GENOME-001","Genome organization","gene_genome_regulation","complete-hereditary-carrier-support","ordered-and-linked-locus-relation","chromosomal-compartment-and-copy-state-held","assembly-and-sample-declared","A genome is the complete declared hereditary carrier support of an organism or cell with order, linkage, compartment, copy state, gaps and assembly provenance retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.Genome
