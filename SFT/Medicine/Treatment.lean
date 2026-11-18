import SFT.Host.Text
namespace SFT.Medicine.Treatment
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-TREATMENT-001","Treatment","screening_prevention_treatment_rehabilitation","patient-with-declared-condition","therapeutic-action-to-course","content-delivery-response-and-harm","indication-setting-time-and-follow-up","Treatment binds a declared indication to delivered therapeutic action, comparator, response, harm and follow-up rather than to intent alone."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Treatment
