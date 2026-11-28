import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthFieldObservation
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
def original : Obligation := ⟨"SFT-EARTH-FIELD-OBSERVATION-001","Field observation and sampling","evidence_hazard_handoffs","site-specimen-instrument-result-carrier","sampling-to-population-relation","design-location-time-effort-calibration-and-exclusions-held","representativeness-declared","A field observation retains site selection, sampling design, effort, calibration, processing, exclusions and representativeness limits.","Reject if convenience samples establish a global Earth relation or if failed and below-detection samples are removed."⟩
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
end SFT.EarthEnvironment.EarthFieldObservation
