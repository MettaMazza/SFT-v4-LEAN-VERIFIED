import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.AlteredStateReportBoundary
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
def original : Obligation := ⟨"SFT-CONSC-ALTERED-STATE-REPORT-BOUNDARY-001","Altered-state evidence boundary","access_report_presence","state-report-observation-word","report/ontology","source-bound-comparison","state-induction-report-controls","first-person-report-with-third-person-controls","Reports of altered experience are preserved as first-person observations while their ontological interpretation requires a separately derived and tested bridge."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := (match StructuralModel.observe StructuralModel.quarter false with | .ok act => !(StructuralModel.reversibleFromRecord act) | .error _ => false)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.AlteredStateReportBoundary
