import SFT.Host.Text
namespace SFT.Medicine.Counterfactual
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-COUNTERFACTUAL-001","Clinical counterfactual","intervention_comparator_counterfactual","same-eligibility-patient-state","alternative-action-outcome-relation","mutually-exclusive-potential-courses","identification-assumption-boundary","A counterfactual denotes alternative courses for the same eligibility state; because only one course is observed, the missing course and identification boundary must remain explicit."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Counterfactual
