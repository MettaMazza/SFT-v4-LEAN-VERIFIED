import SFT.Physics.YangMillsSingletGapCensus0
import SFT.Physics.YangMillsSingletGapCensus1
import SFT.Physics.YangMillsSingletGapCensus2
import SFT.Physics.YangMillsSingletGapCensus3
import SFT.Physics.YangMillsSingletGapCensus4
import SFT.Physics.YangMillsSingletGapCensus5
import SFT.Physics.YangMillsSingletGapCensus6
import SFT.Physics.YangMillsSingletGapCensus7
import SFT.Physics.YangMillsSingletGapCensus8
import SFT.Physics.YangMillsSingletGapCensus9
import SFT.Physics.YangMillsSingletGapCensus10
import SFT.Physics.YangMillsSingletGapCensus11
import SFT.Physics.YangMillsSingletGapCensus12
import SFT.Physics.YangMillsSingletGapCensus13
import SFT.Physics.YangMillsSingletGapCensus14
import SFT.Physics.YangMillsSingletGapCensus15
namespace SFT.Physics.YangMillsSingletGapGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk sector support vacuum gap confinement carrier orbit depth prior extension =>
    cases sector <;> cases support <;> cases vacuum <;> cases gap
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
  | mk sector support vacuum gap confinement carrier orbit depth prior extension =>
    cases sector <;> cases support <;> cases vacuum <;> cases gap
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
  c.sector = .admitted ∧ c.support = .admitted ∧ c.vacuum = .admitted ∧ c.gap = .admitted ∧ c.confinement = .admitted ∧ c.carrier = .admitted ∧ c.orbit = .admitted ∧ c.depth = .admitted ∧ c.prior = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk sector support vacuum gap confinement carrier orbit depth prior extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem sector_rejected_rejected (c : Candidate) (h : c.sector = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sector eq
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

theorem vacuum_rejected_rejected (c : Candidate) (h : c.vacuum = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.vacuum eq
    rw [h] at field
    cases field

theorem gap_rejected_rejected (c : Candidate) (h : c.gap = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.gap eq
    rw [h] at field
    cases field

theorem confinement_rejected_rejected (c : Candidate) (h : c.confinement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.confinement eq
    rw [h] at field
    cases field

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem orbit_rejected_rejected (c : Candidate) (h : c.orbit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orbit eq
    rw [h] at field
    cases field

theorem depth_rejected_rejected (c : Candidate) (h : c.depth = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.depth eq
    rw [h] at field
    cases field

theorem prior_rejected_rejected (c : Candidate) (h : c.prior = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prior eq
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

end SFT.Physics.YangMillsSingletGapGrammar
