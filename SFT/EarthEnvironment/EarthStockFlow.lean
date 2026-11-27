import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthStockFlow
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
def original : Obligation := ⟨"SFT-EARTH-STOCK-FLOW-001","Stock and flow distinction","planetary_budgets","reservoir-stock-interface-flow-carrier","time-integrated-transfer-relation","stock-basis-flow-interval-and-boundary-held","quantity-and-interval-bounded","A stock is retained occupancy within a boundary; a flow is a counted transfer across an interface during a declared interval, and neither may substitute for the other.","Reject if an instantaneous rate is added to a stock without an interval or if cumulative transfer is presented as simultaneous occupancy."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "reservoir_partition_closes") with
   | none => false | some row => row.2) &&
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "boundary_transfer_is_two_sided") with
   | none => false | some row => row.2)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthStockFlow
