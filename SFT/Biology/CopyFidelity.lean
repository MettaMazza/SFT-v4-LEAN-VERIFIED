import SFT.Host.Text
namespace SFT.Biology.CopyFidelity
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-COPY-FIDELITY-001","Replication fidelity and error","inheritance_replication","aligned-template-product-words","positionwise-agreement-census","matches-mismatches-and-unread-positions-held","assay-and-length-declared","Copy fidelity is the exact part-to-whole count of agreed positions over a declared aligned word; every mismatch and unobserved position remains in the record."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.CopyFidelity
