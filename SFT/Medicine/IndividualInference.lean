import SFT.Host.Text
namespace SFT.Medicine.IndividualInference
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-INDIVIDUAL-INFERENCE-001","Individual clinical inference","individual_population_inference","one-patient-evidence-word","evidence-to-patient-support","alternatives-and-uncertainty-held","patient-values-context-and-time","Individual inference conditions only on the available patient evidence and preserves unsupported alternatives, values, context and uncertainty."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.IndividualInference
