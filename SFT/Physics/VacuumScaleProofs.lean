import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.VacuumScaleProofs
open VacuumLedgerProofs LeptonIntervals
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction SFT.Foundation.PrimitiveMaps

theorem multiplyNormalized (n d m e : Nat) (hd : 0 < d) (he : 0 < e) :
 multiply (natRatio n d hd) (natRatio m e he) = natRatio (n*m) (d*e) (Nat.mul_pos hd he) := by
 let a := natRatio n d hd
 let b := natRatio m e he
 have ha := natRatioNonnegative n d hd
 have hb := natRatioNonnegative m e he
 have av := natRatioValue n d hd
 have bv := natRatioValue m e he
 have raw : multiply a b = natRatio (a.num.natAbs*b.num.natAbs) (a.den*b.den)
    (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.pos_of_ne_zero b.den_nz)) := by
  unfold multiply
  rw [ha,hb]
  rfl
 change multiply a b = _
 rw [raw]
 apply natRatioCongruence
 calc
  (a.num.natAbs*b.num.natAbs)*(d*e) = (a.num.natAbs*d)*(b.num.natAbs*e) := mulInterchange _ _ _ _
  _ = (n*a.den)*(m*b.den) := by rw [← av,← bv]
  _ = (n*m)*(a.den*b.den) := mulInterchange _ _ _ _

theorem positiveNormalizedNumerator (m e : Nat) (hm : 0 < m) (he : 0 < e) :
 0 < (natRatio m e he).num.natAbs := by
 apply Nat.pos_of_ne_zero
 intro h
 have value := natRatioValue m e he
 rw [h,Nat.zero_mul] at value
 exact Nat.ne_of_gt (Nat.mul_pos hm (Nat.pos_of_ne_zero (natRatio m e he).den_nz)) value

theorem divideNormalized (n d m e : Nat) (hd : 0 < d) (hm : 0 < m) (he : 0 < e) :
 LeptonRatios.divide (natRatio n d hd) (natRatio m e he) =
 .ok (natRatio (n*e) (d*m) (Nat.mul_pos hd hm)) := by
 let a := natRatio n d hd
 let b := natRatio m e he
 have ha := natRatioNonnegative n d hd
 have hb := natRatioNonnegative m e he
 have av := natRatioValue n d hd
 have bv := natRatioValue m e he
 have bp : 0 < b.num.natAbs := positiveNormalizedNumerator m e hm he
 have raw : LeptonRatios.divide a b = .ok (natRatio (a.num.natAbs*b.den) (a.den*b.num.natAbs)
   (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) bp)) := by
  unfold LeptonRatios.divide
  rw (occs := .pos [1]) [ha]
  rw (occs := .pos [1]) [hb]
  generalize hn : b.num.natAbs = bn at bp ⊢
  cases bn with
  | zero => cases bp
  | succ k => rfl
 change LeptonRatios.divide a b = _
 rw [raw]
 apply congrArg Except.ok
 apply natRatioCongruence
 calc
  (a.num.natAbs*b.den)*(d*m) = (a.num.natAbs*d)*(b.den*m) := mulInterchange _ _ _ _
  _ = (n*a.den)*(b.num.natAbs*e) := by rw [← av,Nat.mul_comm b.den m,bv]
  _ = (n*a.den)*(e*b.num.natAbs) := congrArg (fun x => (n*a.den)*x) (Nat.mul_comm _ _)
  _ = (n*e)*(a.den*b.num.natAbs) := mulInterchange _ _ _ _

theorem positiveNormalized (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
 zero.blt (natRatio n d hd) = true := by
 have positive := positiveNormalizedNumerator n d hn hd
 unfold Rat.blt zero
 rw [natRatioNonnegative n d hd]
 change decide (0 < Int.ofNat (natRatio n d hd).num.natAbs) = true
 cases h : (natRatio n d hd).num.natAbs with
 | zero => rw [h] at positive; cases positive
 | succ k =>
  apply decide_eq_true
  change Int.NonNeg (Int.subNatNat (k+1) 1)
  unfold Int.subNatNat
  have sub : 1-(k+1) = 0 := (Nat.succ_sub_succ_eq_sub 0 k).trans (Nat.zero_sub k)
  rw [sub]
  exact Int.NonNeg.mk _
theorem exactScaleTransport (n d m e : Nat) (hn : 0 < n) (hd : 0 < d) (hm : 0 < m) (he : 0 < e) :
 VacuumDensity.scaleTransport (natRatio n d hd) (natRatio m e he) =
 .ok (natRatio (33*n*n*(e*e)) (16*d*d*(m*m))
   (Nat.mul_pos (Nat.mul_pos (Nat.mul_pos (by decide) hd) hd) (Nat.mul_pos hm hm))) := by
 unfold VacuumDensity.scaleTransport
 rw [positiveNormalized n d hn hd,positiveNormalized m e hm he]
 change LeptonRatios.divide
  (multiply (multiply (natRatio 33 16 (by decide)) (natRatio n d hd)) (natRatio n d hd))
  (multiply (natRatio m e he) (natRatio m e he)) = _
 rw [multiplyNormalized,multiplyNormalized,multiplyNormalized,divideNormalized]
 exact Nat.mul_pos hm hm

theorem separateScale (c n m q f : Nat) :
 (c*(n*q)*(n*q))*((m*f)*(m*f)) = (c*n*n*(m*m))*((q*q)*(f*f)) := by
 calc
  (c*(n*q)*(n*q))*((m*f)*(m*f)) = c*(((n*q)*(n*q))*((m*f)*(m*f))) := by
   repeat rw [mulAssoc]
  _ = c*(((n*n)*(q*q))*((m*m)*(f*f))) := by
   rw [mulInterchange n q n q,mulInterchange m f m f]
  _ = c*(((n*n)*(m*m))*((q*q)*(f*f))) :=
   congrArg (fun x => c*x) (mulInterchange (n*n) (q*q) (m*m) (f*f))
  _ = (c*n*n*(m*m))*((q*q)*(f*f)) := by
   repeat rw [mulAssoc]

theorem commonScaleCovariance (n d m e q f : Nat)
 (hn : 0 < n) (hd : 0 < d) (hm : 0 < m) (he : 0 < e) (hq : 0 < q) (hf : 0 < f) :
 VacuumDensity.scaleTransport
  (multiply (natRatio n d hd) (natRatio q f hf))
  (multiply (natRatio m e he) (natRatio q f hf)) =
 VacuumDensity.scaleTransport (natRatio n d hd) (natRatio m e he) := by
 rw [multiplyNormalized,multiplyNormalized]
 rw [exactScaleTransport (n*q) (d*f) (m*q) (e*f) (Nat.mul_pos hn hq) (Nat.mul_pos hd hf)
   (Nat.mul_pos hm hq) (Nat.mul_pos he hf),exactScaleTransport n d m e hn hd hm he]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [separateScale 33 n e q f,separateScale 16 d m f q,Nat.mul_comm (f*f) (q*q)]
 exact (mulRightComm (33*n*n*(e*e)) ((q*q)*(f*f)) (16*d*d*(m*m))).trans
   (mulAssoc (33*n*n*(e*e)) (16*d*d*(m*m)) ((q*q)*(f*f)))
theorem positiveCarrierRepresentation (p : PositiveFraction) :
 BoundaryGrowth.asFraction p = natRatio p.numerator p.denominator (Nat.pos_of_ne_zero p.denominatorNonzero) :=
 representedIdentity _ _ _ _ rfl rfl

theorem everyPositiveReferenceCovariant (rate speed scale : PositiveFraction) :
 VacuumDensity.scaleTransport
  (multiply (BoundaryGrowth.asFraction rate) (BoundaryGrowth.asFraction scale))
  (multiply (BoundaryGrowth.asFraction speed) (BoundaryGrowth.asFraction scale)) =
 VacuumDensity.scaleTransport (BoundaryGrowth.asFraction rate) (BoundaryGrowth.asFraction speed) := by
 rw [positiveCarrierRepresentation rate,positiveCarrierRepresentation speed,positiveCarrierRepresentation scale]
 exact commonScaleCovariance _ _ _ _ _ _ rate.positive _ speed.positive _ scale.positive _

theorem nonpositiveRateRejected (rate speed : Rat) (rejected : zero.blt rate = false) :
 VacuumDensity.scaleTransport rate speed = .error "scale references must be exact positive carriers" := by
 unfold VacuumDensity.scaleTransport
 rw [rejected]
 rfl

theorem nonpositiveSpeedRejected (rate speed : Rat) (rejected : zero.blt speed = false) :
 VacuumDensity.scaleTransport rate speed = .error "scale references must be exact positive carriers" := by
 unfold VacuumDensity.scaleTransport
 rw [rejected]
 cases zero.blt rate <;> rfl
end SFT.Physics.VacuumScaleProofs
