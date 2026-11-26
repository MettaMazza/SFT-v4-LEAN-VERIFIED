import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.RedStimulusBoundary
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
def original : Obligation := ⟨"SFT-CONSC-RED-STIMULUS-BOUNDARY-001","Red stimulus and experience boundary","red_of_red","physical-stimulus-and-interior-label","stimulus/quality","source-bound-presentation","spectral-display-observer-context","physics-to-first-person","A physically classified red stimulus and the experienced quality remain distinct records connected only by a tested presentation-and-report bridge."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := ((match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "red_of_red_form_is_complete") with | some (_, passed) => passed | none => false))
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.RedStimulusBoundary
