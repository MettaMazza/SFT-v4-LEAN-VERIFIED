import SFT.Host.Text
namespace SFT.Medicine.StoppingWithdrawal
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-STOPPING-WITHDRAWAL-001","Stopping and withdrawal","screening_prevention_treatment_rehabilitation","ongoing-care-and-patient-state","stop-continue-change-decision","reason-transition-and-aftercare","decision-time-and-follow-up","Stopping or withdrawal is a recorded care transition with reason, alternative, taper or aftercare and post-transition outcomes held."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.StoppingWithdrawal
