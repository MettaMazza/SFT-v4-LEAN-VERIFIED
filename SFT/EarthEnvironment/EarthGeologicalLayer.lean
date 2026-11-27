import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthGeologicalLayer
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
def original : Obligation := ⟨"SFT-EARTH-GEOLOGICAL-LAYER-001","Geological layer","geological_material_history","bounded-spatial-material-carrier","adjacency-continuity-and-contact-relation","extent-thickness-contacts-facies-and-uncertainty-held","mapping-resolution-bounded","A geological layer is a mapped material body whose extent, contacts, continuity, internal variation and uncertainty are retained.","Reject if continuity is inferred across an unobserved gap without recording the correlation rule and alternatives."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "layers_are_positive_and_ordered") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthGeologicalLayer
