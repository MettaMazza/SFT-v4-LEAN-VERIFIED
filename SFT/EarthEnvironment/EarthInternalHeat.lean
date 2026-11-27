import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthInternalHeat
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
def original : Obligation := ⟨"SFT-EARTH-INTERNAL-HEAT-001","Earth internal heat sources","interior_geodynamics","source-reservoir-thermal-carrier","production-storage-transfer-relation","source-identity-location-rate-history-and-uncertainty-held","thermal-ledger-bounded","Earth internal heat is a complete source, storage and transport ledger distinguishing inherited, transformation and internally generated contributions.","Reject if present surface flux is assigned to a unique interior source without a registered transport history."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "layers_are_positive_and_ordered") with
   | none => false | some row => row.2) &&
  (match rows.find? (fun row => SFT.Host.Text.equal row.1 "boundary_transfer_is_two_sided") with
   | none => false | some row => row.2)
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthInternalHeat
