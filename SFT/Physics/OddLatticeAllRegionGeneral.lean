import SFT.Physics.OddLatticeAllRegion
open SFT.Physics.OddLatticeAllRegion
open SFT.Physics.GeneratorOperations
set_option maxHeartbeats 100000000
namespace SFT.Physics.OddLatticeAllRegionGeneral
private theorem notBelow (a b : Nat) (bound : b≤a) : ¬ Int.ofNat a < Int.ofNat b := by
 intro bad
 change Int.NonNeg (Int.subNatNat b (a+1)) at bad
 unfold Int.subNatNat at bad
 cases h : (a+1)-b with
 | zero => exact Nat.not_succ_le_self a (Nat.le_trans (Nat.le_of_sub_eq_zero h) bound)
 | succ k => rw [h] at bad; cases bad

theorem acceptedIndex (n i : Nat) (positive : 0<n)
 (odd : n/2+n/2+1=n) (lower : 1≤i) (upper : i≤n) :
 foldLatticeIndex (.integer (.ofNat i)) (.integer (.ofNat n)) =
 .ok (if i+i≤n then i+i else i+i-n) := by
 cases n with
 | zero => exact False.elim (Nat.not_lt_zero _ positive)
 | succ n =>
  unfold foldLatticeIndex isOdd requirePositiveWhole countInteger
  dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
  have ho : (n+1)/2+(n+1)/2+1 == n+1 := by
   have self (k : Nat) : (k==k)=true := by
    induction k with | zero => rfl | succ k ih => exact ih
   exact (congrArg (fun k => k==n+1) odd).trans (self (n+1))
  have lo : ¬ (Int.ofNat i < 1) := notBelow i 1 lower
  have hi : ¬ (Int.ofNat (n+1) < Int.ofNat i) := notBelow (n+1) i upper
  have guard : (!( (n+1)/2+(n+1)/2+1 == n+1) || decide (Int.ofNat i < 1) || decide (Int.ofNat (n+1) < Int.ofNat i)) = false := by
   rw [ho, decide_eq_false lo, decide_eq_false hi]
   rfl
  exact ite_eq_right (fun h => Bool.noConfusion (guard.symm.trans h))
open SFT.Mathematics.OrbitOrderIdentity SFT.Mathematics.OrbitBinaryDepth
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity

theorem sourceOddRemainder (n : Nat) (odd : n/2+n/2+1=n) : n%2=1 := by
 have shape : n=1+2*(n/2) := by
  calc
   n = n/2+n/2+1 := odd.symm
   _ = 1+2*(n/2) := by rw [Nat.mul_comm 2, Nat.mul_succ, Nat.mul_one, Nat.add_comm]
 rw [shape]
 exact moduloAddMultiple 1 2 (n/2) (by decide)

theorem allPositiveRanksInjective (n p r : Nat) (positive : 0<n) (odd : n%2=1)
 (pp : 0<p) (rp : 0<r) (pb : p≤n) (rb : r≤n)
 (same : foldRank p n=foldRank r n) : p=r := by
 have residues := (foldRankResidue p n positive).symm.trans
  ((congrArg (fun x => x%n) same).trans (foldRankResidue r n positive))
 have ordered (a b : Nat) (ap : 0<a) (bp : 0<b) (ab : a≤n) (ba : b≤a)
  (eq : (a*2)%n=(b*2)%n) : a=b := by
  have div := equalRemainderDividesDifference (a*2) (b*2) n positive eq
  rw [Nat.mul_comm a 2, Nat.mul_comm b 2, mulSubtract] at div
  have gap := cancelReducedFactor 2 n (a-b) positive (binaryCoprimeOdd n odd) div
  by_cases empty : a-b=0
  · exact Nat.le_antisymm (Nat.le_of_sub_eq_zero empty) ba
  · have bound := divisorBound n (a-b) (Nat.pos_of_ne_zero empty) gap
    have sum := Nat.add_le_add_right bound b
    rw [subtractAdd a b ba] at sum
    exact False.elim ((Nat.not_lt_of_ge (Nat.le_trans sum ab)) (Nat.lt_add_of_pos_right bp))
 by_cases order : r≤p
 · exact ordered p r pp rp pb order residues
 · exact (ordered r p rp pp rb (Nat.le_of_lt (Nat.lt_of_not_ge order)) residues.symm).symm

theorem sourceStepEqualsRank (n p : Nat) (positive : 0<n) (pp : 0<p) (pb : p≤n) :
 (if p+p≤n then p+p else p+p-n)=foldRank p n := by
 have double : p*2=p+p := by rw [Nat.mul_succ,Nat.mul_one]
 have fb := foldRankBounds p n positive
 by_cases below : p+p≤n
 · rw [ite_eq_left below]
   exact heldRemainderInjective (p+p) (foldRank p n) n
    (Nat.lt_of_lt_of_le pp (Nat.le_add_right p p)) fb.1 below fb.2
    ((congrArg (fun x => x%n) double.symm).trans (foldRankResidue p n positive).symm)
 · rw [ite_eq_right below]
   have lower := Nat.le_of_lt (Nat.lt_of_not_ge below)
   have split := subtractAdd (p+p) n lower
   have qp : 0<p+p-n := by
    apply Nat.pos_of_ne_zero
    intro z
    have eq : p+p=n := by rw [z,Nat.zero_add] at split; exact split.symm
    exact below (Nat.le_of_eq eq)
   have qb : p+p-n≤n := by
    have bound := Nat.add_le_add pb pb
    rw [← split] at bound
    have cancel (a b k : Nat) : a+k≤b+k → a≤b := by
     induction k with
     | zero => exact fun h => h
     | succ k ih => exact fun h => ih (Nat.le_of_succ_le_succ h)
    exact cancel _ _ n bound
   have residue : (p+p-n)%n=(p*2)%n :=
    (moduloRemoves (p+p) n positive lower).symm.trans (congrArg (fun x => x%n) double.symm)
   exact heldRemainderInjective (p+p-n) (foldRank p n) n qp fb.1 qb fb.2
    (residue.trans (foldRankResidue p n positive).symm)

theorem originalStepEqualsRank (n p : Nat) (positive : 0<n) (odd : n/2+n/2+1=n)
 (pp : 0<p) (pb : p≤n) :
 foldLatticeIndex (.integer (.ofNat p)) (.integer (.ofNat n))=.ok (foldRank p n) :=
 (acceptedIndex n p positive odd pp pb).trans (congrArg Except.ok (sourceStepEqualsRank n p positive pp pb))

theorem originalStepInjective (n p r : Nat) (positive : 0<n) (odd : n/2+n/2+1=n)
 (pp : 0<p) (rp : 0<r) (pb : p≤n) (rb : r≤n)
 (same : foldLatticeIndex (.integer (.ofNat p)) (.integer (.ofNat n))=
  foldLatticeIndex (.integer (.ofNat r)) (.integer (.ofNat n))) : p=r := by
 have eq := (originalStepEqualsRank n p positive odd pp pb).symm.trans
  (same.trans (originalStepEqualsRank n r positive odd rp rb))
 exact allPositiveRanksInjective n p r positive (sourceOddRemainder n odd) pp rp pb rb (Except.ok.inj eq)

theorem everyDepthInjective (n p r depth : Nat) (positive : 0<n) (odd : n%2=1)
 (pp : 0<p) (rp : 0<r) (pb : p≤n) (rb : r≤n)
 (same : rankIterate p n depth=rankIterate r n depth) : p=r := by
 induction depth with
 | zero => exact same
 | succ depth ih =>
  have a := iterateBounds p n depth pp pb
  have b := iterateBounds r n depth rp rb
  exact ih (allPositiveRanksInjective n _ _ positive odd a.1 b.1 a.2 b.2 same)

open SFT.Mathematics.OrbitTilingCount SFT.Mathematics.OrbitCyclotomic SFT.Mathematics.OrbitCycleSupport
private theorem positiveSupportMember (n p : Nat) : p ∈ (List.range n).map (fun i => i+1) ↔ 0<p ∧ p≤n := by
 constructor
 · intro h
   obtain ⟨i,m,eq⟩ := mapPreimage _ _ p h
   cases eq
   exact ⟨Nat.zero_lt_succ i,Nat.succ_le_of_lt ((rangeMember n i).mp m)⟩
 · intro h
   cases p with
   | zero => exact False.elim (Nat.not_lt_zero _ h.1)
   | succ p => exact mapMember _ _ p ((rangeMember n p).mpr (Nat.lt_of_succ_le h.2))

theorem completeSupportAtEveryDepth (n depth r : Nat) (positive : 0<n) (odd : n%2=1)
 (rp : 0<r) (rb : r≤n) :
 r ∈ ((List.range n).map (fun i => i+1)).map (fun p => rankIterate p n depth) := by
 let support := (List.range n).map (fun i => i+1)
 let image := support.map (fun p => rankIterate p n depth)
 have supportUnique : Unique support := uniqueMap (fun i => i+1) _ (uniqueRange n)
  (fun _ _ _ _ same => Nat.succ.inj same)
 have imageUnique : Unique image := uniqueMap _ _ supportUnique (by
  intro a ha b hb same
  have a := (positiveSupportMember n a).mp ha
  have b := (positiveSupportMember n b).mp hb
  exact everyDepthInjective n _ _ depth positive odd a.1 b.1 a.2 b.2 same)
 have within (p : Nat) (h : p ∈ image) : p ∈ support := by
  obtain ⟨a,m,eq⟩ := mapPreimage _ _ p h
  have ab := (positiveSupportMember n a).mp m
  have b := iterateBounds a n depth ab.1 ab.2
  exact (positiveSupportMember n p).mpr (eq ▸ b)
 by_cases present : has image r = true
 · exact (hasMember image r).mp present
 · have found : ¬ r ∈ image := fun h => present ((hasMember image r).mpr h)
   have filtered : ∀ p, p ∈ image → p ∈ support.filter (fun p => decide (p≠r)) := by
    intro p h
    apply (filterMember _ _ _).mpr
    exact ⟨within p h,decide_eq_true (fun eq => found (eq ▸ h))⟩
   have bound := subsetLength image _ imageUnique filtered
   have shorter := filterRemovalShorter (fun p => decide (p≠r)) support r
    ((positiveSupportMember n r).mpr ⟨rp,rb⟩) (decide_eq_false (fun h => h rfl))
   have size : image.length=support.length := mappedLength _ _
   rw [size] at bound
   exact False.elim ((Nat.not_lt_of_ge bound) shorter)

private theorem iterateFromFirst (n p k : Nat) : rankIterate (foldRank p n) n k=rankIterate p n (k+1) := by
 have h := iterateAddition p n 1 k
 rw [Nat.add_comm 1 k] at h
 exact h.symm

private theorem foldCons {α β : Type} (f : α → β → Except String α) (state : α) (x : β) (xs : List β) :
 (x::xs).foldlM f state = (do let next ← f state x; xs.foldlM f next) := rfl

theorem originalTraceLoop (n p : Nat) (positive : 0<n) (odd : n/2+n/2+1=n)
 (pp : 0<p) (pb : p≤n) (steps trace : List Nat) :
 ∃ out, steps.foldlM (fun (current,record) _ => do
   let next ← foldLatticeIndex current (.integer (.ofNat n))
   pure (CountInput.integer (.ofNat next),record++[next])) (.integer (.ofNat p),trace) =
   .ok (.integer (.ofNat (rankIterate p n steps.length)),out) ∧
  (steps≠[] → ∃ before, out=before++[rankIterate p n steps.length]) := by
 induction steps generalizing p trace with
 | nil => exact ⟨trace,rfl,fun h => False.elim (h rfl)⟩
 | cons step rest ih =>
  have b := foldRankBounds p n positive
  obtain ⟨out,result,last⟩ := ih (foldRank p n) b.1 b.2 (trace++[foldRank p n])
  refine ⟨out,?_,?_⟩
  · rw [foldCons]
    dsimp only
    rw [originalStepEqualsRank n p positive odd pp pb]
    change rest.foldlM _ _ = _
    exact result.trans (congrArg (fun k => Except.ok (CountInput.integer (.ofNat k),out)) (iterateFromFirst n p rest.length))
  · intro _
    cases rest with
    | nil =>
     have eq : out=trace++[foldRank p n] := by
      change Except.ok (CountInput.integer (.ofNat (foldRank p n)),trace++[foldRank p n]) = _ at result
      exact (congrArg Prod.snd (Except.ok.inj result)).symm
     exact ⟨trace,eq⟩
    | cons a rest =>
     obtain ⟨before,h⟩ := last (by intro h; cases h)
     exact ⟨before,h.trans (congrArg (fun k => before++[k]) (iterateFromFirst n p (rest.length+1)))⟩

theorem originalTraceEndsAtIterate (n p k : Nat) (positive : 0<n) (odd : n/2+n/2+1=n)
 (pp : 0<p) (pb : p≤n) : ∃ before,
 foldIndexTrace (.integer (.ofNat p)) (.integer (.ofNat n)) (.integer (.ofNat (k+1))) =
 .ok (before++[rankIterate p n (k+1)]) := by
 have size : (List.range (k+1)).length=k+1 := rangeLoopLength (k+1) []
 obtain ⟨out,result,last⟩ := originalTraceLoop n p positive odd pp pb (List.range (k+1)) []
 obtain ⟨before,shape⟩ := last (by
  intro eq
  have zero := (congrArg List.length eq).symm.trans size
  cases zero)
 refine ⟨before,?_⟩
 unfold foldIndexTrace requirePositiveWhole
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure] at result ⊢
 rw [result]
 change Except.ok out = _
 exact congrArg Except.ok (shape.trans (congrArg (fun j => before++[rankIterate p n j]) size))

theorem completeImageUnique (n depth : Nat) (positive : 0<n) (odd : n%2=1) :
 Unique (((List.range n).map (fun i => i+1)).map (fun p => rankIterate p n depth)) := by
 have u : Unique ((List.range n).map (fun i => i+1)) :=
  uniqueMap _ _ (uniqueRange n) (fun _ _ _ _ same => Nat.succ.inj same)
 apply uniqueMap _ _ u
 intro a ha b hb same
 have a := (positiveSupportMember n a).mp ha
 have b := (positiveSupportMember n b).mp hb
 exact everyDepthInjective n _ _ depth positive odd a.1 b.1 a.2 b.2 same

theorem everyRegionTallyInvariant (n depth : Nat) (positive : 0<n) (odd : n%2=1)
 (region : Nat → Bool) :
 ((((List.range n).map (fun i => i+1)).map (fun p => rankIterate p n depth)).filter region).length =
 (((List.range n).map (fun i => i+1)).filter region).length := by
 apply sameMembersLength
 · exact uniqueFilter region _ (completeImageUnique n depth positive odd)
 · exact uniqueFilter region _ (uniqueMap _ _ (uniqueRange n) (fun _ _ _ _ same => Nat.succ.inj same))
 · intro r
   constructor
   · intro h
     have ⟨member,held⟩ := (filterMember region _ r).mp h
     obtain ⟨p,m,eq⟩ := mapPreimage _ _ r member
     have bounds := (positiveSupportMember n p).mp m
     have rb := iterateBounds p n depth bounds.1 bounds.2
     exact (filterMember region _ r).mpr ⟨(positiveSupportMember n r).mpr (eq ▸ rb),held⟩
   · intro h
     have ⟨member,held⟩ := (filterMember region _ r).mp h
     have rb := (positiveSupportMember n r).mp member
     exact (filterMember region _ r).mpr ⟨completeSupportAtEveryDepth n depth r positive odd rb.1 rb.2,held⟩

end SFT.Physics.OddLatticeAllRegionGeneral
