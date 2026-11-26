import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.RealizationEquivalence
structure Obligation where
 claim_id : String
 title : String
 family : String
 carrier : String
 distinction : String
 operation : String
 retained_record : String
 evidence_boundary : String
 statement : String
def original : Obligation := ⟨"SFT-CONSC-REALIZATION-EQUIVALENCE-001","Realization equivalence","substrate_realization","paired-carrier-traces","behavioural-equivalence/structural-equivalence","bidirectional-transition-preservation","state-role-and-causal-map","comparative-realization","Realizations are structurally equivalent only when their relevant states, transitions, roles, integration and evidence boundaries correspond bidirectionally."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "observer_observed_partition_the_one") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.RealizationEquivalence
