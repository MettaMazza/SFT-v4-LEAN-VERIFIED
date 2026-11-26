import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.FirstThirdPerson
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
def original : Obligation := ⟨"SFT-CONSC-FIRST-THIRD-PERSON-001","First- and third-person evidence","subject_perspective_interiority","paired-interior-and-external-records","experienced/observed","provenance-preserving-pairing","participant-observer-method","evidence-class-separation","First-person and third-person records may be paired but remain different evidence classes unless a bridge law is independently admitted."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := StructuralModel.observerObservedLock.distinct
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.FirstThirdPerson
