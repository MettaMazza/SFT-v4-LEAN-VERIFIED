import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthSeismicWave
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
def original : Obligation := ⟨"SFT-EARTH-SEISMIC-WAVE-001","Seismic propagation record","seismic_volcanic","source-medium-receiver-carrier","source-to-receiver-propagation-relation","phase-path-time-instrument-and-uncertainty-held","network-resolution-bounded","A seismic record is a source-medium-receiver propagation trace with phase identity, path, timing, calibration and alternative source or medium explanations retained.","Reject if a processed arrival is treated as a direct interior image or if missing stations and phase ambiguity are erased."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "unit_exponent_is_uniquely_enumerated") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthSeismicWave
