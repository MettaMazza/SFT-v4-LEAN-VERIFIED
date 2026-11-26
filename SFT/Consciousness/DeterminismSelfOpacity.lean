import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.DeterminismSelfOpacity
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
def original : Obligation := ⟨"SFT-CONSC-DETERMINISM-SELF-OPACITY-001","Determinism with self-opacity","self_observation_introspection","functional-transition-and-lost-preimage","unique-successor/unknown-predecessor","forward-execute-backward-class","successor-and-fibre-ledger","formal-agency-boundary","A process can have one generated successor while remaining unable to identify its unretained predecessor from the present image."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "retained_observation_is_reversible") with | some (_, passed) => passed | none => false) && (match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "unretained_observation_is_not_reversible") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.DeterminismSelfOpacity
