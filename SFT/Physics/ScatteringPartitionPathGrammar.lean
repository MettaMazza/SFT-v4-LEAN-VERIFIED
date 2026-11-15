import SFT.Physics.ScatteringPartitionPathCensus0
import SFT.Physics.ScatteringPartitionPathCensus1
import SFT.Physics.ScatteringPartitionPathCensus2
import SFT.Physics.ScatteringPartitionPathCensus3
import SFT.Physics.ScatteringPartitionPathCensus4
import SFT.Physics.ScatteringPartitionPathCensus5
import SFT.Physics.ScatteringPartitionPathCensus6
import SFT.Physics.ScatteringPartitionPathCensus7
import SFT.Physics.ScatteringPartitionPathCensus8
import SFT.Physics.ScatteringPartitionPathCensus9
import SFT.Physics.ScatteringPartitionPathCensus10
import SFT.Physics.ScatteringPartitionPathCensus11
import SFT.Physics.ScatteringPartitionPathCensus12
import SFT.Physics.ScatteringPartitionPathCensus13
import SFT.Physics.ScatteringPartitionPathCensus14
import SFT.Physics.ScatteringPartitionPathCensus15
namespace SFT.Physics.ScatteringPartitionPathGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk geometry outcomes exclusivity measure «section» density path cause extension =>
    cases geometry <;> cases outcomes <;> cases exclusivity <;> cases measure
    · exact sourceDecisionChunk0 _ _ _ _ _
    · exact sourceDecisionChunk1 _ _ _ _ _
    · exact sourceDecisionChunk2 _ _ _ _ _
    · exact sourceDecisionChunk3 _ _ _ _ _
    · exact sourceDecisionChunk4 _ _ _ _ _
    · exact sourceDecisionChunk5 _ _ _ _ _
    · exact sourceDecisionChunk6 _ _ _ _ _
    · exact sourceDecisionChunk7 _ _ _ _ _
    · exact sourceDecisionChunk8 _ _ _ _ _
    · exact sourceDecisionChunk9 _ _ _ _ _
    · exact sourceDecisionChunk10 _ _ _ _ _
    · exact sourceDecisionChunk11 _ _ _ _ _
    · exact sourceDecisionChunk12 _ _ _ _ _
    · exact sourceDecisionChunk13 _ _ _ _ _
    · exact sourceDecisionChunk14 _ _ _ _ _
    · exact sourceDecisionChunk15 _ _ _ _ _

theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk geometry outcomes exclusivity measure «section» density path cause extension =>
    cases geometry <;> cases outcomes <;> cases exclusivity <;> cases measure
    · exact uniqueCriteriaChunk0 _ _ _ _ _
    · exact uniqueCriteriaChunk1 _ _ _ _ _
    · exact uniqueCriteriaChunk2 _ _ _ _ _
    · exact uniqueCriteriaChunk3 _ _ _ _ _
    · exact uniqueCriteriaChunk4 _ _ _ _ _
    · exact uniqueCriteriaChunk5 _ _ _ _ _
    · exact uniqueCriteriaChunk6 _ _ _ _ _
    · exact uniqueCriteriaChunk7 _ _ _ _ _
    · exact uniqueCriteriaChunk8 _ _ _ _ _
    · exact uniqueCriteriaChunk9 _ _ _ _ _
    · exact uniqueCriteriaChunk10 _ _ _ _ _
    · exact uniqueCriteriaChunk11 _ _ _ _ _
    · exact uniqueCriteriaChunk12 _ _ _ _ _
    · exact uniqueCriteriaChunk13 _ _ _ _ _
    · exact uniqueCriteriaChunk14 _ _ _ _ _
    · exact uniqueCriteriaChunk15 _ _ _ _ _

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.geometry = .admitted ∧ c.outcomes = .admitted ∧ c.exclusivity = .admitted ∧ c.measure = .admitted ∧ c.«section» = .admitted ∧ c.density = .admitted ∧ c.path = .admitted ∧ c.cause = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk geometry outcomes exclusivity measure «section» density path cause extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem geometry_rejected_rejected (c : Candidate) (h : c.geometry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.geometry eq
    rw [h] at field
    cases field

theorem outcomes_rejected_rejected (c : Candidate) (h : c.outcomes = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.outcomes eq
    rw [h] at field
    cases field

theorem exclusivity_rejected_rejected (c : Candidate) (h : c.exclusivity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.exclusivity eq
    rw [h] at field
    cases field

theorem measure_rejected_rejected (c : Candidate) (h : c.measure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measure eq
    rw [h] at field
    cases field

theorem section_rejected_rejected (c : Candidate) (h : c.«section» = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.«section» eq
    rw [h] at field
    cases field

theorem density_rejected_rejected (c : Candidate) (h : c.density = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.density eq
    rw [h] at field
    cases field

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
    rw [h] at field
    cases field

theorem cause_rejected_rejected (c : Candidate) (h : c.cause = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cause eq
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

end SFT.Physics.ScatteringPartitionPathGrammar
