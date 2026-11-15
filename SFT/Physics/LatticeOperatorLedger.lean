import SFT.Physics.LatticeOperator
import SFT.Physics.MediatorRangeChannelLedger
namespace SFT.Physics.LatticeOperatorLedger
open LatticeOperator LeptonIntervals VacuumLedgerProofs
private theorem ringFold (n k : Nat) :
 (List.replicate n ("opposition",one)).foldl (fun acc row => add acc row.2)
 (natRatio k 1 (by decide))=natRatio (k+n) 1 (by decide) := by
 induction n generalizing k with
 | zero => rfl
 | succ n ih =>
  change (List.replicate n ("opposition",one)).foldl (fun acc row => add acc row.2)
   (add (natRatio k 1 (by decide)) (natRatio 1 1 (by decide)))=_
  rw [addNormalized,ih]
  apply congrArg (fun j => natRatio j 1 (by decide))
  exact Nat.add_right_comm k 1 n

theorem originalRingMagnitude (n : Nat) (hn : 0<n) :
 subtract ((List.replicate n ("opposition",one)).foldl (fun acc row => add acc row.2) one) one=
 wholeRatio n := by
 change subtract ((List.replicate n ("opposition",one)).foldl (fun acc row => add acc row.2)
  (natRatio 1 1 (by decide))) (natRatio 1 1 (by decide))=_
 rw [ringFold,MediatorRangeChannelLedger.originalForwardTake (1+n) 1 1 (by decide)
  (Nat.lt_add_of_pos_right hn)]
 rw [Nat.add_comm 1 n,Nat.succ_sub_succ_eq_sub,Nat.sub_zero,natRatioWhole]

private theorem equalSelf (q : Rat) : SFT.Mathematics.LimitComputations.equalRat q q=true := by
 unfold SFT.Mathematics.LimitComputations.equalRat SFT.Mathematics.LimitComputations.equalInt
 have same (n : Nat) : (n==n)=true := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih
 cases q.num with
 | ofNat n => change (n==n && q.den==q.den)=true; rw [same,same]; rfl
 | negSucc n => change (n==n && q.den==q.den)=true; rw [same,same]; rfl

theorem originalPointSourceBalance (d : Nat) (hd : 0<d) :
 pointSourceOperator (.integer (.ofNat d))=
 .ok ⟨2*d,"source",List.replicate (2*d) ("opposition",one),2*d,true⟩ := by
 unfold pointSourceOperator conservativeStencil
 dsimp only
 rw [dif_pos hd]
 dsimp only [Except.bind,Bind.bind,Except.pure,Pure.pure,stencil]
 rw [originalRingMagnitude (2*d) (Nat.mul_pos (by decide) hd),equalSelf]
end SFT.Physics.LatticeOperatorLedger
