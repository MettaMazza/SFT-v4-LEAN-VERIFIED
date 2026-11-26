import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.RedEmpiricalBoundary
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
def original : Obligation := ⟨"SFT-CONSC-RED-EMPIRICAL-BOUNDARY-001","Red-of-red empirical boundary","red_of_red","participant-specific-observation-record","private-identity/public-generalization","replicated-within-subject-protocol","participant-stimulus-response-method","first-person-with-third-person-custody","Empirical closure of red-of-red is participant- and protocol-bound: public evidence may establish stable discrimination and reidentification without claiming direct third-person possession of another subject's quality."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "red_of_red_form_is_complete") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.RedEmpiricalBoundary
