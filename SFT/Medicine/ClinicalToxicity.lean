import SFT.Host.Text
namespace SFT.Medicine.ClinicalToxicity
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-TOXICITY-001","Clinical toxicity","dose_exposure_response_adverse_event","exposure-and-harm-state","exposure-linked-dysfunction-or-injury","organ-course-dose-and-recovery","method-population-and-time","Toxicity requires an exposure-linked harmful transition with dose, organ or function, timing, recovery and alternative causes retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalToxicity
