import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.UnconsciousProcess
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
def original : Obligation := ⟨"SFT-CONSC-UNCONSCIOUS-PROCESS-001","Active unavailable processing","access_report_presence","active-recurrent-process","active/available","continuation-without-access-closure","process-and-access-records","behavioural-and-biological-correlate","A process may remain active while unavailable to the integrated access relation, so activity is not equated with consciousness."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := (match StructuralModel.observe StructuralModel.quarter false with | .ok act => !(StructuralModel.reversibleFromRecord act) | .error _ => false)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.UnconsciousProcess
