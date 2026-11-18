import SFT.Host.Text
namespace SFT.Medicine.AdherenceCrossover
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-ADHERENCE-CROSSOVER-001","Adherence and crossover","intervention_comparator_counterfactual","assigned-and-received-care-record","assignment-delivery-use-relation","protocol-deviation-trace","participant-time-and-reason","Adherence and crossover preserve assignment, received care, timing and reason as distinct labels rather than rewriting the allocated history."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.AdherenceCrossover
