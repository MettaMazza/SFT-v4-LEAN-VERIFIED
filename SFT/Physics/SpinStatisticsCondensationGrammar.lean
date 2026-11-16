import SFT.Physics.SpinStatisticsCondensationCensus0
import SFT.Physics.SpinStatisticsCondensationCensus1
import SFT.Physics.SpinStatisticsCondensationCensus2
import SFT.Physics.SpinStatisticsCondensationCensus3
import SFT.Physics.SpinStatisticsCondensationCensus4
import SFT.Physics.SpinStatisticsCondensationCensus5
import SFT.Physics.SpinStatisticsCondensationCensus6
import SFT.Physics.SpinStatisticsCondensationCensus7
import SFT.Physics.SpinStatisticsCondensationCensus8
import SFT.Physics.SpinStatisticsCondensationCensus9
import SFT.Physics.SpinStatisticsCondensationCensus10
import SFT.Physics.SpinStatisticsCondensationCensus11
import SFT.Physics.SpinStatisticsCondensationCensus12
import SFT.Physics.SpinStatisticsCondensationCensus13
import SFT.Physics.SpinStatisticsCondensationCensus14
import SFT.Physics.SpinStatisticsCondensationCensus15
namespace SFT.Physics.SpinStatisticsCondensationGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk exchange fermion boson weights spin pairing lock ground =>
    cases exchange <;> cases fermion <;> cases boson <;> cases weights
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
  | mk exchange fermion boson weights spin pairing lock ground =>
    cases exchange <;> cases fermion <;> cases boson <;> cases weights
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
  c.exchange = .admitted ∧ c.fermion = .admitted ∧ c.boson = .admitted ∧ c.weights = .admitted ∧ c.spin = .admitted ∧ c.pairing = .admitted ∧ c.lock = .admitted ∧ c.ground = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk exchange fermion boson weights spin pairing lock ground =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem exchange_rejected_rejected (c : Candidate) (h : c.exchange = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.exchange eq
    rw [h] at field
    cases field

theorem fermion_rejected_rejected (c : Candidate) (h : c.fermion = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fermion eq
    rw [h] at field
    cases field

theorem boson_rejected_rejected (c : Candidate) (h : c.boson = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boson eq
    rw [h] at field
    cases field

theorem weights_rejected_rejected (c : Candidate) (h : c.weights = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.weights eq
    rw [h] at field
    cases field

theorem spin_rejected_rejected (c : Candidate) (h : c.spin = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.spin eq
    rw [h] at field
    cases field

theorem pairing_rejected_rejected (c : Candidate) (h : c.pairing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pairing eq
    rw [h] at field
    cases field

theorem lock_rejected_rejected (c : Candidate) (h : c.lock = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.lock eq
    rw [h] at field
    cases field

theorem ground_rejected_rejected (c : Candidate) (h : c.ground = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ground eq
    rw [h] at field
    cases field

end SFT.Physics.SpinStatisticsCondensationGrammar
