import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.InteriorObservation
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
def original : Obligation := ⟨"SFT-CONSC-INTERIOR-OBSERVATION-001","Interior observation","observation_interior_observation","self-reentering-state","process/its-own-image","image-reenters-successor-state","closed-self-trace","first-person-structural-boundary","Interior observation requires the observation image to re-enter the same organized process rather than remain only in an external record."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := StructuralModel.observerObservedLock.sameImage
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.InteriorObservation
