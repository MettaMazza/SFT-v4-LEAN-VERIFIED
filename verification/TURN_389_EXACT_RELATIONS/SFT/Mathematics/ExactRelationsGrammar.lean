import SFT.Mathematics.ExactRelationsCensus0
import SFT.Mathematics.ExactRelationsCensus1
import SFT.Mathematics.ExactRelationsCensus2
import SFT.Mathematics.ExactRelationsCensus3
import SFT.Mathematics.ExactRelationsCensus4
import SFT.Mathematics.ExactRelationsCensus5
import SFT.Mathematics.ExactRelationsCensus6
import SFT.Mathematics.ExactRelationsCensus7
import SFT.Mathematics.ExactRelationsCensus8
import SFT.Mathematics.ExactRelationsCensus9
import SFT.Mathematics.ExactRelationsCensus10
import SFT.Mathematics.ExactRelationsCensus11
import SFT.Mathematics.ExactRelationsCensus12
import SFT.Mathematics.ExactRelationsCensus13
import SFT.Mathematics.ExactRelationsCensus14
import SFT.Mathematics.ExactRelationsCensus15
namespace SFT.Mathematics.ExactRelationsGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk provenance relation orientation threshold transport composition generality addition =>
  cases provenance <;> cases relation <;> cases orientation <;> cases threshold
  · exact decisionCensus0 transport composition generality addition
  · exact decisionCensus1 transport composition generality addition
  · exact decisionCensus2 transport composition generality addition
  · exact decisionCensus3 transport composition generality addition
  · exact decisionCensus4 transport composition generality addition
  · exact decisionCensus5 transport composition generality addition
  · exact decisionCensus6 transport composition generality addition
  · exact decisionCensus7 transport composition generality addition
  · exact decisionCensus8 transport composition generality addition
  · exact decisionCensus9 transport composition generality addition
  · exact decisionCensus10 transport composition generality addition
  · exact decisionCensus11 transport composition generality addition
  · exact decisionCensus12 transport composition generality addition
  · exact decisionCensus13 transport composition generality addition
  · exact decisionCensus14 transport composition generality addition
  · exact decisionCensus15 transport composition generality addition
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk provenance relation orientation threshold transport composition generality addition =>
  cases provenance <;> cases relation <;> cases orientation <;> cases threshold
  · exact uniqueCensus0 transport composition generality addition
  · exact uniqueCensus1 transport composition generality addition
  · exact uniqueCensus2 transport composition generality addition
  · exact uniqueCensus3 transport composition generality addition
  · exact uniqueCensus4 transport composition generality addition
  · exact uniqueCensus5 transport composition generality addition
  · exact uniqueCensus6 transport composition generality addition
  · exact uniqueCensus7 transport composition generality addition
  · exact uniqueCensus8 transport composition generality addition
  · exact uniqueCensus9 transport composition generality addition
  · exact uniqueCensus10 transport composition generality addition
  · exact uniqueCensus11 transport composition generality addition
  · exact uniqueCensus12 transport composition generality addition
  · exact uniqueCensus13 transport composition generality addition
  · exact uniqueCensus14 transport composition generality addition
  · exact uniqueCensus15 transport composition generality addition
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.provenance = .admitted ∧ c.relation = .admitted ∧ c.orientation = .admitted ∧ c.threshold = .admitted ∧ c.transport = .admitted ∧ c.composition = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk provenance relation orientation threshold transport composition generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
    rw [h] at field
    cases field

theorem threshold_rejected_rejected (c : Candidate) (h : c.threshold = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.threshold eq
    rw [h] at field
    cases field

theorem transport_rejected_rejected (c : Candidate) (h : c.transport = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transport eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

end SFT.Mathematics.ExactRelationsGrammar
