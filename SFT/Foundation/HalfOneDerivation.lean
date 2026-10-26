import SFT.Foundation.ExactOperations
import SFT.Foundation.FoldDerivation

/-! half_one.py closure: the complete minimal Fold partition, label exchange,
unique self-junction coordinate, complement and Fold. -/
namespace SFT.Foundation.HalfOneDerivation
open ExactOperations ExactPartCarrier FractionReduction FoldDerivation
open Count.TraceDerivation Part.SelectionDerivation

def halfOne : ExactPartCarrier.Part := normalizePart 1 2 (by decide) (by decide)

def complement (p : ExactPartCarrier.Part) : Except String ExactPartCarrier.Part := takePart one p

theorem halfOneSource : fromPair 1 2 = .ok halfOne := rfl

theorem complementHalf : complement halfOne = .ok halfOne := rfl

theorem halfFoldsToOne : foldPart halfOne = one := by
  apply partEquality <;> rfl

theorem oneRemainsFixed : foldPart one = one := oneFoldFixed

theorem halfDifferentFromOne : halfOne ≠ one := by
  intro h
  have hd := congrArg ExactPartCarrier.Part.denominator h
  change (2 : Nat) = 1 at hd
  exact (by decide : (2 : Nat) ≠ 1) hd

theorem complementAndHalfTranslationDiffer : complement halfOne ≠ .ok (foldPart halfOne) := by
  rw [complementHalf,halfFoldsToOne]
  intro h
  exact halfDifferentFromOne (Except.ok.inj h)

theorem gcdSelfJunction (n : Nat) (hn : 0 < n) : Nat.gcd n (n+n) = n := by
  have nd : n ∣ n+n := ⟨2,by rw [Nat.mul_succ,Nat.mul_one]⟩
  have ng : n ∣ Nat.gcd n (n+n) :=
    commonDivisorDividesGcd n n (n+n) ⟨1,(Nat.mul_one n).symm⟩ nd
  exact Nat.le_antisymm (divisorBound _ n hn (gcdDivides n (n+n)).1)
    (divisorBound n _ (gcdPositive n (n+n) (Nat.add_pos_left hn n)) ng)

def selfJunction (p : ExactPartCarrier.Part) : PositiveFraction :=
  normalizePositive (p.numerator+p.numerator) p.denominator
    (Nat.add_pos_left p.positive _) (denominatorPositive p)

theorem selfJunctionOneIff (p : ExactPartCarrier.Part) :
    ((selfJunction p).numerator = 1 ∧ (selfJunction p).denominator = 1) ↔ p = halfOne := by
  constructor
  · intro h
    have pair := (normalizationOneIff _ _ _ _).mp h
    have reduced := p.reduced
    change Nat.gcd p.numerator p.denominator = 1 at reduced
    rw [← pair,gcdSelfJunction _ p.positive] at reduced
    have den : p.denominator = 2 := by rw [← pair,reduced]
    exact partEquality p halfOne reduced den
  · intro h
    cases h
    exact ⟨rfl,rfl⟩

def swap : Position firstExtension → Position firstExtension
  | .prior _ => .terminal
  | .terminal => .prior .base

theorem swapTwice (p : Position firstExtension) : swap (swap p) = p := by
  cases p with
  | prior p => cases p; rfl
  | terminal => rfl

def swappedHeld (held : Position firstExtension → Bool) : Position firstExtension → Bool :=
  fun p => held (swap p)

theorem selectionForms (held : Position firstExtension → Bool) :
    heldSelection firstExtension held = [] ∨
    heldSelection firstExtension held = [firstPosition] ∨
    heldSelection firstExtension held = [appendedPosition] ∨
    heldSelection firstExtension held = [firstPosition,appendedPosition] := by
  change select held [firstPosition,appendedPosition] = [] ∨
    select held [firstPosition,appendedPosition] = [firstPosition] ∨
    select held [firstPosition,appendedPosition] = [appendedPosition] ∨
    select held [firstPosition,appendedPosition] = [firstPosition,appendedPosition]
  cases ha : held firstPosition <;> cases hb : held appendedPosition
  all_goals dsimp only [select]; rw [ha,hb]
  · exact Or.inl rfl
  · exact Or.inr (Or.inr (Or.inl rfl))
  · exact Or.inr (Or.inl rfl)
  · exact Or.inr (Or.inr (Or.inr rfl))

theorem swappedLength (held : Position firstExtension → Bool) :
    (heldSelection firstExtension (swappedHeld held)).length = (heldSelection firstExtension held).length := by
  change (select (swappedHeld held) [firstPosition,appendedPosition]).length =
    (select held [firstPosition,appendedPosition]).length
  change (if held appendedPosition then
      firstPosition :: (if held firstPosition then [appendedPosition] else [])
    else (if held firstPosition then [appendedPosition] else [])).length =
    (if held firstPosition then
      firstPosition :: (if held appendedPosition then [appendedPosition] else [])
    else (if held appendedPosition then [appendedPosition] else [])).length
  cases ha : held firstPosition <;> cases hb : held appendedPosition <;> rfl

def selectionPart (held : Position firstExtension → Bool)
    (positive : 0 < (heldSelection firstExtension held).length) : ExactPartCarrier.Part :=
  normalizePart (heldSelection firstExtension held).length (complete firstExtension).length
    positive (heldCountCannotExceedWhole firstExtension held)

theorem properSelectionIsHalf (held : Position firstExtension → Bool)
    (positive : 0 < (heldSelection firstExtension held).length)
    (proper : (heldSelection firstExtension held).length < 2) :
    selectionPart held positive = halfOne := by
  have length : (heldSelection firstExtension held).length = 1 :=
    Nat.le_antisymm (Nat.le_of_lt_succ proper) positive
  apply partEquality
  · change (heldSelection firstExtension held).length / Nat.gcd (heldSelection firstExtension held).length 2 = 1
    rw [length]
    rfl
  · change 2 / Nat.gcd (heldSelection firstExtension held).length 2 = 2
    rw [length]
    rfl

theorem exchangePreservesCoordinate (held : Position firstExtension → Bool)
    (positive : 0 < (heldSelection firstExtension held).length)
    (swappedPositive : 0 < (heldSelection firstExtension (swappedHeld held)).length) :
    selectionPart (swappedHeld held) swappedPositive = selectionPart held positive := by
  apply partEquality
  · change (heldSelection firstExtension (swappedHeld held)).length /
      Nat.gcd (heldSelection firstExtension (swappedHeld held)).length 2 =
      (heldSelection firstExtension held).length / Nat.gcd (heldSelection firstExtension held).length 2
    rw [swappedLength]
  · change 2 / Nat.gcd (heldSelection firstExtension (swappedHeld held)).length 2 =
      2 / Nat.gcd (heldSelection firstExtension held).length 2
    rw [swappedLength]

theorem wholeSelectionIsOne (held : Position firstExtension → Bool)
    (positive : 0 < (heldSelection firstExtension held).length)
    (whole : (heldSelection firstExtension held).length = 2) : selectionPart held positive = one := by
  apply partEquality
  · change (heldSelection firstExtension held).length / Nat.gcd (heldSelection firstExtension held).length 2 = 1
    rw [whole]
    rfl
  · change 2 / Nat.gcd (heldSelection firstExtension held).length 2 = 1
    rw [whole]
    rfl

theorem nonemptySelectionClasses (held : Position firstExtension → Bool)
    (positive : 0 < (heldSelection firstExtension held).length) :
    selectionPart held positive = halfOne ∨ selectionPart held positive = one := by
  rcases selectionForms held with empty | first | second | both
  · rw [empty] at positive
    exact False.elim (Nat.not_lt_zero _ positive)
  · exact Or.inl (properSelectionIsHalf held positive (by rw [first]; decide))
  · exact Or.inl (properSelectionIsHalf held positive (by rw [second]; decide))
  · exact Or.inr (wholeSelectionIsOne held positive (by rw [both]; rfl))

theorem wholeIsNotHalf : one ≠ halfOne := fun h => halfDifferentFromOne h.symm

end SFT.Foundation.HalfOneDerivation
