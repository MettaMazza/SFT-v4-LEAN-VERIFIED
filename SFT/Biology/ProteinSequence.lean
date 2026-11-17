import SFT.Host.Text
namespace SFT.Biology.ProteinSequence
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-PROTEIN-SEQUENCE-001","Protein sequence identity","protein_structure_function","ordered-residue-word-carrier","peptide-linked-position-relation","residue-modification-and-provenance-held","sequence-boundary-declared","A protein sequence is an ordered residue word with every position, linkage, modification, ambiguity and source record retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.ProteinSequence
