import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthquakeCatalog
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
def original : Obligation := ⟨"SFT-EARTH-EARTHQUAKE-CATALOG-001","Earthquake catalog","seismic_volcanic","event-detection-location-magnitude-carrier","catalog-membership-and-equivalence-relation","network-threshold-method-duplicates-errors-and-time-held","catalog-completeness-bounded","An earthquake catalog is a method- and interval-bounded event set retaining detection threshold, location, magnitude scale, duplicates, uncertainty and completeness changes.","Reject if catalogs with different thresholds or magnitude scales are pooled without a registered translation."⟩
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
end SFT.EarthEnvironment.EarthquakeCatalog
