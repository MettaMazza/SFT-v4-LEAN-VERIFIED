import SFT.Host.Text
namespace SFT.Medicine.Rehabilitation
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-REHABILITATION-001","Rehabilitation","screening_prevention_treatment_rehabilitation","person-function-and-participation-state","iterated-action-to-capacity-change","goals-interventions-context-and-course","baseline-follow-up-and-lived-setting","Rehabilitation is an iterated, goal-bound relation among intervention, function, participation and lived context across retained timepoints."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Rehabilitation
