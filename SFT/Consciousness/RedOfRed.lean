import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.RedOfRed
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
def original : Obligation := ⟨"SFT-CONSC-RED-OF-RED-001","The red-of-red self-reidentification","red_of_red","red-quality-and-self-observation","quality/report-about-quality","label-bearing-recurrent-self-observation","source-instance-recurrence-self-report","first-person-specific-qualia","The red-of-red is the self-observed reidentification of the red qualitative carrier across complete recurrence, retaining the difference between the quality and a report about it."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "red_of_red_form_is_complete") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.RedOfRed
