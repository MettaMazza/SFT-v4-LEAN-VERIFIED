import SFT.Host.Text
namespace SFT.Biology.MulticellularComposition
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-MULTICELLULAR-COMPOSITION-001","Multicellular organismal composition","multicellular_development","connected-cell-lineage-carrier","coordinated-cell-composition","cell-identities-boundaries-and-shared-processes-held","organism-stage-bounded","Multicellular organization is a connected lineage-related cell composition with retained cellular identities and regulated shared processes."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.MulticellularComposition
