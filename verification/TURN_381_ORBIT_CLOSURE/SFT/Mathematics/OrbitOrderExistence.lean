import SFT.Mathematics.OrbitTilingCount
import SFT.Mathematics.OrbitReplayCorrespondence
namespace SFT.Mathematics.OrbitOrderExistence
open OrbitOrderIdentity OrbitBinaryDepth OrbitCycleSupport OrbitCyclotomic OrbitTilingCount
open SFT.Foundation.FractionReduction
open SFT.Foundation.ExactValueIdentity OrbitNumberWitnesses OrbitReplayCorrespondence

/-- Ascending finite search used to prove that the source return loop stops.
The bound is the cardinality of its complete finite rank carrier. -/
def firstOrderThrough (q : Nat) : Nat → Option Nat
 | 0 => none
 | n+1 => match firstOrderThrough q n with
   | some k => some k
   | none => if (2^(n+1))%q = 1%q then some (n+1) else none

theorem noOrderThrough (q n : Nat) (none : firstOrderThrough q n = .none) :
 ∀ k, 0 < k → k ≤ n → (2^k)%q ≠ 1%q := by
 induction n with
 | zero => intro k positive bound; exact False.elim (Nat.not_lt_of_ge bound positive)
 | succ n ih =>
   unfold firstOrderThrough at none
   cases prev : firstOrderThrough q n with
   | some j => rw [prev] at none; cases none
   | none =>
     rw [prev] at none
     by_cases returned : (2^(n+1))%q = 1%q
     · rw [ite_eq_left returned] at none; cases none
     · intro k positive bound
       by_cases last : k = n+1
       · rw [last]; exact returned
       · exact ih prev k positive (Nat.le_of_lt_succ (Nat.lt_of_le_of_ne bound last))

theorem foundFirstOrder (q n k : Nat) (some : firstOrderThrough q n = .some k) :
 FirstBinaryOrder q k ∧ k ≤ n := by
 induction n with
 | zero => cases some
 | succ n ih =>
   unfold firstOrderThrough at some
   cases prev : firstOrderThrough q n with
   | some j =>
     rw [prev] at some
     cases some
     have h := ih prev
     exact ⟨h.1,Nat.le_trans h.2 (Nat.le_succ _)⟩
   | none =>
     rw [prev] at some
     by_cases returned : (2^(n+1))%q = 1%q
     · rw [ite_eq_left returned] at some
       cases some
       exact ⟨⟨Nat.zero_lt_succ _,returned,fun j positive before =>
         noOrderThrough q n prev j positive (Nat.le_of_lt_succ before)⟩,Nat.le_refl _⟩
     · rw [ite_eq_right returned] at some; cases some

theorem noCollisionBeforeReturn (q bound i j : Nat) (hq : 0 < q) (odd : q%2=1)
 (noReturn : ∀ k, 0 < k → k ≤ bound → (2^k)%q ≠ 1%q)
 (earlier : i < j) (before : j ≤ bound) : rankIterate 1 q i ≠ rankIterate 1 q j := by
 intro same
 let gap := j-i
 have shape : j = i+gap := (subtractAdd j i (Nat.le_of_lt earlier)).symm.trans (Nat.add_comm _ _)
 have positive : 0 < gap := by
   apply Nat.pos_of_ne_zero
   intro zero
   have collapsed : j = i := by rw [zero,Nat.add_zero] at shape; exact shape
   exact (Nat.ne_of_lt earlier) collapsed.symm
 have small : gap ≤ bound := Nat.le_trans (Nat.sub_le j i) before
 have residues : (1*2^j)%q = (1*2^i)%q :=
   (iterationRemainder 1 q j hq).symm.trans
     ((congrArg (fun x => x%q) same.symm).trans (iterationRemainder 1 q i hq))
 rw [shape,powerAdd,← mulAssoc] at residues
 have reduced : Nat.gcd (1*2^i) q = 1 := by
   rw [Nat.one_mul]
   exact binaryPowerCoprimeOdd q i hq odd
 exact noReturn gap positive small ((binaryReturnIffOrder (1*2^i) q gap hq reduced).mp residues)

/-- The q+1 executed positions cannot all be distinct in q held ranks.
Consequently the original odd-core loop has a first return no later than q. -/
theorem firstOrderExists (q : Nat) (hq : 0 < q) (odd : q%2=1) :
 ∃ k, firstOrderThrough q q = some k ∧ FirstBinaryOrder q k ∧ k ≤ q := by
 cases search : firstOrderThrough q q with
 | some k =>
   have h := foundFirstOrder q q k search
   exact ⟨k,rfl,h.1,h.2⟩
 | none =>
   have noReturn := noOrderThrough q q search
   let positions := (List.range (q+1)).map (rankIterate 1 q)
   have unique : Unique positions := uniqueMap (rankIterate 1 q) (List.range (q+1))
     (uniqueRange (q+1)) (by
       intro i hi j hj same
       have ib := Nat.le_of_lt_succ ((rangeMember (q+1) i).mp hi)
       have jb := Nat.le_of_lt_succ ((rangeMember (q+1) j).mp hj)
       by_cases eq : i = j
       · exact eq
       · by_cases earlier : i < j
         · exact False.elim (noCollisionBeforeReturn q q i j hq odd noReturn earlier jb same)
         · have later := Nat.lt_of_le_of_ne (Nat.le_of_not_gt earlier) (fun h => eq h.symm)
           exact False.elim (noCollisionBeforeReturn q q j i hq odd noReturn later ib same.symm))
   have contained : ∀ x, x ∈ positions → x ∈ positiveRanks (q+1) := by
     intro x member
     obtain ⟨k,_,eq⟩ := mapPreimage (rankIterate 1 q) (List.range (q+1)) x member
     have bounds := iterateBounds 1 q k (by decide) hq
     apply (positiveRankMember (q+1) x (Nat.zero_lt_succ q)).mpr
     rw [← eq]
     exact ⟨bounds.1,Nat.lt_succ_of_le bounds.2⟩
   have bound := subsetLength positions (positiveRanks (q+1)) unique contained
   have positionsSize : positions.length = q+1 :=
     (mappedLength _ _).trans (rangeLoopLength (q+1) [])
   have carrierSize : (positiveRanks (q+1)).length = q :=
     (mappedLength _ _).trans (rangeLoopLength q [])
   rw [positionsSize,carrierSize] at bound
   exact False.elim (Nat.not_succ_le_self q bound)

theorem orderReplayCompletes (q period fuel count : Nat) (aboveOne : 1 < q)
 (first : FirstBinaryOrder q period) (positive : 0 < count) (before : count ≤ period)
 (enough : period ≤ count+fuel) :
 orderReplay q fuel ((2^count)%q) count = some period := by
 have hq := Nat.lt_trans (Nat.zero_lt_succ 0) aboveOne
 have oneRemainder : 1%q = 1 := moduloBelow 1 q hq aboveOne
 induction fuel generalizing count with
 | zero =>
   have eq : count = period := Nat.le_antisymm before enough
   rw [eq]
   unfold orderReplay
   have hit : (2^period)%q = 1 := first.2.1.trans oneRemainder
   rw [hit]
   rfl
 | succ fuel ih =>
   by_cases atReturn : count = period
   · rw [atReturn]
     unfold orderReplay
     have hit : (2^period)%q = 1 := first.2.1.trans oneRemainder
     rw [hit]
     rfl
   · have earlier := Nat.lt_of_le_of_ne before atReturn
     have noReturn : (2^count)%q ≠ 1 := by
       intro hit
       exact first.2.2 count positive earlier (hit.trans oneRemainder.symm)
     have missed : ((2^count)%q == 1) = false := by
       cases eq : (2^count)%q == 1 with
       | false => rfl
       | true => exact False.elim (noReturn (Nat.eq_of_beq_eq_true eq))
     unfold orderReplay
     rw [missed]
     have step : (((2^count)%q)*2)%q = (2^(count+1))%q := by
       rw [moduloMulReduce (2^count) 2 q hq,Nat.pow_succ]
     rw [step]
     apply ih (count+1) (Nat.zero_lt_succ _) earlier
     exact (Nat.add_right_comm count fuel 1) ▸ enough

/-- The finite proof bound is sufficient for the unchanged source while
loop. It is derived from the carrier, not supplied as a scientific parameter. -/
theorem originalOrderLoopTerminates (q : Nat) (aboveOne : 1 < q) (odd : q%2=1) :
 ∃ period, orderWitness q = some period ∧ FirstBinaryOrder q period ∧
   OrderRun q (2%q) 1 period := by
 have hq := Nat.lt_trans (Nat.zero_lt_succ 0) aboveOne
 obtain ⟨period,_,first,bound⟩ := firstOrderExists q hq odd
 have completed := orderReplayCompletes q period q 1 aboveOne first (by decide) first.1
   (Nat.le_trans bound (Nat.le_add_left q 1))
 change orderReplay q q (2%q) 1 = some period at completed
 exact ⟨period,completed,first,orderReplayCorrespondence q q (2%q) 1 period completed⟩

theorem originalOrderTilesReducedResidues (q : Nat) (aboveOne : 1 < q) (odd : q%2=1) :
 ∃ period count, orderWitness q = some period ∧ FirstBinaryOrder q period ∧
   (reducedResidues q).length = period*count := by
 obtain ⟨period,executed,first,_⟩ := originalOrderLoopTerminates q aboveOne odd
 obtain ⟨count,eq⟩ := reducedResidueProduct q period aboveOne odd first
 exact ⟨period,count,executed,first,eq⟩

theorem originalPrimeOrderDivides (q : Nat) (prime : PrimeDenominator q) (odd : q%2=1) :
 ∃ period, orderWitness q = some period ∧ period ∣ q-1 := by
 obtain ⟨period,executed,first,_⟩ := originalOrderLoopTerminates q prime.1 odd
 exact ⟨period,executed,primePeriodDivides q period prime odd first⟩

end SFT.Mathematics.OrbitOrderExistence
