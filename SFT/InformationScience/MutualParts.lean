import SFT.InformationScience.MutualObservation
namespace SFT.InformationScience.MutualParts
open SFT.Foundation.ExactOperations
open SFT.Mathematics.DiscreteObjects

inductive ExactCell where
  | emptyOne
  | part : PositiveFraction → ExactCell

inductive Comparison where
  | emptyBelowProduct | equal | jointBelowProduct | jointAboveProduct
  deriving DecidableEq

def presentMembers : List String → List String
  | [] => ["empty-One"]
  | first :: rest => first :: rest

def countPart (whole : Nat) (positive : 0 < whole) : List String → ExactCell
  | [] => .emptyOne
  | first :: rest => .part (normalizePositive (rest.length+1) whole (Nat.zero_lt_succ _) positive)

def multiply (left right : PositiveFraction) : PositiveFraction :=
  normalizePositive (left.numerator*right.numerator) (left.denominator*right.denominator)
    (Nat.mul_pos left.positive right.positive)
    (Nat.mul_pos (Nat.pos_of_ne_zero left.denominatorNonzero) (Nat.pos_of_ne_zero right.denominatorNonzero))

def compare (joint : ExactCell) (product : PositiveFraction) : Comparison :=
  match joint with
  | .emptyOne => .emptyBelowProduct
  | .part held =>
    if held.numerator*product.denominator = product.numerator*held.denominator then .equal
    else if held.numerator*product.denominator < product.numerator*held.denominator then .jointBelowProduct
    else .jointAboveProduct

def comparisonName : Comparison → String
  | .emptyBelowProduct => "empty-One-below-product"
  | .equal => "equal"
  | .jointBelowProduct => "joint-below-product"
  | .jointAboveProduct => "joint-above-product"

theorem countEmpty (whole : Nat) (positive : 0 < whole) (members : List String) :
    countPart whole positive members = .emptyOne ↔ members = [] := by
  cases members with
  | nil => exact ⟨fun _ => rfl,fun _ => rfl⟩
  | cons first rest => constructor <;> intro h <;> cases h

theorem presentNonempty (members : List String) (nonempty : members ≠ []) : presentMembers members = members := by
  cases members with
  | nil => exact False.elim (nonempty rfl)
  | cons first rest => rfl

theorem countFraction (whole : Nat) (positive : 0 < whole) (members : List String) (part : PositiveFraction)
    (h : countPart whole positive members = .part part) :
    0 < members.length ∧ members.length*part.denominator = part.numerator*whole := by
  cases members with
  | nil => cases h
  | cons first rest =>
    have eq := ExactCell.part.inj h
    rw [← eq]
    exact ⟨Nat.zero_lt_succ _,normalizedValuePreserved _ _ _ _⟩

theorem countReduced (whole : Nat) (positive : 0 < whole) (members : List String) (part : PositiveFraction)
    (h : countPart whole positive members = .part part) :
    part.numerator.Coprime part.denominator ∧ 0 < part.numerator ∧ part.denominator ≠ 0 :=
  ⟨part.reduced,part.positive,part.denominatorNonzero⟩

theorem productFraction (left right : PositiveFraction) :
    (left.numerator*right.numerator)*(multiply left right).denominator =
      (multiply left right).numerator*(left.denominator*right.denominator) :=
  normalizedValuePreserved _ _ _ _

theorem productPositive (left right : PositiveFraction) : 0 < (multiply left right).numerator :=
  (multiply left right).positive

theorem compareEmpty (joint : ExactCell) (product : PositiveFraction) :
    compare joint product = .emptyBelowProduct ↔ joint = .emptyOne := by
  cases joint with
  | emptyOne => exact ⟨fun _ => rfl,fun _ => rfl⟩
  | part held =>
    change (if held.numerator*product.denominator = product.numerator*held.denominator then Comparison.equal
      else if held.numerator*product.denominator < product.numerator*held.denominator then Comparison.jointBelowProduct
      else Comparison.jointAboveProduct) = _ ↔ _
    split
    · constructor <;> intro h <;> cases h
    · split <;> constructor <;> intro h <;> cases h

theorem compareEqual (joint : ExactCell) (product : PositiveFraction) :
    compare joint product = .equal ↔ ∃ held, joint = .part held ∧
      held.numerator*product.denominator = product.numerator*held.denominator := by
  cases joint with
  | emptyOne =>
    constructor
    · intro h; cases h
    · intro ⟨held,h,_⟩; cases h
  | part held =>
    change (if held.numerator*product.denominator = product.numerator*held.denominator then Comparison.equal
      else if held.numerator*product.denominator < product.numerator*held.denominator then Comparison.jointBelowProduct
      else Comparison.jointAboveProduct) = _ ↔ _
    split
    · rename_i same
      constructor
      · intro _; exact ⟨held,rfl,same⟩
      · intro _; rfl
    · rename_i different
      constructor
      · intro h
        split at h <;> cases h
      · intro ⟨value,eq,same⟩
        have e := ExactCell.part.inj eq
        cases e; exact False.elim (different same)

theorem compareBelow (joint : ExactCell) (product : PositiveFraction) :
    compare joint product = .jointBelowProduct ↔ ∃ held, joint = .part held ∧
      held.numerator*product.denominator < product.numerator*held.denominator := by
  cases joint with
  | emptyOne =>
    constructor
    · intro h; cases h
    · intro ⟨held,h,_⟩; cases h
  | part held =>
    change (if held.numerator*product.denominator = product.numerator*held.denominator then Comparison.equal
      else if held.numerator*product.denominator < product.numerator*held.denominator then Comparison.jointBelowProduct
      else Comparison.jointAboveProduct) = _ ↔ _
    split
    · rename_i same
      constructor
      · intro h; cases h
      · intro ⟨value,eq,less⟩
        have e := ExactCell.part.inj eq
        cases e
        rw [same] at less; exact False.elim (Nat.lt_irrefl _ less)
    · split
      · rename_i less
        exact ⟨fun _ => ⟨held,rfl,less⟩,fun _ => rfl⟩
      · rename_i notLess
        constructor
        · intro h; cases h
        · intro ⟨value,eq,less⟩
          have e := ExactCell.part.inj eq
          cases e; exact False.elim (notLess less)

theorem compareAbove (joint : ExactCell) (product : PositiveFraction) :
    compare joint product = .jointAboveProduct ↔ ∃ held, joint = .part held ∧
      product.numerator*held.denominator < held.numerator*product.denominator := by
  cases joint with
  | emptyOne =>
    constructor
    · intro h; cases h
    · intro ⟨held,h,_⟩; cases h
  | part held =>
    change (if held.numerator*product.denominator = product.numerator*held.denominator then Comparison.equal
      else if held.numerator*product.denominator < product.numerator*held.denominator then Comparison.jointBelowProduct
      else Comparison.jointAboveProduct) = _ ↔ _
    split
    · rename_i same
      constructor
      · intro h; cases h
      · intro ⟨value,eq,greater⟩
        have e := ExactCell.part.inj eq
        cases e
        rw [same] at greater; exact False.elim (Nat.lt_irrefl _ greater)
    · rename_i different
      split
      · rename_i less
        constructor
        · intro h; cases h
        · intro ⟨value,eq,greater⟩
          have e := ExactCell.part.inj eq
          cases e; exact False.elim (Nat.lt_asymm less greater)
      · rename_i notLess
        constructor
        · intro _
          exact ⟨held,rfl,Nat.lt_of_le_of_ne (Nat.le_of_not_gt notLess) (fun eq => different eq.symm)⟩
        · intro _; rfl

end SFT.InformationScience.MutualParts
