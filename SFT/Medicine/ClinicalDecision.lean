import SFT.Host.Text
namespace SFT.Medicine.ClinicalDecision
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-DECISION-001","Clinical decision boundary","individual_population_inference","patient-action-alternatives","evidence-consequence-preference-relation","all-actions-outcomes-and-values","decision-maker-time-and-resource-boundary","A clinical decision composes evidence with explicit actions, consequences and patient values; a population average cannot uniquely select an individual action."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalDecision
