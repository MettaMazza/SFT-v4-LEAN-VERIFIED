import SFT.Physics.LatticeOperatorCycleCounts
import SFT.Physics.DecayWidthBranchingLifetimeGeneral
namespace SFT.Physics.LatticeOperatorCycle
open LatticeOperator LatticeOperatorCycleCounts LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation Count.TraceDerivation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
private theorem mapEqualOn {α β : Type} (xs : List α) (f g : α → β)
 (same : ∀ x,x∈xs → f x=g x) : xs.map f=xs.map g := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change f x::xs.map f=g x::xs.map g
  rw [same x (List.Mem.head _),ih (fun a h => same a (List.Mem.tail x h))]
private theorem rangeBound (size i : Nat) (h : i∈List.range size) : i<size := by
 have loop (n : Nat) (acc : List Nat) (bound : n≤size)
  (old : ∀ j,j∈acc → j<size) (held : i∈List.range.loop n acc) : i<size := by
  induction n generalizing acc with
  | zero => exact old i held
  | succ n ih =>
   apply ih (n::acc) (Nat.le_trans (Nat.le_succ n) bound) _ held
   intro j hj
   cases hj with
   | head => exact bound
   | tail _ hj => exact old j hj
 exact loop size [] (Nat.le_refl _) (fun _ h => nomatch h) h
private theorem siteNumerator (xs : List Nat) (d : Nat) (hd : 0<d) (i : Nat)
 (inside : i<xs.length) :
 siteAt (xs.map (fun n => natRatio n d hd)) i=natRatio (countAt xs i) d hd := by
 induction xs generalizing i with
 | nil => exact False.elim (Nat.not_lt_zero _ inside)
 | cons a xs ih =>
  cases i with
  | zero => rfl
  | succ i => exact ih i (Nat.lt_of_succ_lt_succ inside)
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
       exact congrArg Except.ok (appendAssociative acc.reverse [b] bs)
private theorem mapRec {α β : Type} (f : α → Except String β) (xs : List α) : xs.mapM f = recMap f xs := by
 change List.mapM.loop f xs [] = _
 rw [loopRec]
 cases recMap f xs <;> rfl

private theorem validateNumerators (xs : List Nat) (d : Nat) (hd : 0<d)
 (positive : ∀ n,n∈xs → 0<n) (check : FoldFirstReturn.Input → Except String Rat)
 (accept : ∀ n,0<n → check (.fraction (natRatio n d hd))=.ok (natRatio n d hd)) :
 ((xs.map (fun n => natRatio n d hd)).map FoldFirstReturn.Input.fraction).mapM check=
 .ok (xs.map (fun n => natRatio n d hd)) := by
 rw [mapRec]
 induction xs with
 | nil => rfl
 | cons a xs ih =>
  change (do let head ← check (.fraction (natRatio a d hd)); let tail ← _; pure (head::tail))=_
  rw [accept a (positive a (List.Mem.head _))]
  dsimp only [Except.bind,Bind.bind]
  rw [ih (fun n h => positive n (List.Mem.tail a h))]
  rfl
private theorem weightedNumerators (a b c d : Nat) (hd : 0<d) :
 add (add (multiply LatticeOperator.half (natRatio a d hd))
  (multiply quarter (natRatio b d hd))) (multiply quarter (natRatio c d hd))=
 natRatio (2*a+b+c) (4*d) (Nat.mul_pos (by decide) hd) := by
 have halfShare : multiply LatticeOperator.half (natRatio a d hd)=
  natRatio (2*a) (4*d) (Nat.mul_pos (by decide) hd) := by
  change multiply (natRatio 1 2 (by decide)) (natRatio a d hd)=_
  rw [multiplyNormalized,Nat.one_mul]
  apply natRatioCongruence
  calc
   a*(4*d)=(a*4)*d := (SFT.Foundation.FractionReduction.mulAssoc a 4 d).symm
   _=((a*2)*2)*d := congrArg (fun k => k*d) (SFT.Foundation.FractionReduction.mulAssoc a 2 2).symm
   _=(a*2)*(2*d) := SFT.Foundation.FractionReduction.mulAssoc (a*2) 2 d
   _=(2*a)*(2*d) := congrArg (fun k => k*(2*d)) (Nat.mul_comm a 2)
 have quarterShare (n : Nat) : multiply quarter (natRatio n d hd)=
  natRatio n (4*d) (Nat.mul_pos (by decide) hd) := by
  change multiply (natRatio 1 4 (by decide)) (natRatio n d hd)=_
  rw [multiplyNormalized,Nat.one_mul]
 rw [halfShare,quarterShare,quarterShare,addNormalized,addNormalized]

theorem originalCommonDenominatorUpdate (xs : List Nat) (d : Nat) (hd : 0<d)
 (positive : ∀ n,n∈xs → 0<n) (size : 3≤xs.length) :
 cyclicUpdate ((xs.map (fun n => natRatio n d hd)).map FoldFirstReturn.Input.fraction)=
 .ok ((updateNumerators xs).map (fun n => natRatio n (4*d) (Nat.mul_pos (by decide) hd))) := by
 unfold cyclicUpdate
 rw [VacuumSpectrum.mappedLength,VacuumSpectrum.mappedLength]
 rw [if_neg (Nat.not_lt_of_ge size)]
 dsimp only
 rw [validateNumerators xs d hd positive _ (by
  intro n hn
  dsimp only
  rw [positiveNormalized n d hn hd]
  rfl)]
 dsimp only [Except.bind,Bind.bind,Except.pure,Pure.pure]
 rw [VacuumSpectrum.mappedLength]
 apply congrArg Except.ok
 have mapTwice {α β γ : Type} (as : List α) (f : α → β) (g : β → γ) :
  (as.map f).map g=as.map (fun a => g (f a)) := by
  induction as with
  | nil => rfl
  | cons a as ih => exact congrArg (List.cons _) ih
 unfold updateNumerators
 rw [mapTwice]
 apply mapEqualOn
 intro i hi
 have hp : 0<xs.length := Nat.lt_of_lt_of_le (by decide : 0<3) size
 rw [siteNumerator xs d hd i (rangeBound _ _ hi),
  siteNumerator xs d hd _ (Nat.mod_lt _ hp),siteNumerator xs d hd _ (Nat.mod_lt _ hp)]
 exact weightedNumerators _ _ _ _ hd
private theorem oneRatio (d : Nat) (hd : 0<d) : natRatio d d hd=LatticeOperator.one := by
 change natRatio d d hd=natRatio 1 1 (by decide)
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.one_mul]
private theorem foldOne (xs : List Nat) (d : Nat) (hd : 0<d) :
 (xs.map (fun n => natRatio n d hd)).foldl add LatticeOperator.one=
 natRatio (d+xs.foldl Nat.add 0) d hd := by
 rw [← oneRatio d hd,foldNormalized]
 have accum (ns : List Nat) (k : Nat) : ns.foldl Nat.add k=k+ns.foldl Nat.add 0 := by
  induction ns generalizing k with
  | nil => rfl
  | cons a ns ih =>
   change ns.foldl Nat.add (k+a)=k+ns.foldl Nat.add (0+a)
   rw [ih (k+a),ih (0+a),Nat.zero_add,Nat.add_assoc]
 rw [accum]

theorem originalNormalizedConservation (xs : List Nat) (d : Nat) (hd : 0<d)
 (positive : ∀ n,n∈xs → 0<n) (size : 3≤xs.length) :
 (do let ys ← cyclicUpdate ((xs.map (fun n => natRatio n d hd)).map FoldFirstReturn.Input.fraction)
     pure (total ys))=.ok (total (xs.map (fun n => natRatio n d hd))) := by
 rw [originalCommonDenominatorUpdate xs d hd positive size]
 dsimp only [Except.bind,Bind.bind,Except.pure,Pure.pure]
 apply congrArg Except.ok
 unfold total
 apply congrArg (fun q => subtract q LatticeOperator.one)
 rw [foldOne,foldOne,originalCountUpdateTotal xs (Nat.lt_of_lt_of_le (by decide : 0<3) size)]
 apply natRatioCongruence
 rw [← Nat.mul_add,Nat.mul_comm 4 _,SFT.Foundation.FractionReduction.mulAssoc]

private theorem sourcePositiveGuard (q : Rat) (positive : zero.blt q=true) :
 decide (q.num<1)=false := by
 cases hn : q.num with
 | negSucc k =>
  unfold zero Rat.blt at positive
  rw [hn] at positive
  contradiction
 | ofNat n =>
  cases n with
  | zero =>
   unfold zero Rat.blt at positive
   rw [hn] at positive
   contradiction
  | succ n =>
   apply decide_eq_false
   intro bad
   change Int.NonNeg (Int.subNatNat 1 (n+2)) at bad
   unfold Int.subNatNat at bad
   rw [Nat.succ_sub_succ_eq_sub,Nat.sub_zero] at bad
   cases bad

theorem originalEveryPositiveCycleConserves (xs : List Rat)
 (positive : ∀ q,q∈xs → zero.blt q=true) (size : 3≤xs.length) :
 (do let ys ← cyclicUpdate (xs.map FoldFirstReturn.Input.fraction); pure (total ys))=.ok (total xs) := by
 obtain ⟨d,hd,ns,hp,eq⟩ := DecayWidthBranchingLifetimeGeneral.everyPositiveFamilyHasCommonDenominator xs
  (fun q h => sourcePositiveGuard q (positive q h))
 have lengthEq : xs.length=ns.length := (congrArg List.length eq).trans (VacuumSpectrum.mappedLength _ ns)
 rw [eq]
 exact originalNormalizedConservation ns d hd hp (lengthEq ▸ size)
private theorem mapReplicate {α β : Type} (n : Nat) (a : α) (f : α → β) :
 (List.replicate n a).map f=List.replicate n (f a) := by
 induction n with
 | zero => rfl
 | succ n ih => exact congrArg (List.cons (f a)) ih
private theorem replicateLength {α : Type} (n : Nat) (a : α) : (List.replicate n a).length=n := by
 induction n with
 | zero => rfl
 | succ n ih => exact congrArg Nat.succ ih
private theorem replicateCountAt (n a i : Nat) (hi : i<n) : countAt (List.replicate n a) i=a := by
 induction n generalizing i with
 | zero => exact False.elim (Nat.not_lt_zero _ hi)
 | succ n ih =>
  cases i with
  | zero => rfl
  | succ i => exact ih i (Nat.lt_of_succ_lt_succ hi)

theorem originalNormalizedFlatState (n a d : Nat) (ha : 0<a) (hd : 0<d) (size : 3≤n) :
 cyclicUpdate ((List.replicate n (natRatio a d hd)).map FoldFirstReturn.Input.fraction)=
 .ok (List.replicate n (natRatio a d hd)) := by
 have hn : 0<n := Nat.lt_of_lt_of_le (by decide : 0<3) size
 have all (k : Nat) : ∀ j,j∈List.replicate k a → 0<j := by
  induction k with
  | zero => intro j h; cases h
  | succ k ih =>
   intro j hj
   cases hj with
   | head => exact ha
   | tail _ h => exact ih j h
 have positive := all n
 have bound : 3≤(List.replicate n a).length := by rw [replicateLength]; exact size
 have eq := originalCommonDenominatorUpdate (List.replicate n a) d hd positive bound
 rw [mapReplicate] at eq
 have result : (updateNumerators (List.replicate n a)).map (fun j => natRatio j (4*d) (Nat.mul_pos (by decide) hd))=
  List.replicate n (natRatio a d hd) := by
  have mapTwice {α β γ : Type} (as : List α) (f : α → β) (g : β → γ) :
   (as.map f).map g=as.map (fun a => g (f a)) := by
   induction as with
   | nil => rfl
   | cons a as ih => exact congrArg (List.cons _) ih
  unfold updateNumerators
  rw [replicateLength,mapTwice]
  have same : (List.range n).map (fun i => natRatio
   (2*countAt (List.replicate n a) i+countAt (List.replicate n a) ((i+n-1)%n)+countAt (List.replicate n a) ((i+1)%n))
   (4*d) (Nat.mul_pos (by decide) hd))=(List.range n).map (fun _ => natRatio a d hd) := by
   apply mapEqualOn
   intro i hi
   rw [replicateCountAt n a i (rangeBound n i hi),replicateCountAt n a _ (Nat.mod_lt _ hn),
    replicateCountAt n a _ (Nat.mod_lt _ hn),← Nat.succ_mul,← Nat.succ_mul]
   apply natRatioCongruence
   exact (congrArg (fun k => k*d) (Nat.mul_comm 4 a)).trans
    (SFT.Foundation.FractionReduction.mulAssoc a 4 d)
  rw [same]
  have constant (xs : List Nat) : xs.map (fun _ => natRatio a d hd)=List.replicate xs.length (natRatio a d hd) := by
   induction xs with
   | nil => rfl
   | cons x xs ih => exact congrArg (List.cons _) ih
  rw [constant]
  exact congrArg (fun k => List.replicate k (natRatio a d hd))
   ((VacuumSpectrum.rangeLoopLength n []).trans (Nat.add_zero _))
 exact eq.trans (congrArg Except.ok result)

theorem originalEveryPositiveFlatState (n : Nat) (q : Rat) (size : 3≤n) (positive : zero.blt q=true) :
 cyclicUpdate ((List.replicate n q).map FoldFirstReturn.Input.fraction)=.ok (List.replicate n q) := by
 have guard : ∀ r,r∈[q] → decide (r.num<1)=false := by
  intro r hr
  cases hr with
  | head => exact sourcePositiveGuard q positive
  | tail _ h => cases h
 obtain ⟨d,hd,ns,hp,eq⟩ := DecayWidthBranchingLifetimeGeneral.everyPositiveFamilyHasCommonDenominator [q] guard
 cases ns with
 | nil => cases eq
 | cons a rest =>
  cases rest with
  | nil =>
   have hq : q=natRatio a d hd := (List.cons.inj eq).1
   rw [hq]
   exact originalNormalizedFlatState n a d (hp a (List.Mem.head _)) hd size
  | cons b rest => cases (List.cons.inj eq).2
end SFT.Physics.LatticeOperatorCycle
