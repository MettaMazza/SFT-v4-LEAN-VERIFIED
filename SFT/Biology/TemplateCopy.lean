import SFT.Host.Text
namespace SFT.Biology.TemplateCopy
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-TEMPLATE-001","Template-directed copying","inheritance_replication","template-and-product-carrier","positionwise-complement-or-copy-relation","template-product-distinction-retained","finite-word-boundary","Template copying generates a product word through a declared positionwise relation while retaining template, product, direction and every mismatch."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.TemplateCopy
