import SFT.Foundation.FoldDynamics
namespace SFT.Foundation.PrimitiveMaps
open ExactOperations ExactPartCarrier

inductive Primitive where
  | identity | square | constantOne | fold

def primitiveName : Primitive → String
  | .identity => "identity"
  | .square => "square"
  | .constantOne => "constant-One"
  | .fold => "Fold"

def one : Part := normalizePart 1 1 (by decide) (by decide)

def squarePart (p : Part) : Part :=
  normalizePart (p.numerator*p.numerator) (p.denominator*p.denominator)
    (Nat.mul_pos p.positive p.positive) (Nat.mul_le_mul p.throughOne p.throughOne)

def applyPrimitive : Primitive → Part → Part
  | .identity, p => p
  | .square, p => squarePart p
  | .constantOne, _ => one
  | .fold, p => foldPart p

def primitive (name : String) : Except String (Part → Part) :=
  if SFT.Host.Text.equal name "identity" then .ok (applyPrimitive .identity) else
  if SFT.Host.Text.equal name "square" then .ok (applyPrimitive .square) else
  if SFT.Host.Text.equal name "constant-One" then .ok (applyPrimitive .constantOne) else
  if SFT.Host.Text.equal name "Fold" then .ok (applyPrimitive .fold) else
  .error "ValueError: unknown primitive map"

def applyWord : List Primitive → Part → Part
  | [], value => value
  | name::word, value => applyWord word (applyPrimitive name value)

def applyNamedWord : List String → Part → Except String Part
  | [], value => .ok value
  | name::word, value => (primitive name).bind (fun operation => applyNamedWord word (operation value))

theorem primitiveLookup (p : Primitive) : primitive (primitiveName p) = .ok (applyPrimitive p) := by
  cases p <;> rfl

theorem namedWordMatches (word : List Primitive) (value : Part) :
    applyNamedWord (word.map primitiveName) value = .ok (applyWord word value) := by
  induction word generalizing value with
  | nil => rfl
  | cons p ps ih =>
    change (primitive (primitiveName p)).bind _ = _
    rw [primitiveLookup]
    exact ih (applyPrimitive p value)

theorem wordAppend (first second : List Primitive) (value : Part) :
    applyWord (first ++ second) value = applyWord second (applyWord first value) := by
  induction first generalizing value with
  | nil => rfl
  | cons p ps ih => exact ih (applyPrimitive p value)

theorem identityStatic (value : Part) : applyPrimitive .identity value = value := rfl

theorem identityInjective (left right : Part)
    (h : applyPrimitive .identity left = applyPrimitive .identity right) : left = right := h

theorem constantCollapses (left right : Part) :
    applyPrimitive .constantOne left = applyPrimitive .constantOne right := rfl

theorem constantFixed : applyPrimitive .constantOne one = one := rfl

theorem squarePreservesValue (p : Part) :
    (p.numerator*p.numerator)*(squarePart p).denominator =
      (squarePart p).numerator*(p.denominator*p.denominator) :=
  normalizedValuePreserved _ _ (Nat.mul_pos p.positive p.positive)
    (Nat.mul_pos (denominatorPositive p) (denominatorPositive p))

theorem squarePositive (p : Part) : 0 < (squarePart p).numerator := (squarePart p).positive

theorem squareThroughOne (p : Part) : (squarePart p).numerator ≤ (squarePart p).denominator := (squarePart p).throughOne

theorem foldThird : applyPrimitive .fold FoldDynamics.third = FoldDynamics.twoThirds := FoldDynamics.thirdFoldsToTwoThirds

theorem foldTwoThirds : applyPrimitive .fold FoldDynamics.twoThirds = FoldDynamics.third := FoldDynamics.twoThirdsFoldsToThird

theorem foldNonstaticReturn : applyWord [.fold,.fold] FoldDynamics.third = FoldDynamics.third :=
  FoldDynamics.firstTwoCycle

theorem foldCycleNonstatic : applyPrimitive .fold FoldDynamics.third ≠ FoldDynamics.third := by
  rw [foldThird]
  intro eq
  exact FoldDynamics.thirdAndTwoThirdsDistinct eq.symm

theorem foldNoninjective : ∃ left right : Part, left ≠ right ∧
    applyPrimitive .fold left = applyPrimitive .fold right :=
  ⟨HalfOneDerivation.halfOne, ExactOperations.one, HalfOneDerivation.halfDifferentFromOne,
    HalfOneDerivation.halfFoldsToOne.trans HalfOneDerivation.oneRemainsFixed.symm⟩

theorem emptyWordPreserves (value : Part) : applyWord [] value = value := rfl

theorem unknownPrimitiveRejected (name : String)
    (hi : SFT.Host.Text.equal name "identity" = false)
    (hs : SFT.Host.Text.equal name "square" = false)
    (hc : SFT.Host.Text.equal name "constant-One" = false)
    (hf : SFT.Host.Text.equal name "Fold" = false) :
    primitive name = .error "ValueError: unknown primitive map" := by
  unfold primitive
  rw [hi,hs,hc,hf]
  rfl

end SFT.Foundation.PrimitiveMaps
