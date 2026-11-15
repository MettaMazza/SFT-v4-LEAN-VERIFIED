import SFT.Physics.MediatorRangeChannelCensus0
import SFT.Physics.MediatorRangeChannelCensus1
import SFT.Physics.MediatorRangeChannelCensus2
import SFT.Physics.MediatorRangeChannelCensus3
import SFT.Physics.MediatorRangeChannelCensus4
import SFT.Physics.MediatorRangeChannelCensus5
import SFT.Physics.MediatorRangeChannelCensus6
import SFT.Physics.MediatorRangeChannelCensus7
import SFT.Physics.MediatorRangeChannelCensus8
import SFT.Physics.MediatorRangeChannelCensus9
import SFT.Physics.MediatorRangeChannelCensus10
import SFT.Physics.MediatorRangeChannelCensus11
import SFT.Physics.MediatorRangeChannelCensus12
import SFT.Physics.MediatorRangeChannelCensus13
import SFT.Physics.MediatorRangeChannelCensus14
import SFT.Physics.MediatorRangeChannelCensus15
namespace SFT.Physics.MediatorRangeChannelGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier channel mass transfer conservation range ordering massless comparison extension =>
    cases carrier <;> cases channel <;> cases mass <;> cases transfer
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
  | mk carrier channel mass transfer conservation range ordering massless comparison extension =>
    cases carrier <;> cases channel <;> cases mass <;> cases transfer
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
  c.carrier = .admitted ∧ c.channel = .admitted ∧ c.mass = .admitted ∧ c.transfer = .admitted ∧ c.conservation = .admitted ∧ c.range = .admitted ∧ c.ordering = .admitted ∧ c.massless = .admitted ∧ c.comparison = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier channel mass transfer conservation range ordering massless comparison extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem channel_rejected_rejected (c : Candidate) (h : c.channel = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.channel eq
    rw [h] at field
    cases field

theorem mass_rejected_rejected (c : Candidate) (h : c.mass = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mass eq
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

theorem conservation_rejected_rejected (c : Candidate) (h : c.conservation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conservation eq
    rw [h] at field
    cases field

theorem range_rejected_rejected (c : Candidate) (h : c.range = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.range eq
    rw [h] at field
    cases field

theorem ordering_rejected_rejected (c : Candidate) (h : c.ordering = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ordering eq
    rw [h] at field
    cases field

theorem massless_rejected_rejected (c : Candidate) (h : c.massless = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.massless eq
    rw [h] at field
    cases field

theorem comparison_rejected_rejected (c : Candidate) (h : c.comparison = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparison eq
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

end SFT.Physics.MediatorRangeChannelGrammar
