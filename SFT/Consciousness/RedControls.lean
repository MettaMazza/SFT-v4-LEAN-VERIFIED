import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.RedControls
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
def original : Obligation := ⟨"SFT-CONSC-RED-CONTROLS-001","Red-of-red contrast controls","red_of_red","red-and-nonred-comparison-set","identity/mismatch","changed-label-and-changed-stimulus-tests","all-match-mismatch-absence-uncertain-rows","first-person-psychophysical","The red-of-red test preserves matched, mismatched, absent and uncertain rows and must reject a changed label, changed stimulus or report-only surrogate."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "red_of_red_form_is_complete") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.RedControls
