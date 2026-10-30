import SFT.Mathematics.FiniteDifferenceBounds
namespace SFT.Mathematics.DyadicClosure
open SFT.Foundation.ExactOperations
open FiniteDifferenceBounds

/-- Complete source-ordered dyadic terms expressed at their common
finite denominator. Doubling retains every preceding term. -/
def weights : Nat → List Nat
 | 0 => []
 | n+1 => (weights n).map (fun x => x+x) ++ [1]

def total : List Nat → Nat
 | [] => 0
 | x::xs => x+total xs

theorem totalAppend (xs ys : List Nat) : total (xs++ys)=total xs+total ys := by
 induction xs with
 | nil => exact (Nat.zero_add _).symm
 | cons x xs ih =>
  change x+total (xs++ys)=(x+total xs)+total ys
  rw [ih,Nat.add_assoc]

theorem totalDouble (xs : List Nat) : total (xs.map (fun x => x+x))=total xs+total xs := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change (x+x)+total (xs.map (fun x => x+x))=(x+total xs)+(x+total xs)
  rw [ih]
  conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
  conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]

theorem weightSuccessor (n : Nat) : total (weights (n+1))=(total (weights n)+total (weights n))+1 := by
 change total ((weights n).map (fun x => x+x) ++ [1])=_
 rw [totalAppend,totalDouble]
 rfl

theorem completeLedger (n : Nat) : total (weights n)+1=2^n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  rw [weightSuccessor,dyadicDenominatorStep]
  have h : (total (weights n)+total (weights n))+1+1=
   (total (weights n)+1)+(total (weights n)+1) := by
   conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
   conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
  rw [h,ih]

def closedLedger (n : Nat) : PositiveFraction :=
 normalizePositive (total (weights n)+1) (2^n) (Nat.zero_lt_succ _) (Nat.pow_pos (by decide))

theorem closesToOne (n : Nat) : (closedLedger n).numerator=1 ∧ (closedLedger n).denominator=1 :=
 (normalizationOneIff _ _ _ _).mpr (completeLedger n)

theorem originalFiveTerms : weights 5=[16,8,4,2,1] := rfl

theorem originalClosure : (closedLedger 5).numerator=1 ∧ (closedLedger 5).denominator=1 := closesToOne 5

#print axioms weights
#print axioms total
#print axioms totalAppend
#print axioms totalDouble
#print axioms weightSuccessor
#print axioms completeLedger
#print axioms closedLedger
#print axioms closesToOne
#print axioms originalFiveTerms
#print axioms originalClosure
end SFT.Mathematics.DyadicClosure
