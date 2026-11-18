import SFT.Host.Text
namespace SFT.Medicine.ClinicalObservation
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-OBSERVATION-001","Clinical observation","patient_population_health","patient-state-and-observer-record","observation-with-retained-method","source-method-result-provenance","declared-observer-instrument-setting-time","A clinical observation binds the observed carrier to observer, method, setting, time and result so the observation cannot silently become the law."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalObservation
