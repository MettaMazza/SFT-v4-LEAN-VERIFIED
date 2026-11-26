import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.QualiaResonance
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
def original : Obligation := ⟨"SFT-CONSC-QUALIA-RESONANCE-001","Qualia resonance","qualia_resonance_composition","recurrent-quality-carrier","stable-reidentification/transient-output","closed-label-bearing-recurrence","cycle-label-and-perturbation-trace","first-person-with-realization-correlates","Qualia resonance is stable reidentification of a held qualitative label across a complete recurrent interior support, tested against perturbation and changed-label controls."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "three_quality_support_recurs") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.QualiaResonance
