import SFT.Host.Text
namespace SFT.Biology.ProteinInteraction
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-PROTEIN-INTERACTION-001","Protein interaction","protein_structure_function","two-protein-context-carrier","specific-joint-state-recurrence","alternatives-stoichiometry-and-condition-held","interaction-assay-bounded","A protein interaction is a reproducible specific joint-state relation whose alternatives, stoichiometry, condition and observation method are retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.ProteinInteraction
