import SFT.EarthEnvironment.StructuralModel
namespace SFT.EarthEnvironment.EarthHazardRiskHandoff
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
def original : Obligation := ⟨"SFT-EARTH-HAZARD-RISK-HANDOFF-001","Hazard, risk, resilience and disciplinary handoff","evidence_hazard_handoffs","process-exposure-vulnerability-consequence-carrier","hazard-to-impact-and-recovery-chain","event-probability-exposure-vulnerability-capacity-time-and-ownership-held","decision-context-bounded","Earth Science owns the physical or environmental hazard record; risk composes exposure and vulnerability at explicit Social, Medicine and Engineering handoffs, while resilience retains recovery capacities and failures.","Reject if hazard is equated with impact, if a probability is asserted without a reference class, or if Earth Science reowns social, clinical or engineered consequences."⟩
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
end SFT.EarthEnvironment.EarthHazardRiskHandoff
