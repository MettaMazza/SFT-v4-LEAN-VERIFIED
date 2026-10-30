import SFT.Physics.VacuumDensity
import SFT.Foundation.ExactValueIdentity
import SFT.Foundation.PrimitiveSquare
namespace SFT.Physics.VacuumLedgerProofs
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
open SFT.Foundation.ExactValueIdentity SFT.Foundation.PrimitiveMaps
open LeptonIntervals

def natRatio (n d : Nat) (hd : 0 < d) : Rat := normalize (.ofNat n) d hd

theorem natRatioNonnegative (n d : Nat) (hd : 0 < d) :
 (natRatio n d hd).num = .ofNat (natRatio n d hd).num.natAbs := by
 cases n with
 | zero => rfl
 | succ n => rfl

theorem natRatioValue (n d : Nat) (hd : 0 < d) :
 n*(natRatio n d hd).den = (natRatio n d hd).num.natAbs*d := by
 cases n with
 | zero => exact (Nat.zero_mul _).trans (Nat.zero_mul _).symm
 | succ n => exact normalizedValuePreserved (n+1) d (Nat.zero_lt_succ _) hd

theorem nonnegativeRatIdentity (a b : Rat)
 (ha : a.num = .ofNat a.num.natAbs) (hb : b.num = .ofNat b.num.natAbs)
 (cross : a.num.natAbs*b.den = b.num.natAbs*a.den) : a = b := by
 have left : Nat.gcd (a.num.natAbs*b.den) (a.den*b.den) = b.den := by
  rw [Nat.mul_comm a.num.natAbs b.den,Nat.mul_comm a.den b.den,
   gcdScale b.den a.num.natAbs a.den (Nat.pos_of_ne_zero b.den_nz),a.reduced,Nat.mul_one]
 have right : Nat.gcd (b.num.natAbs*a.den) (a.den*b.den) = a.den := by
  rw [Nat.mul_comm b.num.natAbs a.den,
   gcdScale a.den b.num.natAbs b.den (Nat.pos_of_ne_zero a.den_nz),b.reduced,Nat.mul_one]
 have same := congrArg (fun n => Nat.gcd n (a.den*b.den)) cross
 have den : a.den = b.den := right.symm.trans (same.symm.trans left)
 have nums : a.num.natAbs = b.num.natAbs := by
  rw [den] at cross
  exact Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero b.den_nz) cross
 apply Rat.ext
 · exact ha.trans ((congrArg Int.ofNat nums).trans hb.symm)
 · exact den

theorem mulRightComm (a b c : Nat) : (a*b)*c = (a*c)*b :=
 (mulAssoc a b c).trans ((congrArg (fun n => a*n) (Nat.mul_comm b c)).trans (mulAssoc a c b).symm)

theorem crossTrans (a b c : Rat)
 (ab : a.num.natAbs*b.den = b.num.natAbs*a.den)
 (bc : b.num.natAbs*c.den = c.num.natAbs*b.den) :
 a.num.natAbs*c.den = c.num.natAbs*a.den := by
 have scaled : (a.num.natAbs*c.den)*b.den = (c.num.natAbs*a.den)*b.den := by
  rw [mulRightComm a.num.natAbs c.den b.den,ab,
   mulAssoc b.num.natAbs a.den c.den,Nat.mul_comm a.den c.den,
   ← mulAssoc b.num.natAbs c.den a.den,bc,mulRightComm c.num.natAbs b.den a.den]
 exact Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero b.den_nz) scaled

theorem representedIdentity (a : Rat) (n d : Nat) (hd : 0 < d)
 (ha : a.num = .ofNat a.num.natAbs)
 (cross : n*a.den = a.num.natAbs*d) : a = natRatio n d hd := by
 apply nonnegativeRatIdentity a _ ha (natRatioNonnegative n d hd)
 have nr := natRatioValue n d hd
 have scaled : (a.num.natAbs*(natRatio n d hd).den)*d =
     ((natRatio n d hd).num.natAbs*a.den)*d := by
  rw [mulRightComm a.num.natAbs _ d,← cross,
   mulAssoc n a.den _,Nat.mul_comm a.den _,← mulAssoc n _ a.den,nr,
   mulRightComm _ d a.den]
 exact Nat.eq_of_mul_eq_mul_right hd scaled

theorem addMul (a b c : Nat) : (a+b)*c = a*c+b*c := by
 rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]

theorem addCommonDenominator (a b : Rat) (n m d : Nat) (hd : 0 < d)
 (ha : a.num = .ofNat a.num.natAbs) (hb : b.num = .ofNat b.num.natAbs)
 (av : n*a.den = a.num.natAbs*d) (bv : m*b.den = b.num.natAbs*d) :
 add a b = natRatio (n+m) d hd := by
 have raw : add a b = natRatio (a.num.natAbs*b.den+b.num.natAbs*a.den) (a.den*b.den)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.pos_of_ne_zero b.den_nz)) := by
  unfold add
  rw [ha,hb]
  rfl
 rw [raw]
 apply representedIdentity _ (n+m) d hd (natRatioNonnegative _ _ _)
 have sumCross : (n+m)*(a.den*b.den) = (a.num.natAbs*b.den+b.num.natAbs*a.den)*d := by
  rw [addMul,addMul,← mulAssoc n a.den b.den,av,
   Nat.mul_comm a.den b.den,← mulAssoc m b.den a.den,bv,
   mulRightComm a.num.natAbs d b.den,mulRightComm b.num.natAbs d a.den]
 have normalized := natRatioValue (a.num.natAbs*b.den+b.num.natAbs*a.den) (a.den*b.den)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.pos_of_ne_zero b.den_nz))
 have scaled := congrArg (fun k => k*(natRatio (a.num.natAbs*b.den+b.num.natAbs*a.den) (a.den*b.den)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.pos_of_ne_zero b.den_nz))).den) sumCross
 rw [mulRightComm (n+m) _ _,mulRightComm _ d _,normalized,
  mulRightComm _ (a.den*b.den) d] at scaled
 exact Nat.eq_of_mul_eq_mul_right (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.pos_of_ne_zero b.den_nz)) scaled

theorem addNormalized (n m d : Nat) (hd : 0 < d) :
 add (natRatio n d hd) (natRatio m d hd) = natRatio (n+m) d hd :=
 addCommonDenominator _ _ n m d hd (natRatioNonnegative n d hd) (natRatioNonnegative m d hd)
   (natRatioValue n d hd) (natRatioValue m d hd)
theorem foldNormalized (xs : List Nat) (acc d : Nat) (hd : 0 < d) :
 (xs.map (fun n => natRatio n d hd)).foldl add (natRatio acc d hd) =
 natRatio (xs.foldl Nat.add acc) d hd := by
 induction xs generalizing acc with
 | nil => rfl
 | cons x xs ih =>
  change (xs.map (fun n => natRatio n d hd)).foldl add (add (natRatio acc d hd) (natRatio x d hd)) =
   natRatio (xs.foldl Nat.add (acc+x)) d hd
  rw [addNormalized]
  exact ih (acc+x)

theorem appendAssociative {α : Type} (xs ys zs : List α) : (xs++ys)++zs = xs++(ys++zs) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih

theorem rangeLoopAppend (n : Nat) (acc : List Nat) :
 List.range.loop n acc = List.range.loop n [] ++ acc := by
 induction n generalizing acc with
 | zero => rfl
 | succ n ih =>
  change List.range.loop n (n::acc) = List.range.loop n [n] ++ acc
  rw [ih (n::acc),ih [n]]
  exact (appendAssociative (List.range.loop n []) [n] acc).symm

theorem rangeSuccessor (n : Nat) : List.range (n+1) = List.range n ++ [n] :=
 rangeLoopAppend n [n]

theorem foldAppend {α β : Type} (f : β → α → β) (xs ys : List α) (acc : β) :
 (xs++ys).foldl f acc = ys.foldl f (xs.foldl f acc) := by
 induction xs generalizing acc with
 | nil => rfl
 | cons x xs ih => exact ih (f acc x)

theorem foldMap {α β γ : Type} (f : α → β) (g : γ → β → γ) (xs : List α) (acc : γ) :
 (xs.map f).foldl g acc = xs.foldl (fun a x => g a (f x)) acc := by
 induction xs generalizing acc with
 | nil => rfl
 | cons x xs ih => exact ih (g acc (f x))

theorem oddRangeSum (n acc : Nat) :
 (List.range n).foldl (fun a i => a+VacuumSpectrum.oddNumerator i) acc = acc+n*n := by
 induction n with
 | zero => exact (Nat.add_zero acc).symm
 | succ n ih =>
  rw [rangeSuccessor,foldAppend,ih]
  change (acc+n*n)+(2*n+1) = acc+(n+1)*(n+1)
  have step := VacuumDensity.completeOddSum (n+1)
  change VacuumDensity.oddNumeratorSum n+(2*n+1) = (n+1)*(n+1) at step
  rw [VacuumDensity.completeOddSum n] at step
  rw [Nat.add_assoc,step]

theorem mapComposition {α β γ : Type} (f : α → β) (g : β → γ) (xs : List α) :
 (xs.map f).map g = xs.map (fun x => g (f x)) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons (g (f x))) ih

theorem mapPointwise {α β : Type} (f g : α → β) (xs : List α) (same : ∀ x, f x = g x) :
 xs.map f = xs.map g := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact (congrArg (fun v => v :: xs.map f) (same x)).trans (congrArg (List.cons (g x)) ih)

def completeModeTotal (depth : Nat) : Rat :=
 let denominator := 2^(depth+1)
 let modes := (List.range (2^depth)).map fun i =>
  natRatio (2*(i+1)-1) denominator (Nat.pow_pos (by decide))
 modes.foldl add zero

theorem completeTotalNumerators (depth : Nat) :
 completeModeTotal depth = natRatio ((2^depth)*(2^depth)) (2^(depth+1)) (Nat.pow_pos (by decide)) := by
 unfold completeModeTotal
 dsimp only
 have modes := mapPointwise
   (fun i => natRatio (2*(i+1)-1) (2^(depth+1)) (Nat.pow_pos (by decide)))
   (fun i => natRatio (VacuumSpectrum.oddNumerator i) (2^(depth+1)) (Nat.pow_pos (by decide)))
   (List.range (2^depth)) (fun i => congrArg (fun n => natRatio n (2^(depth+1)) (Nat.pow_pos (by decide))) (VacuumSpectrum.sourceNumerator i))
 rw [modes,← mapComposition VacuumSpectrum.oddNumerator
   (fun n => natRatio n (2^(depth+1)) (Nat.pow_pos (by decide))) (List.range (2^depth))]
 change (((List.range (2^depth)).map VacuumSpectrum.oddNumerator).map
   (fun n => natRatio n (2^(depth+1)) (Nat.pow_pos (by decide)))).foldl add
   (natRatio 0 (2^(depth+1)) (Nat.pow_pos (by decide))) = _
 rw [foldNormalized,foldMap]
 exact congrArg (fun n => natRatio n (2^(depth+1)) (Nat.pow_pos (by decide)))
  ((oddRangeSum (2^depth) 0).trans (Nat.zero_add _))
theorem natRatioCongruence (n d m e : Nat) (hd : 0 < d) (he : 0 < e)
 (cross : n*e = m*d) : natRatio n d hd = natRatio m e he := by
 apply representedIdentity _ m e he (natRatioNonnegative n d hd)
 have nr := natRatioValue n d hd
 have scaled := congrArg (fun t => t*(natRatio n d hd).den) cross
 rw [mulRightComm n e _,nr,mulRightComm _ d e,mulRightComm m d _] at scaled
 exact Nat.eq_of_mul_eq_mul_right hd scaled.symm

theorem completeTotalHalfSupport (depth : Nat) :
 completeModeTotal depth = natRatio (2^depth) 2 (by decide) := by
 rw [completeTotalNumerators]
 apply natRatioCongruence
 rw [Nat.pow_succ]
 exact mulAssoc (2^depth) (2^depth) 2

theorem gcdRightOne (n : Nat) : Nat.gcd n 1 = 1 := by
 obtain ⟨k,hk⟩ := (gcdDivides n 1).2
 exact factorOfOne _ _ hk.symm

def wholeRatio (n : Nat) : Rat := ⟨.ofNat n,1,by decide,gcdRightOne n⟩

theorem natRatioWhole (n : Nat) : natRatio n 1 (by decide) = wholeRatio n := by
 apply nonnegativeRatIdentity _ _ (natRatioNonnegative n 1 (by decide)) rfl
 exact (natRatioValue n 1 (by decide)).symm

theorem completeMeanHalf (n : Nat) (positive : 0 < n) :
 LeptonRatios.divide (natRatio n 2 (by decide)) (natRatio n 1 (by decide)) =
 .ok (natRatio 1 2 (by decide)) := by
 rw [natRatioWhole]
 cases n with
 | zero => cases positive
 | succ n =>
  unfold LeptonRatios.divide wholeRatio
  rw [natRatioNonnegative (n+1) 2 (by decide)]
  change Except.ok (natRatio ((natRatio (n+1) 2 (by decide)).num.natAbs*1)
    ((natRatio (n+1) 2 (by decide)).den*(n+1)) _) = _
  apply congrArg Except.ok
  apply natRatioCongruence
  rw [Nat.mul_one,Nat.one_mul,Nat.mul_comm _ (n+1)]
  exact (natRatioValue (n+1) 2 (by decide)).symm

theorem ratEqualSelf (r : Rat) : (r == r) = true := by
 change decide (r = r) = true
 exact decide_eq_true rfl

theorem everyPositiveLedgerCloses (k : Nat) :
 (VacuumDensity.finiteZeroPointLedger (.integer (.ofNat (k+1)))).map
  (fun ledger => (ledger.total,ledger.mean,ledger.closed)) =
 .ok (natRatio (2^(k+1)) 2 (by decide),half,true) := by
 have total : ((List.range (VacuumDensity.binary^(k+1))).map (fun i =>
   normalize (.ofNat (VacuumDensity.binary*(i+1)-1)) (VacuumDensity.binary^(k+1+1))
     (Nat.pow_pos (by decide)))).foldl add zero = natRatio (2^(k+1)) 2 (by decide) :=
  completeTotalHalfSupport (k+1)
 have mean : LeptonRatios.divide (natRatio (2^(k+1)) 2 (by decide))
   (normalize (.ofNat (VacuumDensity.binary^(k+1))) 1 (by decide)) = .ok half :=
  completeMeanHalf (2^(k+1)) (Nat.pow_pos (by decide))
 unfold VacuumDensity.finiteZeroPointLedger
 dsimp only
 rw [total,mean]
 change Except.ok (natRatio (2^(k+1)) 2 (by decide),half,
  (natRatio (2^(k+1)) 2 (by decide) == natRatio (2^(k+1)) 2 (by decide)) && true) = _
 rw [ratEqualSelf]
 rfl

end SFT.Physics.VacuumLedgerProofs
