import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthGeologicalCycle
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
def original : Obligation := ⟨"SFT-EARTH-GEOLOGICAL-CYCLE-001","Geological transformation cycle","geological_material_history","material-state-transition-network","weathering-transport-deposition-transformation-relation","inputs-products-paths-losses-and-times-held","process-network-bounded","A geological cycle is a reconstructible network of material-state transitions whose carriers, paths, transfers, losses and recurrence boundary remain explicit.","Reject if a named cycle implies that every carrier returns or if intermediate transformations and exports are omitted."⟩
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
end SFT.EarthEnvironment.EarthGeologicalCycle
