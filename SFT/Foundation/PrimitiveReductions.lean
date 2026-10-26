import SFT.Foundation.PrimitiveSquare
namespace SFT.Foundation.PrimitiveMaps
open ExactOperations ExactPartCarrier ExactValueIdentity

def productPart (left right : Part) : Part :=
  normalizePart (left.numerator*right.numerator) (left.denominator*right.denominator)
    (Nat.mul_pos left.positive right.positive) (Nat.mul_le_mul left.throughOne right.throughOne)

theorem productRightOne (p : Part) : productPart p one = p := by
  unfold productPart
  apply normalizedRepresents
  change (p.numerator*1)*p.denominator = p.numerator*(p.denominator*1)
  rw [Nat.mul_one,Nat.mul_one]

theorem productLeftOne (p : Part) : productPart one p = p := by
  unfold productPart
  apply normalizedRepresents
  change (1*p.numerator)*p.denominator = p.numerator*(1*p.denominator)
  rw [Nat.one_mul,Nat.one_mul]

theorem selfProductIsSquare (p : Part) : productPart p p = squarePart p := rfl

theorem selfJunctionCastIsFold (p : Part) :
    castPositive (HalfOneDerivation.selfJunction p) = applyPrimitive .fold p := rfl

theorem closedWholeCastsOne (p : PositiveFraction) (k : Nat)
    (whole : p.numerator = (k+1)*p.denominator) : castPositive p = one := by
  unfold castPositive
  apply normalizedRepresents
  change ExactCast.castNumerator p.numerator p.denominator * 1 = 1*p.denominator
  rw [whole,ExactCast.completeTurnsRetainOne k p.denominator (Nat.pos_of_ne_zero p.denominatorNonzero),
    Nat.mul_one,Nat.one_mul]

theorem rawOneSelfJunctionBeyondOne :
    (HalfOneDerivation.selfJunction one).denominator < (HalfOneDerivation.selfJunction one).numerator := by decide

theorem rawSelfJunctionNotTotal : ¬ (∀ p : Part,
    (HalfOneDerivation.selfJunction p).numerator ≤ (HalfOneDerivation.selfJunction p).denominator) := by
  intro all
  exact Nat.not_lt_of_ge (all one) rawOneSelfJunctionBeyondOne

theorem takeSelfRejected (p : Part) :
    takePart p p = .error "Take requires the first exact part to be strictly larger" :=
  takeRejected p p (Nat.lt_irrefl _)

theorem guardedRemovalNotTotal : ¬ (∀ left right : Part, ∃ result : Part, takePart left right = .ok result) := by
  intro all
  obtain ⟨result,accepted⟩ := all one one
  rw [takeSelfRejected] at accepted
  cases accepted

end SFT.Foundation.PrimitiveMaps
