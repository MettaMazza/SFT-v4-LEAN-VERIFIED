import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthEnvironmentalAccumulation
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
def original : Obligation := ⟨"SFT-EARTH-ENVIRONMENTAL-ACCUMULATION-001","Environmental accumulation","environmental_transport_quality","input-storage-output-history-carrier","retention-and-release-ledger","carrier-reservoir-input-output-transformation-and-time-held","reservoir-and-interval-bounded","Environmental accumulation is an input-storage-output ledger over a declared reservoir and interval, including transformation, remobilization and unresolved stock.","Reject if concentration alone establishes accumulation without volume, input, output and time records."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "boundary_transfer_is_two_sided") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthEnvironmentalAccumulation
