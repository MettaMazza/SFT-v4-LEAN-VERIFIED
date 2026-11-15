import SFT.Physics.FoldUniverseTransport
namespace SFT.Physics.FoldUniverseTransportComposition
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
open SFT.Mathematics.OrbitOrderIdentity
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- The two coprime component divisibilities recover composite divisibility. -/
theorem originalCompositeDivisibility (m n x : Nat) (hn : 0<n)
 (coprime : Nat.gcd m n=1) (left : m ∣ x) (right : n ∣ x) : m*n ∣ x := by
 obtain ⟨k,hk⟩ := left
 have nk : n ∣ k := cancelReducedFactor m n k hn coprime (hk ▸ right)
 obtain ⟨j,hj⟩ := nk
 exact ⟨j,hk.trans ((congrArg (m*·) hj).trans (mulAssoc m n j).symm)⟩
/-- Equality of both component projections determines the original composite residue. -/
theorem originalComponentMapInjective (m n a b : Nat) (hm : 0<m) (hn : 0<n)
 (coprime : Nat.gcd m n=1) (ha : a<m*n) (hb : b<m*n)
 (left : a%m=b%m) (right : a%n=b%n) : a=b := by
 have deltaZero (x y : Nat) (bound : x<m*n) (ml : x%m=y%m) (nr : x%n=y%n) : x-y=0 := by
  have divides := originalCompositeDivisibility m n (x-y) hn coprime
   (equalRemainderDividesDifference x y m hm ml) (equalRemainderDividesDifference x y n hn nr)
  cases eq : x-y with
  | zero => rfl
  | succ k =>
   have positive : 0<x-y := eq.symm ▸ Nat.zero_lt_succ k
   have lower := divisorBound (m*n) (x-y) positive divides
   have upper := Nat.lt_of_le_of_lt (Nat.sub_le x y) bound
   exact False.elim (Nat.not_lt_of_ge lower upper)
 cases Nat.le_total a b with
 | inl ab =>
  have z := deltaZero b a hb left.symm right.symm
  have h := subtractAdd b a ab
  rw [z,Nat.zero_add] at h
  exact h
 | inr ba =>
  have z := deltaZero a b ha left right
  have h := subtractAdd a b ba
  rw [z,Nat.zero_add] at h
  exact h.symm
/-- Reducing a composite residue and then projecting is the same projection. -/
theorem originalProjectionReduction (a m n : Nat) (hm : 0<m) (hn : 0<n) :
 (a%(m*n))%m=a%m := by
 have split := remainderQuotient a (m*n) (Nat.mul_pos hm hn)
 rw [mulAssoc] at split
 exact (moduloAddMultiple (a%(m*n)) m (n*(a/(m*n))) hm).symm.trans
  (congrArg (fun x => x%m) split)
/-- One original Fold doubling commutes with both projections. -/
theorem originalFoldCommutation (a m n : Nat) (hm : 0<m) (hn : 0<n) :
 (((2*a)%(m*n))%m,((2*a)%(m*n))%n)=((2*(a%m))%m,(2*(a%n))%n) := by
 have lm := originalProjectionReduction (2*a) m n hm hn
 have rn := originalProjectionReduction (2*a) n m hn hm
 rw [Nat.mul_comm n m] at rn
 have ml := moduloMulReduce a 2 m hm
 have nr := moduloMulReduce a 2 n hn
 rw [Nat.mul_comm (a%m) 2,Nat.mul_comm a 2] at ml
 rw [Nat.mul_comm (a%n) 2,Nat.mul_comm a 2] at nr
 rw [lm,rn,ml,nr]
open SFT.Mathematics.OrbitCycleSupport SFT.Mathematics.OrbitCyclotomic
open SFT.Mathematics.OrbitTilingCount
/-- The full progression used to recover a component pair has no repeated right projection. -/
theorem originalProgressionInjective (m n a i j : Nat) (hn : 0<n)
 (coprime : Nat.gcd m n=1) (hi : i<n) (hj : j<n)
 (same : (a+m*i)%n=(a+m*j)%n) : i=j := by
 have deltaZero (x y : Nat) (bound : x<n) (eq : (a+m*x)%n=(a+m*y)%n) : x-y=0 := by
  have divides := equalRemainderDividesDifference (a+m*x) (a+m*y) n hn eq
  rw [subtractCommonLeft,mulSubtract] at divides
  have small := cancelReducedFactor m n (x-y) hn coprime divides
  cases h : x-y with
  | zero => rfl
  | succ k =>
   have lower := divisorBound n (x-y) (h.symm ▸ Nat.zero_lt_succ k) small
   exact False.elim (Nat.not_lt_of_ge lower (Nat.lt_of_le_of_lt (Nat.sub_le x y) bound))
 cases Nat.le_total i j with
 | inl le =>
  have z := deltaZero j i hj same.symm
  have h := subtractAdd j i le
  rw [z,Nat.zero_add] at h
  exact h
 | inr le =>
  have z := deltaZero i j hi same
  have h := subtractAdd i j le
  rw [z,Nat.zero_add] at h
  exact h.symm
/-- Every right component occurs in the full n-term progression, with no selected residue. -/
theorem originalProgressionOnto (m n a b : Nat) (hn : 0<n)
 (coprime : Nat.gcd m n=1) (hb : b<n) : ∃ k, k<n ∧ (a+m*k)%n=b := by
 let f := fun k => (a+m*k)%n
 let rows := (List.range n).map f
 have unique : Unique rows := uniqueMap f (List.range n) (uniqueRange n)
  (fun i hi j hj eq => originalProgressionInjective m n a i j hn coprime
    ((rangeMember n i).mp hi) ((rangeMember n j).mp hj) eq)
 have size : rows.length=n := (mappedLength f (List.range n)).trans (rangeLoopLength n [])
 have bounded : ∀ x, x ∈ rows → x ∈ List.range n := by
  intro x hx
  obtain ⟨k,_,eq⟩ := mapPreimage f (List.range n) x hx
  exact (rangeMember n x).mpr (eq ▸ Nat.mod_lt (a+m*k) hn)
 cases hit : rows.contains b with
 | true =>
  have member := (SFT.Mathematics.OrbitLoopCompletion.containsMember rows b).mp hit
  obtain ⟨k,hk,eq⟩ := mapPreimage f (List.range n) b member
  exact ⟨k,(rangeMember n k).mp hk,eq⟩
 | false =>
  have member : ¬ b ∈ rows := by
   intro h
   have yes := (SFT.Mathematics.OrbitLoopCompletion.containsMember rows b).mpr h
   rw [hit] at yes; cases yes
  have tooMany := subsetLength (b::rows) (List.range n) ⟨member,unique⟩ (by
    intro x hx
    cases hx with
    | head => exact (rangeMember n b).mpr hb
    | tail _ h => exact bounded x h)
  change rows.length+1 ≤ (List.range n).length at tooMany
  rw [size,show (List.range n).length=n from rangeLoopLength n []] at tooMany
  exact False.elim (Nat.not_succ_le_self n tooMany)
/-- The complete composite interval supplies every ordered component pair. -/
theorem originalComponentPairExists (m n a b : Nat) (hm : 0<m) (hn : 0<n)
 (coprime : Nat.gcd m n=1) (ha : a<m) (hb : b<n) :
 ∃ x, x<m*n ∧ x%m=a ∧ x%n=b := by
 obtain ⟨k,hk,eq⟩ := originalProgressionOnto m n a b hn coprime hb
 refine ⟨a+m*k,?_,?_,eq⟩
 · have first : a+m*k < m+m*k := Nat.add_lt_add_right ha _
   have last : m*(k+1) ≤ m*n := Nat.mul_le_mul_left m hk
   rw [Nat.mul_succ,Nat.add_comm (m*k) m] at last
   exact Nat.lt_of_lt_of_le first last
 · exact (moduloAddMultiple a m k hm).trans (moduloBelow a m hm ha)

open SFT.Mathematics.OrbitBinaryDepth
private theorem reverseReduced (a b : Nat) (h : Nat.gcd a b=1) : Nat.gcd b a=1 := by
 have factors := gcdDivides b a
 have divides := commonDivisorDividesGcd (Nat.gcd b a) a b factors.2 factors.1
 rw [h] at divides
 obtain ⟨k,hk⟩ := divides
 exact factorOfOne _ _ hk.symm
/-- The recovered composite representative remains a unit; no nonunit is introduced. -/
theorem originalUnitPairExists (m n a b : Nat) (hm : 0<m) (hn : 0<n)
 (coprime : Nat.gcd m n=1) (pa : 0<a) (ha : a<m) (hb : b<n)
 (ua : Nat.gcd a m=1) (ub : Nat.gcd b n=1) :
 ∃ x, 0<x ∧ x<m*n ∧ Nat.gcd x (m*n)=1 ∧ x%m=a ∧ x%n=b := by
 obtain ⟨x,bound,left,right⟩ := originalComponentPairExists m n a b hm hn coprime ha hb
 have px : 0<x := by
  cases x with
  | zero =>
   change 0=a at left
   exact False.elim (Nat.not_lt_zero a (left ▸ pa))
  | succ k => exact Nat.zero_lt_succ k
 have xm : Nat.gcd x m=1 := by rw [gcdRemainder x m hm,left,ua]
 have xn : Nat.gcd x n=1 := by rw [gcdRemainder x n hn,right,ub]
 have product : Nat.gcd (m*n) x=1 :=
  (gcdMultiplyReduced m x n px (reverseReduced x m xm)).trans (reverseReduced x n xn)
 exact ⟨x,px,bound,reverseReduced (m*n) x product,left,right⟩
/-- Every composite unit projects to units of both components. -/
theorem originalUnitProjection (m n x : Nat) (hm : 0<m) (hn : 0<n)
 (unit : Nat.gcd x (m*n)=1) : Nat.gcd (x%m) m=1 ∧ Nat.gcd (x%n) n=1 := by
 have lm := reducedWithDivisor x (m*n) m unit ⟨n,rfl⟩
 have rn := reducedWithDivisor x (m*n) n unit ⟨m,Nat.mul_comm m n⟩
 exact ⟨(gcdRemainder x m hm).symm.trans lm,(gcdRemainder x n hn).symm.trans rn⟩

end SFT.Physics.FoldUniverseTransportComposition
