import SFT.Physics.LeptonTerminal
namespace SFT.Physics.LeptonIntervals
open SFT.Foundation.ExactOperations
set_option maxRecDepth 20000

def zero : Rat := ⟨0,1,by decide,by decide⟩

def normalize (n : Int) (d : Nat) (positive : 0 < d) : Rat :=
 match n with
 | .ofNat 0 => zero
 | .ofNat (k+1) => BoundaryGrowth.asFraction (normalizePositive (k+1) d (Nat.zero_lt_succ _) positive)
 | .negSucc k =>
   let p := normalizePositive (k+1) d (Nat.zero_lt_succ _) positive
   ⟨-(Int.ofNat p.numerator),p.denominator,p.denominatorNonzero,by
     rw [Int.natAbs_neg]
     exact p.reduced⟩

def add (a b : Rat) : Rat :=
 normalize (a.num*Int.ofNat b.den+b.num*Int.ofNat a.den) (a.den*b.den)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.pos_of_ne_zero b.den_nz))

def subtract (a b : Rat) : Rat :=
 normalize (a.num*Int.ofNat b.den-b.num*Int.ofNat a.den) (a.den*b.den)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.pos_of_ne_zero b.den_nz))

def multiply (a b : Rat) : Rat :=
 normalize (a.num*b.num) (a.den*b.den)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.pos_of_ne_zero b.den_nz))

def cubic (value pairSum product : Rat) : Rat :=
 subtract (add (subtract (multiply (multiply value value) value) (multiply value value))
   (multiply pairSum value)) product

def half : Rat := ⟨1,2,by decide,by decide⟩

def midpoint (lower upper : Rat) : Rat := multiply (add lower upper) half

def bisectRoot (bracket : Rat × Rat) (pairSum product : Rat) : Rat × Rat :=
 let lower := bracket.1
 let upper := bracket.2
 if lower == upper then bracket else
 let mid := midpoint lower upper
 let atLower := cubic lower pairSum product
 let atMid := cubic mid pairSum product
 if atMid == zero then (mid,mid)
 else if (multiply atLower atMid).blt zero then (lower,mid)
 else (mid,upper)

theorem exactBracketRetained (point pairSum product : Rat) :
 bisectRoot (point,point) pairSum product = (point,point) := by
 unfold bisectRoot
 dsimp only
 rw [show (point == point) = true from beq_self_eq_true point]
 rfl

theorem midpointRootRetained (lower upper pairSum product : Rat)
 (different : (lower == upper) = false)
 (root : (cubic (midpoint lower upper) pairSum product == zero) = true) :
 bisectRoot (lower,upper) pairSum product = (midpoint lower upper,midpoint lower upper) := by
 unfold bisectRoot
 dsimp only
 rw [different,root]
 rfl

theorem oppositeSignRetainsLower (lower upper pairSum product : Rat)
 (different : (lower == upper) = false)
 (notRoot : (cubic (midpoint lower upper) pairSum product == zero) = false)
 (opposite : (multiply (cubic lower pairSum product)
   (cubic (midpoint lower upper) pairSum product)).blt zero = true) :
 bisectRoot (lower,upper) pairSum product = (lower,midpoint lower upper) := by
 unfold bisectRoot
 dsimp only
 rw [different,notRoot,opposite]
 rfl

theorem remainingSignRetainsUpper (lower upper pairSum product : Rat)
 (different : (lower == upper) = false)
 (notRoot : (cubic (midpoint lower upper) pairSum product == zero) = false)
 (notOpposite : (multiply (cubic lower pairSum product)
   (cubic (midpoint lower upper) pairSum product)).blt zero = false) :
 bisectRoot (lower,upper) pairSum product = (midpoint lower upper,upper) := by
 unfold bisectRoot
 dsimp only
 rw [different,notRoot,notOpposite]
 rfl

end SFT.Physics.LeptonIntervals
