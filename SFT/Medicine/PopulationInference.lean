import SFT.Host.Text
namespace SFT.Medicine.PopulationInference
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-POPULATION-INFERENCE-001","Population clinical inference","individual_population_inference","sample-and-source-population","sample-to-population-relation","selection-weights-and-missingness","eligibility-place-time-and-method","Population inference requires an explicit sample-to-source relation with selection, missingness, eligibility, place and time retained."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.PopulationInference
