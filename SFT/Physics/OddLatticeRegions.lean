import SFT.Physics.OddLatticeAllRegionGeneral
import SFT.Physics.VacuumScaleProofs
import SFT.Physics.NuclearBindingPeak
namespace SFT.Physics.OddLatticeRegions
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
private theorem quotientBounds (a d : Nat) (hd : 0<d) : d*(a/d)≤a ∧ a<d*(a/d+1) := by
 have split := remainderQuotient a d hd
 constructor
 · have h := Nat.le_add_left (d*(a/d)) (a%d)
   rw [split] at h
   exact h
 · have bound := Nat.add_lt_add_right (Nat.mod_lt a hd) (d*(a/d))
   rw [split,Nat.add_comm d,← Nat.mul_succ] at bound
   exact bound
private theorem quotientAt (a d k : Nat) (hd : 0<d) (low : d*k≤a) (high : a<d*(k+1)) : a/d=k := by
 have b := quotientBounds a d hd
 apply Nat.le_antisymm
 · by_cases h : a/d≤k
   · exact h
   · have lower := Nat.mul_le_mul_left d (Nat.succ_le_of_lt (Nat.lt_of_not_ge h))
     exact False.elim ((Nat.not_lt_of_ge (Nat.le_trans lower b.1)) high)
 · by_cases h : k≤a/d
   · exact h
   · have upper := Nat.mul_le_mul_left d (Nat.succ_le_of_lt (Nat.lt_of_not_ge h))
     exact False.elim ((Nat.not_lt_of_ge low) (Nat.lt_of_lt_of_le b.2 upper))

theorem everyInteriorRegionWitness (n r k : Nat) (hn : 0<n) (hr : 0<r)
 (rn : r≤n) (kp : 0<k) (kr : k<r) :
 ∃ i, 0<i ∧ i≤n ∧ (i*r)/n=k := by
 let a := k*n
 let q := a/r
 have split : a%r+r*q=a := remainderQuotient a r hr
 have ap : 0<a := Nat.mul_pos kp hn
 have finish (i : Nat) (ip : 0<i) (low : a≤r*i) (upper : r*i<n*(k+1)) :
  ∃ i, 0<i ∧ i≤n ∧ (i*r)/n=k := by
  have u := Nat.mul_le_mul_left n (Nat.succ_le_of_lt kr)
  have small := Nat.le_of_lt (Nat.lt_of_lt_of_le upper u)
  rw [Nat.mul_comm n r] at small
  have ib : i≤n := Nat.le_of_mul_le_mul_left small hr
  refine ⟨i,ip,ib,?_⟩
  rw [Nat.mul_comm i r]
  exact quotientAt (r*i) n k hn ((Nat.mul_comm n k) ▸ low) upper
 by_cases empty : a%r=0
 · have eq : r*q=a := by rw [empty,Nat.zero_add] at split; exact split
   have qp : 0<q := by
    apply Nat.pos_of_ne_zero
    intro zero
    rw [zero,Nat.mul_zero] at eq
    exact Nat.ne_of_gt ap eq.symm
   apply finish q qp (Nat.le_of_eq eq.symm)
   rw [eq,Nat.mul_succ,Nat.mul_comm n k]
   exact Nat.lt_add_of_pos_right hn
 · have positiveRemainder := Nat.pos_of_ne_zero empty
   have low : a≤r*(q+1) := by
    have h := Nat.add_le_add_right (Nat.le_of_lt (Nat.mod_lt a hr)) (r*q)
    rw [split,Nat.add_comm r,← Nat.mul_succ] at h
    exact h
   have upper : r*(q+1)<n*(k+1) := by
    have small := Nat.add_lt_add_right positiveRemainder (r*q)
    rw [Nat.zero_add,split] at small
    have first := Nat.add_le_add_left rn (r*q)
    have second := Nat.add_lt_add_right small n
    have combined := Nat.lt_of_le_of_lt first second
    rw [← Nat.mul_succ] at combined
    rw [Nat.mul_succ n k,Nat.mul_comm n k]
    exact combined
   exact finish (q+1) (Nat.zero_lt_succ q) low upper
private theorem scaledFloor (g a d : Nat) (hg : 0<g) (hd : 0<d) : (g*a)/(g*d)=a/d := by
 have bounds := quotientBounds a d hd
 apply quotientAt _ _ _ (Nat.mul_pos hg hd)
 · have low := Nat.mul_le_mul_left g bounds.1
   rw [← mulAssoc] at low
   exact low
 · have high := Nat.mul_lt_mul_of_pos_left bounds.2 hg
   rw [← mulAssoc] at high
   exact high

theorem normalizedRegionQuotient (i n r : Nat) (ip : 0<i) (hn : 0<n) :
 ((LeptonIntervals.normalize (.ofNat i) n hn).num.toNat*r)/(LeptonIntervals.normalize (.ofNat i) n hn).den = (i*r)/n := by
 cases i with
 | zero => exact False.elim (Nat.not_lt_zero _ ip)
 | succ i =>
  let g := Nat.gcd (i+1) n
  have gp : 0<g := gcdPositive (i+1) n hn
  have divs := gcdDivides (i+1) n
  have np : 0<n/g := quotientPositive n g hn gp divs.2
  change (((i+1)/g)*r)/(n/g)=((i+1)*r)/n
  have inum := quotientFactor (i+1) g gp divs.1
  have inden := quotientFactor n g gp divs.2
  have numerator : (i+1)*r=g*(((i+1)/g)*r) :=
   (congrArg (fun x => x*r) inum).trans (mulAssoc g ((i+1)/g) r)
  exact (scaledFloor g (((i+1)/g)*r) (n/g) gp np).symm.trans
   ((congrArg (fun a => a/(g*(n/g))) numerator.symm).trans
    (congrArg (fun d => ((i+1)*r)/d) inden.symm))

theorem everyRawRegionOccupied (n r region : Nat) (hn : 0<n) (hr : 0<r)
 (rn : r≤n) (positive : 0<region) (bound : region≤r) :
 ∃ i, 0<i ∧ i≤n ∧ (if (i*r)/n == r then 1 else (i*r)/n+1)=region := by
 cases region with
 | zero => exact False.elim (Nat.not_lt_zero _ positive)
 | succ k =>
  cases k with
  | zero =>
   refine ⟨n,hn,Nat.le_refl n,?_⟩
   have self (a : Nat) : (a==a)=true := by
    induction a with | zero => rfl | succ a ih => exact ih
   have quotient := divisionMultiple n r hn
   have guard := (congrArg (fun k => k==r) quotient).trans (self r)
   exact ite_eq_left guard
  | succ k =>
   obtain ⟨i,ip,ib,q⟩ := everyInteriorRegionWitness n r (k+1) hn hr rn
    (Nat.zero_lt_succ _) (Nat.lt_of_succ_le bound)
   refine ⟨i,ip,ib,?_⟩
   have no : ¬ ((i*r)/n==r)=true := by
    intro h
    have eq := Nat.eq_of_beq_eq_true h
    have wrong : k+1=r := q.symm.trans eq
    exact (Nat.ne_of_lt (Nat.lt_of_succ_le bound)) wrong
   exact (ite_eq_right no).trans (congrArg Nat.succ q)
open VacuumLedgerProofs VacuumScaleProofs LeptonIntervals OddLatticeAllRegion
private theorem notBelow (a b : Nat) (bound : b≤a) : ¬ Int.ofNat a < Int.ofNat b := by
 intro bad
 change Int.NonNeg (Int.subNatNat b (a+1)) at bad
 unfold Int.subNatNat at bad
 cases h : (a+1)-b with
 | zero => exact Nat.not_succ_le_self a (Nat.le_trans (Nat.le_of_sub_eq_zero h) bound)
 | succ k => rw [h] at bad; cases bad

theorem normalizedWithinOne (i n : Nat) (ip : 0<i) (hn : 0<n) (bound : i≤n) :
 (normalize 1 1 (by decide)).blt (natRatio i n hn)=false := by
 have value := natRatioValue i n hn
 have scaled := Nat.mul_le_mul_right (natRatio i n hn).den bound
 rw [value,Nat.mul_comm n] at scaled
 have nb := Nat.le_of_mul_le_mul_right scaled hn
 have positive := positiveNormalizedNumerator i n ip hn
 unfold Rat.blt
 rw [natRatioNonnegative i n hn]
 generalize eq : (natRatio i n hn).num.natAbs=m at positive nb ⊢
 cases m with
 | zero => exact False.elim (Nat.not_lt_zero _ positive)
 | succ m =>
  have nonpos : ¬Int.ofNat (m+1)≤0 := by
   intro h
   change Int.NonNeg (Int.subNatNat 0 (m+1)) at h
   unfold Int.subNatNat at h
   rw [Nat.sub_zero] at h
   cases h
  change (if decide (Int.ofNat (m+1)≤0) then false else
   decide (Int.ofNat (1*(natRatio i n hn).den) < Int.ofNat ((m+1)*1)))=false
  rw [decide_eq_false nonpos]
  change decide (Int.ofNat (1*(natRatio i n hn).den) < Int.ofNat ((m+1)*1))=false
  rw [Nat.one_mul,Nat.mul_one]
  exact decide_eq_false (notBelow _ _ nb)

theorem originalRegionFormula (i n r : Nat) (ip : 0<i) (hn : 0<n) (hr : 0<r) (bound : i≤n) :
 positiveRegionLabel (natRatio i n hn) (.integer (.ofNat r)) =
 .ok (if (i*r)/n==r then 1 else (i*r)/n+1) := by
 cases r with
 | zero => exact False.elim (Nat.not_lt_zero _ hr)
 | succ r =>
  unfold positiveRegionLabel requirePositiveWhole
  dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
  have guard : (!zero.blt (natRatio i n hn) || (normalize 1 1 (by decide)).blt (natRatio i n hn))=false := by
   rw [positiveNormalized i n ip hn,normalizedWithinOne i n ip hn bound]
   rfl
  exact (ite_eq_right (fun h => Bool.noConfusion (guard.symm.trans h))).trans
   (congrArg (fun k => Except.ok (if k==r+1 then 1 else k+1)) (normalizedRegionQuotient i n (r+1) ip hn))

theorem everyOriginalRegionOccupied (n r region : Nat) (hn : 0<n) (hr : 0<r)
 (rn : r≤n) (positive : 0<region) (bound : region≤r) :
 ∃ i, 0<i ∧ i≤n ∧ positiveRegionLabel (natRatio i n hn) (.integer (.ofNat r))=.ok region := by
 obtain ⟨i,ip,ib,label⟩ := everyRawRegionOccupied n r region hn hr rn positive bound
 exact ⟨i,ip,ib,(originalRegionFormula i n r ip hn hr ib).trans (congrArg Except.ok label)⟩

-- Reuse of the established source-loop correspondence proof from NuclearBindingScoreComposition.
private theorem reverseAuxAppend {α : Type} (xs ys zs : List α) :
 xs.reverseAux (ys++zs) = xs.reverseAux ys ++ zs := by
 induction xs generalizing ys with
 | nil => rfl
 | cons a xs ih => exact ih (a::ys)
private theorem reverseCons {α : Type} (x : α) (xs : List α) :
 (x::xs).reverse = xs.reverse ++ [x] := reverseAuxAppend xs [] [x]
private theorem appendNil {α : Type} (xs : List α) : xs++[] = xs := by
 induction xs with
 | nil => rfl
 | cons a xs ih => exact congrArg (List.cons a) ih
private def recMap {α β : Type} (f : α → Except String β) : List α → Except String (List β)
 | [] => .ok []
 | a::xs => do
   let b ← f a
   let bs ← recMap f xs
   pure (b::bs)
private theorem loopRec {α β : Type} (f : α → Except String β) (xs : List α) (acc : List β) :
 List.mapM.loop f xs acc = (recMap f xs).map (fun rows => acc.reverse ++ rows) := by
 induction xs generalizing acc with
 | nil => exact congrArg Except.ok (appendNil acc.reverse).symm
 | cons a xs ih =>
   rw [List.mapM.loop.eq_2]
   unfold recMap
   cases hf : f a with
   | error e => rfl
   | ok b =>
     change List.mapM.loop f xs (b::acc) = _
     rw [ih]
     cases hr : recMap f xs with
     | error e => rfl
     | ok bs =>
       change Except.ok ((b::acc).reverse ++ bs) = Except.ok (acc.reverse ++ b::bs)
       rw [reverseCons]
       exact congrArg Except.ok (SFT.Physics.VacuumLedgerProofs.appendAssociative acc.reverse [b] bs)
private theorem mapRec {α β : Type} (f : α → Except String β) (xs : List α) : xs.mapM f = recMap f xs := by
 change List.mapM.loop f xs [] = _
 rw [loopRec]
 cases recMap f xs <;> rfl

private theorem mapMValues {α β : Type} (f : α → Except String β) (g : α → β) (xs : List α)
 (values : ∀ x, x ∈ xs → f x=.ok (g x)) : xs.mapM f=.ok (xs.map g) := by
 rw [mapRec]
 induction xs with
 | nil => rfl
 | cons a xs ih =>
  unfold recMap
  rw [values a (List.Mem.head _)]
  change (do let rest ← recMap f xs; pure (g a::rest))=_
  rw [ih (fun x h => values x (List.Mem.tail a h))]
  rfl
private theorem reverseAuxJoin {α : Type} (xs ys acc : List α) :
 (xs++ys).reverseAux acc=ys.reverseAux (xs.reverseAux acc) := by
 induction xs generalizing acc with
 | nil => rfl
 | cons a xs ih => exact ih (a::acc)
private theorem reverseLast {α : Type} (before : List α) (last : α) :
 (before++[last]).reverse=last::before.reverse := reverseAuxJoin before [last] []

open SFT.Mathematics.OrbitOrderIdentity SFT.Mathematics.OrbitCyclotomic SFT.Mathematics.OrbitCycleSupport
open OddLatticeAllRegionGeneral

theorem originalLastIndex (n p k : Nat) (hn : 0<n) (odd : n/2+n/2+1=n) (pp : 0<p) (pb : p≤n) :
 (do
  let trace ← foldIndexTrace (.integer (.ofNat p)) (.integer (.ofNat n)) (.integer (.ofNat (k+1)))
  match trace.reverse with | last::_ => pure last | [] => throw "IndexError") =
  (Except.ok (rankIterate p n (k+1)) : Except String Nat) := by
 obtain ⟨before,eq⟩ := originalTraceEndsAtIterate n p k hn odd pp pb
 rw [eq]
 change (match (before++[rankIterate p n (k+1)]).reverse with | last::_ => Except.ok last | [] => Except.error "IndexError")=_
 rw [reverseLast]

theorem originalFoldedLattice (n k : Nat) (hn : 0<n) (odd : n/2+n/2+1=n) :
 foldedLattice (.integer (.ofNat n)) (.integer (.ofNat (k+1))) =
 .ok (((List.range n).map (fun i => rankIterate (i+1) n (k+1))).map (fun i => natRatio i n hn)) := by
 have mapped := mapMValues
  (fun i => do
   let trace ← foldIndexTrace (.integer (.ofNat (i+1))) (.integer (.ofNat n)) (.integer (.ofNat (k+1)))
   match trace.reverse with | last::_ => pure last | [] => throw "IndexError")
  (fun i => rankIterate (i+1) n (k+1)) (List.range n) (by
   intro i h
   exact originalLastIndex n (i+1) k hn odd (Nat.zero_lt_succ i) (Nat.succ_le_of_lt ((rangeMember n i).mp h)))
 unfold foldedLattice requirePositiveWhole countInteger
 dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure, Int.toNat] at mapped ⊢
 exact (congrArg (fun result : Except String (List Nat) => result.bind (fun indices =>
  if h : 0<n then Except.ok (indices.map (fun i => normalize (.ofNat i) n h)) else Except.ok [])) mapped).trans
  (dite_eq_left hn)

private theorem mapMOnMap {α β γ : Type} (f : β → Except String γ) (g : α → β) (h : α → γ)
 (xs : List α) (values : ∀ x, x ∈ xs → f (g x)=.ok (h x)) :
 (xs.map g).mapM f=.ok (xs.map h) := by
 rw [mapRec]
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change recMap f (g x::xs.map g)=_
  unfold recMap
  rw [values x (List.Mem.head _)]
  change (do let tail ← recMap f (xs.map g); pure (h x::tail))=_
  rw [ih (fun x m => values x (List.Mem.tail _ m))]
  rfl

theorem originalOccupancyFormula (n r k : Nat) (hn : 0<n) (hr : 0<r)
 (rn : r≤n) (odd : n/2+n/2+1=n) :
 occupancyVector (.integer (.ofNat n)) (.integer (.ofNat (k+1))) (.integer (.ofNat r)) =
 .ok ((List.range r).map (fun j =>
  (((List.range n).map (fun i => rankIterate (i+1) n (k+1))).map
   (fun i => if (i*r)/n==r then 1 else (i*r)/n+1)).filter (fun label => label==j+1) |>.length)) := by
 cases r with
 | zero => exact False.elim (Nat.not_lt_zero _ hr)
 | succ r =>
  let indices := (List.range n).map (fun i => rankIterate (i+1) n (k+1))
  have labels := mapMOnMap (fun p => positiveRegionLabel p (.integer (.ofNat (r+1))))
   (fun i => natRatio i n hn) (fun i => if (i*(r+1))/n==r+1 then 1 else (i*(r+1))/n+1) indices (by
    intro i member
    obtain ⟨a,m,eq⟩ := mapPreimage _ _ i member
    have ib := iterateBounds (a+1) n (k+1) (Nat.zero_lt_succ a) (Nat.succ_le_of_lt ((rangeMember n a).mp m))
    cases eq
    exact originalRegionFormula _ n (r+1) ib.1 hn hr ib.2)
  unfold occupancyVector requirePositiveWhole countInteger
  dsimp only [Bind.bind, Except.bind, Pure.pure, Except.pure]
  rw [ite_eq_right (notBelow n (r+1) rn)]
  change (do
   let parts ← foldedLattice (.integer (.ofNat n)) (.integer (.ofNat (k+1)))
   let labels ← parts.mapM (fun p => positiveRegionLabel p (.integer (.ofNat (r+1))))
   pure ((List.range (r+1)).map (fun i => (labels.filter (fun label => label==i+1)).length)))=_
  rw [originalFoldedLattice n k hn odd]
  change (do let labels ← (indices.map (fun i => natRatio i n hn)).mapM (fun p => positiveRegionLabel p (.integer (.ofNat (r+1))))
             pure ((List.range (r+1)).map (fun i => (labels.filter (fun label => label==i+1)).length)))=_
  exact congrArg (fun result : Except String (List Nat) => result.bind (fun labels =>
   Except.ok ((List.range (r+1)).map (fun i => (labels.filter (fun label => label==i+1)).length)))) labels
private theorem mapTwice {α β γ : Type} (f : α → β) (g : β → γ) (xs : List α) :
 (xs.map f).map g=xs.map (fun x => g (f x)) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons (g (f x))) ih
private theorem filterMappedLength {α β : Type} (f : α → β) (p : β → Bool) (xs : List α) :
 ((xs.map f).filter p).length=(xs.filter (fun x => p (f x))).length := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change (match p (f x) with | true => f x::(xs.map f).filter p | false => (xs.map f).filter p).length =
   (match p (f x) with | true => x::xs.filter (fun x => p (f x)) | false => xs.filter (fun x => p (f x))).length
  cases p (f x) with | false => exact ih | true => exact congrArg Nat.succ ih
private theorem mapSame {α β : Type} (f g : α → β) (xs : List α) (same : ∀ x, f x=g x) : xs.map f=xs.map g := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change f x::xs.map f=g x::xs.map g
  exact (congrArg (fun b => b::xs.map f) (same x)).trans (congrArg (List.cons (g x)) ih)

theorem originalOccupancyDepthInvariant (n r k : Nat) (hn : 0<n) (hr : 0<r)
 (rn : r≤n) (odd : n/2+n/2+1=n) :
 occupancyVector (.integer (.ofNat n)) (.integer (.ofNat (k+1))) (.integer (.ofNat r)) =
 occupancyVector (.integer (.ofNat n)) (.integer 1) (.integer (.ofNat r)) := by
 refine (originalOccupancyFormula n r k hn hr rn odd).trans ((congrArg Except.ok ?_).trans (originalOccupancyFormula n r 0 hn hr rn odd).symm)
 apply mapSame
 intro j
 conv => lhs; rw [filterMappedLength]
 conv => rhs; rw [filterMappedLength]
 rw [← mapTwice (fun i => i+1) (fun p => rankIterate p n (k+1)) (List.range n),
  ← mapTwice (fun i => i+1) (fun p => rankIterate p n 1) (List.range n)]
 exact (everyRegionTallyInvariant n (k+1) hn (sourceOddRemainder n odd) _).trans
  (everyRegionTallyInvariant n 1 hn (sourceOddRemainder n odd) _).symm

open SFT.Mathematics.OrbitTilingCount
private theorem positiveLengthOfMember {α : Type} (x : α) (xs : List α) (member : x ∈ xs) : 0<xs.length := by
 cases xs with | nil => cases member | cons a xs => exact Nat.zero_lt_succ _

theorem everyExecutedRegionPositive (n r k region : Nat) (hn : 0<n) (hr : 0<r)
 (rn : r≤n) (odd : n/2+n/2+1=n) (rp : 0<region) (rb : region≤r) :
 0<(((((List.range n).map (fun i => rankIterate (i+1) n (k+1))).map
  (fun i => if (i*r)/n==r then 1 else (i*r)/n+1)).filter (fun label => label==region)).length) := by
 obtain ⟨i,ip,ib,label⟩ := everyRawRegionOccupied n r region hn hr rn rp rb
 have member := completeSupportAtEveryDepth n (k+1) i hn (sourceOddRemainder n odd) ip ib
 rw [mapTwice] at member
 have image := mapMember (fun i => if (i*r)/n==r then 1 else (i*r)/n+1) _ i member
 have held : region ∈ ((List.range n).map (fun i => rankIterate (i+1) n (k+1))).map
  (fun i => if (i*r)/n==r then 1 else (i*r)/n+1) := label ▸ image
 apply positiveLengthOfMember region
 apply (filterMember _ _ region).mpr
 have self (a : Nat) : (a==a)=true := by
  induction a with | zero => rfl | succ a ih => exact ih
 exact ⟨held,self region⟩
theorem originalRegionRange (i n r : Nat) (hn : 0<n) (hr : 0<r) (ib : i≤n) :
 0<(if (i*r)/n==r then 1 else (i*r)/n+1) ∧
 (if (i*r)/n==r then 1 else (i*r)/n+1)≤r := by
 have low := (quotientBounds (i*r) n hn).1
 have upper := Nat.mul_le_mul_right r ib
 have scaled := Nat.le_trans low upper
 rw [Nat.mul_comm n ((i*r)/n),Nat.mul_comm n r] at scaled
 have qb := Nat.le_of_mul_le_mul_right scaled hn
 by_cases eq : ((i*r)/n==r)=true
 · rw [ite_eq_left eq]
   exact ⟨by decide,hr⟩
 · rw [ite_eq_right eq]
   have neq : (i*r)/n≠r := by
    intro same
    have self (a : Nat) : (a==a)=true := by
     induction a with | zero => rfl | succ a ih => exact ih
    exact eq ((congrArg (fun a => a==r) same).trans (self r))
   exact ⟨Nat.zero_lt_succ _,Nat.succ_le_of_lt (Nat.lt_of_le_of_ne qb neq)⟩

private def sumCounts (keys labels : List Nat) : Nat :=
 match keys with
 | [] => 0
 | key::rest => (labels.filter (fun x => x==key)).length+sumCounts rest labels
private theorem beqSelf (n : Nat) : (n==n)=true := by
 induction n with | zero => rfl | succ n ih => exact ih
private theorem beqDifferent (a b : Nat) (h : a≠b) : (a==b)=false := by
 cases eq : a==b with
 | false => rfl
 | true => exact False.elim (h (Nat.eq_of_beq_eq_true eq))
private theorem absentCounts (keys labels : List Nat) (x : Nat) (absent : ¬ x ∈ keys) :
 sumCounts keys (x::labels)=sumCounts keys labels := by
 induction keys with
 | nil => rfl
 | cons key rest ih =>
  have ne : x≠key := fun h => absent (h ▸ List.Mem.head rest)
  have tail : ¬x ∈ rest := fun h => absent (List.Mem.tail key h)
  unfold sumCounts
  change (match x==key with | true => x::labels.filter (fun x => x==key) | false => labels.filter (fun x => x==key)).length + _ = _
  rw [beqDifferent x key ne,ih tail]
private theorem insertionCounts (keys labels : List Nat) (x : Nat) (unique : Unique keys) (member : x ∈ keys) :
 sumCounts keys (x::labels)=sumCounts keys labels+1 := by
 induction keys with
 | nil => cases member
 | cons key rest ih =>
  by_cases eq : x=key
  · cases eq
    unfold sumCounts
    change (match x==x with | true => x::labels.filter (fun a => a==x) | false => labels.filter (fun a => a==x)).length+_=_
    rw [beqSelf,absentCounts rest labels x unique.1]
    exact Nat.add_right_comm _ 1 _
  · have tail : x ∈ rest := by
     cases member with | head => exact False.elim (eq rfl) | tail _ h => exact h
    unfold sumCounts
    change (match x==key with | true => x::labels.filter (fun a => a==key) | false => labels.filter (fun a => a==key)).length+_=_
    rw [beqDifferent x key eq,ih unique.2 tail]
    exact (Nat.add_assoc _ _ 1).symm
private theorem completeCounts (keys labels : List Nat) (unique : Unique keys)
 (complete : ∀ x, x ∈ labels → x ∈ keys) : sumCounts keys labels=labels.length := by
 induction labels with
 | nil =>
  induction keys with
  | nil => rfl
  | cons key rest ih =>
   change 0+sumCounts rest []=0
   rw [Nat.zero_add]
   exact ih unique.2 (fun _ h => by cases h)
 | cons x xs ih =>
  rw [insertionCounts keys xs x unique (complete x (List.Mem.head xs)),ih (fun x m => complete x (List.Mem.tail _ m))]
  rfl
private theorem sumCountsFold (keys labels : List Nat) (acc : Nat) :
 (keys.map (fun key => (labels.filter (fun x => x==key)).length)).foldl Nat.add acc=acc+sumCounts keys labels := by
 induction keys generalizing acc with
 | nil => rfl
 | cons key rest ih =>
  change (rest.map _).foldl Nat.add (acc+(labels.filter (fun x => x==key)).length)=_
  rw [ih]
  exact Nat.add_assoc _ _ _
theorem completeOriginalOccupancy (n r k : Nat) (hn : 0<n) (hr : 0<r)
 (rn : r≤n) (odd : n/2+n/2+1=n) : ∃ vector,
 occupancyVector (.integer (.ofNat n)) (.integer (.ofNat (k+1))) (.integer (.ofNat r))=.ok vector ∧
 vector.length=r ∧ vector.foldl Nat.add 0=n ∧ ∀ v, v ∈ vector → 0<v := by
 let indices := (List.range n).map (fun i => rankIterate (i+1) n (k+1))
 let labels := indices.map (fun i => if (i*r)/n==r then 1 else (i*r)/n+1)
 let vector := (List.range r).map (fun j => (labels.filter (fun label => label==j+1)).length)
 let keys := (List.range r).map (fun i => i+1)
 have unique : Unique keys := uniqueMap (fun i => i+1) _ (uniqueRange r) (fun _ _ _ _ eq => Nat.succ.inj eq)
 have coverage : ∀ x, x ∈ labels → x ∈ keys := by
  intro x member
  obtain ⟨i,im,eq⟩ := mapPreimage _ _ x member
  obtain ⟨a,am,ieq⟩ := mapPreimage _ _ i im
  have ib := iterateBounds (a+1) n (k+1) (Nat.zero_lt_succ a) (Nat.succ_le_of_lt ((rangeMember n a).mp am))
  have bounds := originalRegionRange i n r hn hr (ieq ▸ ib.2)
  have xb : 0<x ∧ x≤r := eq ▸ bounds
  cases x with
  | zero => exact False.elim (Nat.not_lt_zero _ xb.1)
  | succ x => exact mapMember (fun i => i+1) (List.range r) x ((rangeMember r x).mpr (Nat.lt_of_succ_le xb.2))
 have conserved : vector.foldl Nat.add 0=n := by
  have fold := sumCountsFold keys labels 0
  have shape : keys.map (fun key => (labels.filter (fun x => x==key)).length)=vector := mapTwice _ _ (List.range r)
  rw [shape,Nat.zero_add,completeCounts keys labels unique coverage] at fold
  have size : labels.length=n :=
   (mappedLength _ indices).trans ((mappedLength _ (List.range n)).trans (rangeLoopLength n []))
  exact fold.trans size
 refine ⟨vector,originalOccupancyFormula n r k hn hr rn odd,?_,conserved,?_⟩
 · exact (mappedLength _ (List.range r)).trans (rangeLoopLength r [])
 · intro v member
   obtain ⟨j,m,eq⟩ := mapPreimage _ _ v member
   have positive := everyExecutedRegionPositive n r k (j+1) hn hr rn odd
    (Nat.zero_lt_succ j) (Nat.succ_le_of_lt ((rangeMember r j).mp m))
   exact eq ▸ positive
end SFT.Physics.OddLatticeRegions
