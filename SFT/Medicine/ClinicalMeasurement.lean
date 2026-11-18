import SFT.Host.Text
namespace SFT.Medicine.ClinicalMeasurement
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-MEASUREMENT-001","Clinical measurement","symptom_sign_measurement_diagnosis","patient-specimen-or-signal","traceable-measurement-relation","method-unit-calibration-result","preanalytic-analytic-postanalytic-boundary","A clinical measurement retains carrier, unit, method, calibration, preanalytic state, result, uncertainty and reporting transformation."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalMeasurement
