import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthObservation
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
def original : Obligation := ⟨"SFT-EARTH-OBSERVATION-001","Earth observation","earth_system_observation","source-instrument-processing-result-carrier","source-to-record-trace","location-time-calibration-processing-and-quality-held","method-validity-bounded","An Earth observation is a reconstructible source-to-instrument-to-processing-to-result trace with calibration, uncertainty, exclusions and quality flags retained.","Reject if a model output, interpolated field or uncalibrated reading is silently relabelled as direct observation."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool := StructuralModel.labelsDistinct StructuralModel.observationStatuses
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := StructuralModel.statusSeparation
end SFT.EarthEnvironment.EarthObservation
