import SFT.Host.Text
namespace SFT.Medicine.ClinicalEquipoise
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-EQUIPOISE-001","Clinical equipoise and stopping boundary","consent_ethics_privacy_uncertainty","competing-care-support","unresolved-comparative-benefit-harm","monitoring-and-stopping-rules","evidence-date-population-and-oversight","A comparative study remains admissible only while its declared evidence support leaves the care alternatives unresolved and its harm-stopping rules remain active."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalEquipoise
