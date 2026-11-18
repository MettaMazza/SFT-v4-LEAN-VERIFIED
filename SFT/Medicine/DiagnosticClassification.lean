import SFT.Host.Text
namespace SFT.Medicine.DiagnosticClassification
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-DIAGNOSTIC-CLASSIFICATION-001","Diagnostic classification","symptom_sign_measurement_diagnosis","patient-evidence-word","criteria-to-class-relation","classification-with-alternatives-held","reference-standard-and-verification","Diagnostic classification maps a complete patient evidence word to a declared class while retaining alternative classes, criteria and verification boundary."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.DiagnosticClassification
