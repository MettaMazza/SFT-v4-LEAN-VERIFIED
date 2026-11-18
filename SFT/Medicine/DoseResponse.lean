import SFT.Host.Text
namespace SFT.Medicine.DoseResponse
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-DOSE-RESPONSE-001","Dose-response relation","dose_exposure_response_adverse_event","ordered-dose-groups-and-outcomes","outcome-incidence-by-dose","complete-dose-support-with-adverse-shapes","population-route-and-time","A dose-response relation retains every administered dose group, outcome, route, interval and nonmonotone or adverse pattern; no fitted curve is the law."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.DoseResponse
