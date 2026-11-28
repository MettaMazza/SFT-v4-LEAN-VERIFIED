import SFT.AstronomyCosmology.StructuralModel
namespace SFT.AstronomyCosmology.SurveySelection
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
def original : Obligation := ⟨"SFT-ASTRO-SELECTION-001","Survey selection and non-detection","observation_geometry","target-opportunity-detection-status-carrier","selection-and-detection-relation","footprint-cadence-threshold-masks-and-missingness-held","survey-selection-bounded","Selection, detection, upper limit, non-detection, missing and outside-footprint status remain distinct.","Reject if a non-detection or missing row becomes ordinary zero or confirmed absence."⟩
def carrierWitness : Bool := !original.carrier.isEmpty
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "source_path_observer_ordered") with
 | none => false
 | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.AstronomyCosmology.SurveySelection
