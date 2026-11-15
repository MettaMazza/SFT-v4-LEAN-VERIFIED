import SFT.Physics.FoldUniverseTransportComposition
import SFT.Mathematics.BoundedFoldTuple
namespace SFT.Physics.FoldUniverseTransportPeriod
open FoldUniverseTransportComposition
open SFT.Mathematics.OrbitOrderIdentity SFT.Mathematics.OrbitBinaryDepth
open SFT.Mathematics.BoundedFoldTuple SFT.Mathematics.LeastCommonReturn
open SFT.Foundation.ExactValueIdentity
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- Composite binary recurrence is exactly simultaneous component recurrence. -/
theorem originalCompositeReturn (m n k : Nat) (hm : 1<m) (hn : 1<n)
 (coprime : Nat.gcd m n=1) :
 (2^k)%(m*n)=1 ↔ (2^k)%m=1 ∧ (2^k)%n=1 := by
 have pm := Nat.lt_trans (Nat.zero_lt_succ 0) hm
 have pn := Nat.lt_trans (Nat.zero_lt_succ 0) hn
 have mn : 1<m*n := Nat.lt_of_lt_of_le hm (Nat.le_mul_of_pos_right m pn)
 constructor
 · intro returned
   have lm := originalProjectionReduction (2^k) m n pm pn
   have rn := originalProjectionReduction (2^k) n m pn pm
   rw [Nat.mul_comm n m,returned,moduloBelow 1 n pn hn] at rn
   rw [returned,moduloBelow 1 m pm hm] at lm
   exact ⟨lm.symm,rn.symm⟩
 · intro both
   apply originalComponentMapInjective m n ((2^k)%(m*n)) 1 pm pn coprime
    (Nat.mod_lt _ (Nat.mul_pos pm pn)) mn
   · exact (originalProjectionReduction (2^k) m n pm pn).trans
      (both.1.trans (moduloBelow 1 m pm hm).symm)
   · have h := originalProjectionReduction (2^k) n m pn pm
     rw [Nat.mul_comm n m] at h
     exact h.trans (both.2.trans (moduloBelow 1 n pn hn).symm)
/-- Reuse the existing exact first-order theorem to characterize every return tick. -/
theorem originalOrderDivides (m p k : Nat) (hm : 1<m) (odd : m%2=1)
 (first : FirstBinaryOrder m p) : (2^k)%m=1 ↔ p ∣ k := by
 let c : Component := ⟨1,m,by decide,Nat.le_of_lt hm,gcdOneLeft m,odd,p,first⟩
 have order := exactExecutedReturnIffOrder 1 m k (by decide) (Nat.le_of_lt hm) (gcdOneLeft m)
 rw [moduloBelow 1 m (Nat.lt_trans (Nat.zero_lt_succ 0) hm) hm] at order
 exact order.symm.trans (returnExactlyMultiple c k)
/-- The source LCM is the first positive composite return, not a chosen period. -/
theorem originalLeastCompositePeriod (m n p q : Nat) (hm : 1<m) (hn : 1<n)
 (om : m%2=1) (on : n%2=1) (coprime : Nat.gcd m n=1)
 (fp : FirstBinaryOrder m p) (fq : FirstBinaryOrder n q) :
 FirstBinaryOrder (m*n) (Nat.lcm p q) := by
 have pm := Nat.lt_trans (Nat.zero_lt_succ 0) hm
 have pn := Nat.lt_trans (Nat.zero_lt_succ 0) hn
 have mn : 1<m*n := Nat.lt_of_lt_of_le hm (Nat.le_mul_of_pos_right m pn)
 have one := moduloBelow 1 (m*n) (Nat.mul_pos pm pn) mn
 have returns := returnsBoth p q fq.1
 refine ⟨returnPositive p q fp.1 fq.1,?_,?_⟩
 · rw [one]
   exact (originalCompositeReturn m n _ hm hn coprime).mpr
    ⟨(originalOrderDivides m p _ hm om fp).mpr returns.1,
     (originalOrderDivides n q _ hn on fq).mpr returns.2⟩
 · intro k positive before returned
   rw [one] at returned
   have both := (originalCompositeReturn m n k hm hn coprime).mp returned
   have least := leastPositiveReturn p q k fq.1 positive
    ((originalOrderDivides m p k hm om fp).mp both.1)
    ((originalOrderDivides n q k hn on fq).mp both.2)
   exact Nat.not_lt_of_ge least before
end SFT.Physics.FoldUniverseTransportPeriod
