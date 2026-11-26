import SFT.Consciousness.StructuralModel
namespace SFT.Consciousness.PhenomenalPresence
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
def original : Obligation := ⟨"SFT-CONSC-PHENOMENAL-PRESENCE-001","Phenomenal presence","access_report_presence","interiorly-realized-content","present/merely-processed","closed-interior-observation","first-person-discrimination","phenomenal","Phenomenal presence is registered at the interior-observation boundary and remains distinct from access, report, behaviour and neural correlation."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def distinctionWitness : Bool := !(SFT.Host.Text.equal original.distinction original.operation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier) && !(SFT.Host.Text.equal original.evidence_boundary original.distinction)
def exactFoldWitness : Bool := (match StructuralModel.observe StructuralModel.quarter false with | .ok act => !(StructuralModel.reversibleFromRecord act) | .error _ => false)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem distinctionWitnessPassed : distinctionWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by decide
end SFT.Consciousness.PhenomenalPresence
