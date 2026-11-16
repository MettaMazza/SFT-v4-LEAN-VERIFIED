import SFT.Physics.ThermalEquilibriumResponseCensus0
import SFT.Physics.ThermalEquilibriumResponseCensus1
import SFT.Physics.ThermalEquilibriumResponseCensus2
import SFT.Physics.ThermalEquilibriumResponseCensus3
import SFT.Physics.ThermalEquilibriumResponseCensus4
import SFT.Physics.ThermalEquilibriumResponseCensus5
import SFT.Physics.ThermalEquilibriumResponseCensus6
import SFT.Physics.ThermalEquilibriumResponseCensus7
import SFT.Physics.ThermalEquilibriumResponseCensus8
import SFT.Physics.ThermalEquilibriumResponseCensus9
import SFT.Physics.ThermalEquilibriumResponseCensus10
import SFT.Physics.ThermalEquilibriumResponseCensus11
import SFT.Physics.ThermalEquilibriumResponseCensus12
import SFT.Physics.ThermalEquilibriumResponseCensus13
import SFT.Physics.ThermalEquilibriumResponseCensus14
import SFT.Physics.ThermalEquilibriumResponseCensus15
namespace SFT.Physics.ThermalEquilibriumResponseGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk temperature total equilibrium canonical maximum fluctuation response noise =>
    cases temperature <;> cases total <;> cases equilibrium <;> cases canonical
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
  | mk temperature total equilibrium canonical maximum fluctuation response noise =>
    cases temperature <;> cases total <;> cases equilibrium <;> cases canonical
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
  c.temperature = .admitted ∧ c.total = .admitted ∧ c.equilibrium = .admitted ∧ c.canonical = .admitted ∧ c.maximum = .admitted ∧ c.fluctuation = .admitted ∧ c.response = .admitted ∧ c.noise = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk temperature total equilibrium canonical maximum fluctuation response noise =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem temperature_rejected_rejected (c : Candidate) (h : c.temperature = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.temperature eq
    rw [h] at field
    cases field

theorem total_rejected_rejected (c : Candidate) (h : c.total = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.total eq
    rw [h] at field
    cases field

theorem equilibrium_rejected_rejected (c : Candidate) (h : c.equilibrium = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equilibrium eq
    rw [h] at field
    cases field

theorem canonical_rejected_rejected (c : Candidate) (h : c.canonical = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.canonical eq
    rw [h] at field
    cases field

theorem maximum_rejected_rejected (c : Candidate) (h : c.maximum = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.maximum eq
    rw [h] at field
    cases field

theorem fluctuation_rejected_rejected (c : Candidate) (h : c.fluctuation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fluctuation eq
    rw [h] at field
    cases field

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
    rw [h] at field
    cases field

theorem noise_rejected_rejected (c : Candidate) (h : c.noise = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.noise eq
    rw [h] at field
    cases field

end SFT.Physics.ThermalEquilibriumResponseGrammar
