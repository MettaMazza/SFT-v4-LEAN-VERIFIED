import SFT.Physics.StellarCensus0
import SFT.Physics.StellarCensus1
import SFT.Physics.StellarCensus2
import SFT.Physics.StellarCensus3
import SFT.Physics.StellarCensus4
import SFT.Physics.StellarCensus5
import SFT.Physics.StellarCensus6
import SFT.Physics.StellarCensus7
import SFT.Physics.StellarCensus8
import SFT.Physics.StellarCensus9
import SFT.Physics.StellarCensus10
import SFT.Physics.StellarCensus11
import SFT.Physics.StellarCensus12
import SFT.Physics.StellarCensus13
import SFT.Physics.StellarCensus14
import SFT.Physics.StellarCensus15
import SFT.Physics.StellarCensus16
import SFT.Physics.StellarCensus17
import SFT.Physics.StellarCensus18
import SFT.Physics.StellarCensus19
import SFT.Physics.StellarCensus20
import SFT.Physics.StellarCensus21
import SFT.Physics.StellarCensus22
import SFT.Physics.StellarCensus23
import SFT.Physics.StellarCensus24
import SFT.Physics.StellarCensus25
import SFT.Physics.StellarCensus26
import SFT.Physics.StellarCensus27
import SFT.Physics.StellarCensus28
import SFT.Physics.StellarCensus29
import SFT.Physics.StellarCensus30
import SFT.Physics.StellarCensus31
import SFT.Physics.StellarCensus32
import SFT.Physics.StellarCensus33
import SFT.Physics.StellarCensus34
import SFT.Physics.StellarCensus35
import SFT.Physics.StellarCensus36
import SFT.Physics.StellarCensus37
import SFT.Physics.StellarCensus38
import SFT.Physics.StellarCensus39
import SFT.Physics.StellarCensus40
import SFT.Physics.StellarCensus41
import SFT.Physics.StellarCensus42
import SFT.Physics.StellarCensus43
import SFT.Physics.StellarCensus44
import SFT.Physics.StellarCensus45
import SFT.Physics.StellarCensus46
import SFT.Physics.StellarCensus47
import SFT.Physics.StellarCensus48
import SFT.Physics.StellarCensus49
import SFT.Physics.StellarCensus50
import SFT.Physics.StellarCensus51
import SFT.Physics.StellarCensus52
import SFT.Physics.StellarCensus53
import SFT.Physics.StellarCensus54
import SFT.Physics.StellarCensus55
import SFT.Physics.StellarCensus56
import SFT.Physics.StellarCensus57
import SFT.Physics.StellarCensus58
import SFT.Physics.StellarCensus59
import SFT.Physics.StellarCensus60
import SFT.Physics.StellarCensus61
import SFT.Physics.StellarCensus62
import SFT.Physics.StellarCensus63
namespace SFT.Physics.StellarGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk hydrostatic radial stellar lifetime circular flat dark tully resonance tidal measurement extension =>
    cases hydrostatic <;> cases radial <;> cases stellar <;> cases lifetime <;> cases circular <;> cases flat
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
  | mk hydrostatic radial stellar lifetime circular flat dark tully resonance tidal measurement extension =>
    cases hydrostatic <;> cases radial <;> cases stellar <;> cases lifetime <;> cases circular <;> cases flat
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
  c.hydrostatic = .admitted ∧ c.radial = .admitted ∧ c.stellar = .admitted ∧ c.lifetime = .admitted ∧ c.circular = .admitted ∧ c.flat = .admitted ∧ c.dark = .admitted ∧ c.tully = .admitted ∧ c.resonance = .admitted ∧ c.tidal = .admitted ∧ c.measurement = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk hydrostatic radial stellar lifetime circular flat dark tully resonance tidal measurement extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10; cases h11
      rfl

theorem hydrostatic_rejected_rejected (c : Candidate) (h : c.hydrostatic = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.hydrostatic eq
    rw [h] at field
    cases field

theorem radial_rejected_rejected (c : Candidate) (h : c.radial = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.radial eq
    rw [h] at field
    cases field

theorem stellar_rejected_rejected (c : Candidate) (h : c.stellar = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.stellar eq
    rw [h] at field
    cases field

theorem lifetime_rejected_rejected (c : Candidate) (h : c.lifetime = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.lifetime eq
    rw [h] at field
    cases field

theorem circular_rejected_rejected (c : Candidate) (h : c.circular = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.circular eq
    rw [h] at field
    cases field

theorem flat_rejected_rejected (c : Candidate) (h : c.flat = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.flat eq
    rw [h] at field
    cases field

theorem dark_rejected_rejected (c : Candidate) (h : c.dark = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dark eq
    rw [h] at field
    cases field

theorem tully_rejected_rejected (c : Candidate) (h : c.tully = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.tully eq
    rw [h] at field
    cases field

theorem resonance_rejected_rejected (c : Candidate) (h : c.resonance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.resonance eq
    rw [h] at field
    cases field

theorem tidal_rejected_rejected (c : Candidate) (h : c.tidal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.tidal eq
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

end SFT.Physics.StellarGrammar
