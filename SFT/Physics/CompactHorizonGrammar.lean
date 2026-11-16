import SFT.Physics.CompactHorizonCensus0
import SFT.Physics.CompactHorizonCensus1
import SFT.Physics.CompactHorizonCensus2
import SFT.Physics.CompactHorizonCensus3
import SFT.Physics.CompactHorizonCensus4
import SFT.Physics.CompactHorizonCensus5
import SFT.Physics.CompactHorizonCensus6
import SFT.Physics.CompactHorizonCensus7
import SFT.Physics.CompactHorizonCensus8
import SFT.Physics.CompactHorizonCensus9
import SFT.Physics.CompactHorizonCensus10
import SFT.Physics.CompactHorizonCensus11
import SFT.Physics.CompactHorizonCensus12
import SFT.Physics.CompactHorizonCensus13
import SFT.Physics.CompactHorizonCensus14
import SFT.Physics.CompactHorizonCensus15
import SFT.Physics.CompactHorizonCensus16
import SFT.Physics.CompactHorizonCensus17
import SFT.Physics.CompactHorizonCensus18
import SFT.Physics.CompactHorizonCensus19
import SFT.Physics.CompactHorizonCensus20
import SFT.Physics.CompactHorizonCensus21
import SFT.Physics.CompactHorizonCensus22
import SFT.Physics.CompactHorizonCensus23
import SFT.Physics.CompactHorizonCensus24
import SFT.Physics.CompactHorizonCensus25
import SFT.Physics.CompactHorizonCensus26
import SFT.Physics.CompactHorizonCensus27
import SFT.Physics.CompactHorizonCensus28
import SFT.Physics.CompactHorizonCensus29
import SFT.Physics.CompactHorizonCensus30
import SFT.Physics.CompactHorizonCensus31
import SFT.Physics.CompactHorizonCensus32
import SFT.Physics.CompactHorizonCensus33
import SFT.Physics.CompactHorizonCensus34
import SFT.Physics.CompactHorizonCensus35
import SFT.Physics.CompactHorizonCensus36
import SFT.Physics.CompactHorizonCensus37
import SFT.Physics.CompactHorizonCensus38
import SFT.Physics.CompactHorizonCensus39
import SFT.Physics.CompactHorizonCensus40
import SFT.Physics.CompactHorizonCensus41
import SFT.Physics.CompactHorizonCensus42
import SFT.Physics.CompactHorizonCensus43
import SFT.Physics.CompactHorizonCensus44
import SFT.Physics.CompactHorizonCensus45
import SFT.Physics.CompactHorizonCensus46
import SFT.Physics.CompactHorizonCensus47
import SFT.Physics.CompactHorizonCensus48
import SFT.Physics.CompactHorizonCensus49
import SFT.Physics.CompactHorizonCensus50
import SFT.Physics.CompactHorizonCensus51
import SFT.Physics.CompactHorizonCensus52
import SFT.Physics.CompactHorizonCensus53
import SFT.Physics.CompactHorizonCensus54
import SFT.Physics.CompactHorizonCensus55
import SFT.Physics.CompactHorizonCensus56
import SFT.Physics.CompactHorizonCensus57
import SFT.Physics.CompactHorizonCensus58
import SFT.Physics.CompactHorizonCensus59
import SFT.Physics.CompactHorizonCensus60
import SFT.Physics.CompactHorizonCensus61
import SFT.Physics.CompactHorizonCensus62
import SFT.Physics.CompactHorizonCensus63
namespace SFT.Physics.CompactHorizonGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk occupation momentum support gravity threshold endpoint radius area entropy thermal floor extension =>
    cases occupation <;> cases momentum <;> cases support <;> cases gravity <;> cases threshold <;> cases endpoint
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
  | mk occupation momentum support gravity threshold endpoint radius area entropy thermal floor extension =>
    cases occupation <;> cases momentum <;> cases support <;> cases gravity <;> cases threshold <;> cases endpoint
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
  c.occupation = .admitted ∧ c.momentum = .admitted ∧ c.support = .admitted ∧ c.gravity = .admitted ∧ c.threshold = .admitted ∧ c.endpoint = .admitted ∧ c.radius = .admitted ∧ c.area = .admitted ∧ c.entropy = .admitted ∧ c.thermal = .admitted ∧ c.floor = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk occupation momentum support gravity threshold endpoint radius area entropy thermal floor extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10; cases h11
      rfl

theorem occupation_rejected_rejected (c : Candidate) (h : c.occupation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.occupation eq
    rw [h] at field
    cases field

theorem momentum_rejected_rejected (c : Candidate) (h : c.momentum = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.momentum eq
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

theorem gravity_rejected_rejected (c : Candidate) (h : c.gravity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.gravity eq
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

theorem endpoint_rejected_rejected (c : Candidate) (h : c.endpoint = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.endpoint eq
    rw [h] at field
    cases field

theorem radius_rejected_rejected (c : Candidate) (h : c.radius = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.radius eq
    rw [h] at field
    cases field

theorem area_rejected_rejected (c : Candidate) (h : c.area = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.area eq
    rw [h] at field
    cases field

theorem entropy_rejected_rejected (c : Candidate) (h : c.entropy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.entropy eq
    rw [h] at field
    cases field

theorem thermal_rejected_rejected (c : Candidate) (h : c.thermal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.thermal eq
    rw [h] at field
    cases field

theorem floor_rejected_rejected (c : Candidate) (h : c.floor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.floor eq
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

end SFT.Physics.CompactHorizonGrammar
