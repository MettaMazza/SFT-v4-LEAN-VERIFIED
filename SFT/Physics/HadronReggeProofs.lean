import SFT.Physics.HadronRegge
import SFT.Physics.VacuumScaleProofs
import SFT.Physics.LatticeCurvatureProofs
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.HadronReggeProofs
open HadronRegge LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.ExactCast
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation
set_option maxRecDepth 20000
-- This is the original all-positive-rank normalized affine law.
theorem everyNormalizedRank (n : Nat) : normalizedReggeSquaredSupport (.count (.integer (.ofNat (n+1))))=.ok (wholeRatio (n+1)) := by
 cases n with
 | zero => rfl
 | succ n =>
  change Except.ok (add (wholeRatio 1) (wholeRatio (n+1))) = _
  rw [←natRatioWhole 1,←natRatioWhole (n+1),addNormalized,natRatioWhole,Nat.add_comm 1 (n+1)]
-- Its source domain admits arbitrary positive exact carriers.
theorem positiveCarrierAccepted (message : String) (n d : Nat) (hn : 0<n) (hd : 0<d) :
 positiveCarrier message (.fraction (natRatio n d hd))=.ok (natRatio n d hd) := by
 unfold positiveCarrier
 change (if !zero.blt (natRatio n d hd) then _ else _)=_
 rw [positiveNormalized n d hn hd]
 rfl
theorem affineFirst (a d t e : Nat) (ha : 0<a) (hd : 0<d) (ht : 0<t) (he : 0<e) :
 affineReggeCarrier (.fraction (natRatio a d hd)) (.fraction (natRatio t e he)) (.count (.integer 1))=.ok (natRatio a d hd) := by
 unfold affineReggeCarrier
 rw [positiveCarrierAccepted _ a d ha hd,positiveCarrierAccepted _ t e ht he]
 rfl
theorem affineEverySuccessor (a d t e n : Nat) (ha : 0<a) (hd : 0<d) (ht : 0<t) (he : 0<e) :
 affineReggeCarrier (.fraction (natRatio a d hd)) (.fraction (natRatio t e he)) (.count (.integer (.ofNat (n+2))))=
 .ok (add (natRatio a d hd) (multiply (wholeRatio (n+1)) (natRatio t e he))) := by
 unfold affineReggeCarrier
 rw [positiveCarrierAccepted _ a d ha hd,positiveCarrierAccepted _ t e ht he]
 rfl
theorem everyTrajectoryDepth (n : Nat) : trajectoryMultiplicity (.count (.integer (.ofNat (n+1))))=.ok (2^(n+1)) := by
 unfold trajectoryMultiplicity
 change (do
  let binary ← AlphaCovers.binaryCount
  AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat (n+1))))=_
 rw [AlphaCovers.binaryCountTwo]
 exact AlphaCovers.positivePowerValue 1 n
-- Reuse the existing lattice exact-rational subtraction proof for this source step.
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

theorem affineAllRanks (a d t e n : Nat) (ha : 0<a) (hd : 0<d) (ht : 0<t) (he : 0<e) :
 affineReggeCarrier (.fraction (natRatio a d hd)) (.fraction (natRatio t e he)) (.count (.integer (.ofNat (n+1))))=
 .ok (natRatio (a*e+n*t*d) (d*e) (Nat.mul_pos hd he)) := by
 cases n with
 | zero =>
  change affineReggeCarrier (.fraction (natRatio a d hd)) (.fraction (natRatio t e he)) (.count (.integer 1))=_
  rw [affineFirst a d t e ha hd ht he]
  apply congrArg Except.ok
  apply natRatioCongruence
  conv => lhs; simp only [Nat.zero_mul,Nat.mul_zero,Nat.zero_add,Nat.add_zero,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [Nat.zero_mul,Nat.mul_zero,Nat.zero_add,Nat.add_zero,mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 | succ n =>
  rw [affineEverySuccessor a d t e n ha hd ht he]
  have product : multiply (wholeRatio (n+1)) (natRatio t e he)=natRatio ((n+1)*t) e he := by
   rw [←natRatioWhole (n+1),multiplyNormalized]
   apply natRatioCongruence
   rw [Nat.one_mul]
  rw [product]
  have anchor : natRatio a d hd=natRatio (a*e) (d*e) (Nat.mul_pos hd he) := by
   apply natRatioCongruence
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
   conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  have step : natRatio ((n+1)*t) e he=natRatio ((n+1)*t*d) (d*e) (Nat.mul_pos hd he) := by
   apply natRatioCongruence
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
   conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  rw [anchor,step,addNormalized]

theorem everyReggeStep (a d t e n : Nat) (ha : 0<a) (hd : 0<d) (ht : 0<t) (he : 0<e) :
 reggeStep (.fraction (natRatio a d hd)) (.fraction (natRatio t e he)) (.count (.integer (.ofNat (n+1))))=.ok (natRatio t e he) := by
 have numer : a*e+(n+1)*t*d=(a*e+n*t*d)+t*d := by
  rw [Nat.succ_mul,addMul,Nat.add_assoc]
 have difference : subtract (natRatio (a*e+(n+1)*t*d) (d*e) (Nat.mul_pos hd he))
   (natRatio (a*e+n*t*d) (d*e) (Nat.mul_pos hd he))=natRatio t e he := by
  rw [numer,subtractNormalized _ _ _ _ (Nat.le_add_right _ _),RunningConvergence.addSubtractLeft]
  apply natRatioCongruence
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 unfold reggeStep
 rw [affineAllRanks a d t e n ha hd ht he]
 change (do
  let successor ← affineReggeCarrier (.fraction (natRatio a d hd)) (.fraction (natRatio t e he)) (.count (.integer (.ofNat ((n+1)+1))))
  let step := subtract successor (natRatio (a*e+n*t*d) (d*e) (Nat.mul_pos hd he))
  if !zero.blt step then throw "Regge successor failed positivity"
  pure step)=_
 rw [affineAllRanks a d t e (n+1) ha hd ht he]
 change (if !zero.blt (subtract _ _) then _ else _)=_
 rw [difference,positiveNormalized t e ht he]
 rfl

theorem everyWordIncluded (labels : List Nat) (width : Nat) (word : List Nat)
 (length : word.length=width) (members : ∀ x, x∈word → x∈labels) : word∈orderedWords labels width := by
 induction width generalizing word with
 | zero =>
  cases word with
  | nil => exact List.Mem.head _
  | cons x xs => cases length
 | succ width ih =>
  cases word with
  | nil => cases length
  | cons x xs =>
   apply memFlatMap _ labels x (x::xs) (members x (List.Mem.head _))
   exact memMap (List.cons x) xs _ (ih xs (Nat.succ.inj length) (fun y h => members y (List.Mem.tail _ h)))
theorem everyGeneratedWord (labels : List Nat) (width : Nat) (word : List Nat)
 (member : word∈orderedWords labels width) : word.length=width ∧ ∀ x, x∈word → x∈labels := by
 induction width generalizing word with
 | zero =>
  cases member with
  | head => exact ⟨rfl,fun _ h => nomatch h⟩
  | tail _ h => cases h
 | succ width ih =>
  obtain ⟨x,hx,hm⟩ := memFlatMapOrigin _ labels word member
  obtain ⟨xs,hxs,eq⟩ := memMapPreimage (List.cons x) word _ hm
  cases eq
  have previous := ih xs hxs
  constructor
  · exact congrArg Nat.succ previous.1
  · intro y hy
    cases hy with
    | head => exact hx
    | tail _ tail => exact previous.2 y tail

private theorem wordCountProduct (labels : List Nat) (tail : List (List Nat)) :
 (labels.flatMap (fun label => tail.map (List.cons label))).length=labels.length*tail.length := by
 induction labels with
 | nil => exact (Nat.zero_mul _).symm
 | cons first rest ih =>
  change (tail.map (List.cons first) ++ rest.flatMap (fun label => tail.map (List.cons label))).length=(rest.length+1)*tail.length
  rw [appendLength,mapLength,ih,Nat.succ_mul,Nat.add_comm]
theorem everyWordCount (labels : List Nat) (width : Nat) : (orderedWords labels width).length=labels.length^width := by
 induction width with
 | zero => rfl
 | succ width ih =>
  change (labels.flatMap (fun label => (orderedWords labels width).map (List.cons label))).length=_
  rw [wordCountProduct,ih,Nat.pow_succ,Nat.mul_comm]
end SFT.Physics.HadronReggeProofs
