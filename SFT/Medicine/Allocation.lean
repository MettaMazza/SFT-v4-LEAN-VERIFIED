import SFT.Host.Text
namespace SFT.Medicine.Allocation
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-ALLOCATION-001","Intervention allocation","intervention_comparator_counterfactual","eligible-participant-records","assignment-to-declared-arm","allocation-sequence-with-concealment","generation-implementation-and-time","Allocation is a fully traced deterministic assignment sequence whose concealment can prevent selection even though SFT imports no ontological nondeterminism."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Allocation
