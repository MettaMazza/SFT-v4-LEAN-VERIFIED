import SFT.Host.Text
namespace SFT.Medicine.SymptomRecord
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-SYMPTOM-001","Symptom record","symptom_sign_measurement_diagnosis","patient-reported-experience","report-to-person-state-relation","content-intensity-timing-context","elicitation-method-and-language","A symptom is a patient-reported observation whose content, timing, context, elicitation and reporting uncertainty remain held."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.SymptomRecord
