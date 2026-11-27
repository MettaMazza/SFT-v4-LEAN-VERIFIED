import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthWaterPhaseHandoff
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
def original : Obligation := ⟨"SFT-EARTH-WATER-PHASE-HANDOFF-001","Environmental water phase handoff","hydrosphere_cryosphere","water-state-interface-carrier","phase-transition-and-transfer-relation","source-destination-energy-solutes-and-time-held","interface-condition-bounded","An environmental water phase handoff cites admitted physical and chemical phase laws while retaining source, destination, energy, solutes, boundary and time.","Reject if universal phase behavior is reowned by Earth Science or if environmental carriers and impurities are omitted."⟩
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
end SFT.EarthEnvironment.EarthWaterPhaseHandoff
