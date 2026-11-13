import SFT.Mathematics.AlgebraicBalance
namespace SFT.Mathematics.AlgebraicSeparation
open AlgebraicBalance SFT.Foundation.ExactOperations

-- lineage_laws.py: signed magnitude is held orientation, with positive terms
-- retained on the corresponding side of the balance.
inductive Side where | left | right
structure HeldTerm where
 side : Side
 term : Term

def separate : List HeldTerm → List Term × List Term
 | [] => ([],[])
 | ⟨.left,t⟩::rest => let sides := separate rest; (t::sides.1,sides.2)
 | ⟨.right,t⟩::rest => let sides := separate rest; (sides.1,t::sides.2)

def evaluateHeld (x : PositiveFraction) : List HeldTerm → List PositiveFraction × List PositiveFraction
 | [] => ([],[])
 | ⟨.left,t⟩::rest => let values := evaluateHeld x rest; (termValue t x::values.1,values.2)
 | ⟨.right,t⟩::rest => let values := evaluateHeld x rest; (values.1,termValue t x::values.2)

def evaluateSeparated (held : List HeldTerm) (x : PositiveFraction) :=
 let sides := separate held
 (sides.1.map (fun t => termValue t x),sides.2.map (fun t => termValue t x))

theorem separationPreservesEveryValue (held : List HeldTerm) (x : PositiveFraction) :
 evaluateSeparated held x = evaluateHeld x held := by
 induction held with
 | nil => rfl
 | cons h rest ih =>
   cases h with
   | mk side t =>
     cases side with
     | left => exact congrArg (fun sides => (termValue t x::sides.1,sides.2)) ih
     | right => exact congrArg (fun sides => (sides.1,termValue t x::sides.2)) ih

-- none records an absent side in the term bookkeeping; it is not a numerical
-- zero or an admitted scalar. A polynomial side itself retains its first term.
def positiveTotal : List PositiveFraction → Option PositiveFraction
 | [] => none
 | first::rest => some (rest.foldl positiveAdd first)

def sideTotals (values : List PositiveFraction × List PositiveFraction) :=
 (positiveTotal values.1,positiveTotal values.2)

theorem separationPreservesBalance (held : List HeldTerm) (x left right : PositiveFraction) :
 sideTotals (evaluateHeld x held) = (some left,some right) ↔
 sideTotals (evaluateSeparated held x) = (some left,some right) := by
 rw [separationPreservesEveryValue]

def sourceRoots : List PositiveFraction :=
 [normalizePositive 1 2 (by decide) (by decide),
  normalizePositive 1 3 (by decide) (by decide),
  normalizePositive 1 6 (by decide) (by decide)]

def sourceRootSum : PositiveFraction :=
 positiveAdd (positiveAdd sourceRoots[0] sourceRoots[1]) sourceRoots[2]

def sourceRootPairs : PositiveFraction :=
 positiveAdd (positiveAdd
  (ExactRatioRelations.compose sourceRoots[0] sourceRoots[1])
  (ExactRatioRelations.compose sourceRoots[0] sourceRoots[2]))
  (ExactRatioRelations.compose sourceRoots[1] sourceRoots[2])

def sourceRootProduct : PositiveFraction :=
 ExactRatioRelations.compose (ExactRatioRelations.compose sourceRoots[0] sourceRoots[1]) sourceRoots[2]

def sourceVietaSides : Sides :=
 ⟨⟨⟨normalizePositive 1 1 (by decide) (by decide),3⟩,[⟨sourceRootPairs,1⟩]⟩,
  ⟨⟨sourceRootSum,2⟩,[⟨sourceRootProduct,0⟩]⟩⟩

theorem coefficientSum : sourceRootSum.numerator = 1 ∧ sourceRootSum.denominator = 1 := ⟨rfl,rfl⟩
theorem coefficientPairs : sourceRootPairs.numerator = 11 ∧ sourceRootPairs.denominator = 36 := ⟨rfl,rfl⟩

theorem sourceRootsBalance : sourceRoots.map (sideOrder sourceVietaSides) = [.eq,.eq,.eq] := rfl

theorem coefficientProduct : sourceRootProduct.numerator = 1 ∧ sourceRootProduct.denominator = 36 := by
 exact ⟨rfl,rfl⟩
end SFT.Mathematics.AlgebraicSeparation
