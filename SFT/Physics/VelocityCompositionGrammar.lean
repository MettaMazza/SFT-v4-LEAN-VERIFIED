import SFT.Physics.VelocityCompositionCensus0
import SFT.Physics.VelocityCompositionCensus1
import SFT.Physics.VelocityCompositionCensus2
import SFT.Physics.VelocityCompositionCensus3
import SFT.Physics.VelocityCompositionCensus4
import SFT.Physics.VelocityCompositionCensus5
import SFT.Physics.VelocityCompositionCensus6
import SFT.Physics.VelocityCompositionCensus7
import SFT.Physics.VelocityCompositionCensus8
import SFT.Physics.VelocityCompositionCensus9
import SFT.Physics.VelocityCompositionCensus10
import SFT.Physics.VelocityCompositionCensus11
import SFT.Physics.VelocityCompositionCensus12
import SFT.Physics.VelocityCompositionCensus13
import SFT.Physics.VelocityCompositionCensus14
import SFT.Physics.VelocityCompositionCensus15
import SFT.Physics.VelocityCompositionCensus16
import SFT.Physics.VelocityCompositionCensus17
import SFT.Physics.VelocityCompositionCensus18
import SFT.Physics.VelocityCompositionCensus19
import SFT.Physics.VelocityCompositionCensus20
import SFT.Physics.VelocityCompositionCensus21
import SFT.Physics.VelocityCompositionCensus22
import SFT.Physics.VelocityCompositionCensus23
import SFT.Physics.VelocityCompositionCensus24
import SFT.Physics.VelocityCompositionCensus25
import SFT.Physics.VelocityCompositionCensus26
import SFT.Physics.VelocityCompositionCensus27
import SFT.Physics.VelocityCompositionCensus28
import SFT.Physics.VelocityCompositionCensus29
import SFT.Physics.VelocityCompositionCensus30
import SFT.Physics.VelocityCompositionCensus31
namespace SFT.Physics.VelocityCompositionGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk domain rest representation numerator denominator limit closure associativity record measurement extension =>
    cases domain <;> cases rest <;> cases representation <;> cases numerator <;> cases denominator
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
    · exact sourceDecisionChunk16 _ _ _ _ _ _
    · exact sourceDecisionChunk17 _ _ _ _ _ _
    · exact sourceDecisionChunk18 _ _ _ _ _ _
    · exact sourceDecisionChunk19 _ _ _ _ _ _
    · exact sourceDecisionChunk20 _ _ _ _ _ _
    · exact sourceDecisionChunk21 _ _ _ _ _ _
    · exact sourceDecisionChunk22 _ _ _ _ _ _
    · exact sourceDecisionChunk23 _ _ _ _ _ _
    · exact sourceDecisionChunk24 _ _ _ _ _ _
    · exact sourceDecisionChunk25 _ _ _ _ _ _
    · exact sourceDecisionChunk26 _ _ _ _ _ _
    · exact sourceDecisionChunk27 _ _ _ _ _ _
    · exact sourceDecisionChunk28 _ _ _ _ _ _
    · exact sourceDecisionChunk29 _ _ _ _ _ _
    · exact sourceDecisionChunk30 _ _ _ _ _ _
    · exact sourceDecisionChunk31 _ _ _ _ _ _

theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk domain rest representation numerator denominator limit closure associativity record measurement extension =>
    cases domain <;> cases rest <;> cases representation <;> cases numerator <;> cases denominator
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
    · exact uniqueCriteriaChunk16 _ _ _ _ _ _
    · exact uniqueCriteriaChunk17 _ _ _ _ _ _
    · exact uniqueCriteriaChunk18 _ _ _ _ _ _
    · exact uniqueCriteriaChunk19 _ _ _ _ _ _
    · exact uniqueCriteriaChunk20 _ _ _ _ _ _
    · exact uniqueCriteriaChunk21 _ _ _ _ _ _
    · exact uniqueCriteriaChunk22 _ _ _ _ _ _
    · exact uniqueCriteriaChunk23 _ _ _ _ _ _
    · exact uniqueCriteriaChunk24 _ _ _ _ _ _
    · exact uniqueCriteriaChunk25 _ _ _ _ _ _
    · exact uniqueCriteriaChunk26 _ _ _ _ _ _
    · exact uniqueCriteriaChunk27 _ _ _ _ _ _
    · exact uniqueCriteriaChunk28 _ _ _ _ _ _
    · exact uniqueCriteriaChunk29 _ _ _ _ _ _
    · exact uniqueCriteriaChunk30 _ _ _ _ _ _
    · exact uniqueCriteriaChunk31 _ _ _ _ _ _

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.domain = .admitted ∧ c.rest = .admitted ∧ c.representation = .admitted ∧ c.numerator = .admitted ∧ c.denominator = .admitted ∧ c.limit = .admitted ∧ c.closure = .admitted ∧ c.associativity = .admitted ∧ c.record = .admitted ∧ c.measurement = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk domain rest representation numerator denominator limit closure associativity record measurement extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem domain_rejected_rejected (c : Candidate) (h : c.domain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
    rw [h] at field
    cases field

theorem rest_rejected_rejected (c : Candidate) (h : c.rest = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rest eq
    rw [h] at field
    cases field

theorem representation_rejected_rejected (c : Candidate) (h : c.representation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.representation eq
    rw [h] at field
    cases field

theorem numerator_rejected_rejected (c : Candidate) (h : c.numerator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.numerator eq
    rw [h] at field
    cases field

theorem denominator_rejected_rejected (c : Candidate) (h : c.denominator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.denominator eq
    rw [h] at field
    cases field

theorem limit_rejected_rejected (c : Candidate) (h : c.limit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.limit eq
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

theorem associativity_rejected_rejected (c : Candidate) (h : c.associativity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.associativity eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
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

end SFT.Physics.VelocityCompositionGrammar
