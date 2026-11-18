import SFT.Host.Text
namespace SFT.Medicine.ClinicalSign
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-SIGN-001","Clinical sign","symptom_sign_measurement_diagnosis","observer-elicited-patient-feature","feature-to-method-relation","observer-method-result-record","setting-time-and-observer","A sign is an observer-elicited feature with method, observer, setting and time retained; it is not interchangeable with a symptom."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalSign
