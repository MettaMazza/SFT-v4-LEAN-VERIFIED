import SFT.AstronomyCosmology.StructuralModel
namespace SFT.AstronomyCosmology.AstronomicalClassification
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
def original : Obligation := ⟨"SFT-ASTRO-CLASSIFICATION-001","Astronomical classification","object_identity_classification","feature-evidence-class-carrier","feature-to-class-relation","features-method-probability-alternatives-and-version-held","classifier-and-taxonomy-bounded","Classification retains measured features, method, alternatives and taxonomy version.","Reject if a label replaces its evidence or an uncertain class becomes certain."⟩
def carrierWitness : Bool := !original.carrier.isEmpty
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "evidence_classes_distinct") with
 | none => false
 | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.AstronomyCosmology.AstronomicalClassification
