import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Mathematics.ExactTracePairing
open ExactTraceArithmetic

theorem zipPreservesLeft (left right : Trace) (h : left.length = right.length) :
    (left.zip right).map Prod.fst = left := by
  induction left generalizing right with
  | nil => cases right with
    | nil => rfl
    | cons b bs => cases h
  | cons a as ih => cases right with
    | nil => cases h
    | cons b bs => exact congrArg (List.cons a) (ih bs (Nat.succ.inj h))

theorem zipPreservesRight (left right : Trace) (h : left.length = right.length) :
    (left.zip right).map Prod.snd = right := by
  induction left generalizing right with
  | nil => cases right with
    | nil => rfl
    | cons b bs => cases h
  | cons a as ih => cases right with
    | nil => cases h
    | cons b bs => exact congrArg (List.cons b) (ih bs (Nat.succ.inj h))

theorem exactPairingComplete (left right : Trace) (pairs : List (Atom × Atom))
    (h : exactPairing left right = some pairs) :
    pairs.map Prod.fst = left ∧ pairs.map Prod.snd = right := by
  unfold exactPairing at h
  split at h
  next lengths =>
    have eq := Option.some.inj h
    cases eq
    exact ⟨zipPreservesLeft left right lengths,zipPreservesRight left right lengths⟩
  next unequal => cases h

theorem exactPairingCardinality (left right : Trace) (pairs : List (Atom × Atom))
    (h : exactPairing left right = some pairs) : pairs.length = left.length ∧ pairs.length = right.length := by
  have projections := exactPairingComplete left right pairs h
  have l := congrArg List.length projections.1
  have r := congrArg List.length projections.2
  rw [SFT.Foundation.CommonRefinement.mapLength] at l r
  exact ⟨l,r⟩

theorem pairingExistsIffEqualLength (left right : Trace) :
    (∃ pairs, exactPairing left right = some pairs) ↔ left.length = right.length := by
  constructor
  · intro h
    obtain ⟨pairs,h⟩ := h
    have sizes := exactPairingCardinality left right pairs h
    exact sizes.1.symm.trans sizes.2
  · intro h
    exact ⟨left.zip right,exactPairingEqualLength left right h⟩

theorem pairingUnique (left right : Trace) (a b : List (Atom × Atom))
    (ha : exactPairing left right = some a) (hb : exactPairing left right = some b) : a = b :=
  Option.some.inj (ha.symm.trans hb)

end SFT.Mathematics.ExactTracePairing
