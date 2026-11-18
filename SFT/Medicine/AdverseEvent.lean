import SFT.Host.Text
namespace SFT.Medicine.AdverseEvent
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-ADVERSE-EVENT-001","Adverse event","dose_exposure_response_adverse_event","participant-unfavorable-event","event-after-exposure-or-care","seriousness-severity-relatedness-outcome","solicitation-time-and-follow-up","Every unfavorable event after care remains recorded with seriousness, severity, timing, relatedness assessment and final outcome, whether or not causally attributed."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.AdverseEvent
