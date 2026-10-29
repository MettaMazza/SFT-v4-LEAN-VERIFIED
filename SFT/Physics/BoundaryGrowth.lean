import SFT.Physics.BoundarySupport
namespace SFT.Physics.BoundaryGrowth
open SFT.Foundation.ExactOperations SFT.Physics.GeneratorOperations
open SFT.Physics.FoldFirstReturn BoundarySupport

def multiply (left right : PositiveFraction) : PositiveFraction :=
 normalizePositive (left.numerator*right.numerator) (left.denominator*right.denominator)
   (Nat.mul_pos left.positive right.positive)
   (Nat.mul_pos (Nat.pos_of_ne_zero left.denominatorNonzero) (Nat.pos_of_ne_zero right.denominatorNonzero))

theorem multiplicationValue (left right : PositiveFraction) :
 (multiply left right).numerator * (left.denominator*right.denominator) =
   (left.numerator*right.numerator) * (multiply left right).denominator :=
 (normalizedValuePreserved _ _ (Nat.mul_pos left.positive right.positive)
   (Nat.mul_pos (Nat.pos_of_ne_zero left.denominatorNonzero) (Nat.pos_of_ne_zero right.denominatorNonzero))).symm

def repeatFrom (base : PositiveFraction) : Nat → PositiveFraction → PositiveFraction
 | 0,result => result
 | n+1,result => repeatFrom base n (multiply result base)

inductive ProductSteps (base : PositiveFraction) : Nat → PositiveFraction → PositiveFraction → Prop where
 | initial (value : PositiveFraction) : ProductSteps base 0 value value
 | next (count : Nat) (value result : PositiveFraction)
     (tail : ProductSteps base count (multiply value base) result) : ProductSteps base (count+1) value result

theorem nativeProductSteps (base : PositiveFraction) (count : Nat) (initial : PositiveFraction) :
 ProductSteps base count initial (repeatFrom base count initial) := by
 induction count generalizing initial with
 | zero => exact .initial _
 | succ count ih => exact .next _ _ _ (ih (multiply initial base))

def productTrace (base : PositiveFraction) : Nat → PositiveFraction → List PositiveFraction
 | 0,result => [result]
 | n+1,result => result :: productTrace base n (multiply result base)

theorem productTraceLength (base : PositiveFraction) (count : Nat) (initial : PositiveFraction) :
 (productTrace base count initial).length = count+1 := by
 induction count generalizing initial with
 | zero => rfl
 | succ count ih => exact congrArg Nat.succ (ih (multiply initial base))

theorem productComposition (base : PositiveFraction) (first second : Nat) (initial : PositiveFraction) :
 repeatFrom base (first+second) initial = repeatFrom base second (repeatFrom base first initial) := by
 induction first generalizing initial with
 | zero => rw [Nat.zero_add]; rfl
 | succ first ih => rw [Nat.succ_add]; exact ih (multiply initial base)

def admitPositive : Rat → Option PositiveFraction
 | ⟨.negSucc _,_,_,_⟩ => none
 | ⟨.ofNat n,d,hd,reduced⟩ =>
   if positive : 0 < n then some ⟨n,d,hd,reduced,positive⟩ else none

def asFraction (value : PositiveFraction) : Rat :=
 ⟨.ofNat value.numerator,value.denominator,value.denominatorNonzero,value.reduced⟩

theorem positiveRoundTrip (value : PositiveFraction) : admitPositive (asFraction value) = some value := by
 cases value
 unfold asFraction admitPositive
 dsimp only
 rw [dite_eq_left (by assumption)]

def checkedProduct (base : PositiveFraction) : CountInput → Except String PositiveFraction
 | .boolean _ => .error "ValueError: repeated product requires a positive count"
 | .integer (.negSucc _) => .error "ValueError: repeated product requires a positive count"
 | .integer (.ofNat 0) => .error "ValueError: repeated product requires a positive count"
 | .integer (.ofNat (n+1)) => .ok (repeatFrom base n base)

def repeatedPositiveProduct : Input → CountInput → Except String PositiveFraction
 | .nonFraction,_ => .error "ValueError: repeated product requires an exact positive part or ratio"
 | .fraction value,count => match admitPositive value with
   | none => .error "ValueError: repeated product requires an exact positive part or ratio"
   | some base => checkedProduct base count

def boundaryGrowth : Input → Except String PositiveFraction
 | .nonFraction => .error "ValueError: distance ratio must be exact and above the One"
 | .fraction value => match admitPositive value with
   | none => .error "ValueError: distance ratio must be exact and above the One"
   | some base => if base.denominator < base.numerator then do
       let rank ← boundaryRank
       checkedProduct base (.integer (.ofNat rank))
     else .error "ValueError: distance ratio must be exact and above the One"

theorem repeatedProductAdmitted (base : PositiveFraction) (count : Nat) :
 repeatedPositiveProduct (.fraction (asFraction base)) (.integer (.ofNat (count+1))) =
   .ok (repeatFrom base count base) := by
 unfold repeatedPositiveProduct
 dsimp only
 rw [positiveRoundTrip]
 rfl

theorem growthAdmitted (base : PositiveFraction) (aboveOne : base.denominator < base.numerator) :
 boundaryGrowth (.fraction (asFraction base)) = .ok (multiply base base) := by
 unfold boundaryGrowth
 dsimp only
 rw [positiveRoundTrip]
 dsimp only
 rw [ite_eq_left aboveOne,boundaryRankTwo]
 rfl

theorem growthBoundary (base : PositiveFraction) (notAbove : ¬ base.denominator < base.numerator) :
 boundaryGrowth (.fraction (asFraction base)) = .error "ValueError: distance ratio must be exact and above the One" := by
 unfold boundaryGrowth
 dsimp only
 rw [positiveRoundTrip]
 dsimp only
 rw [ite_eq_right notAbove]

theorem exactGrowthValue (base : PositiveFraction) :
 (multiply base base).numerator * (base.denominator*base.denominator) =
   (base.numerator*base.numerator) * (multiply base base).denominator := multiplicationValue base base

def two : PositiveFraction := normalizePositive 2 1 (by decide) (by decide)
def three : PositiveFraction := normalizePositive 3 1 (by decide) (by decide)

theorem doubledBoundary : ((multiply two two).numerator,(multiply two two).denominator) = (4,1) := rfl

theorem tripledBoundary : ((multiply three three).numerator,(multiply three three).denominator) = (9,1) := rfl

end SFT.Physics.BoundaryGrowth
