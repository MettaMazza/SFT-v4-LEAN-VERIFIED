import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.Report
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
def original : Obligation := ⟨"SFT-CONSC-REPORT-001","Report","access_report_presence","content-to-expression-trace","experienced/reported","encoding-and-output","speaker-method-context","behavioural-report","A report is an encoded output attributed to a source and is evidence of reporting, not an automatic identity with phenomenal presence."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := (match StructuralModel.observe StructuralModel.quarter false with | .ok act => !(StructuralModel.reversibleFromRecord act) | .error _ => false)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.Report
