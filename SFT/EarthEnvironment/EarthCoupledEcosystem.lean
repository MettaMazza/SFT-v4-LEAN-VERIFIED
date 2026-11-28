import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthCoupledEcosystem
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
def original : Obligation := ⟨"SFT-EARTH-COUPLED-ECOSYSTEM-001","Coupled ecosystem-Earth organization","biogeochemical_ecological","community-abiotic-reservoir-joint-carrier","biotic-abiotic-transfer-and-feedback-network","species-resources-disturbance-boundaries-effort-and-time-held","ecosystem-observation-bounded","A coupled ecosystem-Earth claim retains Biology-owned communities together with abiotic stocks, transfers, disturbances, observation effort and missing links.","Reject if ecological recurrence alone establishes planetary stability or if absent observations become absent interactions."⟩
def carrierWitness : Bool := SFT.Physics.CapabilityValues.nonblank original.carrier
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses with
 | .error _ => false
 | .ok rows =>
  match rows.find? (fun row => SFT.Host.Text.equal row.1 "coupled_cycle_recurs_and_closes") with
  | none => false
  | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.EarthEnvironment.EarthCoupledEcosystem
