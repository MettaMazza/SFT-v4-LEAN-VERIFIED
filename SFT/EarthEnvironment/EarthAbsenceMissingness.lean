import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthAbsenceMissingness
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
def original : Obligation := ⟨"SFT-EARTH-ABSENCE-MISSINGNESS-001","Absence, non-detection and missingness","earth_system_observation","complete-observation-status-carrier","status-class-distinction","detected-absent-censored-missing-outside-scope-held","detection-boundary-declared","Observed absence, non-detection, censoring, missing data and outside-scope status are distinct Earth evidence classes and may not be merged.","Reject if any unavailable or unresolved observation is converted into ordinary numerical zero or favorable absence."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool := StructuralModel.labelsDistinct StructuralModel.observationStatuses
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := StructuralModel.statusSeparation
end SFT.EarthEnvironment.EarthAbsenceMissingness
