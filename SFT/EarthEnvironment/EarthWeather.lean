import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthWeather
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
def original : Obligation := ⟨"SFT-EARTH-WEATHER-001","Weather state and forecast boundary","atmosphere_weather","finite-time-atmospheric-state-carrier","state-transition-and-observation-relation","initial-state-forcing-resolution-ensemble-and-outcomes-held","forecast-horizon-bounded","Weather is the observed atmospheric state and its finite-time transition record; a forecast is a sealed conditional consequence, not an observation or natural law.","Reject if forecast skill selects the governing law, if adverse forecasts are dropped, or if a model trajectory is relabelled as measured weather."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "bounded_cavity_has_distinct_modes") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthWeather
