import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthClimateForcing
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
def original : Obligation := ⟨"SFT-EARTH-CLIMATE-FORCING-001","Climate forcing","climate_system","external-or-boundary-driver-carrier","driver-to-energy-or-matter-budget-change","identity-magnitude-timing-spectrum-location-and-uncertainty-held","system-boundary-bounded","A climate forcing is a registered driver that changes a declared Earth-system boundary ledger while retaining identity, timing, spectrum, location and uncertainty.","Reject if an internal response is relabelled as forcing or if the forcing is inferred solely from the response it is meant to explain."⟩
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
end SFT.EarthEnvironment.EarthClimateForcing
