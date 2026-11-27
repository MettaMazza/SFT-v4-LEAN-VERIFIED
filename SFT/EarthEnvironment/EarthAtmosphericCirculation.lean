import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthAtmosphericCirculation
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
def original : Obligation := ⟨"SFT-EARTH-ATMOSPHERIC-CIRCULATION-001","Atmospheric circulation","atmosphere_weather","time-indexed-air-mass-motion-carrier","transport-recurrence-and-exchange-network","position-orientation-moisture-energy-boundaries-and-time-held","spatial-temporal-window-bounded","Atmospheric circulation is a time-indexed network of air-mass motion and exchange retaining orientation, transported carriers, boundaries and unresolved scales.","Reject if one averaged velocity field is treated as the complete carrier history or if opposite orientations are encoded as negative proof magnitudes."⟩
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
end SFT.EarthEnvironment.EarthAtmosphericCirculation
