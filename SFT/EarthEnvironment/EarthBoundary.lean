import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthBoundary
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
def original : Obligation := ⟨"SFT-EARTH-BOUNDARY-001","Earth-system boundary and interface","earth_system_observation","two-reservoir-interface-carrier","cross-boundary-transfer-relation","orientation-area-route-and-time-held","interface-resolution-bounded","An Earth-system boundary distinguishes adjacent carriers while retaining every registered cross-boundary transfer, orientation and observation limit.","Reject if a transfer is counted on only one side, if orientation is lost, or if the interface is replaced by an ungenerated continuum."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool := StructuralModel.labelsDistinct StructuralModel.observationStatuses
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := StructuralModel.statusSeparation
end SFT.EarthEnvironment.EarthBoundary
