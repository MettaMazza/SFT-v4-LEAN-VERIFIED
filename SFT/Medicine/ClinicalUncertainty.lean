import SFT.Host.Text
namespace SFT.Medicine.ClinicalUncertainty
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-CLINICAL-UNCERTAINTY-001","Clinical uncertainty","individual_population_inference","retained-admissible-clinical-states","evidence-conditioned-support","known-missing-and-unknown-record","decision-and-observation-boundary","Clinical uncertainty is the exact retained support after available evidence, including known missingness and unresolved alternatives, not an ontological nondeterminism claim."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.ClinicalUncertainty
