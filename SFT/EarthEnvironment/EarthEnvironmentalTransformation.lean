import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthEnvironmentalTransformation
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
def original : Obligation := ⟨"SFT-EARTH-ENVIRONMENTAL-TRANSFORMATION-001","Environmental transformation and persistence","environmental_transport_quality","substance-condition-product-carrier","condition-dependent-transition-network","precursors-products-pathways-rates-controls-and-time-held","medium-condition-bounded","Environmental transformation is a condition-bounded chemical or biological transition network with precursors, products, alternatives, rates and persistence observations retained.","Reject if disappearance of the measured precursor is treated as destruction of matter or proof of harmless products."⟩
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
end SFT.EarthEnvironment.EarthEnvironmentalTransformation
