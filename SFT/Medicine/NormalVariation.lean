import SFT.Host.Text
namespace SFT.Medicine.NormalVariation
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-NORMAL-VARIATION-001","Normal clinical variation","variation_dysfunction_disease_injury","reference-person-states","variation-within-declared-reference","distribution-with-subgroups-held","population-method-time-boundary","Normal variation is the observed support within a declared reference population and method; it is not a universal numerical threshold."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.NormalVariation
