import SFT.Physics.OrbitalDimensionStabilityCertificate
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.OrbitalDimensionStabilityGeneral
open OrbitalDimensionStability BoundaryGrowth LeptonTerminal SFT.Foundation.ExactOperations
set_option maxHeartbeats 100000000
private theorem productLeftComm (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [← SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm a b,SFT.Foundation.FractionReduction.mulAssoc]
private theorem powerValue (q : PositiveFraction) (n : Nat) :
 (positivePower q n).numerator*q.denominator^n=q.numerator^n*(positivePower q n).denominator := by
 induction n with
 | zero => rfl
 | succ n ih =>
  let p := positivePower q n
  let next := multiply p q
  have step := multiplicationValue p q
  change next.numerator*q.denominator^(n+1)=q.numerator^(n+1)*next.denominator
  rw [Nat.pow_succ,Nat.pow_succ]
  apply Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero p.denominatorNonzero)
  calc
   (next.numerator*(q.denominator^n*q.denominator))*p.denominator=(next.numerator*(p.denominator*q.denominator))*q.denominator^n := by
    conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
    conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
   _=((p.numerator*q.numerator)*next.denominator)*q.denominator^n := congrArg (fun x => x*q.denominator^n) step
   _=(p.numerator*q.denominator^n)*(q.numerator*next.denominator) := by
    conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
    conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
   _=(q.numerator^n*p.denominator)*(q.numerator*next.denominator) := congrArg (fun x => x*(q.numerator*next.denominator)) ih
   _=((q.numerator^n*q.numerator)*next.denominator)*p.denominator := by
    conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
    conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]

theorem originalPowerRepresentation (q : PositiveFraction) (n : Nat) :
 positivePower q n=normalizePositive (q.numerator^n) (q.denominator^n) (Nat.pow_pos q.positive) (Nat.pow_pos (Nat.pos_of_ne_zero q.denominatorNonzero)) := by
 symm
 exact FieldGeometricDilution.positiveNormalizationRepresents _ _ _ _ _ (powerValue q n).symm

theorem originalInversePowerRepresentation (q : PositiveFraction) (n : Nat) :
 LeptonInvariants.reciprocal (positivePower q n)=normalizePositive (q.denominator^n) (q.numerator^n) (Nat.pow_pos (Nat.pos_of_ne_zero q.denominatorNonzero)) (Nat.pow_pos q.positive) := by
 let p := positivePower q n
 let r := LeptonInvariants.reciprocal p
 have inverse : p.denominator*r.denominator=r.numerator*p.numerator := normalizedValuePreserved _ _ (Nat.pos_of_ne_zero p.denominatorNonzero) p.positive
 symm
 apply FieldGeometricDilution.positiveNormalizationRepresents
 apply Nat.eq_of_mul_eq_mul_right p.positive
 calc
  (q.denominator^n*r.denominator)*p.numerator=(p.numerator*q.denominator^n)*r.denominator := by
   conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
   conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
  _=(q.numerator^n*p.denominator)*r.denominator := congrArg (fun x => x*r.denominator) (powerValue q n)
  _=q.numerator^n*(p.denominator*r.denominator) := SFT.Foundation.FractionReduction.mulAssoc _ _ _
  _=q.numerator^n*(r.numerator*p.numerator) := congrArg (fun x => q.numerator^n*x) inverse
  _=(r.numerator*q.numerator^n)*p.numerator := by
   conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
   conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
theorem originalFourDimensionalMarginal (q : PositiveFraction) (above : q.denominator<q.numerator) :
 orbitalStabilityClass (.integer 4) (.fraction (asFraction q))=.ok "marginal" := by
 unfold orbitalStabilityClass
 have actual := originalMagnitudes 2 q above
 change displacedMagnitudes (.integer 4) (.fraction (asFraction q))=.ok (LeptonInvariants.reciprocal (positivePower q 3),LeptonInvariants.reciprocal (positivePower q 3)) at actual
 rw [actual]
 dsimp only [Except.bind,Bind.bind]
 let r := LeptonInvariants.reciprocal (positivePower q 3)
 change (if (r.numerator*r.denominator == r.numerator*r.denominator) then _ else _)=_
 have self : ∀ n : Nat, (n==n)=true := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih => exact ih
 rw [self]
 rfl
private theorem normalizedPositiveLess (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (cross : n*e<m*d) :
 (normalizePositive n d hn hd).numerator*(normalizePositive m e hm he).denominator <
 (normalizePositive m e hm he).numerator*(normalizePositive n d hn hd).denominator := by
 have less := CommonScaleAxis.normalizedCrossLess n d m e hd he cross
 cases n with
 | zero => cases hn
 | succ n =>
  cases m with
  | zero => cases hm
  | succ m => exact less
private theorem positivePowerOrdered (n d k : Nat) (hd : 0<d) (below : d<n) : d^(k+1)<n^(k+1) := by
 induction k with
 | zero =>
  change 1*d<1*n
  rw [Nat.one_mul,Nat.one_mul]
  exact below
 | succ k ih =>
  rw [Nat.pow_succ,Nat.pow_succ]
  exact Nat.lt_trans (Nat.mul_lt_mul_of_pos_right ih hd) (Nat.mul_lt_mul_of_pos_left below (Nat.pow_pos (Nat.lt_trans hd below)))
private theorem wholePowerAdd (n a b : Nat) : n^(a+b)=n^a*n^b := by
 induction b with
 | zero => rw [Nat.add_zero,Nat.pow_zero,Nat.mul_one]
 | succ b ih => rw [Nat.add_succ,Nat.pow_succ,ih,Nat.pow_succ n b,SFT.Foundation.FractionReduction.mulAssoc]
private theorem inversePowerCross (n d a k : Nat) (hd : 0<d) (below : d<n) :
 d^(a+(k+1))*n^a < d^a*n^(a+(k+1)) := by
 have powers := positivePowerOrdered n d k hd below
 have positive : 0<d^a*n^a := Nat.mul_pos (Nat.pow_pos hd) (Nat.pow_pos (Nat.lt_trans hd below))
 have scaled := Nat.mul_lt_mul_of_pos_left powers (show 0<d^a*n^a from positive)
 rw [wholePowerAdd d a (k+1),wholePowerAdd n a (k+1)]
 have left : (d^a*d^(k+1))*n^a=(d^a*n^a)*d^(k+1) := by
  conv => lhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
  conv => rhs; simp only [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm,productLeftComm]
 have right : d^a*(n^a*n^(k+1))=(d^a*n^a)*n^(k+1) := (SFT.Foundation.FractionReduction.mulAssoc _ _ _).symm
 rw [left,right]
 exact scaled
private theorem inversePowerStrictOrder (q : PositiveFraction) (a k : Nat) (above : q.denominator<q.numerator) :
 (LeptonInvariants.reciprocal (positivePower q (a+(k+1)))).numerator*(LeptonInvariants.reciprocal (positivePower q a)).denominator <
 (LeptonInvariants.reciprocal (positivePower q a)).numerator*(LeptonInvariants.reciprocal (positivePower q (a+(k+1)))).denominator := by
 rw [originalInversePowerRepresentation,originalInversePowerRepresentation]
 exact normalizedPositiveLess _ _ _ _ _ _ _ _ (inversePowerCross q.numerator q.denominator a k (Nat.pos_of_ne_zero q.denominatorNonzero) above)
private theorem unequalNatBeqFalse (a b : Nat) (different : a≠b) : (a==b)=false := by
 cases h : (a==b) with
 | false => rfl
 | true => exact False.elim (different (Nat.eq_of_beq_eq_true h))
theorem originalAboveFourUnstable (k : Nat) (q : PositiveFraction) (above : q.denominator<q.numerator) :
 orbitalStabilityClass (.integer (.ofNat (k+5))) (.fraction (asFraction q))=.ok "unstable-nonrestoring" := by
 have actual := originalMagnitudes (k+3) q above
 change displacedMagnitudes (.integer (.ofNat (k+5))) (.fraction (asFraction q))=.ok (LeptonInvariants.reciprocal (positivePower q (k+4)),LeptonInvariants.reciprocal (positivePower q 3)) at actual
 have exponent : 3+(k+1)=k+4 := by rw [Nat.add_comm 3 (k+1)]
 have less := inversePowerStrictOrder q 3 k above
 rw [exponent] at less
 unfold orbitalStabilityClass
 rw [actual]
 dsimp only [Except.bind,Bind.bind]
 rw [unequalNatBeqFalse _ _ (Nat.ne_of_lt less)]
 rw [ite_eq_right (Nat.not_lt_of_ge (Nat.le_of_lt less))]
 rfl
theorem originalTwoDimensionalStable (q : PositiveFraction) (above : q.denominator<q.numerator) :
 orbitalStabilityClass (.integer 2) (.fraction (asFraction q))=.ok "stable-restoring" := by
 have actual := originalMagnitudes 0 q above
 change displacedMagnitudes (.integer 2) (.fraction (asFraction q))=.ok (LeptonInvariants.reciprocal (positivePower q 1),LeptonInvariants.reciprocal (positivePower q 3)) at actual
 have less := inversePowerStrictOrder q 1 1 above
 change (LeptonInvariants.reciprocal (positivePower q 3)).numerator*(LeptonInvariants.reciprocal (positivePower q 1)).denominator < (LeptonInvariants.reciprocal (positivePower q 1)).numerator*(LeptonInvariants.reciprocal (positivePower q 3)).denominator at less
 unfold orbitalStabilityClass
 rw [actual]
 dsimp only [Except.bind,Bind.bind]
 rw [unequalNatBeqFalse _ _ (Nat.ne_of_gt less)]
 rw [ite_eq_left less]
 rfl
theorem originalThreeDimensionalStable (q : PositiveFraction) (above : q.denominator<q.numerator) :
 orbitalStabilityClass (.integer 3) (.fraction (asFraction q))=.ok "stable-restoring" := by
 have actual := originalMagnitudes 1 q above
 change displacedMagnitudes (.integer 3) (.fraction (asFraction q))=.ok (LeptonInvariants.reciprocal (positivePower q 2),LeptonInvariants.reciprocal (positivePower q 3)) at actual
 have less := inversePowerStrictOrder q 2 0 above
 change (LeptonInvariants.reciprocal (positivePower q 3)).numerator*(LeptonInvariants.reciprocal (positivePower q 2)).denominator < (LeptonInvariants.reciprocal (positivePower q 2)).numerator*(LeptonInvariants.reciprocal (positivePower q 3)).denominator at less
 unfold orbitalStabilityClass
 rw [actual]
 dsimp only [Except.bind,Bind.bind]
 rw [unequalNatBeqFalse _ _ (Nat.ne_of_gt less)]
 rw [ite_eq_left less]
 rfl
end SFT.Physics.OrbitalDimensionStabilityGeneral
