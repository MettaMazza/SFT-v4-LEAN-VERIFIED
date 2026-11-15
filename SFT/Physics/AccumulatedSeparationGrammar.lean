import SFT.Physics.AccumulatedSeparationCensus0
import SFT.Physics.AccumulatedSeparationCensus1
import SFT.Physics.AccumulatedSeparationCensus2
import SFT.Physics.AccumulatedSeparationCensus3
import SFT.Physics.AccumulatedSeparationCensus4
import SFT.Physics.AccumulatedSeparationCensus5
import SFT.Physics.AccumulatedSeparationCensus6
import SFT.Physics.AccumulatedSeparationCensus7
import SFT.Physics.AccumulatedSeparationCensus8
import SFT.Physics.AccumulatedSeparationCensus9
import SFT.Physics.AccumulatedSeparationCensus10
import SFT.Physics.AccumulatedSeparationCensus11
import SFT.Physics.AccumulatedSeparationCensus12
import SFT.Physics.AccumulatedSeparationCensus13
import SFT.Physics.AccumulatedSeparationCensus14
import SFT.Physics.AccumulatedSeparationCensus15
namespace SFT.Physics.AccumulatedSeparationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor term first contraction envelope boundary tolerance extension =>
    cases predecessor <;> cases term <;> cases first <;> cases contraction
    · exact sourceDecisionChunk0 _ _ _ _
    · exact sourceDecisionChunk1 _ _ _ _
    · exact sourceDecisionChunk2 _ _ _ _
    · exact sourceDecisionChunk3 _ _ _ _
    · exact sourceDecisionChunk4 _ _ _ _
    · exact sourceDecisionChunk5 _ _ _ _
    · exact sourceDecisionChunk6 _ _ _ _
    · exact sourceDecisionChunk7 _ _ _ _
    · exact sourceDecisionChunk8 _ _ _ _
    · exact sourceDecisionChunk9 _ _ _ _
    · exact sourceDecisionChunk10 _ _ _ _
    · exact sourceDecisionChunk11 _ _ _ _
    · exact sourceDecisionChunk12 _ _ _ _
    · exact sourceDecisionChunk13 _ _ _ _
    · exact sourceDecisionChunk14 _ _ _ _
    · exact sourceDecisionChunk15 _ _ _ _

theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor term first contraction envelope boundary tolerance extension =>
    cases predecessor <;> cases term <;> cases first <;> cases contraction
    · exact uniqueCriteriaChunk0 _ _ _ _
    · exact uniqueCriteriaChunk1 _ _ _ _
    · exact uniqueCriteriaChunk2 _ _ _ _
    · exact uniqueCriteriaChunk3 _ _ _ _
    · exact uniqueCriteriaChunk4 _ _ _ _
    · exact uniqueCriteriaChunk5 _ _ _ _
    · exact uniqueCriteriaChunk6 _ _ _ _
    · exact uniqueCriteriaChunk7 _ _ _ _
    · exact uniqueCriteriaChunk8 _ _ _ _
    · exact uniqueCriteriaChunk9 _ _ _ _
    · exact uniqueCriteriaChunk10 _ _ _ _
    · exact uniqueCriteriaChunk11 _ _ _ _
    · exact uniqueCriteriaChunk12 _ _ _ _
    · exact uniqueCriteriaChunk13 _ _ _ _
    · exact uniqueCriteriaChunk14 _ _ _ _
    · exact uniqueCriteriaChunk15 _ _ _ _

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.term = .admitted ∧ c.first = .admitted ∧ c.contraction = .admitted ∧ c.envelope = .admitted ∧ c.boundary = .admitted ∧ c.tolerance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor term first contraction envelope boundary tolerance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
    rw [h] at field
    cases field

theorem term_rejected_rejected (c : Candidate) (h : c.term = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.term eq
    rw [h] at field
    cases field

theorem first_rejected_rejected (c : Candidate) (h : c.first = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.first eq
    rw [h] at field
    cases field

theorem contraction_rejected_rejected (c : Candidate) (h : c.contraction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.contraction eq
    rw [h] at field
    cases field

theorem envelope_rejected0_rejected (c : Candidate) (h : c.envelope = .rejected0) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.envelope eq
    rw [h] at field
    cases field

theorem envelope_rejected2_rejected (c : Candidate) (h : c.envelope = .rejected2) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.envelope eq
    rw [h] at field
    cases field

theorem envelope_rejected3_rejected (c : Candidate) (h : c.envelope = .rejected3) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.envelope eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

theorem tolerance_rejected_rejected (c : Candidate) (h : c.tolerance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.tolerance eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.AccumulatedSeparationGrammar
