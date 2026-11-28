import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthClimateAttribution
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
def original : Obligation := ⟨"SFT-EARTH-CLIMATE-ATTRIBUTION-001","Climate detection and attribution","climate_system","observation-driver-response-alternative-carrier","generated-alternative-elimination-relation","forcings-internal-variation-methods-controls-and-uncertainty-held","question-and-period-bounded","Climate attribution requires a preregistered observation, candidate driver set, complete alternatives, controls and source-bound uncertainty; detection of change alone is not attribution.","Reject if the tested driver set omits a viable alternative, if a model ensemble selects its own target, or if disagreement and failed transport rows are removed."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "tipping_basins_share_image_without_physical_assignment") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthClimateAttribution
