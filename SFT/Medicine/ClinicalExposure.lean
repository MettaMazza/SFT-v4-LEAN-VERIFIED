import SFT.Host.Text
namespace SFT.Medicine.ClinicalExposure
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-EXPOSURE-001","Clinical exposure","dose_exposure_response_adverse_event","person-agent-contact-word","contact-intensity-duration-route","source-path-person-time","measurement-and-reconstruction-method","Exposure retains source, path, route, intensity, duration, person and measurement or reconstruction method."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalExposure
