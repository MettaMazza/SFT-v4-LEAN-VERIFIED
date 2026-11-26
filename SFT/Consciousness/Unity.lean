import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.Unity
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
def original : Obligation := ⟨"SFT-CONSC-UNITY-001","Unity of experience","binding_unity","complete-bound-content","one-process/many-processes","joint-closure-to-one-carrier","participation-and-boundary","first-person-unity","Unity is one closed interior process over complete participating content, not a heap, synchrony measure or unlabelled aggregate."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := (StructuralModel.observerObservedLock.wholePartition && StructuralModel.observerObservedLock.completion)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.Unity
