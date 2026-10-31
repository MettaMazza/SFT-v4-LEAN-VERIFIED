import SFT.Physics.Calibration
namespace SFT.Physics.DimensionalConsistency
open SFT.Physics.DimensionComposition SFT.Physics.DimensionReferenceTransport

-- DIMENSIONAL_CONSISTENCY: every compared/joined path is checked; conversions
-- retain the original positive exact ratio and its reciprocal.
def allSame : List (Path × Path) → Bool
  | [] => true
  | pair :: rest => sameDimension pair.1 pair.2 && allSame rest

def Lawful (pairs : List (Path × Path)) : Prop :=
  ∀ pair, pair ∈ pairs → SameDimension pair.1 pair.2

theorem allSameSound (pairs : List (Path × Path))
    (passed : allSame pairs = true) : Lawful pairs := by
  induction pairs with
  | nil => intro pair member; cases member
  | cons head rest ih =>
    have both : sameDimension head.1 head.2 = true ∧ allSame rest = true :=
      by
        cases h : sameDimension head.1 head.2 <;> cases t : allSame rest
        all_goals first | exact ⟨rfl,rfl⟩ | (change _ && _ = true at passed; rw [h,t] at passed; cases passed)
    intro pair member
    cases member with
    | head => exact finiteComparisonSound _ _ both.1
    | tail _ member => exact ih both.2 pair member

theorem allSameComplete (pairs : List (Path × Path))
    (lawful : Lawful pairs) : allSame pairs = true := by
  induction pairs with
  | nil => rfl
  | cons head rest ih =>
    have first := finiteComparisonComplete _ _ (lawful head List.mem_cons_self)
    have tail : Lawful rest := fun pair member => lawful pair (List.mem_cons_of_mem head member)
    change sameDimension head.1 head.2 && allSame rest = true
    rw [first,ih tail]
    rfl

theorem finiteLawfulExactly (pairs : List (Path × Path)) :
    allSame pairs = true ↔ Lawful pairs :=
  ⟨allSameSound pairs,allSameComplete pairs⟩

theorem unlikePairRejected (pairs : List (Path × Path)) (pair : Path × Path)
    (member : pair ∈ pairs) (unlike : ¬ SameDimension pair.1 pair.2) :
    allSame pairs = false := by
  cases h : allSame pairs with
  | false => rfl
  | true => exact False.elim (unlike (allSameSound pairs h pair member))

theorem lawfulAppend (left right : List (Path × Path))
    (a : Lawful left) (b : Lawful right) : Lawful (left ++ right) := by
  induction left with
  | nil => exact b
  | cons head rest ih =>
    have first := a head List.mem_cons_self
    have tail : Lawful rest := fun pair member => a pair (List.mem_cons_of_mem head member)
    intro pair member
    cases member with
    | head => exact first
    | tail _ member => exact ih tail pair member

theorem everyConversionDimension {a b : Reference} (c : Comparison a b) :
    SameDimension a.dimension b.dimension := c.sameDimension

theorem inverseConversionDimension {a b : Reference} (c : Comparison a b) :
    SameDimension b.dimension a.dimension := (reverse c).sameDimension

theorem inverseConversionExact {a b : Reference} (c : Comparison a b) :
    (chain c (reverse c)).ratio.numerator = 1 ∧
    (chain c (reverse c)).ratio.denominator = 1 := reverseReturnsOne c

theorem conversionCompositionLawful {a b c : Reference}
    (ab : Comparison a b) (bc : Comparison b c) :
    sameDimension a.dimension c.dimension = true := composedComparisonPasses ab bc

theorem unlikeConversionExcluded (a b : Reference)
    (unlike : ¬ SameDimension a.dimension b.dimension) : Comparison a b → False :=
  fun c => unlike c.sameDimension

theorem calibrationEndpointLawful {a b : Reference}
    (p : SFT.Physics.Calibration.Chain a b) :
    sameDimension a.dimension b.dimension = true :=
  finiteComparisonComplete _ _ (SFT.Physics.Calibration.calibrationPreservesDimension p)
end SFT.Physics.DimensionalConsistency
