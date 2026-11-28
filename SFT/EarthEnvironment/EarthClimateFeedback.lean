import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthClimateFeedback
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
def original : Obligation := ⟨"SFT-EARTH-CLIMATE-FEEDBACK-001","Climate feedback","climate_system","state-response-return-path-carrier","response-modifies-driver-or-budget-relation","sign-as-orientation-gain-path-delay-and-boundaries-held","process-timescale-bounded","A climate feedback is a closed response path that modifies a registered driver or budget; its orientation, path, delay and boundary must remain structural labels rather than negative proof scalars.","Reject if correlation substitutes for a closed path or if the feedback magnitude is fitted from the same target used to validate it."⟩
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
end SFT.EarthEnvironment.EarthClimateFeedback
