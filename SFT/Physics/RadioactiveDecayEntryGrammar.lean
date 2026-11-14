import SFT.Physics.RadioactiveDecayEntryGrammarBatch00
import SFT.Physics.RadioactiveDecayEntryGrammarBatch01
import SFT.Physics.RadioactiveDecayEntryGrammarBatch02
import SFT.Physics.RadioactiveDecayEntryGrammarBatch03
import SFT.Physics.RadioactiveDecayEntryGrammarBatch04
import SFT.Physics.RadioactiveDecayEntryGrammarBatch05
import SFT.Physics.RadioactiveDecayEntryGrammarBatch06
import SFT.Physics.RadioactiveDecayEntryGrammarBatch07
import SFT.Physics.RadioactiveDecayEntryGrammarBatch08
import SFT.Physics.RadioactiveDecayEntryGrammarBatch09
import SFT.Physics.RadioactiveDecayEntryGrammarBatch10
import SFT.Physics.RadioactiveDecayEntryGrammarBatch11
import SFT.Physics.RadioactiveDecayEntryGrammarBatch12
import SFT.Physics.RadioactiveDecayEntryGrammarBatch13
import SFT.Physics.RadioactiveDecayEntryGrammarBatch14
import SFT.Physics.RadioactiveDecayEntryGrammarBatch15
namespace SFT.Physics.RadioactiveDecayEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk predecessor topology alpha beta gamma composition survival determinism target extension =>
  cases predecessor <;> cases topology <;> cases alpha <;> cases beta
  · exact RadioactiveDecayEntryGrammarBatch00.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch01.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch02.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch03.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch04.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch05.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch06.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch07.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch08.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch09.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch10.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch11.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch12.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch13.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch14.sourceDecisionMatches gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch15.sourceDecisionMatches gamma composition survival determinism target extension
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk predecessor topology alpha beta gamma composition survival determinism target extension =>
  cases predecessor <;> cases topology <;> cases alpha <;> cases beta
  · exact RadioactiveDecayEntryGrammarBatch00.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch01.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch02.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch03.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch04.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch05.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch06.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch07.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch08.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch09.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch10.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch11.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch12.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch13.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch14.uniqueCriteria gamma composition survival determinism target extension
  · exact RadioactiveDecayEntryGrammarBatch15.uniqueCriteria gamma composition survival determinism target extension
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := (uniqueSurvivor survivor).mpr rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.topology = .admitted ∧ c.alpha = .admitted ∧ c.beta = .admitted ∧ c.gamma = .admitted ∧ c.composition = .admitted ∧ c.survival = .admitted ∧ c.determinism = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor topology alpha beta gamma composition survival determinism target extension =>
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

theorem topology_rejected_rejected (c : Candidate) (h : c.topology = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.topology eq
    rw [h] at field
    cases field

theorem alpha_rejected_rejected (c : Candidate) (h : c.alpha = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.alpha eq
    rw [h] at field
    cases field

theorem beta_rejected_rejected (c : Candidate) (h : c.beta = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.beta eq
    rw [h] at field
    cases field

theorem gamma_rejected_rejected (c : Candidate) (h : c.gamma = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.gamma eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem survival_rejected_rejected (c : Candidate) (h : c.survival = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.survival eq
    rw [h] at field
    cases field

theorem determinism_rejected_rejected (c : Candidate) (h : c.determinism = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.determinism eq
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

end SFT.Physics.RadioactiveDecayEntryGrammar
