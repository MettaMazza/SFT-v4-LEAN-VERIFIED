import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthMatterBudget
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
def original : Obligation := ⟨"SFT-EARTH-MATTER-BUDGET-001","Earth-system matter budget","planetary_budgets","species-resolved-stock-transfer-carrier","source-storage-transformation-export-balance","species-phase-location-time-and-uncertainty-held","matter-domain-bounded","An Earth matter budget follows distinguishable material carriers through storage, transformation, transfer and export without permitting disappearance.","Reject if chemical identity, phase, location, boundary transfer or unresolved stock is erased."⟩
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
end SFT.EarthEnvironment.EarthMatterBudget
