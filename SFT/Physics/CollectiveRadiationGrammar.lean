import SFT.Physics.CollectiveRadiationCensus0
import SFT.Physics.CollectiveRadiationCensus1
import SFT.Physics.CollectiveRadiationCensus2
import SFT.Physics.CollectiveRadiationCensus3
import SFT.Physics.CollectiveRadiationCensus4
import SFT.Physics.CollectiveRadiationCensus5
import SFT.Physics.CollectiveRadiationCensus6
import SFT.Physics.CollectiveRadiationCensus7
import SFT.Physics.CollectiveRadiationCensus8
import SFT.Physics.CollectiveRadiationCensus9
import SFT.Physics.CollectiveRadiationCensus10
import SFT.Physics.CollectiveRadiationCensus11
import SFT.Physics.CollectiveRadiationCensus12
import SFT.Physics.CollectiveRadiationCensus13
import SFT.Physics.CollectiveRadiationCensus14
import SFT.Physics.CollectiveRadiationCensus15
namespace SFT.Physics.CollectiveRadiationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk occupation radiation acoustic stimulated threshold linewidth plasma magnetofluid =>
    cases occupation <;> cases radiation <;> cases acoustic <;> cases stimulated
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
  | mk occupation radiation acoustic stimulated threshold linewidth plasma magnetofluid =>
    cases occupation <;> cases radiation <;> cases acoustic <;> cases stimulated
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
  c.occupation = .admitted ∧ c.radiation = .admitted ∧ c.acoustic = .admitted ∧ c.stimulated = .admitted ∧ c.threshold = .admitted ∧ c.linewidth = .admitted ∧ c.plasma = .admitted ∧ c.magnetofluid = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk occupation radiation acoustic stimulated threshold linewidth plasma magnetofluid =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem occupation_rejected_rejected (c : Candidate) (h : c.occupation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.occupation eq
    rw [h] at field
    cases field

theorem radiation_rejected_rejected (c : Candidate) (h : c.radiation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.radiation eq
    rw [h] at field
    cases field

theorem acoustic_rejected_rejected (c : Candidate) (h : c.acoustic = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.acoustic eq
    rw [h] at field
    cases field

theorem stimulated_rejected_rejected (c : Candidate) (h : c.stimulated = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.stimulated eq
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

theorem linewidth_rejected_rejected (c : Candidate) (h : c.linewidth = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.linewidth eq
    rw [h] at field
    cases field

theorem plasma_rejected_rejected (c : Candidate) (h : c.plasma = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.plasma eq
    rw [h] at field
    cases field

theorem magnetofluid_rejected_rejected (c : Candidate) (h : c.magnetofluid = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.magnetofluid eq
    rw [h] at field
    cases field

end SFT.Physics.CollectiveRadiationGrammar
