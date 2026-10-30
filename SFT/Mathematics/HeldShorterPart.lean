import SFT.Mathematics.ExactRatioRelations
namespace SFT.Mathematics.HeldShorterPart
open SFT.Foundation.ExactOperations

/-- The side is retained as a label, never as a signed magnitude. -/
inductive Side where
 | first | second

structure HeldSeparation where
 side : Side
 first : PositiveFraction
 second : PositiveFraction

def noLonger (a b : PositiveFraction) : Prop :=
 a.numerator*b.denominator ≤ b.numerator*a.denominator

def shorter (h : HeldSeparation) : PositiveFraction :=
 if h.first.numerator*h.second.denominator ≤ h.second.numerator*h.first.denominator then h.first else h.second

def heldSide (h : HeldSeparation) : Side := h.side

theorem selectedFromGenerated (h : HeldSeparation) :
 shorter h=h.first ∨ shorter h=h.second := by
 unfold shorter
 split
 · exact Or.inl rfl
 · exact Or.inr rfl

theorem positiveSeparation (h : HeldSeparation) : 0<(shorter h).numerator :=
 (shorter h).positive

theorem shorterThanFirst (h : HeldSeparation) : noLonger (shorter h) h.first := by
 unfold shorter
 split
 · exact Nat.le_refl _
 · next hn => exact Nat.le_of_lt (Nat.lt_of_not_ge hn)

theorem shorterThanSecond (h : HeldSeparation) : noLonger (shorter h) h.second := by
 unfold shorter
 split
 · next he => exact he
 · exact Nat.le_refl _

theorem sideRetained (h : HeldSeparation) : heldSide h=h.side := rfl

theorem sideDoesNotChangeMagnitude (side : Side) (h : HeldSeparation) :
 shorter { h with side := side }=shorter h := rfl

theorem tiePreservesExactValue (h : HeldSeparation)
 (tie : h.first.numerator*h.second.denominator=h.second.numerator*h.first.denominator) :
 (shorter h).numerator*h.second.denominator=
 h.second.numerator*(shorter h).denominator := by
 unfold shorter
 split
 · exact tie
 · rfl

#print axioms Side
#print axioms HeldSeparation
#print axioms noLonger
#print axioms shorter
#print axioms heldSide
#print axioms selectedFromGenerated
#print axioms positiveSeparation
#print axioms shorterThanFirst
#print axioms shorterThanSecond
#print axioms sideRetained
#print axioms sideDoesNotChangeMagnitude
#print axioms tiePreservesExactValue
end SFT.Mathematics.HeldShorterPart
