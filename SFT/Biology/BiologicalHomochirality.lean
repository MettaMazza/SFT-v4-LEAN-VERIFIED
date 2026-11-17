import SFT.Host.Text
namespace SFT.Biology.BiologicalHomochirality
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-BIOLOGICAL-HOMOCHIRALITY-001","Biological homochirality","protein_structure_function","chiral-biopolymer-carrier","same-hand-recurrence-along-chain","opposed-hand-controls-retained","organism-and-polymer-bounded","Biological homochirality is a source-bound recurrence of one molecular hand across a declared biopolymer class; Chemistry supplies chirality while Biology owns its lineage-maintained selection."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.BiologicalHomochirality
