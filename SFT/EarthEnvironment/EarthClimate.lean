import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthClimate
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
def original : Obligation := ⟨"SFT-EARTH-CLIMATE-001","Climate state","climate_system","distribution-of-earth-state-histories-carrier","time-window-recurrence-and-change-relation","variables-distributions-extremes-boundaries-and-methods-held","declared-climate-window-bounded","Climate is a source- and interval-bounded distribution of Earth-system states, variations and extremes rather than one instantaneous weather state or mean.","Reject if the averaging interval, distribution, extremes, spatial support or observation changes are omitted."⟩
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
end SFT.EarthEnvironment.EarthClimate
