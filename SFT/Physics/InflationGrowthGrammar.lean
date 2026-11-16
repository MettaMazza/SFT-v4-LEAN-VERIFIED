import SFT.Physics.InflationGrowthCensus0
import SFT.Physics.InflationGrowthCensus1
import SFT.Physics.InflationGrowthCensus2
import SFT.Physics.InflationGrowthCensus3
import SFT.Physics.InflationGrowthCensus4
import SFT.Physics.InflationGrowthCensus5
import SFT.Physics.InflationGrowthCensus6
import SFT.Physics.InflationGrowthCensus7
import SFT.Physics.InflationGrowthCensus8
import SFT.Physics.InflationGrowthCensus9
import SFT.Physics.InflationGrowthCensus10
import SFT.Physics.InflationGrowthCensus11
import SFT.Physics.InflationGrowthCensus12
import SFT.Physics.InflationGrowthCensus13
import SFT.Physics.InflationGrowthCensus14
import SFT.Physics.InflationGrowthCensus15
namespace SFT.Physics.InflationGrowthGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk volume cover duration scalar tensor exit growth transfer =>
    cases volume <;> cases cover <;> cases duration <;> cases scalar
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
  | mk volume cover duration scalar tensor exit growth transfer =>
    cases volume <;> cases cover <;> cases duration <;> cases scalar
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
  c.volume = .admitted ∧ c.cover = .admitted ∧ c.duration = .admitted ∧ c.scalar = .admitted ∧ c.tensor = .admitted ∧ c.exit = .admitted ∧ c.growth = .admitted ∧ c.transfer = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk volume cover duration scalar tensor exit growth transfer =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem volume_rejected_rejected (c : Candidate) (h : c.volume = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.volume eq
    rw [h] at field
    cases field

theorem cover_rejected_rejected (c : Candidate) (h : c.cover = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cover eq
    rw [h] at field
    cases field

theorem duration_rejected_rejected (c : Candidate) (h : c.duration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.duration eq
    rw [h] at field
    cases field

theorem scalar_rejected_rejected (c : Candidate) (h : c.scalar = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scalar eq
    rw [h] at field
    cases field

theorem tensor_rejected_rejected (c : Candidate) (h : c.tensor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.tensor eq
    rw [h] at field
    cases field

theorem exit_rejected_rejected (c : Candidate) (h : c.exit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.exit eq
    rw [h] at field
    cases field

theorem growth_rejected_rejected (c : Candidate) (h : c.growth = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.growth eq
    rw [h] at field
    cases field

theorem transfer_rejected_rejected (c : Candidate) (h : c.transfer = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transfer eq
    rw [h] at field
    cases field

end SFT.Physics.InflationGrowthGrammar
