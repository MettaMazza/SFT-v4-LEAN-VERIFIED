import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthReservoir
structure Obligation where
 claim_id : String
 title : String
 family : String
 carrier : String
 relation : String
 retained_record : String
 evidence_boundary : String
 statement : String
 falsification_condition : String
def original : Obligation := ⟨"SFT-EARTH-RESERVOIR-001","Earth-system reservoir","earth_system_observation","bounded-stock-membership-carrier","membership-storage-and-transfer-relation","members-stock-units-boundary-and-time-held","reservoir-definition-bounded","An Earth reservoir is a source- and time-bounded carrier with explicit membership, stored quantity, interfaces and observation units.","Reject if membership or boundary changes without record, or if an unobserved remainder is treated as absent."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool := StructuralModel.labelsDistinct StructuralModel.observationStatuses
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := StructuralModel.statusSeparation
end SFT.EarthEnvironment.EarthReservoir
