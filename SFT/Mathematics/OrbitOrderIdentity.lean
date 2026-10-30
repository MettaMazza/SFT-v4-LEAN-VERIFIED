import SFT.Foundation.ExactValueIdentity
namespace SFT.Mathematics.OrbitOrderIdentity
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity

/-- Cancellation used by V3's reduced-rank return derivation. -/
theorem cancelReducedFactor (p q n : Nat) (hq : 0 < q)
 (reduced : Nat.gcd p q = 1) (divides : q ∣ p*n) : q ∣ n := by
 cases n with
 | zero => exact ⟨0,rfl⟩
 | succ n =>
   have left : q ∣ (n+1)*p := by rw [Nat.mul_comm]; exact divides
   have right : q ∣ (n+1)*q := ⟨n+1,Nat.mul_comm _ _⟩
   have common := commonDivisorDividesGcd q ((n+1)*p) ((n+1)*q) left right
   rw [gcdScale (n+1) p q (Nat.zero_lt_succ _),reduced,Nat.mul_one] at common
   exact common

theorem subtractCommonLeft (r a b : Nat) : (r+a)-(r+b) = a-b := by
 rw [Nat.add_comm r a,Nat.add_comm r b]
 exact addSubtractSame a b r

theorem equalRemainderDividesDifference (a b q : Nat) (hq : 0 < q)
 (same : a%q = b%q) : q ∣ a-b := by
 have aSplit := remainderQuotient a q hq
 have bSplit := remainderQuotient b q hq
 rw [same] at aSplit
 have difference : a-b = q*(a/q-b/q) := by
   calc
     a-b = ((b%q)+q*(a/q))-((b%q)+q*(b/q)) := (congrArg (fun x => x-b) aSplit.symm).trans (congrArg (fun x => ((b%q)+q*(a/q))-x) bSplit.symm)
     _ = q*(a/q)-q*(b/q) := subtractCommonLeft _ _ _
     _ = q*(a/q-b/q) := mulSubtract _ _ _
 exact ⟨a/q-b/q,difference⟩

theorem moduloAddMultiple (n q k : Nat) (hq : 0 < q) :
 (n+q*k)%q = n%q := by
 induction k with
 | zero => rw [Nat.mul_zero,Nat.add_zero]
 | succ k ih =>
   rw [Nat.mul_succ,← Nat.add_assoc]
   have bound : q ≤ n+q*k+q := Nat.le_add_left q (n+q*k)
   rw [moduloRemoves _ q hq bound]
   have sub : (n+q*k+q)-q = n+q*k := by
     have h := addSubtractSame (n+q*k) 0 q
     rw [Nat.zero_add,Nat.sub_zero] at h
     exact h
   rw [sub]
   exact ih

theorem reducedReturnForward (p q power : Nat) (hq : 0 < q)
 (reduced : Nat.gcd p q = 1) (same : (p*power)%q = p%q) : q ∣ power-1 := by
 have difference := equalRemainderDividesDifference (p*power) p q hq same
 have identity : p*power-p = p*(power-1) := by
   have h := mulSubtract p power 1
   rw [Nat.mul_one] at h
   exact h
 rw [identity] at difference
 exact cancelReducedFactor p q (power-1) hq reduced difference

theorem multiplyMinusOneReturn (p q power : Nat) (hq : 0 < q)
 (positive : 0 < power) (divides : q ∣ power-1) : (p*power)%q = p%q := by
 obtain ⟨k,hk⟩ := divides
 have powerForm : power = q*k+1 := hk ▸ (subtractAdd power 1 positive).symm
 have commute : p*(q*k) = q*(p*k) :=
   (mulAssoc p q k).symm.trans ((congrArg (fun x => x*k) (Nat.mul_comm p q)).trans (mulAssoc q p k))
 rw [powerForm,Nat.mul_add,Nat.mul_one,commute,Nat.add_comm]
 exact moduloAddMultiple p q (p*k) hq

/-- The exact cancellation in the source derivation, for every supplied
reduced numerator and positive power, rather than a bounded prime table. -/
theorem reducedReturnIffOrder (p q power : Nat) (hq : 0 < q)
 (reduced : Nat.gcd p q = 1) (positive : 0 < power) :
 (p*power)%q = p%q ↔ power%q = 1%q := by
 constructor
 · intro returned
   have divides := reducedReturnForward p q power hq reduced returned
   have single := multiplyMinusOneReturn 1 q power hq positive divides
   rw [Nat.one_mul] at single
   exact single
 · intro order
   exact multiplyMinusOneReturn p q power hq positive
     (equalRemainderDividesDifference power 1 q hq order)

theorem binaryReturnIffOrder (p q k : Nat) (hq : 0 < q)
 (reduced : Nat.gcd p q = 1) :
 (p*2^k)%q = p%q ↔ (2^k)%q = 1%q :=
 reducedReturnIffOrder p q (2^k) hq reduced (Nat.pow_pos (by decide))

theorem addMul (a b c : Nat) : (a+b)*c = a*c+b*c := by
 rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]

theorem moduloMulReduce (a b q : Nat) (hq : 0 < q) :
 ((a%q)*b)%q = (a*b)%q := by
 have split := congrArg (fun x => x*b) (remainderQuotient a q hq)
 rw [addMul,mulAssoc] at split
 exact (moduloAddMultiple ((a%q)*b) q ((a/q)*b) hq).symm.trans
   (congrArg (fun x => x%q) split)

def foldRank (rank denominator : Nat) : Nat :=
 let remainder := (rank*2)%denominator
 if remainder = 0 then denominator else remainder

def rankIterate (rank denominator : Nat) : Nat → Nat
 | 0 => rank
 | k+1 => foldRank (rankIterate rank denominator k) denominator

theorem moduloSelf (q : Nat) (hq : 0 < q) : q%q = 0 := by
 rw [moduloRemoves q q hq (Nat.le_refl q),Nat.sub_self]
 exact moduloBelow 0 q hq hq

theorem foldRankResidue (p q : Nat) (hq : 0 < q) :
 (foldRank p q)%q = (p*2)%q := by
 unfold foldRank
 by_cases empty : (p*2)%q = 0
 · rw [ite_eq_left empty,moduloSelf q hq,empty]
 · rw [ite_eq_right empty]
   exact moduloBelow ((p*2)%q) q hq (Nat.mod_lt _ hq)

/-- Actual repeated double-and-cast execution has the source binary-power
remainder at every supplied finite depth. -/
theorem iterationRemainder (p q k : Nat) (hq : 0 < q) :
 (rankIterate p q k)%q = (p*2^k)%q := by
 induction k with
 | zero => rw [Nat.pow_zero,Nat.mul_one]; rfl
 | succ k ih =>
   change (foldRank (rankIterate p q k) q)%q = _
   rw [foldRankResidue _ q hq,← moduloMulReduce (rankIterate p q k) 2 q hq,ih,
     moduloMulReduce (p*2^k) 2 q hq,mulAssoc,Nat.pow_succ]

theorem executedReturnIffOrder (p q k : Nat) (hq : 0 < q)
 (reduced : Nat.gcd p q = 1) :
 (rankIterate p q k)%q = p%q ↔ (2^k)%q = 1%q := by
 rw [iterationRemainder p q k hq]
 exact binaryReturnIffOrder p q k hq reduced

def FirstReducedReturn (p q k : Nat) : Prop :=
 0 < k ∧ (rankIterate p q k)%q = p%q ∧
 ∀ j, 0 < j → j < k → (rankIterate p q j)%q ≠ p%q

def FirstBinaryOrder (q k : Nat) : Prop :=
 0 < k ∧ (2^k)%q = 1%q ∧ ∀ j, 0 < j → j < k → (2^j)%q ≠ 1%q

theorem firstReturnIffFirstOrder (p q k : Nat) (hq : 0 < q)
 (reduced : Nat.gcd p q = 1) : FirstReducedReturn p q k ↔ FirstBinaryOrder q k := by
 constructor
 · intro h
   refine ⟨h.1,(executedReturnIffOrder p q k hq reduced).mp h.2.1,?_⟩
   intro j positive before earlier
   exact h.2.2 j positive before ((executedReturnIffOrder p q j hq reduced).mpr earlier)
 · intro h
   refine ⟨h.1,(executedReturnIffOrder p q k hq reduced).mpr h.2.1,?_⟩
   intro j positive before earlier
   exact h.2.2 j positive before ((executedReturnIffOrder p q j hq reduced).mp earlier)

def heldRemainder (r q : Nat) : Nat := if r = 0 then q else r

theorem heldRemainderRecovers (p q : Nat) (positive : 0 < p) (bound : p ≤ q) :
 heldRemainder (p%q) q = p := by
 have hq := Nat.lt_of_lt_of_le positive bound
 by_cases below : p < q
 · rw [moduloBelow p q hq below]
   exact ite_eq_right (Nat.ne_of_gt positive)
 · have eq : p = q := Nat.le_antisymm bound (Nat.le_of_not_gt below)
   cases eq
   rw [moduloSelf p positive]
   rfl

theorem heldRemainderInjective (p r q : Nat) (pp : 0 < p) (rp : 0 < r)
 (pb : p ≤ q) (rb : r ≤ q) (same : p%q = r%q) : p = r :=
 (heldRemainderRecovers p q pp pb).symm.trans
 ((congrArg (fun x => heldRemainder x q) same).trans (heldRemainderRecovers r q rp rb))

theorem foldRankBounds (p q : Nat) (hq : 0 < q) : 0 < foldRank p q ∧ foldRank p q ≤ q := by
 unfold foldRank
 by_cases empty : (p*2)%q = 0
 · rw [ite_eq_left empty]
   exact ⟨hq,Nat.le_refl q⟩
 · rw [ite_eq_right empty]
   exact ⟨Nat.pos_of_ne_zero empty,Nat.le_of_lt (Nat.mod_lt _ hq)⟩

theorem iterateBounds (p q k : Nat) (positive : 0 < p) (bound : p ≤ q) :
 0 < rankIterate p q k ∧ rankIterate p q k ≤ q := by
 cases k with
 | zero => exact ⟨positive,bound⟩
 | succ k => exact foldRankBounds _ q (Nat.lt_of_lt_of_le positive bound)

/-- Exact held-rank return, including the source cast of a zero remainder to
its complete denominator, is equivalent to the binary order predicate. -/
theorem exactExecutedReturnIffOrder (p q k : Nat) (positive : 0 < p) (bound : p ≤ q)
 (reduced : Nat.gcd p q = 1) : rankIterate p q k = p ↔ (2^k)%q = 1%q := by
 have hq := Nat.lt_of_lt_of_le positive bound
 constructor
 · intro returned
   exact (executedReturnIffOrder p q k hq reduced).mp (congrArg (fun x => x%q) returned)
 · intro order
   have bounds := iterateBounds p q k positive bound
   exact heldRemainderInjective _ p q bounds.1 positive bounds.2 bound
     ((executedReturnIffOrder p q k hq reduced).mpr order)

end SFT.Mathematics.OrbitOrderIdentity
