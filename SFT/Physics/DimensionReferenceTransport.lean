import SFT.Physics.DimensionComposition
import SFT.Mathematics.ExactRatioRelations
namespace SFT.Physics.DimensionReferenceTransport
open SFT.Physics.DimensionComposition SFT.Foundation.ExactOperations
open SFT.Mathematics.ExactRatioRelations

-- UNIT_COMPARISON's same-dimension reference pairing instantiated by the
-- generated finite product/quotient forms, not syntactic path equality.
structure Reference where
  name : String
  dimension : Path

structure Comparison (a b : Reference) where
  sameDimension : SameDimension a.dimension b.dimension
  ratio : PositiveFraction

def reverse {a b : Reference} (ab : Comparison a b) : Comparison b a :=
  ⟨sameSymmetric _ _ ab.sameDimension,reciprocal ab.ratio⟩

def chain {a b c : Reference} (ab : Comparison a b) (bc : Comparison b c) :
    Comparison a c :=
  ⟨sameTransitive _ _ _ ab.sameDimension bc.sameDimension,compose ab.ratio bc.ratio⟩

def fromFiniteComparison (a b : Reference)
    (passed : sameDimension a.dimension b.dimension = true)
    (ratio : PositiveFraction) : Comparison a b :=
  ⟨finiteComparisonSound _ _ passed,ratio⟩

theorem everyComparisonPasses {a b : Reference} (ab : Comparison a b) :
    sameDimension a.dimension b.dimension = true :=
  finiteComparisonComplete _ _ ab.sameDimension

theorem rejectedFormsExcluded (a b : Reference)
    (rejected : sameDimension a.dimension b.dimension = false) :
    Comparison a b → False := by
  intro ab
  have passed := everyComparisonPasses ab
  rw [rejected] at passed
  cases passed

theorem ratioCannotChangeDimension {a b : Reference}
    (ab : Comparison a b) (newRatio : PositiveFraction) :
    SameDimension a.dimension b.dimension :=
  (⟨ab.sameDimension,newRatio⟩ : Comparison a b).sameDimension

theorem finiteAdmissionRetainsRatio (a b : Reference)
    (passed : sameDimension a.dimension b.dimension = true)
    (x : PositiveFraction) :
    (fromFiniteComparison a b passed x).ratio = x := rfl

theorem reversedComparisonPasses {a b : Reference} (ab : Comparison a b) :
    sameDimension b.dimension a.dimension = true :=
  everyComparisonPasses (reverse ab)

theorem composedComparisonPasses {a b c : Reference}
    (ab : Comparison a b) (bc : Comparison b c) :
    sameDimension a.dimension c.dimension = true :=
  everyComparisonPasses (chain ab bc)

theorem composedValue {a b c : Reference}
    (ab : Comparison a b) (bc : Comparison b c) :
    (ab.ratio.numerator*bc.ratio.numerator)*(chain ab bc).ratio.denominator =
      (chain ab bc).ratio.numerator*(ab.ratio.denominator*bc.ratio.denominator) :=
  composeValue ab.ratio bc.ratio

theorem reverseReturnsOne {a b : Reference} (ab : Comparison a b) :
    (chain ab (reverse ab)).ratio.numerator = 1 ∧
    (chain ab (reverse ab)).ratio.denominator = 1 :=
  reciprocalReturnsOne ab.ratio

theorem comparisonPositive {a b : Reference} (ab : Comparison a b) :
    0 < ab.ratio.numerator := ab.ratio.positive

def compositeDescriptionsAdmitted (nameA nameB : String) (p q : Path)
    (x : PositiveFraction) :
    Comparison ⟨nameA,.product p q⟩ ⟨nameB,.product q p⟩ :=
  ⟨productCommutes p q,x⟩

def cancelledDescriptionsAdmitted (nameA nameB : String) (p q : Path)
    (x : PositiveFraction) :
    Comparison ⟨nameA,.quotient (.product p q) q⟩ ⟨nameB,p⟩ :=
  ⟨sharedProductCancellation p q,x⟩

end SFT.Physics.DimensionReferenceTransport
