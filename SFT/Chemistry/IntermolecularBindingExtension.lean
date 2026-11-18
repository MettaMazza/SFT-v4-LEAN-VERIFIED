import SFT.Chemistry.IntermolecularBinding
import SFT.Physics.VelocityCompositionReconstruction
namespace SFT.Chemistry.IntermolecularBindingExtension
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
open SFT.Physics SFT.Physics.BoundaryGrowth SFT.Physics.VacuumLedgerProofs
open SFT.Chemistry.DihedralTorsion SFT.Chemistry.IntermolecularBinding
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
-- Representation lemmas bind the existing reduced arithmetic to this source's
-- raw PositiveRatio fields; they add no scientific condition.
private theorem positiveExt (p q : PositiveFraction)
 (hn : p.numerator=q.numerator) (hd : p.denominator=q.denominator) : p=q := by
 cases p
 cases q
 dsimp only at hn hd
 cases hn
 cases hd
 rfl
private theorem asFractionInjective (p q : PositiveFraction)
 (same : asFraction p=asFraction q) : p=q := by
 apply positiveExt p q
 · exact Int.ofNat.inj (congrArg Rat.num same)
 · exact congrArg Rat.den same
private theorem rawRoundTrip (p : PositiveFraction) : fraction (rawRatio p)=p := by
 apply positiveExt
 · change p.numerator / Nat.gcd p.numerator p.denominator=p.numerator
   rw [p.reduced,divisionOne]
 · change p.denominator / Nat.gcd p.numerator p.denominator=p.denominator
   rw [p.reduced,divisionOne]
private theorem normalizedIdentity (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (cross : n*e=m*d) : normalizePositive n d hn hd=normalizePositive m e hm he := by
 apply asFractionInjective
 rw [CommonScaleAxis.normalizedPositiveAsRat,CommonScaleAxis.normalizedPositiveAsRat]
 exact natRatioCongruence n d m e hd he cross
private theorem normalizedSelf (p : PositiveFraction) :
 normalizePositive p.numerator p.denominator p.positive (Nat.pos_of_ne_zero p.denominatorNonzero)=p :=
 rawRoundTrip p
private theorem positiveRat (p : PositiveFraction) :
 asFraction p=natRatio p.numerator p.denominator (Nat.pos_of_ne_zero p.denominatorNonzero) := by
 rw [← CommonScaleAxis.normalizedPositiveAsRat p.numerator p.denominator p.positive]
 exact congrArg asFraction (normalizedSelf p).symm
private theorem addAsRat (p q : PositiveFraction) :
 asFraction (AlphaRatio.add p q)=LeptonIntervals.add (asFraction p) (asFraction q) := by
 unfold AlphaRatio.add
 rw [CommonScaleAxis.normalizedPositiveAsRat]
 rfl
private theorem multiplyAsRat (p q : PositiveFraction) :
 asFraction (BoundaryGrowth.multiply p q)=LeptonIntervals.multiply (asFraction p) (asFraction q) := by
 unfold BoundaryGrowth.multiply
 rw [CommonScaleAxis.normalizedPositiveAsRat]
 rfl
private theorem addCommon (n m d : Nat) (hn : 0<n) (hm : 0<m) (hd : 0<d) :
 AlphaRatio.add (normalizePositive n d hn hd) (normalizePositive m d hm hd)=
 normalizePositive (n+m) d (Nat.add_pos_left hn m) hd := by
 apply asFractionInjective
 rw [addAsRat,CommonScaleAxis.normalizedPositiveAsRat,CommonScaleAxis.normalizedPositiveAsRat,
  CommonScaleAxis.normalizedPositiveAsRat,addNormalized]
private theorem scaleCommon (n d k : Nat) (hn : 0<n) (hd : 0<d) (hk : 0<k) :
 BoundaryGrowth.multiply (normalizePositive n d hn hd) (AlphaRatio.whole k hk)=
 normalizePositive (n*k) d (Nat.mul_pos hn hk) hd := by
 apply asFractionInjective
 rw [multiplyAsRat,CommonScaleAxis.normalizedPositiveAsRat]
 change LeptonIntervals.multiply (natRatio n d hd)
  (asFraction (normalizePositive k 1 hk (by decide)))=_
 rw [CommonScaleAxis.normalizedPositiveAsRat,VacuumScaleProofs.multiplyNormalized,
  CommonScaleAxis.normalizedPositiveAsRat]
 apply natRatioCongruence
 rw [Nat.mul_one]
private theorem commonOrder (n m d : Nat) (hn : 0<n) (hm : 0<m) (hd : 0<d) (order : m<n) :
 (normalizePositive m d hm hd).numerator*(normalizePositive n d hn hd).denominator <
 (normalizePositive n d hn hd).numerator*(normalizePositive m d hm hd).denominator := by
 have h := CommonScaleAxis.normalizedCrossLess m d n d hd hd (Nat.mul_lt_mul_of_pos_right order hd)
 rw [← CommonScaleAxis.normalizedPositiveAsRat m d hm hd,← CommonScaleAxis.normalizedPositiveAsRat n d hn hd] at h
 exact h
private theorem takeAsRat (h l : PositiveFraction)
 (order : l.numerator*h.denominator<h.numerator*l.denominator) :
 asFraction (LeptonTake.heldRemainder h l order)=LeptonIntervals.subtract (asFraction h) (asFraction l) := by
 have diff : Int.ofNat (h.numerator*l.denominator)-Int.ofNat (l.numerator*h.denominator)=
  Int.ofNat (h.numerator*l.denominator-l.numerator*h.denominator) := by
  have bound := Nat.le_of_lt order
  generalize eq : l.numerator*h.denominator = k at bound ⊢
  cases k with
  | zero => rw [Nat.sub_zero]; rfl
  | succ k =>
   change Int.subNatNat _ _ = _
   unfold Int.subNatNat
   rw [CommonScaleAxis.subtractionZeroOfBound _ _ bound]
 unfold LeptonTake.heldRemainder
 rw [CommonScaleAxis.normalizedPositiveAsRat]
 unfold LeptonIntervals.subtract asFraction
 change natRatio _ _ _=LeptonIntervals.normalize
  (Int.ofNat (h.numerator*l.denominator)-Int.ofNat (l.numerator*h.denominator)) _ _
 rw [diff]
 rfl
private theorem commonTake (n m d : Nat) (hn : 0<n) (hm : 0<m) (hd : 0<d) (order : m<n) :
 exactBindingTake (.ratio (rawRatio (normalizePositive n d hn hd)))
  (.ratio (rawRatio (normalizePositive m d hm hd)))=
 .ok (rawRatio (normalizePositive (n-m) d (SFT.Foundation.ExactCast.subtractPositive n m order) hd)) := by
 have guard := commonOrder n m d hn hm hd order
 have sourceGuard : (fraction (rawRatio (normalizePositive m d hm hd))).numerator*
  (fraction (rawRatio (normalizePositive n d hn hd))).denominator <
  (fraction (rawRatio (normalizePositive n d hn hd))).numerator*
  (fraction (rawRatio (normalizePositive m d hm hd))).denominator := by
  rw [rawRoundTrip,rawRoundTrip]
  exact guard
 rw [bindingTakeExact _ _ sourceGuard]
 apply congrArg Except.ok
 apply congrArg rawRatio
 apply asFractionInjective
 rw [takeAsRat,rawRoundTrip,rawRoundTrip,CommonScaleAxis.normalizedPositiveAsRat,
  CommonScaleAxis.normalizedPositiveAsRat,CommonScaleAxis.normalizedPositiveAsRat]
 exact VelocityComposition.originalSubtractNormalized n m d hd (Nat.le_of_lt order)
-- V3's exact shared-state operation on an arbitrary common denominator.
-- Any finite set of positive rational state heights has this representation.
theorem sharedConstituentCommon (n m x d : Nat) (hn : 0<n) (hm : 0<m) (hx : 0<x) (hd : 0<d)
 (order : m<n) :
 appendSharedConstituentPreservesBinding
  (.ratio (rawRatio (normalizePositive n d hn hd)))
  (.ratio (rawRatio (normalizePositive m d hm hd)))
  (.ratio (rawRatio (normalizePositive x d hx hd)))=.ok true := by
 unfold appendSharedConstituentPreservesBinding
 rw [commonTake n m d hn hm hd order]
 dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure]
 rw [rawRoundTrip,rawRoundTrip,rawRoundTrip,addCommon,addCommon]
 rw [commonTake (n+x) (m+x) d (Nat.add_pos_left hn x) (Nat.add_pos_left hm x) hd
  (Nat.add_lt_add_right order x)]
 have normalizedDifference : normalizePositive (n+x-(m+x)) d
   (SFT.Foundation.ExactCast.subtractPositive (n+x) (m+x) (Nat.add_lt_add_right order x)) hd =
   normalizePositive (n-m) d (SFT.Foundation.ExactCast.subtractPositive n m order) hd := by
  apply normalizedIdentity
  exact congrArg (fun value => value*d) (addSubtractSame n m x)
 rw [normalizedDifference]
 change Except.ok (equalHeight (.ratio _) (.ratio _))=.ok true
 apply congrArg Except.ok
 unfold equalHeight
 change (decide (_ = _) && decide (_ = _)) = true
 rw [decide_eq_true rfl,decide_eq_true rfl]
 rfl
-- V3's repeated_unit_binding returns the repeated exact original Take.
theorem repeatedBindingCommon (n m d k : Nat) (hn : 0<n) (hm : 0<m) (hd : 0<d) (hk : 0<k)
 (order : m<n) :
 repeatedUnitBinding (.ratio (rawRatio (normalizePositive n d hn hd)))
  (.ratio (rawRatio (normalizePositive m d hm hd))) (.count ⟨k,hk⟩)=
 .ok (rawRatio (normalizePositive ((n-m)*k) d
  (Nat.mul_pos (SFT.Foundation.ExactCast.subtractPositive n m order) hk) hd)) := by
 unfold repeatedUnitBinding
 dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure]
 rw [rawRoundTrip,rawRoundTrip,scaleCommon,scaleCommon]
 rw [commonTake (n*k) (m*k) d (Nat.mul_pos hn hk) (Nat.mul_pos hm hk) hd
  (Nat.mul_lt_mul_of_pos_right order hk)]
 have difference : n*k-m*k=(n-m)*k := by
  rw [Nat.mul_comm n k,Nat.mul_comm m k,mulSubtract,Nat.mul_comm k (n-m)]
 apply congrArg Except.ok
 apply congrArg rawRatio
 apply asFractionInjective
 rw [CommonScaleAxis.normalizedPositiveAsRat,CommonScaleAxis.normalizedPositiveAsRat]
 apply natRatioCongruence
 exact congrArg (fun value => value*d) difference
private theorem representedFraction (p : PositiveFraction) (n d : Nat) (hn : 0<n) (hd : 0<d)
 (cross : p.numerator*d=n*p.denominator) : p=normalizePositive n d hn hd :=
 (normalizedSelf p).symm.trans (normalizedIdentity p.numerator p.denominator n d p.positive
  (Nat.pos_of_ne_zero p.denominatorNonzero) hn hd cross)
private theorem takeFractionCongruence (a b c d : Ratio)
 (ha : fraction a=fraction c) (hb : fraction b=fraction d) :
 exactBindingTake (.ratio a) (.ratio b)=exactBindingTake (.ratio c) (.ratio d) := by
 dsimp only [exactBindingTake,barrierTake]
 rw [ha,hb]
private theorem appendFractionCongruence (a b x c d y : Ratio)
 (ha : fraction a=fraction c) (hb : fraction b=fraction d) (hx : fraction x=fraction y) :
 appendSharedConstituentPreservesBinding (.ratio a) (.ratio b) (.ratio x)=
 appendSharedConstituentPreservesBinding (.ratio c) (.ratio d) (.ratio y) := by
 dsimp only [appendSharedConstituentPreservesBinding]
 rw [takeFractionCongruence a b c d ha hb,ha,hb,hx]
private theorem repetitionFractionCongruence (a b c d : Ratio) (k : CapabilityValues.PositiveCount)
 (ha : fraction a=fraction c) (hb : fraction b=fraction d) :
 repeatedUnitBinding (.ratio a) (.ratio b) (.count k)=repeatedUnitBinding (.ratio c) (.ratio d) (.count k) := by
 dsimp only [repeatedUnitBinding]
 rw [ha,hb]
-- The common denominator is constructed from all three original denominators.
-- It is an exact representation of the supplied states, not a model parameter.
theorem everySharedConstituentPreservesBinding (a b x : Ratio)
 (order : (fraction b).numerator*(fraction a).denominator <
  (fraction a).numerator*(fraction b).denominator) :
 appendSharedConstituentPreservesBinding (.ratio a) (.ratio b) (.ratio x)=.ok true := by
 let h := fraction a
 let l := fraction b
 let e := fraction x
 let D := h.denominator*l.denominator*e.denominator
 let N := h.numerator*l.denominator*e.denominator
 let M := l.numerator*h.denominator*e.denominator
 let X := e.numerator*h.denominator*l.denominator
 have hd := Nat.pos_of_ne_zero h.denominatorNonzero
 have ld := Nat.pos_of_ne_zero l.denominatorNonzero
 have ed := Nat.pos_of_ne_zero e.denominatorNonzero
 have dpos : 0<D := Nat.mul_pos (Nat.mul_pos hd ld) ed
 have npos : 0<N := Nat.mul_pos (Nat.mul_pos h.positive ld) ed
 have mpos : 0<M := Nat.mul_pos (Nat.mul_pos l.positive hd) ed
 have xpos : 0<X := Nat.mul_pos (Nat.mul_pos e.positive hd) ld
 have hh : h=normalizePositive N D npos dpos := by
  apply representedFraction
  dsimp only [N,D]
  conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 have hl : l=normalizePositive M D mpos dpos := by
  apply representedFraction
  dsimp only [M,D]
  conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 have he : e=normalizePositive X D xpos dpos := by
  apply representedFraction
  dsimp only [X,D]
  conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 have converted := appendFractionCongruence a b x
  (rawRatio (normalizePositive N D npos dpos)) (rawRatio (normalizePositive M D mpos dpos))
  (rawRatio (normalizePositive X D xpos dpos))
  (hh.trans (rawRoundTrip _).symm) (hl.trans (rawRoundTrip _).symm) (he.trans (rawRoundTrip _).symm)
 rw [converted]
 exact sharedConstituentCommon N M X D npos mpos xpos dpos (Nat.mul_lt_mul_of_pos_right order ed)
theorem everyPositiveRepetitionScalesBinding (a b : Ratio) (k : CapabilityValues.PositiveCount)
 (order : (fraction b).numerator*(fraction a).denominator <
  (fraction a).numerator*(fraction b).denominator) :
 repeatedUnitBinding (.ratio a) (.ratio b) (.count k)=
 .ok (rawRatio (BoundaryGrowth.multiply
  (LeptonTake.heldRemainder (fraction a) (fraction b) order) (AlphaRatio.whole k.value k.positive))) := by
 let h := fraction a
 let l := fraction b
 let D := h.denominator*l.denominator
 let N := h.numerator*l.denominator
 let M := l.numerator*h.denominator
 have hd := Nat.pos_of_ne_zero h.denominatorNonzero
 have ld := Nat.pos_of_ne_zero l.denominatorNonzero
 have dpos : 0<D := Nat.mul_pos hd ld
 have npos : 0<N := Nat.mul_pos h.positive ld
 have mpos : 0<M := Nat.mul_pos l.positive hd
 have hh : h=normalizePositive N D npos dpos := by
  apply representedFraction
  dsimp only [N,D]
  conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 have hl : l=normalizePositive M D mpos dpos := by
  apply representedFraction
  dsimp only [M,D]
  conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 have ah := hh.trans (rawRoundTrip _).symm
 have bl := hl.trans (rawRoundTrip _).symm
 have common := commonTake N M D npos mpos dpos order
 have takeSame := (bindingTakeExact a b order).symm.trans
  ((takeFractionCongruence a b _ _ ah bl).trans common)
 have remainder : LeptonTake.heldRemainder h l order=
  normalizePositive (N-M) D (SFT.Foundation.ExactCast.subtractPositive N M order) dpos := by
  have equality := congrArg fraction (Except.ok.inj takeSame)
  rw [rawRoundTrip,rawRoundTrip] at equality
  exact equality
 rw [repetitionFractionCongruence a b _ _ k ah bl]
 rw [repeatedBindingCommon N M D k.value npos mpos dpos k.positive order]
 change Except.ok _=Except.ok (rawRatio (BoundaryGrowth.multiply (LeptonTake.heldRemainder h l order) _))
 rw [remainder,scaleCommon]
end SFT.Chemistry.IntermolecularBindingExtension

