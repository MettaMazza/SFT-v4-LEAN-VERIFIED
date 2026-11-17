import SFT.Host.Text
namespace SFT.Medicine.PatientIdentity
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-PATIENT-IDENTITY-001","Patient identity","patient_population_health","consented-person-record","same-person-across-episodes","identity-with-held-linkage","declared-care-context-and-interval","A patient is one consent-bound person carrier whose episode records may compose only while their exact linkage, context and provenance remain held."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.PatientIdentity
