import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthForecastValidation
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
def original : Obligation := ⟨"SFT-EARTH-FORECAST-VALIDATION-001","Earth forecast validation","evidence_hazard_handoffs","sealed-forecast-outcome-carrier","predeclared-comparison-relation","targets-metrics-baselines-adverse-cases-missingness-and-time-held","forecast-question-bounded","Forecast validation compares a sealed forecast with later source-bound outcomes using preregistered targets, metrics, baselines and complete adverse and missing rows.","Reject if the target or score enters before sealing, if unfavorable forecasts are omitted, or if accuracy is treated as proof of an opaque law."⟩
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
end SFT.EarthEnvironment.EarthForecastValidation
