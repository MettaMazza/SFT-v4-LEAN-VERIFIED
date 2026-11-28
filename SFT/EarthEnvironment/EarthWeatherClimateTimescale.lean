import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthWeatherClimateTimescale
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
def original : Obligation := ⟨"SFT-EARTH-WEATHER-CLIMATE-TIMESCALE-001","Weather-climate timescale distinction","climate_system","nested-time-indexed-state-carrier","short-transition-to-long-distribution-relation","sampling-window-memory-forcing-and-variability-held","timescale-explicit","Weather and climate are distinct evidence classes linked by declared aggregation and memory relations; neither may be inferred from an unlabeled timescale.","Reject if one event proves a climate law or if a long-term distribution is used as a deterministic event forecast."⟩
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
end SFT.EarthEnvironment.EarthWeatherClimateTimescale
