import SFT.Host.Text
namespace SFT.Medicine.Comparator
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-COMPARATOR-001","Clinical comparator","intervention_comparator_counterfactual","alternative-care-action","contrast-with-intervention","concurrent-or-declared-reference","same-eligibility-outcome-and-time","A comparator is an explicit alternative action evaluated under the same eligibility, outcome and time boundary; omitted care is not numerical zero."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Comparator
