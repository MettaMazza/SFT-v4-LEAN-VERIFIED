import SFT.Physics.SymmetryActionCensus0
import SFT.Physics.SymmetryActionCensus1
import SFT.Physics.SymmetryActionCensus2
import SFT.Physics.SymmetryActionCensus3
import SFT.Physics.SymmetryActionCensus4
import SFT.Physics.SymmetryActionCensus5
import SFT.Physics.SymmetryActionCensus6
import SFT.Physics.SymmetryActionCensus7
import SFT.Physics.SymmetryActionCensus8
import SFT.Physics.SymmetryActionCensus9
import SFT.Physics.SymmetryActionCensus10
import SFT.Physics.SymmetryActionCensus11
import SFT.Physics.SymmetryActionCensus12
import SFT.Physics.SymmetryActionCensus13
import SFT.Physics.SymmetryActionCensus14
import SFT.Physics.SymmetryActionCensus15
namespace SFT.Physics.SymmetryActionGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support symmetry incidence carrier conserved converse action path extension =>
    cases support <;> cases symmetry <;> cases incidence <;> cases carrier
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

theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support symmetry incidence carrier conserved converse action path extension =>
    cases support <;> cases symmetry <;> cases incidence <;> cases carrier
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

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.symmetry = .admitted ∧ c.incidence = .admitted ∧ c.carrier = .admitted ∧ c.conserved = .admitted ∧ c.converse = .admitted ∧ c.action = .admitted ∧ c.path = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support symmetry incidence carrier conserved converse action path extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem symmetry_rejected_rejected (c : Candidate) (h : c.symmetry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.symmetry eq
    rw [h] at field
    cases field

theorem incidence_rejected_rejected (c : Candidate) (h : c.incidence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.incidence eq
    rw [h] at field
    cases field

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem conserved_rejected_rejected (c : Candidate) (h : c.conserved = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conserved eq
    rw [h] at field
    cases field

theorem converse_rejected_rejected (c : Candidate) (h : c.converse = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.converse eq
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

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
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

end SFT.Physics.SymmetryActionGrammar
