import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.SynchronyBoundary
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
def original : Obligation := ⟨"SFT-CONSC-SYNCHRONY-BOUNDARY-001","Synchrony and binding distinction","binding_unity","timed-process-traces","same-time/same-whole","recurrence-alignment-test","phase-and-composition-record","biological-correlate-boundary","Synchrony may test a timing relation but does not alone prove binding unless joint compositional closure is independently shown."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := (StructuralModel.observerObservedLock.wholePartition && StructuralModel.observerObservedLock.completion)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.SynchronyBoundary
