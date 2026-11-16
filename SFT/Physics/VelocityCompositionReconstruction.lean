import SFT.Physics.VelocityCompositionPairProduct
import SFT.Physics.HadronReggeProofs
import Lean
namespace SFT.Physics.VelocityComposition
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Reuse the existing private kernel theorem without modifying its module or proof.
elab "retainedVelocitySubtraction" : term =>
 return Lean.mkConst ((Lean.Name.num `_private.SFT.Physics.HadronReggeProofs 0).append `SFT.Physics.HadronReggeProofs.subtractNormalized)
theorem originalSubtractNormalized (n m d : Nat) (hd : 0<d) (bound : m≤n) :
 subtract (natRatio n d hd) (natRatio m d hd)=natRatio (n-m) d hd := by
 exact retainedVelocitySubtraction n m d hd bound
-- The exact recover_speed operation for every retained positive forward/held record.
theorem originalRecoverNormalized (h delta d : Nat) (hd : 0<d) (hp : 0<delta) :
 recoverSpeed ⟨natRatio (h+delta) d hd,.part (natRatio h d hd)⟩ =
 .ok (natRatio delta (h+delta+h) (Nat.add_pos_left (Nat.add_pos_right h hp) h)) := by
 have lt : (natRatio h d hd).blt (natRatio (h+delta) d hd)=true := by
  cases h with
  | zero =>
   rw [Nat.zero_add]
   exact positiveNormalized delta d hp hd
  | succ k =>
   apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (Nat.zero_lt_succ _) hd (Nat.add_pos_right _ hp) hd
   rw [VacuumLedgerProofs.addMul]
   exact Nat.lt_add_of_pos_right (Nat.mul_pos hp hd)
 dsimp only [recoverSpeed]
 rw [lt]
 change LeptonRatios.divide (subtract (natRatio (h+delta) d hd) (natRatio h d hd))
  (add (natRatio (h+delta) d hd) (natRatio h d hd)) = _
 rw [originalSubtractNormalized _ _ _ hd (Nat.le_add_right h delta),RunningConvergence.addSubtractLeft,addNormalized,divideNormalized delta d (h+delta+h) d hd (Nat.add_pos_left (Nat.add_pos_right h hp) h) hd]
 apply congrArg Except.ok
 apply natRatioCongruence
 exact mulAssoc _ _ _
theorem originalHeldPairSublimit (n a : Nat) (hd : 0<n+a) (ha : 0<a)
 (hu : speed (natRatio n (n+a) hd)=.ok (natRatio n (n+a) hd)) :
 heldPair (natRatio n (n+a) hd)=.ok ⟨natRatio (n+a+n) (n+a) hd,.part (natRatio a (n+a) hd)⟩ := by
 let u := natRatio n (n+a) hd
 have notLimit : ¬u.num = Int.ofNat u.den := by
  intro h
  have cross := natRatioValue n (n+a) hd
  have abs : u.num.natAbs=u.den := congrArg Int.natAbs h
  change n*u.den=u.num.natAbs*(n+a) at cross
  rw [abs,Nat.mul_comm u.den (n+a)] at cross
  have eq := Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero u.den_nz) cross
  have less : n<n+a := Nat.lt_add_of_pos_right ha
  exact (Nat.ne_of_lt less) eq
 unfold heldPair
 rw [hu]
 change (Except.ok (Pair.mk (add one u) (if u.num=Int.ofNat u.den then Held.empty else Held.part (subtract one u))) : Except String Pair) = _
 rw [if_neg notLimit]
 rw [sourceOneAtDenominator (n+a) hd]
 change (Except.ok (Pair.mk (add (natRatio (n+a) (n+a) hd) (natRatio n (n+a) hd)) (Held.part (subtract (natRatio (n+a) (n+a) hd) (natRatio n (n+a) hd)))) : Except String Pair) = _
 rw [addNormalized,originalSubtractNormalized _ _ _ hd (Nat.le_add_right n a),RunningConvergence.addSubtractLeft]
theorem originalHeldPairLimit : heldPair one=.ok ⟨wholeRatio 2,.empty⟩ := rfl
theorem originalComposedHeldSublimit (n a m b : Nat) (hd : 0<n+a) (he : 0<m+b)
 (ha : 0<a) (hb : 0<b)
 (hu : speed (natRatio n (n+a) hd)=.ok (natRatio n (n+a) hd))
 (hv : speed (natRatio m (m+b) he)=.ok (natRatio m (m+b) he)) :
 composeHeldPairs (natRatio n (n+a) hd) (natRatio m (m+b) he)=
 .ok ⟨natRatio ((n+a+n)*(m+b+m)) ((n+a)*(m+b)) (Nat.mul_pos hd he),
 .part (natRatio (a*b) ((n+a)*(m+b)) (Nat.mul_pos hd he))⟩ := by
 rw [originalPairProduct,originalHeldPairSublimit n a hd ha hu,originalHeldPairSublimit m b he hb hv]
 change (Except.ok (Pair.mk
  (multiply (natRatio (n+a+n) (n+a) hd) (natRatio (m+b+m) (m+b) he))
  (.part (multiply (natRatio a (n+a) hd) (natRatio b (m+b) he)))) : Except String Pair)=_
 rw [multiplyNormalized,multiplyNormalized]
theorem originalRecoverEmpty (forward : Rat) : recoverSpeed ⟨forward,.empty⟩=.ok one := rfl
theorem originalProductRecovery (n a m b : Nat) (hd : 0<n+a) (he : 0<m+b)
 (hn : 0<n) :
 recoverSpeed ⟨natRatio ((n+a+n)*(m+b+m)) ((n+a)*(m+b)) (Nat.mul_pos hd he),
 .part (natRatio (a*b) ((n+a)*(m+b)) (Nat.mul_pos hd he))⟩ =
 .ok (natRatio (n*(m+b)+m*(n+a)) ((n+a)*(m+b)+n*m)
   (Nat.add_pos_left (Nat.mul_pos hd he) _)) := by
 have left : n+a+n=2*n+a := by
  rw [Nat.two_mul,Nat.add_assoc,Nat.add_comm a n,←Nat.add_assoc]
 have right : m+b+m=2*m+b := by
  rw [Nat.two_mul,Nat.add_assoc,Nat.add_comm b m,←Nat.add_assoc]
 have hp : 0<2*(n*(m+b)+m*(n+a)) :=
  Nat.mul_pos (by decide) (Nat.add_pos_left (Nat.mul_pos hn he) _)
 rw [left,right,originalForwardHeldDifference]
 rw [originalRecoverNormalized (a*b) _ _ (Nat.mul_pos hd he) hp]
 have den : a*b+2*(n*(m+b)+m*(n+a))+a*b=2*((n+a)*(m+b)+n*m) := by
  rw [←originalForwardHeldDifference,originalForwardHeldSum]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [den]
 conv => lhs; simp only [Nat.mul_assoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
 conv => rhs; simp only [Nat.mul_assoc,Nat.mul_comm,CommonScaleAxis.multiplyLeftComm]
theorem originalReconstructionSublimit (n a m b : Nat) (hd : 0<n+a) (he : 0<m+b)
 (hn : 0<n) (ha : 0<a) (hb : 0<b)
 (hu : speed (natRatio n (n+a) hd)=.ok (natRatio n (n+a) hd))
 (hv : speed (natRatio m (m+b) he)=.ok (natRatio m (m+b) he)) :
 (do let p ← composeHeldPairs (natRatio n (n+a) hd) (natRatio m (m+b) he)
     recoverSpeed p) =
 .ok (natRatio (n*(m+b)+m*(n+a)) ((n+a)*(m+b)+n*m)
   (Nat.add_pos_left (Nat.mul_pos hd he) _)) := by
 rw [originalComposedHeldSublimit n a m b hd he ha hb hu hv]
 exact originalProductRecovery n a m b hd he hn
theorem originalReconstructionLeftLimit (v : Rat) (p : Pair) (hv : heldPair v=.ok p) :
 (do let q ← composeHeldPairs one v; recoverSpeed q)=.ok one := by
 rw [originalPairProduct,originalHeldPairLimit,hv]
 rfl
theorem originalReconstructionRightLimit (u : Rat) (p : Pair) (hu : heldPair u=.ok p) :
 (do let q ← composeHeldPairs u one; recoverSpeed q)=.ok one := by
 rw [originalPairProduct,hu,originalHeldPairLimit]
 cases p with
 | mk f h => cases h <;> rfl
end SFT.Physics.VelocityComposition
