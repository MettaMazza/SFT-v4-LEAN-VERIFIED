import SFT.Physics.FoldUniverseTransportCensus0
import SFT.Physics.FoldUniverseTransportCensus1
import SFT.Physics.FoldUniverseTransportCensus2
import SFT.Physics.FoldUniverseTransportCensus3
import SFT.Physics.FoldUniverseTransportCensus4
import SFT.Physics.FoldUniverseTransportCensus5
import SFT.Physics.FoldUniverseTransportCensus6
import SFT.Physics.FoldUniverseTransportCensus7
import SFT.Physics.FoldUniverseTransportCensus8
import SFT.Physics.FoldUniverseTransportCensus9
import SFT.Physics.FoldUniverseTransportCensus10
import SFT.Physics.FoldUniverseTransportCensus11
import SFT.Physics.FoldUniverseTransportCensus12
import SFT.Physics.FoldUniverseTransportCensus13
import SFT.Physics.FoldUniverseTransportCensus14
import SFT.Physics.FoldUniverseTransportCensus15
namespace SFT.Physics.FoldUniverseTransportGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk orbit dynamics topology mapping period correlation signal travel physical extension =>
    cases orbit <;> cases dynamics <;> cases topology <;> cases mapping
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
  | mk orbit dynamics topology mapping period correlation signal travel physical extension =>
    cases orbit <;> cases dynamics <;> cases topology <;> cases mapping
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
  c.orbit = .admitted ∧ c.dynamics = .admitted ∧ c.topology = .admitted ∧ c.mapping = .admitted ∧ c.period = .admitted ∧ c.correlation = .admitted ∧ c.signal = .admitted ∧ c.travel = .admitted ∧ c.physical = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk orbit dynamics topology mapping period correlation signal travel physical extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem orbit_rejected_rejected (c : Candidate) (h : c.orbit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orbit eq
    rw [h] at field
    cases field

theorem dynamics_rejected_rejected (c : Candidate) (h : c.dynamics = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dynamics eq
    rw [h] at field
    cases field

theorem topology_rejected_rejected (c : Candidate) (h : c.topology = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.topology eq
    rw [h] at field
    cases field

theorem mapping_rejected_rejected (c : Candidate) (h : c.mapping = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mapping eq
    rw [h] at field
    cases field

theorem period_rejected_rejected (c : Candidate) (h : c.period = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.period eq
    rw [h] at field
    cases field

theorem correlation_rejected_rejected (c : Candidate) (h : c.correlation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.correlation eq
    rw [h] at field
    cases field

theorem signal_rejected_rejected (c : Candidate) (h : c.signal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.signal eq
    rw [h] at field
    cases field

theorem travel_rejected_rejected (c : Candidate) (h : c.travel = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.travel eq
    rw [h] at field
    cases field

theorem physical_rejected_rejected (c : Candidate) (h : c.physical = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.physical eq
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

end SFT.Physics.FoldUniverseTransportGrammar
