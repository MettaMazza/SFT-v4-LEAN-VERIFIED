import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.IntrospectionLoss
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
def original : Obligation := ⟨"SFT-CONSC-INTROSPECTION-LOSS-001","Accumulated introspection loss","self_observation_introspection","ordered-self-observation-trace","retained/closed-predecessors","counted-label-closure","loss-ledger","formal-information","Each unrecorded two-to-one self-observation closes one predecessor distinction; repeated loss is counted without negative information quantities."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "retained_observation_is_reversible") with | some (_, passed) => passed | none => false) && (match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "unretained_observation_is_not_reversible") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.IntrospectionLoss
