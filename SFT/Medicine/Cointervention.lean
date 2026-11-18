import SFT.Host.Text
namespace SFT.Medicine.Cointervention
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-COINTERVENTION-001","Clinical cointervention","intervention_comparator_counterfactual","joint-care-word","additional-action-to-outcome-relation","all-concurrent-actions-held","arm-setting-and-time","Every concurrent care action that can change an outcome remains in the intervention word and may not be hidden inside an arm label."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Cointervention
