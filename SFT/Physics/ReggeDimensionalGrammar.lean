import SFT.Physics.ReggeDimensionalCensus0
import SFT.Physics.ReggeDimensionalCensus1
import SFT.Physics.ReggeDimensionalCensus2
import SFT.Physics.ReggeDimensionalCensus3
import SFT.Physics.ReggeDimensionalCensus4
import SFT.Physics.ReggeDimensionalCensus5
import SFT.Physics.ReggeDimensionalCensus6
import SFT.Physics.ReggeDimensionalCensus7
import SFT.Physics.ReggeDimensionalCensus8
import SFT.Physics.ReggeDimensionalCensus9
import SFT.Physics.ReggeDimensionalCensus10
import SFT.Physics.ReggeDimensionalCensus11
import SFT.Physics.ReggeDimensionalCensus12
import SFT.Physics.ReggeDimensionalCensus13
import SFT.Physics.ReggeDimensionalCensus14
import SFT.Physics.ReggeDimensionalCensus15
namespace SFT.Physics.ReggeDimensionalGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor motion hands successor base closure units target extension =>
    cases predecessor <;> cases motion <;> cases hands <;> cases successor
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
  | mk predecessor motion hands successor base closure units target extension =>
    cases predecessor <;> cases motion <;> cases hands <;> cases successor
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
  c.predecessor = .admitted ∧ c.motion = .admitted ∧ c.hands = .admitted ∧ c.successor = .admitted ∧ c.base = .admitted ∧ c.closure = .admitted ∧ c.units = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor motion hands successor base closure units target extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
    rw [h] at field
    cases field

theorem motion_rejected_rejected (c : Candidate) (h : c.motion = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.motion eq
    rw [h] at field
    cases field

theorem hands_rejected_rejected (c : Candidate) (h : c.hands = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.hands eq
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

theorem base_rejected_rejected (c : Candidate) (h : c.base = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.base eq
    rw [h] at field
    cases field

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
    rw [h] at field
    cases field

theorem units_rejected_rejected (c : Candidate) (h : c.units = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.units eq
    rw [h] at field
    cases field

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
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

end SFT.Physics.ReggeDimensionalGrammar
