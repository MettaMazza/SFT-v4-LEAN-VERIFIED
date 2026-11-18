import SFT.Host.Text
namespace SFT.Medicine.Randomization
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-RANDOMIZATION-001","Randomized allocation in a deterministic model","trial_observational_synthesis","eligible-participants-and-held-generator-state","concealed-unpredictable-assignment","reconstructible-sequence-and-custody","generation-concealment-release-boundary","Randomization is a reproducible held-label allocation process whose future labels are concealed from selectors; it imports no nondeterministic ontology."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Randomization
