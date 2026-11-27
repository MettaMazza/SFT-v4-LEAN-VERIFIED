import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthGroundwater
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
def original : Obligation := ⟨"SFT-EARTH-GROUNDWATER-001","Groundwater system","hydrosphere_cryosphere","subsurface-water-material-carrier","storage-gradient-path-and-exchange-relation","porosity-composition-boundaries-recharge-discharge-and-time-held","aquifer-observation-bounded","A groundwater system is a material-bounded storage and transfer organization with recharge, paths, composition, residence and discharge observations retained.","Reject if hydraulic head or a model surface is substituted for direct water identity, path and source evidence."⟩
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
end SFT.EarthEnvironment.EarthGroundwater
