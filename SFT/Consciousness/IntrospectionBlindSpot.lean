import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.IntrospectionBlindSpot
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
def original : Obligation := ⟨"SFT-CONSC-INTROSPECTION-BLIND-SPOT-001","Introspection blind spot","self_observation_introspection","two-preimage-observation-class","predecessor/image","unretained-fibre-closure","missing-fibre-explicit","formal-and-report","Introspection from the image alone cannot recover which generated predecessor label was closed by the act."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "retained_observation_is_reversible") with | some (_, passed) => passed | none => false) && (match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "unretained_observation_is_not_reversible") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.IntrospectionBlindSpot
