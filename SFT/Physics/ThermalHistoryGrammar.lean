import SFT.Physics.ThermalHistoryCensus0
import SFT.Physics.ThermalHistoryCensus1
import SFT.Physics.ThermalHistoryCensus2
import SFT.Physics.ThermalHistoryCensus3
import SFT.Physics.ThermalHistoryCensus4
import SFT.Physics.ThermalHistoryCensus5
import SFT.Physics.ThermalHistoryCensus6
import SFT.Physics.ThermalHistoryCensus7
import SFT.Physics.ThermalHistoryCensus8
import SFT.Physics.ThermalHistoryCensus9
import SFT.Physics.ThermalHistoryCensus10
import SFT.Physics.ThermalHistoryCensus11
import SFT.Physics.ThermalHistoryCensus12
import SFT.Physics.ThermalHistoryCensus13
import SFT.Physics.ThermalHistoryCensus14
import SFT.Physics.ThermalHistoryCensus15
namespace SFT.Physics.ThermalHistoryGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk provenance temperature threshold freezeout decay capture recombination acoustic =>
    cases provenance <;> cases temperature <;> cases threshold <;> cases freezeout
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
  | mk provenance temperature threshold freezeout decay capture recombination acoustic =>
    cases provenance <;> cases temperature <;> cases threshold <;> cases freezeout
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
  c.provenance = .admitted ∧ c.temperature = .admitted ∧ c.threshold = .admitted ∧ c.freezeout = .admitted ∧ c.decay = .admitted ∧ c.capture = .admitted ∧ c.recombination = .admitted ∧ c.acoustic = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk provenance temperature threshold freezeout decay capture recombination acoustic =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem temperature_rejected_rejected (c : Candidate) (h : c.temperature = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.temperature eq
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

theorem freezeout_rejected_rejected (c : Candidate) (h : c.freezeout = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.freezeout eq
    rw [h] at field
    cases field

theorem decay_rejected_rejected (c : Candidate) (h : c.decay = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.decay eq
    rw [h] at field
    cases field

theorem capture_rejected_rejected (c : Candidate) (h : c.capture = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.capture eq
    rw [h] at field
    cases field

theorem recombination_rejected_rejected (c : Candidate) (h : c.recombination = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recombination eq
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

end SFT.Physics.ThermalHistoryGrammar
