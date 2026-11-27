import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthHydrologicCycle
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
def original : Obligation := ⟨"SFT-EARTH-HYDROLOGIC-CYCLE-001","Hydrologic cycle","hydrosphere_cryosphere","water-reservoir-transfer-network","evaporation-transport-precipitation-runoff-infiltration-relation","stocks-flows-phases-boundaries-and-losses-held","basin-and-time-bounded","The hydrologic cycle is a bounded reservoir-transfer network whose stocks, phase changes, atmospheric transport, precipitation, runoff, infiltration and exports remain counted.","Reject if the name cycle implies closure while storage change, groundwater exchange or boundary export remains unregistered."⟩
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
end SFT.EarthEnvironment.EarthHydrologicCycle
