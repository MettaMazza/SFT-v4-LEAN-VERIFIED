import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthAtmosphere
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
def original : Obligation := ⟨"SFT-EARTH-ATMOSPHERE-001","Atmospheric system identity","atmosphere_weather","bounded-gas-aerosol-energy-carrier","layered-composition-motion-and-exchange-relation","composition-state-height-boundaries-and-time-held","atmospheric-observation-bounded","The atmosphere is a layered, moving material and energy carrier whose composition, state, boundaries and exchanges with other Earth reservoirs remain explicit.","Reject if a global mean erases vertical, regional or temporal structure required by the claim."⟩
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
end SFT.EarthEnvironment.EarthAtmosphere
