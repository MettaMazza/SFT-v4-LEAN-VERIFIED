import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthProxyReconstruction
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
def original : Obligation := ⟨"SFT-EARTH-PROXY-RECONSTRUCTION-001","Proxy and Earth-history reconstruction","evidence_hazard_handoffs","archive-proxy-calibration-target-carrier","proxy-to-past-state-inference","archive-formation-dating-calibration-resolution-and-alternatives-held","proxy-region-period-bounded","A proxy reconstruction preserves archive formation, dating, calibration, resolution, uncertainty and competing environmental controls and remains distinct from direct observation.","Reject if one modern calibration is assumed invariant through untested history or if proxy disagreement is discarded."⟩
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
end SFT.EarthEnvironment.EarthProxyReconstruction
