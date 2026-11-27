import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthSurfaceWater
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
def original : Obligation := ⟨"SFT-EARTH-SURFACE-WATER-001","Rivers, lakes and surface-water networks","hydrosphere_cryosphere","surface-water-node-edge-carrier","storage-routing-and-exchange-relation","network-geometry-flow-quality-boundaries-and-time-held","catchment-window-bounded","Surface-water organization is a directed storage and transfer network over rivers, lakes, wetlands and interfaces with complete catchment and observation boundaries.","Reject if ungauged reaches, diversions, floodplain storage or groundwater exchange are silently omitted."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "complementary_cycle_recurs") with
   | none => false | some row => row.2) &&
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "reservoir_partition_closes") with
   | none => false | some row => row.2)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthSurfaceWater
