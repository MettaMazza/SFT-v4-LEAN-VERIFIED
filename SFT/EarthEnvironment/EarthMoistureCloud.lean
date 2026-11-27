import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthMoistureCloud
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
def original : Obligation := ⟨"SFT-EARTH-MOISTURE-CLOUD-001","Atmospheric moisture and cloud organization","atmosphere_weather","water-vapour-droplet-ice-air-carrier","transport-phase-nucleation-and-precipitation-relation","phase-size-location-time-aerosol-and-uncertainty-held","cloud-observation-bounded","Atmospheric moisture and clouds are phase-resolved water organizations coupled to air motion, particles and radiation under explicit observation limits.","Reject if cloud occurrence alone fixes its microphysics or if unresolved sub-grid structure is treated as absent."⟩
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
end SFT.EarthEnvironment.EarthMoistureCloud
