import SFT.Physics.FiniteLoop
import SFT.Physics.MagneticCovariance
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.FiniteLoopProofs
open SFT.Foundation ExactOperations ExactPartCarrier FractionReduction
open LeptonIntervals VacuumLedgerProofs FiniteLoop

private theorem mulLC (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [← mulAssoc,Nat.mul_comm a b,mulAssoc]

theorem halveRatio (n d : Nat) (hd : 0<d) :
 LeptonRatios.divide (natRatio n d hd) (wholeRatio 2) =
 .ok (natRatio n (d*2) (Nat.mul_pos hd (by decide))) := by
 let a := natRatio n d hd
 have ha := natRatioNonnegative n d hd
 have av := natRatioValue n d hd
 change Except.ok (normalize (a.num*1) (a.den*2) _) = _
 have raw : normalize (a.num*1) (a.den*2) (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (by decide)) = natRatio a.num.natAbs (a.den*2) (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (by decide)) := by
  rw [ha]
  have hm (k : Nat) : Int.ofNat k * 1 = Int.ofNat k := congrArg Int.ofNat (Nat.mul_one k)
  rw [hm]
  rfl
 rw [raw]
 apply congrArg Except.ok
 apply representedIdentity _ n (d*2) _ (natRatioNonnegative _ _ _)
 have nv := natRatioValue a.num.natAbs (a.den*2) (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (by decide))
 let b := natRatio a.num.natAbs (a.den*2) (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (by decide))
 apply Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero a.den_nz)
 calc
  (n*b.den)*a.den = (n*a.den)*b.den := mulRightComm _ _ _
  _ = (a.num.natAbs*d)*b.den := congrArg (fun x => x*b.den) av
  _ = (a.num.natAbs*b.den)*d := mulRightComm _ _ _
  _ = (b.num.natAbs*(a.den*2))*d := congrArg (fun x => x*d) nv
  _ = (b.num.natAbs*(d*2))*a.den := by
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,mulLC]
   all_goals (conv => rhs; simp only [mulAssoc,Nat.mul_comm,mulLC])
theorem appendHalfTerm (n d : Nat) (hd : 0<d) :
 add (natRatio n d hd) (natRatio 1 (d*2) (Nat.mul_pos hd (by decide))) =
 natRatio (n+n+1) (d*2) (Nat.mul_pos hd (by decide)) := by
 have av := natRatioValue n d hd
 have doubled : (n+n)*(natRatio n d hd).den = (natRatio n d hd).num.natAbs*(d*2) := by
  rw [addMul,av,Nat.mul_succ,Nat.mul_one,Nat.mul_add]
 exact addCommonDenominator _ _ (n+n) 1 (d*2) _
  (natRatioNonnegative n d hd) (natRatioNonnegative 1 (d*2) _) doubled (natRatioValue 1 (d*2) _)

open SFT.Mathematics.DyadicClosure in
theorem completeLoopState (n : Nat) :
 appendTerms (wholeRatio 2) n ⟨1,2,by decide,by decide⟩ ⟨1,2,by decide,by decide⟩ =
 .ok (natRatio (total (weights (n+1))) (2^(n+1)) (Nat.pow_pos (by decide)),
      natRatio 1 (2^(n+1)) (Nat.pow_pos (by decide))) := by
 induction n with
 | zero => rfl
 | succ n ih =>
  unfold appendTerms
  rw [ih]
  dsimp only [Except.bind,Bind.bind]
  rw [halveRatio]
  dsimp only [Except.bind,Bind.bind,Except.pure,Pure.pure]
  rw [appendHalfTerm]
  conv => rhs; simp only [weightSuccessor (n+1),Nat.pow_succ]
  conv => lhs; simp only [Nat.pow_succ]
open SFT.Mathematics.DyadicClosure in
theorem sourcePositiveDepth (n : Nat) :
 finiteLoopSum (.integer (.ofNat (n+1))) =
 .ok (natRatio (total (weights (n+1))) (2^(n+1)) (Nat.pow_pos (by decide))) := by
 have hp : 0<total (weights (n+1)) := by
  rw [weightSuccessor]
  exact Nat.zero_lt_succ _
 have below : total (weights (n+1)) < 2^(n+1) := by
  rw [← completeLedger (n+1)]
  exact Nat.lt_succ_self _
 have positive := VacuumScaleProofs.positiveNormalized (total (weights (n+1))) (2^(n+1)) hp (Nat.pow_pos (by decide))
 have small : (natRatio (total (weights (n+1))) (2^(n+1)) (Nat.pow_pos (by decide))).blt (asFraction one)=true := by
  apply CommonScaleAxis.positiveNormalizedLess _ _ 1 1 hp (Nat.pow_pos (by decide)) (by decide) (by decide)
  rw [Nat.mul_one,Nat.one_mul]
  exact below
 unfold finiteLoopSum
 rw [AlphaCovers.binaryCountTwo]
 change (do let record ← appendTerms (wholeRatio 2) n ⟨1,2,by decide,by decide⟩ ⟨1,2,by decide,by decide⟩
            if zero.blt record.1 && record.1.blt (asFraction one) then pure record.1
            else throw "finite Fold loop sum left its exact sub-One boundary") = _
 rw [completeLoopState]
 dsimp only [Except.bind,Bind.bind]
 rw [positive,small]
 rfl
end SFT.Physics.FiniteLoopProofs
