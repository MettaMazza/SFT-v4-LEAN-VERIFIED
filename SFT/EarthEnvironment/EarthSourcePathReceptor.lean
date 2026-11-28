import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthSourcePathReceptor
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
def original : Obligation := ⟨"SFT-EARTH-SOURCE-PATH-RECEPTOR-001","Environmental source-path-receptor chain","environmental_transport_quality","source-medium-path-receptor-carrier","causal-transfer-chain","identity-route-timing-transformation-exposure-and-controls-held","system-and-study-bounded","An environmental exposure claim requires a reconstructible source-to-path-to-receptor chain retaining carrier identity, transformations, timing, alternatives and controls.","Reject if co-location or correlation substitutes for the transfer chain."⟩
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
end SFT.EarthEnvironment.EarthSourcePathReceptor
