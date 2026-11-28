import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthSystemTipping
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
def original : Obligation := ⟨"SFT-EARTH-EARTH-SYSTEM-TIPPING-001","Earth-system tipping boundary","climate_system","multi-basin-state-forcing-carrier","threshold-crossing-hysteresis-and-return-relation","state-variable-driver-path-rate-controls-and-time-held","system-proxy-and-timescale-bounded","An Earth-system tipping claim requires observed or independently reconstructed basins, forcing path, threshold crossing, hysteresis or return behavior and ordinary-variability controls; no universal physical half-One threshold is assumed.","Reject if abrupt change alone establishes tipping, if the threshold is read from the validation target, or if reversible and ordinary-variable alternatives survive."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "tipping_basins_share_image_without_physical_assignment") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthSystemTipping
