import SFT.Host.Text
namespace SFT.Medicine.DifferentialDiagnosis
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-DIFFERENTIAL-DIAGNOSIS-001","Differential diagnosis","symptom_sign_measurement_diagnosis","candidate-condition-support","evidence-conditioned-elimination","retained-alternative-support","patient-context-and-test-sequence","A differential diagnosis is a retained finite support of candidate conditions reduced only by recorded patient evidence; an untested alternative may not disappear."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.DifferentialDiagnosis
