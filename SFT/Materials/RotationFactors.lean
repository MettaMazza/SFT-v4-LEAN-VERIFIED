import SFT.Materials.CubicCoordinationProofs
namespace SFT.Materials.RotationFactors
open SFT.Foundation.FractionReduction

theorem dividesFromRemainder (r d : Nat) (hd : 0 < d) (exactDivision : r%d=0) : d ∣ r := by
 have split := remainderQuotient r d hd
 rw [exactDivision,Nat.zero_add] at split
 exact ⟨r/d,split.symm⟩

theorem quotientSmaller (r d : Nat) (hr : 0 < r) (hd : 1 < d)
 (exactDivision : r%d=0) : r/d < r := by
 have posd : 0 < d := Nat.lt_trans (by decide : 0<1) hd
 have divides := dividesFromRemainder r d posd exactDivision
 have positive := quotientPositive r d hr posd divides
 have factor := quotientFactor r d posd divides
 have bound := Nat.mul_le_mul_right (r/d) hd
 change (1+1)*(r/d) ≤ d*(r/d) at bound
 rw [Nat.succ_mul,Nat.one_mul] at bound
 have smaller : r/d < d*(r/d) := Nat.lt_of_lt_of_le (Nat.lt_add_of_pos_left positive) bound
 exact Nat.lt_of_lt_of_le smaller (Nat.le_of_eq factor.symm)

def strip (r d : Nat) (hr : 0 < r) (hd : 1 < d) : {out : Nat // 0 < out ∧ out ≤ r} :=
 if h : r%d=0 then
   let divides := dividesFromRemainder r d (Nat.lt_trans (by decide) hd) h
   let result := strip (r/d) d (quotientPositive r d hr (Nat.lt_trans (by decide) hd) divides) hd
   ⟨result.val,result.property.1,Nat.le_trans result.property.2 (Nat.le_of_lt (quotientSmaller r d hr hd h))⟩
 else ⟨r,hr,Nat.le_refl r⟩
termination_by r
decreasing_by exact quotientSmaller r d hr hd h

theorem divisorWithin (r d : Nat) (hd : 1 < d) (bound : d*d ≤ r) : d ≤ r := by
 have h := Nat.mul_le_mul_left d (Nat.le_of_lt hd)
 rw [Nat.mul_one] at h
 exact Nat.le_trans h bound

theorem measureDecreases (r out d : Nat) (smaller : out ≤ r) (bound : d ≤ r) :
 out+1-(d+1) < r+1-d := by
 induction d generalizing r out with
 | zero => exact Nat.lt_succ_of_le smaller
 | succ d ih =>
   cases r with
   | zero => exact False.elim (Nat.not_succ_le_zero _ bound)
   | succ r =>
     have bd := Nat.le_of_succ_le_succ bound
     cases out with
     | zero =>
       have h := ih r 0 (Nat.zero_le _) bd
       simpa only [Nat.succ_sub_succ_eq_sub,Nat.zero_sub] using h
     | succ out =>
       simpa only [Nat.succ_sub_succ_eq_sub] using ih r out (Nat.le_of_succ_le_succ smaller) bd

def factorLoop (r d : Nat) (hr : 0 < r) (hd : 1 < d) : List Nat :=
 if bound : d*d ≤ r then
   if divides : r%d=0 then
     let reduced := strip r d hr hd
     d :: factorLoop reduced.val (d+1) reduced.property.1 (Nat.lt_trans hd (Nat.lt_succ_self d))
   else factorLoop r (d+1) hr (Nat.lt_trans hd (Nat.lt_succ_self d))
 else if 1 < r then [r] else []
termination_by r+1-d
decreasing_by
 · exact measureDecreases r (strip r d hr hd).val d (strip r d hr hd).property.2 (divisorWithin r d hd bound)
 · exact measureDecreases r r d (Nat.le_refl _) (divisorWithin r d hd bound)

inductive FactorInput where
 | integer : Int → FactorInput
 | boolean : Bool → FactorInput
 | other : FactorInput

def positivePrimeFactors : FactorInput → Except String (List Nat)
 | .integer (.ofNat (n+1)) => .ok (factorLoop (n+1) 2 (Nat.zero_lt_succ _) (by decide))
 | .integer (.ofNat 0) => .error "factor support requires a positive whole"
 | .integer (.negSucc _) => .error "factor support requires a positive whole"
 | .boolean _ => .error "factor support requires a positive whole"
 | .other => .error "factor support requires a positive whole"

theorem booleanRejected (b : Bool) : positivePrimeFactors (.boolean b) =
 .error "factor support requires a positive whole" := rfl

theorem otherRejected : positivePrimeFactors .other =
 .error "factor support requires a positive whole" := rfl

theorem zeroRejected : positivePrimeFactors (.integer (.ofNat 0)) =
 .error "factor support requires a positive whole" := rfl

theorem negativeRejected (n : Nat) : positivePrimeFactors (.integer (.negSucc n)) =
 .error "factor support requires a positive whole" := rfl

end SFT.Materials.RotationFactors
