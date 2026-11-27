import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthGeologicalProvenance
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
def original : Obligation := ⟨"SFT-EARTH-GEOLOGICAL-PROVENANCE-001","Geological provenance","geological_material_history","source-path-deposit-carrier","source-to-observed-material-reconstruction","composition-age-route-alteration-and-alternatives-held","method-and-basin-bounded","Geological provenance is a source-to-path-to-deposit reconstruction supported by retained composition, age, alteration and competing-source evidence.","Reject if one matching property uniquely identifies a source while generated alternatives remain viable."⟩
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
end SFT.EarthEnvironment.EarthGeologicalProvenance
