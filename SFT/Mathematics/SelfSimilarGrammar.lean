import SFT.Mathematics.SelfSimilarCensus0
import SFT.Mathematics.SelfSimilarCensus1
import SFT.Mathematics.SelfSimilarCensus2
import SFT.Mathematics.SelfSimilarCensus3
import SFT.Mathematics.SelfSimilarCensus4
import SFT.Mathematics.SelfSimilarCensus5
import SFT.Mathematics.SelfSimilarCensus6
import SFT.Mathematics.SelfSimilarCensus7
import SFT.Mathematics.SelfSimilarCensus8
import SFT.Mathematics.SelfSimilarCensus9
import SFT.Mathematics.SelfSimilarCensus10
import SFT.Mathematics.SelfSimilarCensus11
import SFT.Mathematics.SelfSimilarCensus12
import SFT.Mathematics.SelfSimilarCensus13
import SFT.Mathematics.SelfSimilarCensus14
import SFT.Mathematics.SelfSimilarCensus15
namespace SFT.Mathematics.SelfSimilarGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk scale separation information power support series generality addition =>
  cases scale <;> cases separation <;> cases information <;> cases power
  · exact decisionCensus0 support series generality addition
  · exact decisionCensus1 support series generality addition
  · exact decisionCensus2 support series generality addition
  · exact decisionCensus3 support series generality addition
  · exact decisionCensus4 support series generality addition
  · exact decisionCensus5 support series generality addition
  · exact decisionCensus6 support series generality addition
  · exact decisionCensus7 support series generality addition
  · exact decisionCensus8 support series generality addition
  · exact decisionCensus9 support series generality addition
  · exact decisionCensus10 support series generality addition
  · exact decisionCensus11 support series generality addition
  · exact decisionCensus12 support series generality addition
  · exact decisionCensus13 support series generality addition
  · exact decisionCensus14 support series generality addition
  · exact decisionCensus15 support series generality addition
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk scale separation information power support series generality addition =>
  cases scale <;> cases separation <;> cases information <;> cases power
  · exact uniqueCensus0 support series generality addition
  · exact uniqueCensus1 support series generality addition
  · exact uniqueCensus2 support series generality addition
  · exact uniqueCensus3 support series generality addition
  · exact uniqueCensus4 support series generality addition
  · exact uniqueCensus5 support series generality addition
  · exact uniqueCensus6 support series generality addition
  · exact uniqueCensus7 support series generality addition
  · exact uniqueCensus8 support series generality addition
  · exact uniqueCensus9 support series generality addition
  · exact uniqueCensus10 support series generality addition
  · exact uniqueCensus11 support series generality addition
  · exact uniqueCensus12 support series generality addition
  · exact uniqueCensus13 support series generality addition
  · exact uniqueCensus14 support series generality addition
  · exact uniqueCensus15 support series generality addition
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.scale = .admitted ∧ c.separation = .admitted ∧ c.information = .admitted ∧ c.power = .admitted ∧ c.support = .admitted ∧ c.series = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk scale separation information power support series generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem scale_rejected_rejected (c : Candidate) (h : c.scale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scale eq
    rw [h] at field
    cases field

theorem separation_rejected_rejected (c : Candidate) (h : c.separation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.separation eq
    rw [h] at field
    cases field

theorem information_rejected_rejected (c : Candidate) (h : c.information = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.information eq
    rw [h] at field
    cases field

theorem power_rejected_rejected (c : Candidate) (h : c.power = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.power eq
    rw [h] at field
    cases field

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem series_rejected_rejected (c : Candidate) (h : c.series = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.series eq
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

end SFT.Mathematics.SelfSimilarGrammar
