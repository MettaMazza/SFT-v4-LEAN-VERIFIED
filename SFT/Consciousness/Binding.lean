import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.Binding
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
def original : Obligation := ⟨"SFT-CONSC-BINDING-001","Binding relation","binding_unity","joint-content-word","separate/joint","shared-successor-composition","component-and-joint-trace","phenomenal-and-operational","Binding is a generated joint relation in which distinct contents participate in one successor while remaining reconstructible from held labels."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := (StructuralModel.observerObservedLock.wholePartition && StructuralModel.observerObservedLock.completion)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.Binding
