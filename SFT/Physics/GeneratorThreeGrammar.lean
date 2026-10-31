import SFT.Physics.GeneratorThreeCensus0
import SFT.Physics.GeneratorThreeCensus1
import SFT.Physics.GeneratorThreeCensus2
import SFT.Physics.GeneratorThreeCensus3
import SFT.Physics.GeneratorThreeCensus4
import SFT.Physics.GeneratorThreeCensus5
import SFT.Physics.GeneratorThreeCensus6
import SFT.Physics.GeneratorThreeCensus7
import SFT.Physics.GeneratorThreeCensus8
import SFT.Physics.GeneratorThreeCensus9
import SFT.Physics.GeneratorThreeCensus10
import SFT.Physics.GeneratorThreeCensus11
import SFT.Physics.GeneratorThreeCensus12
import SFT.Physics.GeneratorThreeCensus13
import SFT.Physics.GeneratorThreeCensus14
import SFT.Physics.GeneratorThreeCensus15
namespace SFT.Physics.GeneratorThreeGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier action recurrence binary successor unit orbit order measurement extension =>
    cases carrier with
    | rejected =>
      cases action with
      | rejected =>
        cases recurrence with
        | rejected =>
          cases binary with
          | rejected =>
            exact decisionCensus0 successor unit orbit order measurement extension
          | admitted =>
            exact decisionCensus1 successor unit orbit order measurement extension
        | admitted =>
          cases binary with
          | rejected =>
            exact decisionCensus2 successor unit orbit order measurement extension
          | admitted =>
            exact decisionCensus3 successor unit orbit order measurement extension
      | admitted =>
        cases recurrence with
        | rejected =>
          cases binary with
          | rejected =>
            exact decisionCensus4 successor unit orbit order measurement extension
          | admitted =>
            exact decisionCensus5 successor unit orbit order measurement extension
        | admitted =>
          cases binary with
          | rejected =>
            exact decisionCensus6 successor unit orbit order measurement extension
          | admitted =>
            exact decisionCensus7 successor unit orbit order measurement extension
    | admitted =>
      cases action with
      | rejected =>
        cases recurrence with
        | rejected =>
          cases binary with
          | rejected =>
            exact decisionCensus8 successor unit orbit order measurement extension
          | admitted =>
            exact decisionCensus9 successor unit orbit order measurement extension
        | admitted =>
          cases binary with
          | rejected =>
            exact decisionCensus10 successor unit orbit order measurement extension
          | admitted =>
            exact decisionCensus11 successor unit orbit order measurement extension
      | admitted =>
        cases recurrence with
        | rejected =>
          cases binary with
          | rejected =>
            exact decisionCensus12 successor unit orbit order measurement extension
          | admitted =>
            exact decisionCensus13 successor unit orbit order measurement extension
        | admitted =>
          cases binary with
          | rejected =>
            exact decisionCensus14 successor unit orbit order measurement extension
          | admitted =>
            exact decisionCensus15 successor unit orbit order measurement extension

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier action recurrence binary successor unit orbit order measurement extension =>
    cases carrier with
    | rejected =>
      constructor <;> intro h <;> cases h
    | admitted =>
      cases action with
      | rejected =>
        constructor <;> intro h <;> cases h
      | admitted =>
        cases recurrence with
        | rejected =>
          constructor <;> intro h <;> cases h
        | admitted =>
          cases binary with
          | rejected =>
            constructor <;> intro h <;> cases h
          | admitted =>
            cases successor with
            | rejected =>
              constructor <;> intro h <;> cases h
            | admitted =>
              cases unit with
              | rejected =>
                constructor <;> intro h <;> cases h
              | admitted =>
                cases orbit with
                | rejected =>
                  constructor <;> intro h <;> cases h
                | admitted =>
                  cases order with
                  | rejected =>
                    constructor <;> intro h <;> cases h
                  | admitted =>
                    cases measurement with
                    | rejected =>
                      constructor <;> intro h <;> cases h
                    | admitted =>
                      cases extension with
                      | rejected =>
                        constructor <;> intro h <;> cases h
                      | admitted =>
                        constructor <;> intro h <;> rfl

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.action = .admitted ∧ c.recurrence = .admitted ∧ c.binary = .admitted ∧ c.successor = .admitted ∧ c.unit = .admitted ∧ c.orbit = .admitted ∧ c.order = .admitted ∧ c.measurement = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier action recurrence binary successor unit orbit order measurement extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
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

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
    rw [h] at field
    cases field

theorem binary_rejected_rejected (c : Candidate) (h : c.binary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.binary eq
    rw [h] at field
    cases field

theorem successor_rejected_rejected (c : Candidate) (h : c.successor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.successor eq
    rw [h] at field
    cases field

theorem unit_rejected_rejected (c : Candidate) (h : c.unit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unit eq
    rw [h] at field
    cases field

theorem orbit_rejected_rejected (c : Candidate) (h : c.orbit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orbit eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
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

end SFT.Physics.GeneratorThreeGrammar
