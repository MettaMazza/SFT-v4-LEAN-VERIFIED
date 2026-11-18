import SFT.Host.Text
namespace SFT.Medicine.ClinicalResponse
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-RESPONSE-001","Clinical response","dose_exposure_response_adverse_event","patient-baseline-and-follow-up-state","change-after-exposure-or-intervention","multidomain-course-with-controls","outcome-method-and-time","A response is a recorded change from baseline after an exposure or intervention, with controls required before the temporal relation becomes causal."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalResponse
