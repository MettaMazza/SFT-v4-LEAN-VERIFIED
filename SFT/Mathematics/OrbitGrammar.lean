import SFT.Mathematics.OrbitCensus0
import SFT.Mathematics.OrbitCensus1
import SFT.Mathematics.OrbitCensus2
import SFT.Mathematics.OrbitCensus3
import SFT.Mathematics.OrbitCensus4
import SFT.Mathematics.OrbitCensus5
import SFT.Mathematics.OrbitCensus6
import SFT.Mathematics.OrbitCensus7
import SFT.Mathematics.OrbitCensus8
import SFT.Mathematics.OrbitCensus9
import SFT.Mathematics.OrbitCensus10
import SFT.Mathematics.OrbitCensus11
import SFT.Mathematics.OrbitCensus12
import SFT.Mathematics.OrbitCensus13
import SFT.Mathematics.OrbitCensus14
import SFT.Mathematics.OrbitCensus15
namespace SFT.Mathematics.OrbitGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk domain reduction transition period partition transient generality addition =>
  cases domain <;> cases reduction <;> cases transition <;> cases period
  · exact decisionCensus0 partition transient generality addition
  · exact decisionCensus1 partition transient generality addition
  · exact decisionCensus2 partition transient generality addition
  · exact decisionCensus3 partition transient generality addition
  · exact decisionCensus4 partition transient generality addition
  · exact decisionCensus5 partition transient generality addition
  · exact decisionCensus6 partition transient generality addition
  · exact decisionCensus7 partition transient generality addition
  · exact decisionCensus8 partition transient generality addition
  · exact decisionCensus9 partition transient generality addition
  · exact decisionCensus10 partition transient generality addition
  · exact decisionCensus11 partition transient generality addition
  · exact decisionCensus12 partition transient generality addition
  · exact decisionCensus13 partition transient generality addition
  · exact decisionCensus14 partition transient generality addition
  · exact decisionCensus15 partition transient generality addition
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk domain reduction transition period partition transient generality addition =>
  cases domain <;> cases reduction <;> cases transition <;> cases period
  · exact uniqueCensus0 partition transient generality addition
  · exact uniqueCensus1 partition transient generality addition
  · exact uniqueCensus2 partition transient generality addition
  · exact uniqueCensus3 partition transient generality addition
  · exact uniqueCensus4 partition transient generality addition
  · exact uniqueCensus5 partition transient generality addition
  · exact uniqueCensus6 partition transient generality addition
  · exact uniqueCensus7 partition transient generality addition
  · exact uniqueCensus8 partition transient generality addition
  · exact uniqueCensus9 partition transient generality addition
  · exact uniqueCensus10 partition transient generality addition
  · exact uniqueCensus11 partition transient generality addition
  · exact uniqueCensus12 partition transient generality addition
  · exact uniqueCensus13 partition transient generality addition
  · exact uniqueCensus14 partition transient generality addition
  · exact uniqueCensus15 partition transient generality addition
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.domain = .admitted ∧ c.reduction = .admitted ∧ c.transition = .admitted ∧ c.period = .admitted ∧ c.partition = .admitted ∧ c.transient = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk domain reduction transition period partition transient generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem domain_rejected_rejected (c : Candidate) (h : c.domain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
    rw [h] at field
    cases field

theorem reduction_rejected_rejected (c : Candidate) (h : c.reduction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reduction eq
    rw [h] at field
    cases field

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
    rw [h] at field
    cases field

theorem period_rejected_rejected (c : Candidate) (h : c.period = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.period eq
    rw [h] at field
    cases field

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
    rw [h] at field
    cases field

theorem transient_rejected_rejected (c : Candidate) (h : c.transient = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transient eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Mathematics.OrbitGrammar
