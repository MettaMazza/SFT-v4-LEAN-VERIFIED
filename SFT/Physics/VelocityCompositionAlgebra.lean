import SFT.Physics.VelocityComposition
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.VelocityComposition
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- The original admitted speed guard, without a new scientific condition.
theorem admittedSpeed (u : Rat) (positive : zero.blt u=true) (bounded : one.blt u=false) : speed u=.ok u := by
 unfold speed
 rw [positive,bounded]
 rfl
private theorem integerSumComm (a b : Int) : a+b=b+a := by
 cases a with
 | ofNat n => cases b with
   | ofNat m => exact congrArg Int.ofNat (Nat.add_comm n m)
   | negSucc m => rfl
 | negSucc n => cases b with
   | ofNat m => rfl
   | negSucc m =>
     change Int.negSucc (n+m+1)=Int.negSucc (m+n+1)
     rw [Nat.add_comm n m]
private theorem integerProductComm (a b : Int) : a*b=b*a := by
 cases a with
 | ofNat n => cases b with
   | ofNat m => exact congrArg Int.ofNat (Nat.mul_comm n m)
   | negSucc m =>
     change -(Int.ofNat (n*(m+1)))= -(Int.ofNat ((m+1)*n))
     rw [Nat.mul_comm n (m+1)]
 | negSucc n => cases b with
   | ofNat m =>
     change -(Int.ofNat ((n+1)*m))= -(Int.ofNat (m*(n+1)))
     rw [Nat.mul_comm (n+1) m]
   | negSucc m => exact congrArg Int.ofNat (Nat.mul_comm (n+1) (m+1))
private theorem normalizedInputs (n m : Int) (d e : Nat) (hd : 0<d) (he : 0<e)
 (hn : n=m) (hde : d=e) : normalize n d hd=normalize m e he := by
 cases hn
 cases hde
 rfl
theorem sumCommutative (u v : Rat) : add u v=add v u :=
 normalizedInputs _ _ _ _ _ _ (integerSumComm _ _) (Nat.mul_comm _ _)
theorem productCommutative (u v : Rat) : multiply u v=multiply v u :=
 normalizedInputs _ _ _ _ _ _ (integerProductComm _ _) (Nat.mul_comm _ _)
theorem originalCompositionFormula (u v : Rat) (hu : speed u=.ok u) (hv : speed v=.ok v) :
 composeSameDirection (.speed u) (.speed v) = (LeptonRatios.divide (add u v) (add one (multiply u v))).map Motion.speed := by
 change (do let x ← speed u
            let y ← speed v
            let z ← LeptonRatios.divide (add x y) (add one (multiply x y))
            pure (Motion.speed z))=_
 rw [hu,hv]
 change (LeptonRatios.divide (add u v) (add one (multiply u v)) >>= fun z => Except.ok (Motion.speed z))=_
 cases LeptonRatios.divide (add u v) (add one (multiply u v)) <;> rfl
theorem originalCommutative (u v : Rat) (hu : speed u=.ok u) (hv : speed v=.ok v) :
 composeSameDirection (.speed u) (.speed v)=composeSameDirection (.speed v) (.speed u) := by
 rw [originalCompositionFormula u v hu hv,originalCompositionFormula v u hv hu,sumCommutative u v,productCommutative u v]
-- Exact normalized arithmetic reuses the already verified denominator semantics.
theorem sourceSumFractions (n d m e : Nat) (hd : 0<d) (he : 0<e) :
 add (natRatio n d hd) (natRatio m e he)=natRatio (n*e+m*d) (d*e) (Nat.mul_pos hd he) := by
 have a : natRatio n d hd=natRatio (n*e) (d*e) (Nat.mul_pos hd he) := by
  apply natRatioCongruence
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 have b : natRatio m e he=natRatio (m*d) (d*e) (Nat.mul_pos hd he) := by
  apply natRatioCongruence
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 rw [a,b,addNormalized]
theorem sourceOneAtDenominator (d : Nat) (hd : 0<d) : one=natRatio d d hd := by
 change natRatio 1 1 (by decide)=_
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.mul_one]
theorem originalRationalComposition (n d m e : Nat) (hd : 0<d) (he : 0<e)
 (hu : speed (natRatio n d hd)=.ok (natRatio n d hd))
 (hv : speed (natRatio m e he)=.ok (natRatio m e he)) :
 composeSameDirection (.speed (natRatio n d hd)) (.speed (natRatio m e he))=
 .ok (.speed (natRatio (n*e+m*d) (d*e+n*m) (Nat.add_pos_left (Nat.mul_pos hd he) _))) := by
 rw [originalCompositionFormula _ _ hu hv,sourceSumFractions,multiplyNormalized]
 have den : add one (natRatio (n*m) (d*e) (Nat.mul_pos hd he))=natRatio (d*e+n*m) (d*e) (Nat.mul_pos hd he) := by
  rw [sourceOneAtDenominator (d*e) (Nat.mul_pos hd he),addNormalized]
 rw [den]
 rw [divideNormalized _ _ _ _ _ (Nat.add_pos_left (Nat.mul_pos hd he) _) _]
 change Except.ok (Motion.speed (natRatio ((n*e+m*d)*(d*e)) ((d*e)*(d*e+n*m)) _))=_
 apply congrArg (fun q => Except.ok (Motion.speed q))
 apply natRatioCongruence
 exact mulAssoc _ _ _
-- Residuals a and b are the original held complements in a common positive-whole presentation.
theorem originalHeldResidual (n a m b : Nat) :
 (n+a)*(m+b)+n*m=(n*(m+b)+m*(n+a))+a*b := by
 conv => lhs; simp only [Nat.mul_add,Nat.add_mul,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_comm]
 conv => rhs; simp only [Nat.mul_add,Nat.add_mul,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm,Nat.mul_comm]
theorem originalStrictClosureCross (n a m b : Nat) (ha : 0<a) (hb : 0<b) :
 n*(m+b)+m*(n+a)<(n+a)*(m+b)+n*m := by
 rw [originalHeldResidual]
 exact Nat.lt_add_of_pos_right (Nat.mul_pos ha hb)
theorem originalLimitCross (n m e : Nat) : n*e+m*n=n*e+n*m := by rw [Nat.mul_comm m n]
end SFT.Physics.VelocityComposition
