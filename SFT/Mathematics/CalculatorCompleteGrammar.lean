import SFT.Mathematics.CalculatorCompleteCensus0
import SFT.Mathematics.CalculatorCompleteCensus1
import SFT.Mathematics.CalculatorCompleteCensus2
import SFT.Mathematics.CalculatorCompleteCensus3
import SFT.Mathematics.CalculatorCompleteCensus4
import SFT.Mathematics.CalculatorCompleteCensus5
import SFT.Mathematics.CalculatorCompleteCensus6
import SFT.Mathematics.CalculatorCompleteCensus7
import SFT.Mathematics.CalculatorCompleteCensus8
import SFT.Mathematics.CalculatorCompleteCensus9
import SFT.Mathematics.CalculatorCompleteCensus10
import SFT.Mathematics.CalculatorCompleteCensus11
import SFT.Mathematics.CalculatorCompleteCensus12
import SFT.Mathematics.CalculatorCompleteCensus13
import SFT.Mathematics.CalculatorCompleteCensus14
import SFT.Mathematics.CalculatorCompleteCensus15
namespace SFT.Mathematics.CalculatorCompleteGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk interaction value_law scientific_surface mathematics_census proof_output accessibility portability periodic_scale resource_boundary testing =>
    cases interaction <;> cases value_law <;> cases scientific_surface <;> cases mathematics_census
    · exact sourceDecisionChunk0 _ _ _ _ _ _
    · exact sourceDecisionChunk1 _ _ _ _ _ _
    · exact sourceDecisionChunk2 _ _ _ _ _ _
    · exact sourceDecisionChunk3 _ _ _ _ _ _
    · exact sourceDecisionChunk4 _ _ _ _ _ _
    · exact sourceDecisionChunk5 _ _ _ _ _ _
    · exact sourceDecisionChunk6 _ _ _ _ _ _
    · exact sourceDecisionChunk7 _ _ _ _ _ _
    · exact sourceDecisionChunk8 _ _ _ _ _ _
    · exact sourceDecisionChunk9 _ _ _ _ _ _
    · exact sourceDecisionChunk10 _ _ _ _ _ _
    · exact sourceDecisionChunk11 _ _ _ _ _ _
    · exact sourceDecisionChunk12 _ _ _ _ _ _
    · exact sourceDecisionChunk13 _ _ _ _ _ _
    · exact sourceDecisionChunk14 _ _ _ _ _ _
    · exact sourceDecisionChunk15 _ _ _ _ _ _

theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk interaction value_law scientific_surface mathematics_census proof_output accessibility portability periodic_scale resource_boundary testing =>
    cases interaction <;> cases value_law <;> cases scientific_surface <;> cases mathematics_census
    · exact uniqueCriteriaChunk0 _ _ _ _ _ _
    · exact uniqueCriteriaChunk1 _ _ _ _ _ _
    · exact uniqueCriteriaChunk2 _ _ _ _ _ _
    · exact uniqueCriteriaChunk3 _ _ _ _ _ _
    · exact uniqueCriteriaChunk4 _ _ _ _ _ _
    · exact uniqueCriteriaChunk5 _ _ _ _ _ _
    · exact uniqueCriteriaChunk6 _ _ _ _ _ _
    · exact uniqueCriteriaChunk7 _ _ _ _ _ _
    · exact uniqueCriteriaChunk8 _ _ _ _ _ _
    · exact uniqueCriteriaChunk9 _ _ _ _ _ _
    · exact uniqueCriteriaChunk10 _ _ _ _ _ _
    · exact uniqueCriteriaChunk11 _ _ _ _ _ _
    · exact uniqueCriteriaChunk12 _ _ _ _ _ _
    · exact uniqueCriteriaChunk13 _ _ _ _ _ _
    · exact uniqueCriteriaChunk14 _ _ _ _ _ _
    · exact uniqueCriteriaChunk15 _ _ _ _ _ _

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.interaction = .admitted ∧ c.value_law = .admitted ∧ c.scientific_surface = .admitted ∧ c.mathematics_census = .admitted ∧ c.proof_output = .admitted ∧ c.accessibility = .admitted ∧ c.portability = .admitted ∧ c.periodic_scale = .admitted ∧ c.resource_boundary = .admitted ∧ c.testing = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk interaction value_law scientific_surface mathematics_census proof_output accessibility portability periodic_scale resource_boundary testing =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem interaction_rejected_rejected (c : Candidate) (h : c.interaction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.interaction eq
    rw [h] at field
    cases field

theorem value_law_rejected_rejected (c : Candidate) (h : c.value_law = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.value_law eq
    rw [h] at field
    cases field

theorem scientific_surface_rejected_rejected (c : Candidate) (h : c.scientific_surface = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scientific_surface eq
    rw [h] at field
    cases field

theorem mathematics_census_rejected_rejected (c : Candidate) (h : c.mathematics_census = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mathematics_census eq
    rw [h] at field
    cases field

theorem proof_output_rejected_rejected (c : Candidate) (h : c.proof_output = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.proof_output eq
    rw [h] at field
    cases field

theorem accessibility_rejected_rejected (c : Candidate) (h : c.accessibility = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.accessibility eq
    rw [h] at field
    cases field

theorem portability_rejected_rejected (c : Candidate) (h : c.portability = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.portability eq
    rw [h] at field
    cases field

theorem periodic_scale_rejected_rejected (c : Candidate) (h : c.periodic_scale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.periodic_scale eq
    rw [h] at field
    cases field

theorem resource_boundary_rejected_rejected (c : Candidate) (h : c.resource_boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.resource_boundary eq
    rw [h] at field
    cases field

theorem testing_rejected_rejected (c : Candidate) (h : c.testing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.testing eq
    rw [h] at field
    cases field

end SFT.Mathematics.CalculatorCompleteGrammar
