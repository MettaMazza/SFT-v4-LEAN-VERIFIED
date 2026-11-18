import SFT.Host.Text
namespace SFT.Medicine.BenefitHarm
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-BENEFIT-HARM-001","Benefit-harm composition","efficacy_effectiveness_safety_benefit_harm","joint-benefit-and-harm-outcomes","noncollapsed-outcome-comparison","patient-valued-components-held","population-horizon-and-preference-boundary","Benefit and harm remain separate outcome components and may compose only under an explicit population, horizon and value boundary."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.BenefitHarm
