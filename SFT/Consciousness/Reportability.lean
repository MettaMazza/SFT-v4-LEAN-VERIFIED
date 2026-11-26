import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.Reportability
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
def original : Obligation := ⟨"SFT-CONSC-REPORTABILITY-001","Reportability","access_report_presence","accessible-content-and-output-route","accessible/reportable","semantics-preserving-expression","content-report-link","operational-behavioural","Reportability requires both cognitive access and a retained expression route; absence of report alone does not decide presence."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := (match StructuralModel.observe StructuralModel.quarter false with | .ok act => !(StructuralModel.reversibleFromRecord act) | .error _ => false)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.Reportability
