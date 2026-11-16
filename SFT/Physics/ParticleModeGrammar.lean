import SFT.Physics.ParticleModeCensus0
import SFT.Physics.ParticleModeCensus1
import SFT.Physics.ParticleModeCensus2
import SFT.Physics.ParticleModeCensus3
import SFT.Physics.ParticleModeCensus4
import SFT.Physics.ParticleModeCensus5
import SFT.Physics.ParticleModeCensus6
import SFT.Physics.ParticleModeCensus7
import SFT.Physics.ParticleModeCensus8
import SFT.Physics.ParticleModeCensus9
import SFT.Physics.ParticleModeCensus10
import SFT.Physics.ParticleModeCensus11
import SFT.Physics.ParticleModeCensus12
import SFT.Physics.ParticleModeCensus13
import SFT.Physics.ParticleModeCensus14
import SFT.Physics.ParticleModeCensus15
import SFT.Physics.ParticleModeCensus16
import SFT.Physics.ParticleModeCensus17
import SFT.Physics.ParticleModeCensus18
import SFT.Physics.ParticleModeCensus19
import SFT.Physics.ParticleModeCensus20
import SFT.Physics.ParticleModeCensus21
import SFT.Physics.ParticleModeCensus22
import SFT.Physics.ParticleModeCensus23
import SFT.Physics.ParticleModeCensus24
import SFT.Physics.ParticleModeCensus25
import SFT.Physics.ParticleModeCensus26
import SFT.Physics.ParticleModeCensus27
import SFT.Physics.ParticleModeCensus28
import SFT.Physics.ParticleModeCensus29
import SFT.Physics.ParticleModeCensus30
import SFT.Physics.ParticleModeCensus31
namespace SFT.Physics.ParticleModeGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk fibre mode generation cover placement mass dual reach transition extension =>
    cases fibre <;> cases mode <;> cases generation <;> cases cover <;> cases placement
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
    · exact sourceDecisionChunk16 _ _ _ _ _
    · exact sourceDecisionChunk17 _ _ _ _ _
    · exact sourceDecisionChunk18 _ _ _ _ _
    · exact sourceDecisionChunk19 _ _ _ _ _
    · exact sourceDecisionChunk20 _ _ _ _ _
    · exact sourceDecisionChunk21 _ _ _ _ _
    · exact sourceDecisionChunk22 _ _ _ _ _
    · exact sourceDecisionChunk23 _ _ _ _ _
    · exact sourceDecisionChunk24 _ _ _ _ _
    · exact sourceDecisionChunk25 _ _ _ _ _
    · exact sourceDecisionChunk26 _ _ _ _ _
    · exact sourceDecisionChunk27 _ _ _ _ _
    · exact sourceDecisionChunk28 _ _ _ _ _
    · exact sourceDecisionChunk29 _ _ _ _ _
    · exact sourceDecisionChunk30 _ _ _ _ _
    · exact sourceDecisionChunk31 _ _ _ _ _

theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk fibre mode generation cover placement mass dual reach transition extension =>
    cases fibre <;> cases mode <;> cases generation <;> cases cover <;> cases placement
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
    · exact uniqueCriteriaChunk16 _ _ _ _ _
    · exact uniqueCriteriaChunk17 _ _ _ _ _
    · exact uniqueCriteriaChunk18 _ _ _ _ _
    · exact uniqueCriteriaChunk19 _ _ _ _ _
    · exact uniqueCriteriaChunk20 _ _ _ _ _
    · exact uniqueCriteriaChunk21 _ _ _ _ _
    · exact uniqueCriteriaChunk22 _ _ _ _ _
    · exact uniqueCriteriaChunk23 _ _ _ _ _
    · exact uniqueCriteriaChunk24 _ _ _ _ _
    · exact uniqueCriteriaChunk25 _ _ _ _ _
    · exact uniqueCriteriaChunk26 _ _ _ _ _
    · exact uniqueCriteriaChunk27 _ _ _ _ _
    · exact uniqueCriteriaChunk28 _ _ _ _ _
    · exact uniqueCriteriaChunk29 _ _ _ _ _
    · exact uniqueCriteriaChunk30 _ _ _ _ _
    · exact uniqueCriteriaChunk31 _ _ _ _ _

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.fibre = .admitted ∧ c.mode = .admitted ∧ c.generation = .admitted ∧ c.cover = .admitted ∧ c.placement = .admitted ∧ c.mass = .admitted ∧ c.dual = .admitted ∧ c.reach = .admitted ∧ c.transition = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk fibre mode generation cover placement mass dual reach transition extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem fibre_rejected_rejected (c : Candidate) (h : c.fibre = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fibre eq
    rw [h] at field
    cases field

theorem mode_rejected_rejected (c : Candidate) (h : c.mode = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mode eq
    rw [h] at field
    cases field

theorem generation_rejected_rejected (c : Candidate) (h : c.generation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generation eq
    rw [h] at field
    cases field

theorem cover_rejected_rejected (c : Candidate) (h : c.cover = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cover eq
    rw [h] at field
    cases field

theorem placement_rejected_rejected (c : Candidate) (h : c.placement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.placement eq
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

theorem dual_rejected_rejected (c : Candidate) (h : c.dual = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dual eq
    rw [h] at field
    cases field

theorem reach_rejected_rejected (c : Candidate) (h : c.reach = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reach eq
    rw [h] at field
    cases field

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
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

end SFT.Physics.ParticleModeGrammar
