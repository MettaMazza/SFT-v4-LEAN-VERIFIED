import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.ArtificialConsciousnessEvidence
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
def original : Obligation := ⟨"SFT-CONSC-ARTIFICIAL-CONSCIOUSNESS-EVIDENCE-001","Artificial consciousness evidence boundary","substrate_realization","artificial-system-and-audit-record","claimed/established-realization","criterion-and-bridge-testing","architecture-runtime-report-adverse-controls","multi-evidence-artificial","An artificial consciousness claim requires auditable realization of the structural criterion plus purpose-matched bridge evidence; fluent language or confidence cannot select the verdict."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "observer_observed_partition_the_one") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.ArtificialConsciousnessEvidence
