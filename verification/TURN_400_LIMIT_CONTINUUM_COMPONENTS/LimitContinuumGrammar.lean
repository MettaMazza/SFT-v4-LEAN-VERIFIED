import SFT.Mathematics.LimitContinuumCensus0
import SFT.Mathematics.LimitContinuumCensus1
import SFT.Mathematics.LimitContinuumCensus2
import SFT.Mathematics.LimitContinuumCensus3
import SFT.Mathematics.LimitContinuumCensus4
import SFT.Mathematics.LimitContinuumCensus5
import SFT.Mathematics.LimitContinuumCensus6
import SFT.Mathematics.LimitContinuumCensus7
import SFT.Mathematics.LimitContinuumCensus8
import SFT.Mathematics.LimitContinuumCensus9
import SFT.Mathematics.LimitContinuumCensus10
import SFT.Mathematics.LimitContinuumCensus11
import SFT.Mathematics.LimitContinuumCensus12
import SFT.Mathematics.LimitContinuumCensus13
import SFT.Mathematics.LimitContinuumCensus14
import SFT.Mathematics.LimitContinuumCensus15
namespace SFT.Mathematics.LimitContinuumGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk object successor refinement convergence continuum cardinality generality addition =>
  cases object <;> cases successor <;> cases refinement <;> cases convergence
  · exact decisionCensus0 continuum cardinality generality addition
  · exact decisionCensus1 continuum cardinality generality addition
  · exact decisionCensus2 continuum cardinality generality addition
  · exact decisionCensus3 continuum cardinality generality addition
  · exact decisionCensus4 continuum cardinality generality addition
  · exact decisionCensus5 continuum cardinality generality addition
  · exact decisionCensus6 continuum cardinality generality addition
  · exact decisionCensus7 continuum cardinality generality addition
  · exact decisionCensus8 continuum cardinality generality addition
  · exact decisionCensus9 continuum cardinality generality addition
  · exact decisionCensus10 continuum cardinality generality addition
  · exact decisionCensus11 continuum cardinality generality addition
  · exact decisionCensus12 continuum cardinality generality addition
  · exact decisionCensus13 continuum cardinality generality addition
  · exact decisionCensus14 continuum cardinality generality addition
  · exact decisionCensus15 continuum cardinality generality addition
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk object successor refinement convergence continuum cardinality generality addition =>
  cases object <;> cases successor <;> cases refinement <;> cases convergence
  · exact uniqueCensus0 continuum cardinality generality addition
  · exact uniqueCensus1 continuum cardinality generality addition
  · exact uniqueCensus2 continuum cardinality generality addition
  · exact uniqueCensus3 continuum cardinality generality addition
  · exact uniqueCensus4 continuum cardinality generality addition
  · exact uniqueCensus5 continuum cardinality generality addition
  · exact uniqueCensus6 continuum cardinality generality addition
  · exact uniqueCensus7 continuum cardinality generality addition
  · exact uniqueCensus8 continuum cardinality generality addition
  · exact uniqueCensus9 continuum cardinality generality addition
  · exact uniqueCensus10 continuum cardinality generality addition
  · exact uniqueCensus11 continuum cardinality generality addition
  · exact uniqueCensus12 continuum cardinality generality addition
  · exact uniqueCensus13 continuum cardinality generality addition
  · exact uniqueCensus14 continuum cardinality generality addition
  · exact uniqueCensus15 continuum cardinality generality addition
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.object = .admitted ∧ c.successor = .admitted ∧ c.refinement = .admitted ∧ c.convergence = .admitted ∧ c.continuum = .admitted ∧ c.cardinality = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk object successor refinement convergence continuum cardinality generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem object_rejected_rejected (c : Candidate) (h : c.object = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.object eq
    rw [h] at field
    cases field

theorem successor_rejected_rejected (c : Candidate) (h : c.successor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.successor eq
    rw [h] at field
    cases field

theorem refinement_rejected_rejected (c : Candidate) (h : c.refinement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.refinement eq
    rw [h] at field
    cases field

theorem convergence_rejected_rejected (c : Candidate) (h : c.convergence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.convergence eq
    rw [h] at field
    cases field

theorem continuum_rejected_rejected (c : Candidate) (h : c.continuum = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.continuum eq
    rw [h] at field
    cases field

theorem cardinality_rejected_rejected (c : Candidate) (h : c.cardinality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cardinality eq
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

end SFT.Mathematics.LimitContinuumGrammar
