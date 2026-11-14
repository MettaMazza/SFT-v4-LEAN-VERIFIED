import SFT.Physics.CommonScaleAxisAlgebra
import SFT.Foundation.FoldCastLaws
import SFT.Physics.InverseSquare
import SFT.Physics.FieldElectricDistinction
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.CoulombGauss
open SFT.Foundation ExactOperations
open BoundaryGrowth FoldFirstReturn FoldCastLaws
open SFT.Mathematics.FoldScalar

structure Result where
 field : PositiveFraction
 flux : PositiveFraction
 retainedPotential : Rat

def coulombGaussClosure (source : Rat) : Input → Except String Result
 | .nonFraction => .error "Coulomb witness requires exact ordered positive source and radius"
 | .fraction radius =>
   match admitPositive source with
   | none => .error "Coulomb witness requires exact ordered positive source and radius"
   | some s => match admitPositive radius with
    | none => .error "Coulomb witness requires exact ordered positive source and radius"
    | some r =>
     if source.blt radius && !(ExactPartCarrier.asFraction one).blt radius then
       let field := InverseSquare.exactResponse s r
       let flux := BoundaryGrowth.multiply (BoundaryGrowth.multiply field r) r
       let potential := LeptonIntervals.subtract (ExactPartCarrier.asFraction one) (asFraction (quotientMagnitude s r))
       if !(asFraction flux).blt source && !source.blt (asFraction flux) && LeptonIntervals.zero.blt potential then
         .ok ⟨field,flux,potential⟩
       else .error "Coulomb/Gauss closure lost source or retained potential"
     else .error "Coulomb witness requires exact ordered positive source and radius"

-- Bind V3's two successive radius multiplications to its complete square boundary.
private theorem successiveProduct (a b c : PositiveFraction) :
 BoundaryGrowth.multiply (BoundaryGrowth.multiply a b) c =
 normalizePositive ((a.numerator*b.numerator)*c.numerator)
   ((a.denominator*b.denominator)*c.denominator)
   (Nat.mul_pos (Nat.mul_pos a.positive b.positive) c.positive)
   (Nat.mul_pos (Nat.mul_pos (Nat.pos_of_ne_zero a.denominatorNonzero)
     (Nat.pos_of_ne_zero b.denominatorNonzero)) (Nat.pos_of_ne_zero c.denominatorNonzero)) := by
 let g := Nat.gcd (a.numerator*b.numerator) (a.denominator*b.denominator)
 have hg : 0<g := FractionReduction.gcdPositive _ _
   (Nat.mul_pos (Nat.pos_of_ne_zero a.denominatorNonzero) (Nat.pos_of_ne_zero b.denominatorNonzero))
 have hn := normalizedNumeratorFactor (a.numerator*b.numerator) (a.denominator*b.denominator)
   (Nat.mul_pos a.positive b.positive)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.denominatorNonzero) (Nat.pos_of_ne_zero b.denominatorNonzero))
 have hd := normalizedDenominatorFactor (a.numerator*b.numerator) (a.denominator*b.denominator)
   (Nat.mul_pos a.positive b.positive)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.denominatorNonzero) (Nat.pos_of_ne_zero b.denominatorNonzero))
 change a.numerator*b.numerator=g*(BoundaryGrowth.multiply a b).numerator at hn
 change a.denominator*b.denominator=g*(BoundaryGrowth.multiply a b).denominator at hd
 exact (FieldGeometricDilution.commonCountScaleCancels g _ _ hg _ _).symm.trans
   (positiveNormalizationCongr _ _ _ _ _ _ _ _
     ((congrArg (fun x => x*c.numerator) hn).trans (FractionReduction.mulAssoc _ _ _))
     ((congrArg (fun x => x*c.denominator) hd).trans (FractionReduction.mulAssoc _ _ _))).symm

private theorem productCommutes (a b : PositiveFraction) :
 BoundaryGrowth.multiply a b=BoundaryGrowth.multiply b a := by
 unfold BoundaryGrowth.multiply
 exact positiveNormalizationCongr _ _ _ _ _ _ _ _ (Nat.mul_comm _ _) (Nat.mul_comm _ _)

theorem sequentialFluxReturnsSource (source radius : PositiveFraction) :
 BoundaryGrowth.multiply (BoundaryGrowth.multiply (InverseSquare.exactResponse source radius) radius) radius=source := by
 have h := successiveProduct (InverseSquare.exactResponse source radius) radius radius
 have k := successiveProduct radius radius (InverseSquare.exactResponse source radius)
 have hn : (InverseSquare.exactResponse source radius).numerator*radius.numerator*radius.numerator =
   radius.numerator*radius.numerator*(InverseSquare.exactResponse source radius).numerator := by
   rw [FractionReduction.mulAssoc,Nat.mul_comm (InverseSquare.exactResponse source radius).numerator]
 have hd : (InverseSquare.exactResponse source radius).denominator*radius.denominator*radius.denominator =
   radius.denominator*radius.denominator*(InverseSquare.exactResponse source radius).denominator := by
   rw [FractionReduction.mulAssoc,Nat.mul_comm (InverseSquare.exactResponse source radius).denominator]
 exact h.trans ((positiveNormalizationCongr _ _ _ _ _ _ _ _ hn hd).trans (k.symm.trans ((productCommutes _ _).trans (InverseSquare.conservedAtEveryScale source radius))))
private theorem integerNotLess (a b : Nat) (bound : b≤a) : ¬Int.ofNat a<Int.ofNat b := by
 intro h
 change Int.NonNeg (Int.subNatNat b (a+1)) at h
 unfold Int.subNatNat at h
 have positive := RunningConvergence.orderedDifferencePositive _ _ (Nat.lt_succ_of_le bound)
 cases hd : (a+1)-b with
 | zero => rw [hd] at positive; cases positive
 | succ n => rw [hd] at h; cases h

private theorem positiveLess (a b : PositiveFraction) :
 (asFraction a).blt (asFraction b)=decide (a.numerator*b.denominator<b.numerator*a.denominator) := by
 cases a with
 | mk an ad az ar ap =>
  cases an with
  | zero => exact False.elim (Nat.not_lt_zero _ ap)
  | succ an =>
   cases b with
   | mk bn bd bz br bp =>
    cases bn with
    | zero => exact False.elim (Nat.not_lt_zero _ bp)
    | succ bn =>
     unfold Rat.blt asFraction
     dsimp only
     have notNeg : ¬Int.ofNat (an+1)<0 := integerNotLess (an+1) 0 (Nat.zero_le _)
     have notZero : Int.ofNat (an+1)≠0 := fun h => Nat.noConfusion (congrArg Int.toNat h)
     have notNonpos : ¬Int.ofNat (bn+1)≤0 := by
      intro h
      change Int.NonNeg (Int.subNatNat 0 (bn+1)) at h
      unfold Int.subNatNat at h
      rw [Nat.sub_zero] at h
      cases h
     rw [decide_eq_false notNeg,ite_eq_right notZero,decide_eq_false notNonpos,Bool.and_false,Bool.false_and]
     change decide (Int.ofNat ((an+1)*bd)<Int.ofNat ((bn+1)*ad))=decide ((an+1)*bd<(bn+1)*ad)
     if h : (an+1)*bd<(bn+1)*ad then
      rw [decide_eq_true h,decide_eq_true (CommonScaleAxis.integerNaturalLess _ _ h)]
     else rw [decide_eq_false h,decide_eq_false (integerNotLess _ _ (Nat.le_of_not_gt h))]

private theorem positiveAboveZero (a : PositiveFraction) : LeptonIntervals.zero.blt (asFraction a)=true := by
 rw [VacuumScaleProofs.positiveCarrierRepresentation]
 exact VacuumScaleProofs.positiveNormalized _ _ a.positive _

private theorem ownComparison (a : PositiveFraction) : (asFraction a).blt (asFraction a)=false := by
 rw [positiveLess]
 exact decide_eq_false (Nat.lt_irrefl _)

theorem quotientBelowOne (source radius : PositiveFraction)
 (ordered : source.numerator*radius.denominator<radius.numerator*source.denominator) :
 (quotientMagnitude source radius).numerator<(quotientMagnitude source radius).denominator := by
 let q := quotientMagnitude source radius
 apply Nat.lt_of_not_ge
 intro h
 have less := Nat.mul_lt_mul_of_pos_right ordered (Nat.pos_of_ne_zero q.denominatorNonzero)
 have val := quotientExact source radius
 change source.numerator*radius.denominator*q.denominator=q.numerator*(source.denominator*radius.numerator) at val
 rw [val] at less
 have bound := Nat.mul_le_mul_left (source.denominator*radius.numerator) h
 rw [Nat.mul_comm (source.denominator*radius.numerator) q.numerator,
     Nat.mul_comm source.denominator radius.numerator] at bound
 rw [Nat.mul_comm source.denominator radius.numerator] at less
 exact Nat.not_le_of_gt less bound

private theorem normalizedPositiveRat (n d : Nat) (hn : 0<n) (hd : 0<d) :
 LeptonIntervals.normalize (.ofNat n) d hd=asFraction (normalizePositive n d hn hd) := by
 cases n with
 | zero => exact False.elim (Nat.not_lt_zero _ hn)
 | succ n => rfl

theorem retainedPotentialPositive (q : PositiveFraction) (below : q.numerator<q.denominator) :
 LeptonIntervals.zero.blt (LeptonIntervals.subtract (ExactPartCarrier.asFraction one) (asFraction q))=true := by
 have diff : Int.ofNat q.denominator-Int.ofNat q.numerator=Int.ofNat (q.denominator-q.numerator) := by
  cases hn : q.numerator with
  | zero => rfl
  | succ n =>
   change Int.subNatNat q.denominator (n+1)=_
   unfold Int.subNatNat
   have bound : n+1≤q.denominator := by rw [← hn]; exact Nat.le_of_lt below
   rw [CommonScaleAxis.subtractionZeroOfBound _ _ bound]
 have raw : (1:Int)*Int.ofNat q.denominator-Int.ofNat q.numerator*1=Int.ofNat (q.denominator-q.numerator) := by
  have right : Int.ofNat q.numerator*1=Int.ofNat q.numerator := congrArg Int.ofNat (Nat.mul_one _)
  rw [Int.one_mul,right]
  exact diff
 exact (congrArg (fun n : Int => LeptonIntervals.zero.blt
   (LeptonIntervals.normalize n (1*q.denominator)
    (Nat.mul_pos (by decide) (Nat.pos_of_ne_zero q.denominatorNonzero)))) raw).trans
   ((congrArg (fun value => LeptonIntervals.zero.blt value)
      (normalizedPositiveRat _ _ (RunningConvergence.orderedDifferencePositive _ _ below) _)).trans (positiveAboveZero _))

theorem admittedSourceRecord (source radius : PositiveFraction)
 (ordered : source.numerator*radius.denominator<radius.numerator*source.denominator)
 (throughOne : radius.numerator≤radius.denominator) :
 coulombGaussClosure (asFraction source) (.fraction (asFraction radius))=
 .ok ⟨InverseSquare.exactResponse source radius,source,
  LeptonIntervals.subtract (ExactPartCarrier.asFraction one) (asFraction (quotientMagnitude source radius))⟩ := by
 unfold coulombGaussClosure
 dsimp only
 rw [positiveRoundTrip,positiveRoundTrip]
 dsimp only
 have comparison := positiveLess source radius
 rw [decide_eq_true ordered] at comparison
 have bound : (ExactPartCarrier.asFraction one).blt (asFraction radius)=false := by
  change (asFraction (normalizePositive 1 1 (by decide) (by decide))).blt (asFraction radius)=false
  rw [positiveLess]
  change decide (1*radius.denominator<radius.numerator*1)=false
  rw [Nat.one_mul,Nat.mul_one]
  exact decide_eq_false (Nat.not_lt_of_ge throughOne)
 rw [comparison,bound]
 rw [sequentialFluxReturnsSource,ownComparison,
   retainedPotentialPositive _ (quotientBelowOne source radius ordered)]
 rfl

def sourceEighth : Rat := ⟨1,8,by decide,by decide⟩
def innerRadius : Rat := ⟨1,4,by decide,by decide⟩
def outerRadius : Rat := ⟨1,2,by decide,by decide⟩
theorem innerSourceRecord : coulombGaussClosure sourceEighth (.fraction innerRadius)=
 .ok ⟨normalizePositive 2 1 (by decide) (by decide),
      normalizePositive 1 8 (by decide) (by decide),⟨1,2,by decide,by decide⟩⟩ := rfl
theorem outerSourceRecord : coulombGaussClosure sourceEighth (.fraction outerRadius)=
 .ok ⟨normalizePositive 1 2 (by decide) (by decide),
      normalizePositive 1 8 (by decide) (by decide),⟨3,4,by decide,by decide⟩⟩ := rfl
end SFT.Physics.CoulombGauss
