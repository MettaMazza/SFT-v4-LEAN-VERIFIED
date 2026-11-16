import SFT.Physics.SmithionCensus0
import SFT.Physics.SmithionCensus1
import SFT.Physics.SmithionCensus2
import SFT.Physics.SmithionCensus3
import SFT.Physics.SmithionCensus4
import SFT.Physics.SmithionCensus5
import SFT.Physics.SmithionCensus6
import SFT.Physics.SmithionCensus7
import SFT.Physics.SmithionCensus8
import SFT.Physics.SmithionCensus9
import SFT.Physics.SmithionCensus10
import SFT.Physics.SmithionCensus11
import SFT.Physics.SmithionCensus12
import SFT.Physics.SmithionCensus13
import SFT.Physics.SmithionCensus14
import SFT.Physics.SmithionCensus15
namespace SFT.Physics.SmithionGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk sector kind depth invariant roots ratios relic abundance flavour measurement extension =>
    cases sector <;> cases kind <;> cases depth <;> cases invariant
    · exact sourceDecisionChunk0 _ _ _ _ _ _ _
    · exact sourceDecisionChunk1 _ _ _ _ _ _ _
    · exact sourceDecisionChunk2 _ _ _ _ _ _ _
    · exact sourceDecisionChunk3 _ _ _ _ _ _ _
    · exact sourceDecisionChunk4 _ _ _ _ _ _ _
    · exact sourceDecisionChunk5 _ _ _ _ _ _ _
    · exact sourceDecisionChunk6 _ _ _ _ _ _ _
    · exact sourceDecisionChunk7 _ _ _ _ _ _ _
    · exact sourceDecisionChunk8 _ _ _ _ _ _ _
    · exact sourceDecisionChunk9 _ _ _ _ _ _ _
    · exact sourceDecisionChunk10 _ _ _ _ _ _ _
    · exact sourceDecisionChunk11 _ _ _ _ _ _ _
    · exact sourceDecisionChunk12 _ _ _ _ _ _ _
    · exact sourceDecisionChunk13 _ _ _ _ _ _ _
    · exact sourceDecisionChunk14 _ _ _ _ _ _ _
    · exact sourceDecisionChunk15 _ _ _ _ _ _ _
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk sector kind depth invariant roots ratios relic abundance flavour measurement extension =>
    cases sector <;> cases kind <;> cases depth <;> cases invariant
    · exact uniqueCriteriaChunk0 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk1 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk2 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk3 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk4 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk5 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk6 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk7 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk8 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk9 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk10 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk11 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk12 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk13 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk14 _ _ _ _ _ _ _
    · exact uniqueCriteriaChunk15 _ _ _ _ _ _ _
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.sector = .admitted ∧ c.kind = .admitted ∧ c.depth = .admitted ∧ c.invariant = .admitted ∧ c.roots = .admitted ∧ c.ratios = .admitted ∧ c.relic = .admitted ∧ c.abundance = .admitted ∧ c.flavour = .admitted ∧ c.measurement = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk sector kind depth invariant roots ratios relic abundance flavour measurement extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem sector_rejected_rejected (c : Candidate) (h : c.sector = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sector eq
    rw [h] at field
    cases field

theorem kind_rejected_rejected (c : Candidate) (h : c.kind = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.kind eq
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

theorem invariant_rejected_rejected (c : Candidate) (h : c.invariant = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.invariant eq
    rw [h] at field
    cases field

theorem roots_rejected_rejected (c : Candidate) (h : c.roots = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.roots eq
    rw [h] at field
    cases field

theorem ratios_rejected_rejected (c : Candidate) (h : c.ratios = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ratios eq
    rw [h] at field
    cases field

theorem relic_rejected_rejected (c : Candidate) (h : c.relic = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relic eq
    rw [h] at field
    cases field

theorem abundance_rejected_rejected (c : Candidate) (h : c.abundance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.abundance eq
    rw [h] at field
    cases field

theorem flavour_rejected_rejected (c : Candidate) (h : c.flavour = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.flavour eq
    rw [h] at field
    cases field

theorem measurement_rejected_rejected (c : Candidate) (h : c.measurement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measurement eq
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

end SFT.Physics.SmithionGrammar
