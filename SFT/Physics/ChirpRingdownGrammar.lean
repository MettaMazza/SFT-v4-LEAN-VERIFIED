import SFT.Physics.ChirpRingdownCensus0
import SFT.Physics.ChirpRingdownCensus1
import SFT.Physics.ChirpRingdownCensus2
import SFT.Physics.ChirpRingdownCensus3
import SFT.Physics.ChirpRingdownCensus4
import SFT.Physics.ChirpRingdownCensus5
import SFT.Physics.ChirpRingdownCensus6
import SFT.Physics.ChirpRingdownCensus7
import SFT.Physics.ChirpRingdownCensus8
import SFT.Physics.ChirpRingdownCensus9
import SFT.Physics.ChirpRingdownCensus10
import SFT.Physics.ChirpRingdownCensus11
import SFT.Physics.ChirpRingdownCensus12
import SFT.Physics.ChirpRingdownCensus13
import SFT.Physics.ChirpRingdownCensus14
import SFT.Physics.ChirpRingdownCensus15
import SFT.Physics.ChirpRingdownCensus16
import SFT.Physics.ChirpRingdownCensus17
import SFT.Physics.ChirpRingdownCensus18
import SFT.Physics.ChirpRingdownCensus19
import SFT.Physics.ChirpRingdownCensus20
import SFT.Physics.ChirpRingdownCensus21
import SFT.Physics.ChirpRingdownCensus22
import SFT.Physics.ChirpRingdownCensus23
import SFT.Physics.ChirpRingdownCensus24
import SFT.Physics.ChirpRingdownCensus25
import SFT.Physics.ChirpRingdownCensus26
import SFT.Physics.ChirpRingdownCensus27
import SFT.Physics.ChirpRingdownCensus28
import SFT.Physics.ChirpRingdownCensus29
import SFT.Physics.ChirpRingdownCensus30
import SFT.Physics.ChirpRingdownCensus31
import SFT.Physics.ChirpRingdownCensus32
import SFT.Physics.ChirpRingdownCensus33
import SFT.Physics.ChirpRingdownCensus34
import SFT.Physics.ChirpRingdownCensus35
import SFT.Physics.ChirpRingdownCensus36
import SFT.Physics.ChirpRingdownCensus37
import SFT.Physics.ChirpRingdownCensus38
import SFT.Physics.ChirpRingdownCensus39
import SFT.Physics.ChirpRingdownCensus40
import SFT.Physics.ChirpRingdownCensus41
import SFT.Physics.ChirpRingdownCensus42
import SFT.Physics.ChirpRingdownCensus43
import SFT.Physics.ChirpRingdownCensus44
import SFT.Physics.ChirpRingdownCensus45
import SFT.Physics.ChirpRingdownCensus46
import SFT.Physics.ChirpRingdownCensus47
import SFT.Physics.ChirpRingdownCensus48
import SFT.Physics.ChirpRingdownCensus49
import SFT.Physics.ChirpRingdownCensus50
import SFT.Physics.ChirpRingdownCensus51
import SFT.Physics.ChirpRingdownCensus52
import SFT.Physics.ChirpRingdownCensus53
import SFT.Physics.ChirpRingdownCensus54
import SFT.Physics.ChirpRingdownCensus55
import SFT.Physics.ChirpRingdownCensus56
import SFT.Physics.ChirpRingdownCensus57
import SFT.Physics.ChirpRingdownCensus58
import SFT.Physics.ChirpRingdownCensus59
import SFT.Physics.ChirpRingdownCensus60
import SFT.Physics.ChirpRingdownCensus61
import SFT.Physics.ChirpRingdownCensus62
import SFT.Physics.ChirpRingdownCensus63
namespace SFT.Physics.ChirpRingdownGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk source moment transfer separation balance wave contact merger tone damping floor sequence =>
    cases source <;> cases moment <;> cases transfer <;> cases separation <;> cases balance <;> cases wave
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
  | mk source moment transfer separation balance wave contact merger tone damping floor sequence =>
    cases source <;> cases moment <;> cases transfer <;> cases separation <;> cases balance <;> cases wave
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
  c.source = .admitted ∧ c.moment = .admitted ∧ c.transfer = .admitted ∧ c.separation = .admitted ∧ c.balance = .admitted ∧ c.wave = .admitted ∧ c.contact = .admitted ∧ c.merger = .admitted ∧ c.tone = .admitted ∧ c.damping = .admitted ∧ c.floor = .admitted ∧ c.sequence = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk source moment transfer separation balance wave contact merger tone damping floor sequence =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10; cases h11
      rfl

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem moment_rejected_rejected (c : Candidate) (h : c.moment = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.moment eq
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

theorem separation_rejected_rejected (c : Candidate) (h : c.separation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.separation eq
    rw [h] at field
    cases field

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
    rw [h] at field
    cases field

theorem wave_rejected_rejected (c : Candidate) (h : c.wave = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.wave eq
    rw [h] at field
    cases field

theorem contact_rejected_rejected (c : Candidate) (h : c.contact = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.contact eq
    rw [h] at field
    cases field

theorem merger_rejected_rejected (c : Candidate) (h : c.merger = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.merger eq
    rw [h] at field
    cases field

theorem tone_rejected_rejected (c : Candidate) (h : c.tone = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.tone eq
    rw [h] at field
    cases field

theorem damping_rejected_rejected (c : Candidate) (h : c.damping = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.damping eq
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

theorem sequence_rejected_rejected (c : Candidate) (h : c.sequence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sequence eq
    rw [h] at field
    cases field

end SFT.Physics.ChirpRingdownGrammar
