import SFT.Physics.CompositeConfiningCensus0
import SFT.Physics.CompositeConfiningCensus1
import SFT.Physics.CompositeConfiningCensus2
import SFT.Physics.CompositeConfiningCensus3
import SFT.Physics.CompositeConfiningCensus4
import SFT.Physics.CompositeConfiningCensus5
import SFT.Physics.CompositeConfiningCensus6
import SFT.Physics.CompositeConfiningCensus7
import SFT.Physics.CompositeConfiningCensus8
import SFT.Physics.CompositeConfiningCensus9
import SFT.Physics.CompositeConfiningCensus10
import SFT.Physics.CompositeConfiningCensus11
import SFT.Physics.CompositeConfiningCensus12
import SFT.Physics.CompositeConfiningCensus13
import SFT.Physics.CompositeConfiningCensus14
import SFT.Physics.CompositeConfiningCensus15
import SFT.Physics.CompositeConfiningCensus16
import SFT.Physics.CompositeConfiningCensus17
import SFT.Physics.CompositeConfiningCensus18
import SFT.Physics.CompositeConfiningCensus19
import SFT.Physics.CompositeConfiningCensus20
import SFT.Physics.CompositeConfiningCensus21
import SFT.Physics.CompositeConfiningCensus22
import SFT.Physics.CompositeConfiningCensus23
import SFT.Physics.CompositeConfiningCensus24
import SFT.Physics.CompositeConfiningCensus25
import SFT.Physics.CompositeConfiningCensus26
import SFT.Physics.CompositeConfiningCensus27
import SFT.Physics.CompositeConfiningCensus28
import SFT.Physics.CompositeConfiningCensus29
import SFT.Physics.CompositeConfiningCensus30
import SFT.Physics.CompositeConfiningCensus31
namespace SFT.Physics.CompositeConfiningGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk scope support modes action confinement orbits antipodes pair_count coupling comparison extension =>
    cases scope <;> cases support <;> cases modes <;> cases action <;> cases confinement
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
  | mk scope support modes action confinement orbits antipodes pair_count coupling comparison extension =>
    cases scope <;> cases support <;> cases modes <;> cases action <;> cases confinement
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
  c.scope = .admitted ∧ c.support = .admitted ∧ c.modes = .admitted ∧ c.action = .admitted ∧ c.confinement = .admitted ∧ c.orbits = .admitted ∧ c.antipodes = .admitted ∧ c.pair_count = .admitted ∧ c.coupling = .admitted ∧ c.comparison = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk scope support modes action confinement orbits antipodes pair_count coupling comparison extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem scope_rejected_rejected (c : Candidate) (h : c.scope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scope eq
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

theorem modes_rejected_rejected (c : Candidate) (h : c.modes = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.modes eq
    rw [h] at field
    cases field

theorem action_rejected_rejected (c : Candidate) (h : c.action = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.action eq
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

theorem orbits_rejected_rejected (c : Candidate) (h : c.orbits = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orbits eq
    rw [h] at field
    cases field

theorem antipodes_rejected_rejected (c : Candidate) (h : c.antipodes = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.antipodes eq
    rw [h] at field
    cases field

theorem pair_count_rejected_rejected (c : Candidate) (h : c.pair_count = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pair_count eq
    rw [h] at field
    cases field

theorem coupling_rejected_rejected (c : Candidate) (h : c.coupling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coupling eq
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

end SFT.Physics.CompositeConfiningGrammar
