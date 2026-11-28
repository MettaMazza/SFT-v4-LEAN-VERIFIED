import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthModelDataAssimilation
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
def original : Obligation := ⟨"SFT-EARTH-MODEL-DATA-ASSIMILATION-001","Earth model and data-assimilation boundary","evidence_hazard_handoffs","law-state-observation-update-carrier","conditional-simulation-and-state-update-relation","equations-as-correspondence-inputs-parameters-observations-errors-and-outputs-held","model-purpose-bounded","An Earth model is a declared conditional simulation and data assimilation is a traceable state update; neither can select an SFT law or become an observation.","Reject if tuned performance is offered as structural proof, if observations leak into a sealed prediction, or if model and observation errors are conflated."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "observation_statuses_remain_distinct") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthModelDataAssimilation
