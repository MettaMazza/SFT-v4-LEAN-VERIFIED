import SFT.Mathematics.FiniteRefinement
import SFT.Mathematics.FiniteDifferenceBounds
import SFT.Mathematics.DyadicClosure
import SFT.Physics.LeptonRatios
namespace SFT.Mathematics.LimitComputations
open SFT.Physics.LeptonIntervals SFT.Physics.LeptonRatios

def whole (n : Nat) : Rat := normalize (.ofNat n) 1 (by decide)
def spacing (k : Nat) : Rat := normalize 1 (2^k) (Nat.pow_pos (by decide))
def square (x : Rat) : Rat := multiply x x
def cube (x : Rat) : Rat := multiply (multiply x x) x

def quadratic (k : Nat) : Except String Rat :=
 let h := spacing k
 divide (add (subtract (square (add (whole 1) h)) (whole 2))
   (square (subtract (whole 1) h))) (square h)

def cubic (k : Nat) : Except String Rat :=
 let h := spacing k
 divide (add (subtract (cube (add (whole 1) (multiply (whole 2) h)))
   (multiply (whole 2) (cube (add (whole 1) h)))) (whole 1)) (square h)

def cubicError (k : Nat) : Rat :=
 normalize 6 (2^k) (Nat.pow_pos (by decide))

def equalNonnegative (n : Nat) : Int → Bool
 | .ofNat m => n==m
 | .negSucc _ => false

def equalNegative (n : Nat) : Int → Bool
 | .ofNat _ => false
 | .negSucc m => n==m

def equalInt (a b : Int) : Bool :=
 match a with
 | .ofNat n => equalNonnegative n b
 | .negSucc n => equalNegative n b

def equalRat (a b : Rat) : Bool := equalInt a.num b.num && a.den==b.den

def terms (n : Nat) : List Rat := (List.range n).map (fun i => spacing (i+1))
def ledger (n : Nat) : Rat := add ((terms n).foldl add (whole 0)) (spacing n)

def finiteRungs : Bool := (List.range 14).all (fun i => match (spacing (i+1)).num with
 | .ofNat n => decide (0<n)
 | .negSucc _ => false)
def quadraticWitness : Bool := (List.range 10).all (fun i => match quadratic (i+1) with
 | .ok value => equalRat value (whole 2)
 | .error _ => false)
def cubicWitness : Bool := (List.range 9).all (fun i =>
 equalRat (multiply (cubicError (i+2)) (whole 2)) (cubicError (i+1)))
def closureWitness : Bool := equalRat (ledger 5) (whole 1)

theorem finiteRungsPassed : finiteRungs=true := rfl
theorem quadraticPassed : quadraticWitness=true := rfl
theorem cubicPassed : cubicWitness=true := rfl
theorem closurePassed : closureWitness=true := rfl

#print axioms whole
#print axioms spacing
#print axioms square
#print axioms cube
#print axioms quadratic
#print axioms cubic
#print axioms cubicError
#print axioms equalNonnegative
#print axioms equalNegative
#print axioms equalInt
#print axioms equalRat
#print axioms terms
#print axioms ledger
#print axioms finiteRungs
#print axioms quadraticWitness
#print axioms cubicWitness
#print axioms closureWitness
#print axioms finiteRungsPassed
#print axioms quadraticPassed
#print axioms cubicPassed
#print axioms closurePassed
end SFT.Mathematics.LimitComputations
