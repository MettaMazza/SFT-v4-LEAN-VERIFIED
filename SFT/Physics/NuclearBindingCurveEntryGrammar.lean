import SFT.Physics.NuclearBindingCurveEntryGrammarBatch00
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch01
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch02
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch03
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch04
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch05
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch06
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch07
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch08
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch09
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch10
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch11
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch12
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch13
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch14
import SFT.Physics.NuclearBindingCurveEntryGrammarBatch15
namespace SFT.Physics.NuclearBindingCurveEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk predecessor bulk surface coulomb asymmetry pairing radius maximum target extension =>
  cases predecessor <;> cases bulk <;> cases surface <;> cases coulomb
  · exact NuclearBindingCurveEntryGrammarBatch00.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch01.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch02.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch03.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch04.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch05.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch06.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch07.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch08.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch09.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch10.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch11.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch12.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch13.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch14.sourceDecisionMatches asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch15.sourceDecisionMatches asymmetry pairing radius maximum target extension
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk predecessor bulk surface coulomb asymmetry pairing radius maximum target extension =>
  cases predecessor <;> cases bulk <;> cases surface <;> cases coulomb
  · exact NuclearBindingCurveEntryGrammarBatch00.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch01.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch02.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch03.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch04.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch05.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch06.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch07.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch08.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch09.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch10.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch11.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch12.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch13.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch14.uniqueCriteria asymmetry pairing radius maximum target extension
  · exact NuclearBindingCurveEntryGrammarBatch15.uniqueCriteria asymmetry pairing radius maximum target extension
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := (uniqueSurvivor survivor).mpr rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.bulk = .admitted ∧ c.surface = .admitted ∧ c.coulomb = .admitted ∧ c.asymmetry = .admitted ∧ c.pairing = .admitted ∧ c.radius = .admitted ∧ c.maximum = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor bulk surface coulomb asymmetry pairing radius maximum target extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      exact survivorAccepted

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
    rw [h] at field
    cases field

theorem bulk_rejected_rejected (c : Candidate) (h : c.bulk = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bulk eq
    rw [h] at field
    cases field

theorem surface_rejected_rejected (c : Candidate) (h : c.surface = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.surface eq
    rw [h] at field
    cases field

theorem coulomb_rejected_rejected (c : Candidate) (h : c.coulomb = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coulomb eq
    rw [h] at field
    cases field

theorem asymmetry_rejected_rejected (c : Candidate) (h : c.asymmetry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.asymmetry eq
    rw [h] at field
    cases field

theorem pairing_rejected_rejected (c : Candidate) (h : c.pairing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pairing eq
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

theorem maximum_rejected_rejected (c : Candidate) (h : c.maximum = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.maximum eq
    rw [h] at field
    cases field

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
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

end SFT.Physics.NuclearBindingCurveEntryGrammar
