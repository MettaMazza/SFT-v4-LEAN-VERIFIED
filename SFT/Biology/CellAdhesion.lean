import SFT.Host.Text
namespace SFT.Biology.CellAdhesion
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-CELL-ADHESION-001","Cell adhesion and tissue boundary","multicellular_development","cell-interface-carrier","specific-persistent-contact-relation","adhesion-components-mechanics-and-controls-held","tissue-condition-bounded","Cell adhesion is a specific persistent intercellular or cell-matrix relation that retains component identity, contact geometry, mechanical context and adverse controls."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.CellAdhesion
