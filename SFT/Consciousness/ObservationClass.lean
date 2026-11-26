import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.ObservationClass
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
def original : Obligation := ⟨"SFT-CONSC-OBSERVATION-CLASS-001","Observation equivalence class","observation_interior_observation","complete-preimage-fibre","distinguishable-source/same-image","many-to-one-observation","retained-or-closed-fibre","formal-information","An observation class is the complete generated source fibre of one image, with every closed and retained predecessor distinction counted."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := StructuralModel.observerObservedLock.sameImage
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.ObservationClass
