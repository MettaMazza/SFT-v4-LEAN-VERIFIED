import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthHistory
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
def original : Obligation := ⟨"SFT-EARTH-EARTH-HISTORY-001","Earth historical record","geological_material_history","time-ordered-multi-proxy-carrier","event-state-reconstruction","dating-provenance-gaps-resolution-and-alternatives-held","dated-record-bounded","An Earth-history claim is a source-dated reconstruction over preserved records with temporal uncertainty, gaps, resolution and alternative histories retained.","Reject if absence of record becomes proof of absence, if dating uncertainty is erased, or if a universal law is inferred from one contingent history alone."⟩
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
end SFT.EarthEnvironment.EarthHistory
