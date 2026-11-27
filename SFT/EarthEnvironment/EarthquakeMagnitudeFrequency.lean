import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthquakeMagnitudeFrequency
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
def original : Obligation := ⟨"SFT-EARTH-QUAKE-MAGNITUDE-FREQUENCY-001","Earthquake magnitude-frequency law","seismic_volcanic","complete-catalog-size-count-carrier","scale-to-frequency-recurrence","magnitude-scale-threshold-region-time-and-residuals-held","catalog-completeness-bounded","An earthquake magnitude-frequency claim is an exact size-count relation over a complete declared catalog, with its exponent derived before blind comparison and all departures retained.","Reject if the catalog selects the exponent, if incomplete small events are treated as absent, or if one fitted line erases scale-dependent departures."⟩
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
end SFT.EarthEnvironment.EarthquakeMagnitudeFrequency
