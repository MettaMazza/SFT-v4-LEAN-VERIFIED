import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.Interiority
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
def original : Obligation := ⟨"SFT-CONSC-INTERIORITY-001","Interiority","subject_perspective_interiority","closed-self-observation-loop","inside/outside-description","state-participates-in-own-transition","internal-and-external-traces","phenomenal-bridge","Interiority is the asymmetry between participating in a closed self-observation process and possessing an external description of it."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := StructuralModel.observerObservedLock.distinct
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.Interiority
