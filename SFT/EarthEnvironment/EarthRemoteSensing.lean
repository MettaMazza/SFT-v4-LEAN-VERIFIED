import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthRemoteSensing
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
def original : Obligation := ⟨"SFT-EARTH-REMOTE-SENSING-001","Remote-sensing observation","evidence_hazard_handoffs","source-path-sensor-retrieval-carrier","signal-to-geophysical-record-relation","geometry-spectrum-calibration-processing-validation-and-cloud-held","sensor-product-bounded","Remote sensing is a source-to-path-to-sensor-to-retrieval trace whose geophysical interpretation retains calibration, geometry, processing, validation and unavailable pixels.","Reject if a retrieval product is called direct ground truth or if cloud, saturation and algorithm changes are erased."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "observation_statuses_remain_distinct") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthRemoteSensing
