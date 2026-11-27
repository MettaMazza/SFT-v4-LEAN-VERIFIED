import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthGeologicalMaterial
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
def original : Obligation := ⟨"SFT-EARTH-GEOLOGICAL-MATERIAL-001","Geological material identity","geological_material_history","specimen-composition-phase-texture-carrier","material-class-equivalence","provenance-mineralogy-chemistry-structure-and-scale-held","specimen-method-bounded","A geological material is a source-bound specimen class retaining chemical composition, material phases, texture, structure, provenance and observation scale.","Reject if a hand specimen name erases heterogeneous phases, alteration, provenance or measurement resolution."⟩
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
end SFT.EarthEnvironment.EarthGeologicalMaterial
