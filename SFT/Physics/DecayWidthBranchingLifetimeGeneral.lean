import SFT.Physics.DecayWidthBranchingLifetime
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.DecayWidthBranchingLifetimeGeneral
open DecayWidthBranchingLifetime LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.ExactCast
set_option maxHeartbeats 100000000
private theorem positiveNumeratorGuard (n d : Nat) (hn : 0<n) (hd : 0<d) :
 decide ((natRatio n d hd).num<1)=false := by
 rw [natRatioNonnegative n d hd]
 have pos := positiveNormalizedNumerator n d hn hd
 generalize h : (natRatio n d hd).num.natAbs=k at pos ⊢
 cases k with
 | zero => cases pos
 | succ k =>
  apply decide_eq_false
  intro bad
  change Int.NonNeg (Int.subNatNat 1 (k+2)) at bad
  unfold Int.subNatNat at bad
  rw [Nat.succ_sub_succ_eq_sub,Nat.sub_zero] at bad
  cases bad
private theorem familyGuard (xs : List Nat) (d : Nat) (hd : 0<d)
 (positive : ∀ n, n∈xs → 0<n) :
 ((xs.map (fun n => natRatio n d hd)).any (fun r => decide (r.num<1)))=false := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change (decide ((natRatio x d hd).num<1) || (xs.map (fun n => natRatio n d hd)).any (fun r => decide (r.num<1)))=false
  rw [positiveNumeratorGuard x d (positive x (List.Mem.head _)) hd]
  exact ih (fun n hn => positive n (List.Mem.tail x hn))
-- The source begins with the first positive width, never with a numeric-null seed.
theorem totalForEveryCommonDenominatorFamily (first d : Nat) (rest : List Nat)
 (hf : 0<first) (hd : 0<d) (hr : ∀ n,n∈rest → 0<n) :
 totalTransitionWidth ((first::rest).map (fun n => natRatio n d hd))=
 .ok (natRatio (rest.foldl Nat.add first) d hd) := by
 unfold totalTransitionWidth
 have hg := familyGuard (first::rest) d hd (fun n h => by
  cases h with
  | head => exact hf
  | tail _ h => exact hr n h)
 rw [hg]
 change Except.ok ((rest.map (fun n => natRatio n d hd)).foldl add (natRatio first d hd))=_
 exact congrArg Except.ok (foldNormalized rest first d hd)
theorem sourceSuccessorFold (first : Rat) (rest : List Rat) (successor : Rat) :
 (rest++[successor]).foldl add first=add (rest.foldl add first) successor :=
 foldAppend add rest [successor] first
theorem lifetimeForEveryPositiveCarrier (a b n d : Nat)
 (ha : 0<a) (hb : 0<b) (hn : 0<n) (hd : 0<d) :
 lifetimeFromWidth (natRatio a b hb) (natRatio n d hd)=
 .ok (natRatio (a*d) (b*n) (Nat.mul_pos hb hn)) := by
 unfold lifetimeFromWidth
 rw [positiveNumeratorGuard a b ha hb,positiveNumeratorGuard n d hn hd]
 exact divideNormalized a b n d hb hn hd
theorem partialWidthForEveryPositiveCarrier (l k e f a b : Nat)
 (hl : 0<l) (hk : 0<k) (he : 0<e) (hf : 0<f) (ha : 0<a) (hb : 0<b) :
 partialTransitionWidth (natRatio l k hk) (natRatio e f hf) (natRatio a b hb)=
 .ok (natRatio (((l*l)*e)*b) (((k*k)*f)*a) (Nat.mul_pos (Nat.mul_pos (Nat.mul_pos hk hk) hf) ha)) := by
 unfold partialTransitionWidth
 change (do
  if decide ((natRatio l k hk).num<1) || (decide ((natRatio e f hf).num<1) || (decide ((natRatio a b hb).num<1) || false)) then throw "partial width requires exact positive carriers"
  LeptonRatios.divide (multiply (multiply (natRatio l k hk) (natRatio l k hk)) (natRatio e f hf)) (natRatio a b hb))=_
 rw [positiveNumeratorGuard l k hl hk,positiveNumeratorGuard e f he hf,positiveNumeratorGuard a b ha hb]
 change LeptonRatios.divide (multiply (multiply (natRatio l k hk) (natRatio l k hk)) (natRatio e f hf)) (natRatio a b hb)=_
 rw [multiplyNormalized,multiplyNormalized]
 exact divideNormalized ((l*l)*e) ((k*k)*f) a b (Nat.mul_pos (Nat.mul_pos hk hk) hf) ha hb
theorem closedChannelIsEmpty : closedChannel=[] := rfl
private theorem positiveFold (xs : List Nat) (acc : Nat) (ha : 0<acc) : 0<xs.foldl Nat.add acc := by
 induction xs generalizing acc with
 | nil => exact ha
 | cons x xs ih => exact ih (acc+x) (Nat.lt_of_lt_of_le ha (Nat.le_add_right acc x))
private theorem divideCommon (n d total : Nat) (hd : 0<d) (ht : 0<total) :
 LeptonRatios.divide (natRatio n d hd) (natRatio total d hd)=.ok (natRatio n total ht) := by
 rw [divideNormalized n d total d hd ht hd]
 apply congrArg Except.ok
 apply natRatioCongruence
 exact SFT.Foundation.FractionReduction.mulAssoc n d total
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
private theorem divideFamilyRec (xs : List Nat) (d total : Nat) (hd : 0<d) (ht : 0<total) :
 recMap (fun r => LeptonRatios.divide r (natRatio total d hd)) (xs.map (fun n => natRatio n d hd))=
 Except.ok (xs.map (fun n => natRatio n total ht)) := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change (do
   let y ← LeptonRatios.divide (natRatio x d hd) (natRatio total d hd)
   let ys ← recMap (fun r => LeptonRatios.divide r (natRatio total d hd)) (xs.map (fun n => natRatio n d hd))
   pure (y::ys))=_
  rw [divideCommon,ih]
  rfl
private theorem divideFamily (xs : List Nat) (d total : Nat) (hd : 0<d) (ht : 0<total) :
 (xs.map (fun n => natRatio n d hd)).mapM (fun r => LeptonRatios.divide r (natRatio total d hd))=
 Except.ok (xs.map (fun n => natRatio n total ht)) := by
 rw [mapRec]
 exact divideFamilyRec xs d total hd ht
theorem branchingForEveryCommonDenominatorFamily (first d : Nat) (rest : List Nat)
 (hf : 0<first) (hd : 0<d) (hr : ∀ n,n∈rest → 0<n) :
 branchingParts ((first::rest).map (fun n => natRatio n d hd))=
 .ok ((first::rest).map (fun n => natRatio n (rest.foldl Nat.add first) (positiveFold rest first hf))) := by
 unfold branchingParts
 rw [totalForEveryCommonDenominatorFamily first d rest hf hd hr]
 exact divideFamily (first::rest) d (rest.foldl Nat.add first) hd (positiveFold rest first hf)
theorem completePartitionForEveryCommonDenominatorFamily (first d : Nat) (rest : List Nat)
 (hf : 0<first) (hd : 0<d) (hr : ∀ n,n∈rest → 0<n) :
 completeBranchingPartition ((first::rest).map (fun n => natRatio n d hd))=.ok (wholeRatio 1) := by
 unfold completeBranchingPartition
 rw [branchingForEveryCommonDenominatorFamily first d rest hf hd hr]
 change totalTransitionWidth ((first::rest).map (fun n => natRatio n (rest.foldl Nat.add first) (positiveFold rest first hf)))=_
 rw [totalForEveryCommonDenominatorFamily first (rest.foldl Nat.add first) rest hf (positiveFold rest first hf) hr]
 apply congrArg Except.ok
 rw [←natRatioWhole 1]
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.one_mul]
private theorem positiveRepresentation (r : Rat) (guard : decide (r.num<1)=false) :
 ∃ n, ∃ hn : 0<n, r=natRatio n r.den (Nat.pos_of_ne_zero r.den_nz) := by
 cases h : r.num with
 | negSucc n =>
  have positive : Int.negSucc n < 1 := by
   change Int.NonNeg (1 - Int.subNatNat 1 (n+1))
   unfold Int.subNatNat
   rw [Nat.succ_sub_succ_eq_sub,Nat.sub_zero]
   cases n with
   | zero => exact Int.NonNeg.mk 1
   | succ n => exact Int.NonNeg.mk (1+(n+1))
  rw [h,decide_eq_true positive] at guard
  cases guard
 | ofNat n =>
  cases n with
  | zero => rw [h] at guard; contradiction
  | succ n =>
   refine ⟨n+1,Nat.zero_lt_succ n,?_⟩
   apply representedIdentity r (n+1) r.den (Nat.pos_of_ne_zero r.den_nz)
   · rw [h]; rfl
   · rw [h]; rfl
private theorem scaleRepresentation (n d k : Nat) (hd : 0<d) (hk : 0<k) :
 natRatio n d hd=natRatio (n*k) (d*k) (Nat.mul_pos hd hk) := by
 apply natRatioCongruence
 exact (SFT.Foundation.FractionReduction.mulAssoc n d k).symm.trans (mulRightComm n d k)
private theorem scaleFamily (xs : List Nat) (d k : Nat) (hd : 0<d) (hk : 0<k) :
 xs.map (fun n => natRatio n d hd)=(xs.map (fun n => n*k)).map (fun n => natRatio n (d*k) (Nat.mul_pos hd hk)) := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change natRatio x d hd :: xs.map (fun n => natRatio n d hd)=_
  rw [scaleRepresentation x d k hd hk,ih]
  rfl
private theorem scaledPositive (xs : List Nat) (k : Nat) (hk : 0<k)
 (hp : ∀ n,n∈xs → 0<n) : ∀ n,n∈xs.map (fun n => n*k) → 0<n := by
 induction xs with
 | nil => intro n h; cases h
 | cons x xs ih =>
  intro n h
  cases h with
  | head => exact Nat.mul_pos (hp x (List.Mem.head _)) hk
  | tail _ h => exact ih (fun n hn => hp n (List.Mem.tail x hn)) n h
-- Every admitted finite source family has such a common-denominator presentation.
-- The denominator is constructed from its existing denominators, never fitted.
theorem everyPositiveFamilyHasCommonDenominator (xs : List Rat)
 (guard : ∀ r,r∈xs → decide (r.num<1)=false) :
 ∃ d, ∃ hd : 0<d, ∃ ns : List Nat, (∀ n,n∈ns → 0<n) ∧ xs=ns.map (fun n => natRatio n d hd) := by
 induction xs with
 | nil => exact ⟨1,by decide,[],(fun _ h => nomatch h),rfl⟩
 | cons x xs ih =>
  obtain ⟨d,hd,ns,hns,heq⟩ := ih (fun r hr => guard r (List.Mem.tail x hr))
  obtain ⟨n,hn,hx⟩ := positiveRepresentation x (guard x (List.Mem.head _))
  have hxden := Nat.pos_of_ne_zero x.den_nz
  refine ⟨d*x.den,Nat.mul_pos hd hxden,n*d::ns.map (fun m => m*x.den),?_,?_⟩
  · intro m hm
    cases hm with
    | head => exact Nat.mul_pos hn hd
    | tail _ h => exact scaledPositive ns x.den hxden hns m h
  · have headEq : x=natRatio (n*d) (d*x.den) (Nat.mul_pos hd hxden) := by
     rw (occs := .pos [1]) [hx]
     apply natRatioCongruence
     exact (SFT.Foundation.FractionReduction.mulAssoc n d x.den).symm
    change x::xs = natRatio (n*d) (d*x.den) (Nat.mul_pos hd hxden) :: _
    exact (congrArg (fun r => r::xs) headEq).trans (congrArg (List.cons _) (heq.trans (scaleFamily ns d x.den hd hxden)))
theorem completePartitionForEveryAdmittedFamily (first : Rat) (rest : List Rat)
 (guard : ∀ r,r∈first::rest → decide (r.num<1)=false) :
 completeBranchingPartition (first::rest)=.ok (wholeRatio 1) := by
 obtain ⟨d,hd,ns,hp,heq⟩ := everyPositiveFamilyHasCommonDenominator (first::rest) guard
 cases ns with
 | nil => cases heq
 | cons n ns =>
  rw [heq]
  exact completePartitionForEveryCommonDenominatorFamily n d ns (hp n (List.Mem.head _)) hd (fun m hm => hp m (List.Mem.tail n hm))
theorem everyPositiveWidthOrder (a b n d m e : Nat)
 (ha : 0<a) (hb : 0<b) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (order : n*e<m*d) :
 widerStateLifetimeTake (natRatio a b hb) (natRatio n d hd) (natRatio m e he)=
 .ok (subtract (natRatio (a*d) (b*n) (Nat.mul_pos hb hn)) (natRatio (a*e) (b*m) (Nat.mul_pos hb hm))) := by
 have sourceOrder := CommonScaleAxis.positiveNormalizedLess n d m e hn hd hm he order
 have reverseOrder : (natRatio (a*e) (b*m) (Nat.mul_pos hb hm)).blt (natRatio (a*d) (b*n) (Nat.mul_pos hb hn))=true := by
  apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (Nat.mul_pos ha he) (Nat.mul_pos hb hm) (Nat.mul_pos ha hd) (Nat.mul_pos hb hn)
  have scaled := Nat.mul_lt_mul_of_pos_right order (Nat.mul_pos ha hb)
  have left : (a*e)*(b*n)=(n*e)*(a*b) := by
   conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
   conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  have right : (a*d)*(b*m)=(m*d)*(a*b) := by
   conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
   conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  rw [left,right]
  exact scaled
 unfold widerStateLifetimeTake
 rw [sourceOrder]
 change (do
  let longer ← lifetimeFromWidth (natRatio a b hb) (natRatio n d hd)
  let shorter ← lifetimeFromWidth (natRatio a b hb) (natRatio m e he)
  RunningConvergence.positiveTake longer shorter)=_
 rw [lifetimeForEveryPositiveCarrier a b n d ha hb hn hd,lifetimeForEveryPositiveCarrier a b m e ha hb hm he]
 change RunningConvergence.positiveTake (natRatio (a*d) (b*n) (Nat.mul_pos hb hn)) (natRatio (a*e) (b*m) (Nat.mul_pos hb hm))=_
 unfold RunningConvergence.positiveTake
 rw [reverseOrder,positiveNormalized (a*e) (b*m) (Nat.mul_pos ha he) (Nat.mul_pos hb hm)]
 rfl
private theorem admittedGuard (xs : List Rat)
 (guard : ∀ r,r∈xs → decide (r.num<1)=false) : xs.any (fun r => decide (r.num<1))=false := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change (decide (x.num<1) || xs.any (fun r => decide (r.num<1)))=false
  rw [guard x (List.Mem.head _)]
  exact ih (fun r h => guard r (List.Mem.tail x h))
theorem totalForEveryAdmittedFamily (first : Rat) (rest : List Rat)
 (guard : ∀ r,r∈first::rest → decide (r.num<1)=false) :
 totalTransitionWidth (first::rest)=.ok (rest.foldl add first) := by
 unfold totalTransitionWidth
 rw [admittedGuard (first::rest) guard]
 rfl
private theorem admittedAppend (xs : List Rat) (successor : Rat)
 (guard : ∀ r,r∈xs → decide (r.num<1)=false) (hs : decide (successor.num<1)=false) :
 ∀ r,r∈xs++[successor] → decide (r.num<1)=false := by
 induction xs with
 | nil =>
  intro r h
  cases h with
  | head => exact hs
  | tail _ h => cases h
 | cons x xs ih =>
  intro r h
  cases h with
  | head => exact guard x (List.Mem.head _)
  | tail _ h => exact ih (fun r hr => guard r (List.Mem.tail x hr)) r h
theorem appendedSourceFamily (first : Rat) (rest : List Rat) (successor : Rat)
 (guard : ∀ r,r∈first::rest → decide (r.num<1)=false) (hs : decide (successor.num<1)=false) :
 appendOpenChannel (first::rest) successor=.ok ((first::rest)++[successor]) := by
 unfold appendOpenChannel
 rw [totalForEveryAdmittedFamily first rest guard]
 have hn : ¬successor.num<1 := of_decide_eq_false hs
 change (if successor.num<1 then Except.error "successor channel width must remain exact and positive" else Except.ok ((first::rest)++[successor]))=_
 rw [if_neg hn]
theorem totalAfterEveryAdmittedSuccessor (first : Rat) (rest : List Rat) (successor : Rat)
 (guard : ∀ r,r∈first::rest → decide (r.num<1)=false) (hs : decide (successor.num<1)=false) :
 (do totalTransitionWidth (← appendOpenChannel (first::rest) successor))=
 .ok (add (rest.foldl add first) successor) := by
 rw [appendedSourceFamily first rest successor guard hs]
 change totalTransitionWidth (first::(rest++[successor]))=_
 rw [totalForEveryAdmittedFamily first (rest++[successor]) (admittedAppend (first::rest) successor guard hs)]
 exact congrArg Except.ok (sourceSuccessorFold first rest successor)
theorem enlargedFamilyStillPartitionsOne (first : Rat) (rest : List Rat) (successor : Rat)
 (guard : ∀ r,r∈first::rest → decide (r.num<1)=false) (hs : decide (successor.num<1)=false) :
 (do completeBranchingPartition (← appendOpenChannel (first::rest) successor))=.ok (wholeRatio 1) := by
 rw [appendedSourceFamily first rest successor guard hs]
 exact completePartitionForEveryAdmittedFamily first (rest++[successor]) (admittedAppend (first::rest) successor guard hs)
private theorem multiplyDifference (n m k : Nat) (bound : m≤n) : (n-m)*k=n*k-m*k := by
 conv => rhs;rw [← subtractAdd n m bound,addMul,Nat.add_comm ((n-m)*k) (m*k),RunningConvergence.addSubtractLeft]

private theorem subtractNormalized (n m d : Nat) (hd : 0<d) (bound : m≤n) :
 subtract (natRatio n d hd) (natRatio m d hd)=natRatio (n-m) d hd := by
 let a := natRatio n d hd
 let b := natRatio m d hd
 have av := natRatioValue n d hd
 have bv := natRatioValue m d hd
 have avc : (a.num.natAbs*b.den)*d=n*(a.den*b.den) := by
  rw [mulRightComm,← av,mulAssoc]
 have bvc : (b.num.natAbs*a.den)*d=m*(a.den*b.den) := by
  rw [mulRightComm,← bv,mulAssoc,Nat.mul_comm b.den a.den]
 have ordered : b.num.natAbs*a.den≤a.num.natAbs*b.den := by
  apply Nat.le_of_mul_le_mul_right _ hd
  rw [avc,bvc]
  exact Nat.mul_le_mul_right _ bound
 have intDiff : Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)=
  Int.ofNat (a.num.natAbs*b.den-b.num.natAbs*a.den) := by
  generalize h : b.num.natAbs*a.den = k at ordered ⊢
  cases k with
  | zero => rw [Nat.sub_zero];rfl
  | succ k =>
   change Int.subNatNat _ _ = _
   unfold Int.subNatNat
   rw [CommonScaleAxis.subtractionZeroOfBound _ _ ordered]
 change subtract a b = _
 unfold subtract
 rw [natRatioNonnegative n d hd,natRatioNonnegative m d hd]
 change normalize (Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)) (a.den*b.den) _ = _
 rw [intDiff]
 apply natRatioCongruence
 rw [multiplyDifference _ _ _ ordered,avc,bvc,multiplyDifference _ _ _ bound]

theorem successorIncrementForEveryCommonDenominatorFamily (first d next : Nat) (rest : List Nat)
 (hf : 0<first) (hd : 0<d) (hn : 0<next) (hr : ∀ n,n∈rest → 0<n) :
 successorTotalIncrement ((first::rest).map (fun n => natRatio n d hd)) (natRatio next d hd)=.ok (natRatio next d hd) := by
 have guard : ∀ r,r∈(first::rest).map (fun n => natRatio n d hd) → decide (r.num<1)=false := by
  intro r h
  have all := familyGuard (first::rest) d hd (fun n h => by
   cases h with
   | head => exact hf
   | tail _ h => exact hr n h)
  have memGuard : ∀ (xs : List Rat), xs.any (fun r => decide (r.num<1))=false → ∀ r,r∈xs → decide (r.num<1)=false := by
   intro xs
   induction xs with
   | nil => intro _ r h; cases h
   | cons x xs ih =>
    intro h r member
    cases hx : decide (x.num<1) with
    | true => rw [List.any_cons,hx] at h; cases h
    | false =>
     cases member with
     | head => exact hx
     | tail _ ht =>
      change (decide (x.num<1) || xs.any (fun r => decide (r.num<1)))=false at h
      rw [hx] at h
      exact ih h r ht
  exact memGuard _ all r h
 unfold successorTotalIncrement
 rw [totalForEveryCommonDenominatorFamily first d rest hf hd hr]
 rw [List.map_cons]
 rw [appendedSourceFamily (natRatio first d hd) (rest.map (fun n => natRatio n d hd)) (natRatio next d hd) guard (positiveNumeratorGuard next d hn hd)]
 change (do
  let after ← totalTransitionWidth (((first::rest).map (fun n => natRatio n d hd))++[natRatio next d hd])
  RunningConvergence.positiveTake after (natRatio (rest.foldl Nat.add first) d hd))=_
 have appendMap : ((first::rest).map (fun n => natRatio n d hd))++[natRatio next d hd]=((first::rest)++[next]).map (fun n => natRatio n d hd) := by
  have mapAppend : ∀ xs : List Nat, xs.map (fun n => natRatio n d hd)++[natRatio next d hd]=(xs++[next]).map (fun n => natRatio n d hd) := by
   intro xs
   induction xs with
   | nil => rfl
   | cons x xs ih => exact congrArg (List.cons (natRatio x d hd)) ih
  exact mapAppend (first::rest)
 rw [appendMap]
 have expanded : ∀ n,n∈rest++[next] → 0<n := by
  have extend : ∀ xs : List Nat, (∀ n,n∈xs → 0<n) → ∀ n,n∈xs++[next] → 0<n := by
   intro xs
   induction xs with
   | nil =>
    intro _ n h
    cases h with | head => exact hn | tail _ h => cases h
   | cons x xs ih =>
    intro hp n h
    cases h with
    | head => exact hp x (List.Mem.head _)
    | tail _ h => exact ih (fun n hn => hp n (List.Mem.tail x hn)) n h
  exact extend rest hr
 change (do
  let after ← totalTransitionWidth ((first::(rest++[next])).map (fun n => natRatio n d hd))
  RunningConvergence.positiveTake after (natRatio (rest.foldl Nat.add first) d hd))=_
 rw [totalForEveryCommonDenominatorFamily first d (rest++[next]) hf hd expanded]
 rw [foldAppend]
 change RunningConvergence.positiveTake (natRatio (rest.foldl Nat.add first+next) d hd) (natRatio (rest.foldl Nat.add first) d hd)=_
 have hp := positiveFold rest first hf
 have lt : rest.foldl Nat.add first<rest.foldl Nat.add first+next := Nat.lt_add_of_pos_right hn
 have below := CommonScaleAxis.positiveNormalizedLess _ d _ d hp hd (Nat.lt_trans hp lt) hd (Nat.mul_lt_mul_of_pos_right lt hd)
 unfold RunningConvergence.positiveTake
 rw [below,positiveNormalized _ d hp hd]
 change Except.ok (subtract (natRatio (rest.foldl Nat.add first+next) d hd) (natRatio (rest.foldl Nat.add first) d hd))=_
 rw [subtractNormalized _ _ d hd (Nat.le_add_right _ _),RunningConvergence.addSubtractLeft]
end SFT.Physics.DecayWidthBranchingLifetimeGeneral
