import SFT.Physics.GrandLockCensus0
import SFT.Physics.GrandLockCensus1
import SFT.Physics.GrandLockCensus2
import SFT.Physics.GrandLockCensus3
import SFT.Physics.GrandLockCensus4
import SFT.Physics.GrandLockCensus5
import SFT.Physics.GrandLockCensus6
import SFT.Physics.GrandLockCensus7
import SFT.Physics.GrandLockCensus8
import SFT.Physics.GrandLockCensus9
import SFT.Physics.GrandLockCensus10
import SFT.Physics.GrandLockCensus11
import SFT.Physics.GrandLockCensus12
import SFT.Physics.GrandLockCensus13
import SFT.Physics.GrandLockCensus14
import SFT.Physics.GrandLockCensus15
import SFT.Physics.GrandLockCensus16
import SFT.Physics.GrandLockCensus17
import SFT.Physics.GrandLockCensus18
import SFT.Physics.GrandLockCensus19
import SFT.Physics.GrandLockCensus20
import SFT.Physics.GrandLockCensus21
import SFT.Physics.GrandLockCensus22
import SFT.Physics.GrandLockCensus23
import SFT.Physics.GrandLockCensus24
import SFT.Physics.GrandLockCensus25
import SFT.Physics.GrandLockCensus26
import SFT.Physics.GrandLockCensus27
import SFT.Physics.GrandLockCensus28
import SFT.Physics.GrandLockCensus29
import SFT.Physics.GrandLockCensus30
import SFT.Physics.GrandLockCensus31
import SFT.Physics.GrandLockCensus32
import SFT.Physics.GrandLockCensus33
import SFT.Physics.GrandLockCensus34
import SFT.Physics.GrandLockCensus35
import SFT.Physics.GrandLockCensus36
import SFT.Physics.GrandLockCensus37
import SFT.Physics.GrandLockCensus38
import SFT.Physics.GrandLockCensus39
import SFT.Physics.GrandLockCensus40
import SFT.Physics.GrandLockCensus41
import SFT.Physics.GrandLockCensus42
import SFT.Physics.GrandLockCensus43
import SFT.Physics.GrandLockCensus44
import SFT.Physics.GrandLockCensus45
import SFT.Physics.GrandLockCensus46
import SFT.Physics.GrandLockCensus47
import SFT.Physics.GrandLockCensus48
import SFT.Physics.GrandLockCensus49
import SFT.Physics.GrandLockCensus50
import SFT.Physics.GrandLockCensus51
import SFT.Physics.GrandLockCensus52
import SFT.Physics.GrandLockCensus53
import SFT.Physics.GrandLockCensus54
import SFT.Physics.GrandLockCensus55
import SFT.Physics.GrandLockCensus56
import SFT.Physics.GrandLockCensus57
import SFT.Physics.GrandLockCensus58
import SFT.Physics.GrandLockCensus59
import SFT.Physics.GrandLockCensus60
import SFT.Physics.GrandLockCensus61
import SFT.Physics.GrandLockCensus62
import SFT.Physics.GrandLockCensus63
namespace SFT.Physics.GrandLockGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk ownership receipt registration dependency root values perturbation invariants identity empirical extension rule =>
    cases ownership <;> cases receipt <;> cases registration <;> cases dependency <;> cases root <;> cases values
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
    · exact sourceDecisionChunk32 _ _ _ _ _ _
    · exact sourceDecisionChunk33 _ _ _ _ _ _
    · exact sourceDecisionChunk34 _ _ _ _ _ _
    · exact sourceDecisionChunk35 _ _ _ _ _ _
    · exact sourceDecisionChunk36 _ _ _ _ _ _
    · exact sourceDecisionChunk37 _ _ _ _ _ _
    · exact sourceDecisionChunk38 _ _ _ _ _ _
    · exact sourceDecisionChunk39 _ _ _ _ _ _
    · exact sourceDecisionChunk40 _ _ _ _ _ _
    · exact sourceDecisionChunk41 _ _ _ _ _ _
    · exact sourceDecisionChunk42 _ _ _ _ _ _
    · exact sourceDecisionChunk43 _ _ _ _ _ _
    · exact sourceDecisionChunk44 _ _ _ _ _ _
    · exact sourceDecisionChunk45 _ _ _ _ _ _
    · exact sourceDecisionChunk46 _ _ _ _ _ _
    · exact sourceDecisionChunk47 _ _ _ _ _ _
    · exact sourceDecisionChunk48 _ _ _ _ _ _
    · exact sourceDecisionChunk49 _ _ _ _ _ _
    · exact sourceDecisionChunk50 _ _ _ _ _ _
    · exact sourceDecisionChunk51 _ _ _ _ _ _
    · exact sourceDecisionChunk52 _ _ _ _ _ _
    · exact sourceDecisionChunk53 _ _ _ _ _ _
    · exact sourceDecisionChunk54 _ _ _ _ _ _
    · exact sourceDecisionChunk55 _ _ _ _ _ _
    · exact sourceDecisionChunk56 _ _ _ _ _ _
    · exact sourceDecisionChunk57 _ _ _ _ _ _
    · exact sourceDecisionChunk58 _ _ _ _ _ _
    · exact sourceDecisionChunk59 _ _ _ _ _ _
    · exact sourceDecisionChunk60 _ _ _ _ _ _
    · exact sourceDecisionChunk61 _ _ _ _ _ _
    · exact sourceDecisionChunk62 _ _ _ _ _ _
    · exact sourceDecisionChunk63 _ _ _ _ _ _
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk ownership receipt registration dependency root values perturbation invariants identity empirical extension rule =>
    cases ownership <;> cases receipt <;> cases registration <;> cases dependency <;> cases root <;> cases values
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
    · exact uniqueCriteriaChunk32 _ _ _ _ _ _
    · exact uniqueCriteriaChunk33 _ _ _ _ _ _
    · exact uniqueCriteriaChunk34 _ _ _ _ _ _
    · exact uniqueCriteriaChunk35 _ _ _ _ _ _
    · exact uniqueCriteriaChunk36 _ _ _ _ _ _
    · exact uniqueCriteriaChunk37 _ _ _ _ _ _
    · exact uniqueCriteriaChunk38 _ _ _ _ _ _
    · exact uniqueCriteriaChunk39 _ _ _ _ _ _
    · exact uniqueCriteriaChunk40 _ _ _ _ _ _
    · exact uniqueCriteriaChunk41 _ _ _ _ _ _
    · exact uniqueCriteriaChunk42 _ _ _ _ _ _
    · exact uniqueCriteriaChunk43 _ _ _ _ _ _
    · exact uniqueCriteriaChunk44 _ _ _ _ _ _
    · exact uniqueCriteriaChunk45 _ _ _ _ _ _
    · exact uniqueCriteriaChunk46 _ _ _ _ _ _
    · exact uniqueCriteriaChunk47 _ _ _ _ _ _
    · exact uniqueCriteriaChunk48 _ _ _ _ _ _
    · exact uniqueCriteriaChunk49 _ _ _ _ _ _
    · exact uniqueCriteriaChunk50 _ _ _ _ _ _
    · exact uniqueCriteriaChunk51 _ _ _ _ _ _
    · exact uniqueCriteriaChunk52 _ _ _ _ _ _
    · exact uniqueCriteriaChunk53 _ _ _ _ _ _
    · exact uniqueCriteriaChunk54 _ _ _ _ _ _
    · exact uniqueCriteriaChunk55 _ _ _ _ _ _
    · exact uniqueCriteriaChunk56 _ _ _ _ _ _
    · exact uniqueCriteriaChunk57 _ _ _ _ _ _
    · exact uniqueCriteriaChunk58 _ _ _ _ _ _
    · exact uniqueCriteriaChunk59 _ _ _ _ _ _
    · exact uniqueCriteriaChunk60 _ _ _ _ _ _
    · exact uniqueCriteriaChunk61 _ _ _ _ _ _
    · exact uniqueCriteriaChunk62 _ _ _ _ _ _
    · exact uniqueCriteriaChunk63 _ _ _ _ _ _
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.ownership = .admitted ∧ c.receipt = .admitted ∧ c.registration = .admitted ∧ c.dependency = .admitted ∧ c.root = .admitted ∧ c.values = .admitted ∧ c.perturbation = .admitted ∧ c.invariants = .admitted ∧ c.identity = .admitted ∧ c.empirical = .admitted ∧ c.extension = .admitted ∧ c.rule = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk ownership receipt registration dependency root values perturbation invariants identity empirical extension rule =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10; cases h11
      rfl

theorem ownership_rejected_rejected (c : Candidate) (h : c.ownership = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ownership eq
    rw [h] at field
    cases field

theorem receipt_rejected_rejected (c : Candidate) (h : c.receipt = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.receipt eq
    rw [h] at field
    cases field

theorem registration_rejected_rejected (c : Candidate) (h : c.registration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.registration eq
    rw [h] at field
    cases field

theorem dependency_rejected_rejected (c : Candidate) (h : c.dependency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dependency eq
    rw [h] at field
    cases field

theorem root_rejected_rejected (c : Candidate) (h : c.root = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.root eq
    rw [h] at field
    cases field

theorem values_rejected_rejected (c : Candidate) (h : c.values = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.values eq
    rw [h] at field
    cases field

theorem perturbation_rejected_rejected (c : Candidate) (h : c.perturbation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.perturbation eq
    rw [h] at field
    cases field

theorem invariants_rejected_rejected (c : Candidate) (h : c.invariants = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.invariants eq
    rw [h] at field
    cases field

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem empirical_rejected_rejected (c : Candidate) (h : c.empirical = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.empirical eq
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

theorem rule_rejected_rejected (c : Candidate) (h : c.rule = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rule eq
    rw [h] at field
    cases field

end SFT.Physics.GrandLockGrammar
