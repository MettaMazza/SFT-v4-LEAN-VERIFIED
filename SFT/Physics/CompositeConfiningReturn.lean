import SFT.Physics.CompositeConfiningComplements
namespace SFT.Physics.CompositeConfiningDerivation
open SFT.Mathematics.OrbitTilingCount SFT.Mathematics.OrbitCycleSupport
open SFT.Mathematics.OrbitCyclotomic SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- Iteration of the exact original held-label Fold action. -/
def originalTicks (d k : Nat) : Nat → Nat
 | 0 => k
 | n+1 => (originalTicks d k n + originalTicks d k n)%d
theorem originalTicksConfined (d k n : Nat) (positive : 0<d) (odd : d%2=1)
 (nonempty : 0<k) (bound : k<d) : 0<originalTicks d k n ∧ originalTicks d k n<d := by
 induction n with
 | zero => exact ⟨nonempty,bound⟩
 | succ n ih => exact originalFoldConfined d _ positive odd ih.1 ih.2
theorem originalTicksAddition (d k a b : Nat) :
 originalTicks d k (a+b)=originalTicks d (originalTicks d k a) b := by
 induction b with
 | zero => rfl
 | succ b ih => exact congrArg (fun x => (x+x)%d) ih
theorem originalTicksInjective (d a b n : Nat) (positive : 0<d) (odd : d%2=1)
 (ap : 0<a) (ab : a<d) (bp : 0<b) (bb : b<d)
 (same : originalTicks d a n=originalTicks d b n) : a=b := by
 induction n with
 | zero => exact same
 | succ n ih =>
  exact ih (originalFoldInjective d _ _ positive odd
   (originalTicksConfined d a n positive odd ap ab).2
   (originalTicksConfined d b n positive odd bp bb).2 same)
/-- A repeated position in the source orbit forces a return to its initial label. -/
theorem originalCollisionReturns (d k i j : Nat) (positive : 0<d) (odd : d%2=1)
 (kp : 0<k) (kb : k<d) (earlier : i<j)
 (same : originalTicks d k i=originalTicks d k j) : originalTicks d k (j-i)=k := by
 have shape : j=(j-i)+i := (subtractAdd j i (Nat.le_of_lt earlier)).symm
 have bounds := originalTicksConfined d k (j-i) positive odd kp kb
 apply originalTicksInjective d _ k i positive odd bounds.1 bounds.2 kp kb
 exact (originalTicksAddition d k (j-i) i).symm.trans ((congrArg (originalTicks d k) shape).symm.trans same.symm)
/-- Bounded constructive search for the source's first positive return. -/
def originalReturnThrough (d k : Nat) : Nat → Option Nat
 | 0 => none
 | n+1 => match originalReturnThrough d k n with
  | some j => some j
  | none => if originalTicks d k (n+1)=k then some (n+1) else none
theorem originalNoReturnThrough (d k n : Nat) (none : originalReturnThrough d k n=.none) :
 ∀ j, 0<j → j≤n → originalTicks d k j≠k := by
 induction n with
 | zero => intro j pos bound; exact False.elim (Nat.not_lt_of_ge bound pos)
 | succ n ih =>
  unfold originalReturnThrough at none
  cases prev : originalReturnThrough d k n with
  | some j => rw [prev] at none; cases none
  | none =>
   rw [prev] at none
   by_cases hit : originalTicks d k (n+1)=k
   · rw [ite_eq_left hit] at none; cases none
   · intro j pos bound
     by_cases last : j=n+1
     · rw [last]; exact hit
     · exact ih prev j pos (Nat.le_of_lt_succ (Nat.lt_of_le_of_ne bound last))
theorem originalFoundFirstReturn (d k n period : Nat)
 (found : originalReturnThrough d k n=some period) :
 0<period ∧ period≤n ∧ originalTicks d k period=k ∧
 (∀ j, 0<j → j<period → originalTicks d k j≠k) := by
 induction n with
 | zero => cases found
 | succ n ih =>
  unfold originalReturnThrough at found
  cases prev : originalReturnThrough d k n with
  | some j =>
   rw [prev] at found; cases found
   have h := ih prev
   exact ⟨h.1,Nat.le_trans h.2.1 (Nat.le_succ _),h.2.2⟩
  | none =>
   rw [prev] at found
   by_cases hit : originalTicks d k (n+1)=k
   · rw [ite_eq_left hit] at found; cases found
     exact ⟨Nat.zero_lt_succ _,Nat.le_refl _,hit,fun j pos before =>
      originalNoReturnThrough d k n prev j pos (Nat.le_of_lt_succ before)⟩
   · rw [ite_eq_right hit] at found; cases found
/-- Every original standing label returns within the complete d-1-label carrier.
No coprimality of k and d is required. -/
theorem originalFirstReturnExists (d k : Nat) (positive : 0<d) (odd : d%2=1)
 (kp : 0<k) (kb : k<d) :
 ∃ period, originalReturnThrough d k (d-1)=some period ∧ 0<period ∧
 period≤d-1 ∧ originalTicks d k period=k ∧
 (∀ j, 0<j → j<period → originalTicks d k j≠k) := by
 cases search : originalReturnThrough d k (d-1) with
 | some period => exact ⟨period,rfl,originalFoundFirstReturn d k (d-1) period search⟩
 | none =>
  have noReturn := originalNoReturnThrough d k (d-1) search
  let positions := (List.range d).map (originalTicks d k)
  have unique : Unique positions := uniqueMap _ _ (uniqueRange d) (by
   intro i hi j hj same
   have ib := (rangeMember d i).mp hi
   have jb := (rangeMember d j).mp hj
   by_cases eq : i=j
   · exact eq
   · by_cases earlier : i<j
     · have back := originalCollisionReturns d k i j positive odd kp kb earlier same
       exact False.elim (noReturn (j-i) (SFT.Foundation.ExactCast.subtractPositive j i earlier)
        (Nat.le_trans (Nat.sub_le j i) (Nat.le_pred_of_lt jb)) back)
     · have later := Nat.lt_of_le_of_ne (Nat.le_of_not_gt earlier) (fun h => eq h.symm)
       have back := originalCollisionReturns d k j i positive odd kp kb later same.symm
       exact False.elim (noReturn (i-j) (SFT.Foundation.ExactCast.subtractPositive i j later)
        (Nat.le_trans (Nat.sub_le i j) (Nat.le_pred_of_lt ib)) back))
  have contained : ∀ x, x∈positions → x∈positiveRanks d := by
   intro x member
   obtain ⟨n,_,eq⟩ := mapPreimage _ _ x member
   apply (positiveRankMember d x positive).mpr
   rw [← eq]
   exact originalTicksConfined d k n positive odd kp kb
  have bound := subsetLength positions (positiveRanks d) unique contained
  have ps : positions.length=d := (mappedLength _ _).trans (rangeLoopLength d [])
  have cs : (positiveRanks d).length=d-1 := (mappedLength _ _).trans (rangeLoopLength (d-1) [])
  rw [ps,cs] at bound
  exact False.elim (Nat.not_le_of_gt (Nat.sub_lt positive (by decide)) bound)

/-- The existing rank iterator and the original held-label iterator agree on
this entire support, including labels not coprime to the denominator. -/
theorem originalTicksRank (d k n : Nat) (positive : 0<d) (odd : d%2=1)
 (kp : 0<k) (kb : k<d) :
 originalTicks d k n=SFT.Mathematics.OrbitOrderIdentity.rankIterate k d n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  have confined := originalTicksConfined d k (n+1) positive odd kp kb
  have nonzero : (originalTicks d k n*2)%d≠0 := by
   rw [Nat.mul_two]
   exact Nat.ne_of_gt confined.1
  change (originalTicks d k n+originalTicks d k n)%d =
   SFT.Mathematics.OrbitOrderIdentity.foldRank _ d
  rw [← ih]
  unfold SFT.Mathematics.OrbitOrderIdentity.foldRank
  rw [ite_eq_right nonzero,Nat.mul_two]
/-- Every reachable original label lies in the generated first-return cycle. -/
theorem originalOrbitCoverage (d k period : Nat) (positive : 0<d) (odd : d%2=1)
 (kp : 0<k) (kb : k<d) (pp : 0<period) (returned : originalTicks d k period=k)
 (n : Nat) : ∃ j, j<period ∧ originalTicks d k j=originalTicks d k n := by
 have rankReturn := (originalTicksRank d k period positive odd kp kb).symm.trans returned
 refine ⟨n%period,Nat.mod_lt _ pp,?_⟩
 exact (originalTicksRank d k _ positive odd kp kb).trans
  ((iterateModuloPeriod k d period pp rankReturn n).symm.trans
   (originalTicksRank d k n positive odd kp kb).symm)
/-- Overlapping source cycles contain exactly the same labels. Distinct cycles
are disjoint, and each label supplies its own cycle. -/
theorem originalOrbitPartition (d a b : Nat) (positive : 0<d) (odd : d%2=1)
 (ap : 0<a) (ab : a<d) (bp : 0<b) (bb : b<d) :
 Reaches d a a ∧ Reaches d b b ∧
 (∀ shared, Reaches d a shared → Reaches d b shared →
  ∀ x, Reaches d a x ↔ Reaches d b x) := by
 obtain ⟨pa,_,pap,_,ar,_⟩ := originalFirstReturnExists d a positive odd ap ab
 obtain ⟨pb,_,pbp,_,br,_⟩ := originalFirstReturnExists d b positive odd bp bb
 have arank := (originalTicksRank d a pa positive odd ap ab).symm.trans ar
 have brank := (originalTicksRank d b pb positive odd bp bb).symm.trans br
 refine ⟨reachesSelf d a,reachesSelf d b,?_⟩
 intro shared left right x
 have backA := reachesReverse d a shared pa pap arank left
 have backB := reachesReverse d b shared pb pbp brank right
 constructor
 · intro h
   exact reachesCompose d b a x (reachesCompose d b shared a right backA) h
 · intro h
   exact reachesCompose d a b x (reachesCompose d a shared b left backB) h

/-- The first-return row contains every position once: no earlier collision
can occur because it would force a smaller positive return. -/
theorem originalFirstCycleUnique (d k period : Nat) (positive : 0<d) (odd : d%2=1)
 (kp : 0<k) (kb : k<d)
 (first : ∀ j, 0<j → j<period → originalTicks d k j≠k) :
 Unique ((List.range period).map (originalTicks d k)) := by
 apply uniqueMap _ _ (uniqueRange period)
 intro i hi j hj same
 have ib := (rangeMember period i).mp hi
 have jb := (rangeMember period j).mp hj
 by_cases eq : i=j
 · exact eq
 · by_cases earlier : i<j
   · exact False.elim (first (j-i) (SFT.Foundation.ExactCast.subtractPositive j i earlier)
      (Nat.lt_of_le_of_lt (Nat.sub_le j i) jb)
      (originalCollisionReturns d k i j positive odd kp kb earlier same))
   · have later := Nat.lt_of_le_of_ne (Nat.le_of_not_gt earlier) (fun h => eq h.symm)
     exact False.elim (first (i-j) (SFT.Foundation.ExactCast.subtractPositive i j later)
      (Nat.lt_of_le_of_lt (Nat.sub_le i j) ib)
      (originalCollisionReturns d k j i positive odd kp kb later same.symm))
/-- The enumerated original first-return row has its declared period length. -/
theorem originalFirstCycleLength (d k period : Nat) :
 ((List.range period).map (originalTicks d k)).length=period :=
 (mappedLength _ _).trans (rangeLoopLength period [])
end SFT.Physics.CompositeConfiningDerivation
