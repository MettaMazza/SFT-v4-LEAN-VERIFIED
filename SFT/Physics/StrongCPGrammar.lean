import SFT.Physics.StrongCPCensus0
import SFT.Physics.StrongCPCensus1
import SFT.Physics.StrongCPCensus2
import SFT.Physics.StrongCPCensus3
import SFT.Physics.StrongCPCensus4
import SFT.Physics.StrongCPCensus5
import SFT.Physics.StrongCPCensus6
import SFT.Physics.StrongCPCensus7
import SFT.Physics.StrongCPCensus8
import SFT.Physics.StrongCPCensus9
import SFT.Physics.StrongCPCensus10
import SFT.Physics.StrongCPCensus11
import SFT.Physics.StrongCPCensus12
import SFT.Physics.StrongCPCensus13
import SFT.Physics.StrongCPCensus14
import SFT.Physics.StrongCPCensus15
namespace SFT.Physics.StrongCPGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor cp hand strong compensator sector baryon transition baryogenesis measurement extension =>
    cases predecessor <;> cases cp <;> cases hand <;> cases strong
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
  | mk predecessor cp hand strong compensator sector baryon transition baryogenesis measurement extension =>
    cases predecessor <;> cases cp <;> cases hand <;> cases strong
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
  c.predecessor = .admitted ∧ c.cp = .admitted ∧ c.hand = .admitted ∧ c.strong = .admitted ∧ c.compensator = .admitted ∧ c.sector = .admitted ∧ c.baryon = .admitted ∧ c.transition = .admitted ∧ c.baryogenesis = .admitted ∧ c.measurement = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor cp hand strong compensator sector baryon transition baryogenesis measurement extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
    rw [h] at field
    cases field

theorem cp_rejected_rejected (c : Candidate) (h : c.cp = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cp eq
    rw [h] at field
    cases field

theorem hand_rejected_rejected (c : Candidate) (h : c.hand = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.hand eq
    rw [h] at field
    cases field

theorem strong_rejected_rejected (c : Candidate) (h : c.strong = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.strong eq
    rw [h] at field
    cases field

theorem compensator_rejected_rejected (c : Candidate) (h : c.compensator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.compensator eq
    rw [h] at field
    cases field

theorem sector_rejected_rejected (c : Candidate) (h : c.sector = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sector eq
    rw [h] at field
    cases field

theorem baryon_rejected_rejected (c : Candidate) (h : c.baryon = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.baryon eq
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

theorem baryogenesis_rejected_rejected (c : Candidate) (h : c.baryogenesis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.baryogenesis eq
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

end SFT.Physics.StrongCPGrammar
