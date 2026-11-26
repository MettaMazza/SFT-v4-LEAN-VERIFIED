import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.IntegrationBoundary
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
def original : Obligation := ⟨"SFT-CONSC-INTEGRATION-BOUNDARY-001","Integration boundary","binding_unity","coupled-process-support","separate/integrated","complete-mutual-participation","coupling-and-transition-trace","perturbational-and-phenomenal","Integration requires each participating process to enter the joint closure; a one-way influence does not establish one interior whole."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := (StructuralModel.observerObservedLock.wholePartition && StructuralModel.observerObservedLock.completion)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.IntegrationBoundary
