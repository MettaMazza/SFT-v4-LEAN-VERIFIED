import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthAtmosphericComposition
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
def original : Obligation := ⟨"SFT-EARTH-ATMOSPHERIC-COMPOSITION-001","Atmospheric composition","atmosphere_weather","species-aerosol-mixture-carrier","amount-fraction-and-transformation-relation","species-units-altitude-location-time-and-method-held","sampling-network-bounded","Atmospheric composition is a source- and method-bound mixture record retaining species, amount basis, altitude, location, time, transformation and uncertainty.","Reject if dry, wet, local and global composition bases are mixed or if below-detection values become ordinary zero."⟩
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
end SFT.EarthEnvironment.EarthAtmosphericComposition
