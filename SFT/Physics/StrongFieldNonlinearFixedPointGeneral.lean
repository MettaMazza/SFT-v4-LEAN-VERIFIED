import SFT.Physics.StrongFieldNonlinearFixedPointCertificate
import SFT.Physics.StrongRunning
import SFT.Host.SHA256Chunks
namespace SFT.Physics.StrongFieldNonlinearFixedPointGeneral
open StrongFieldNonlinearFixedPoint LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
set_option maxHeartbeats 100000000
-- Original positive exact source successor, with the source's complete binary addition.
theorem originalEveryPositiveSuccessor (n d : Nat) (hn : 0<n) (hd : 0<d) :
 colourSelfSourceSuccessor (.fraction (natRatio n d hd))=.ok (natRatio (n+2*d) d hd) := by
 unfold colourSelfSourceSuccessor
 dsimp only
 rw [positiveNormalized n d hn hd]
 change Except.ok (add (natRatio n d hd) (wholeRatio 2))=_
 apply congrArg Except.ok
 apply addCommonDenominator _ _ n (2*d) d hd (natRatioNonnegative n d hd) (by rfl) (natRatioValue n d hd)
 change (2*d)*1=2*d
 exact Nat.mul_one _
theorem originalEveryPositiveSuccessorGrows (n d : Nat) (hn : 0<n) (hd : 0<d) :
 (natRatio n d hd).blt (natRatio (n+2*d) d hd)=true := by
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ hn hd (Nat.add_pos_left hn _) hd
 exact Nat.mul_lt_mul_of_pos_right (Nat.lt_add_of_pos_right (Nat.mul_pos (by decide) hd)) hd
-- Connect the actual guarded iteration to the already established source-count recurrence.
theorem originalGeneratedSuccessor (k : Nat) :
 colourSelfSourceSuccessor (.fraction (wholeRatio (StrongRunning.sourceCount k)))=
 .ok (wholeRatio (StrongRunning.sourceCount (k+1))) := by
 rw [←natRatioWhole,originalEveryPositiveSuccessor _ 1 (StrongRunning.positiveAtEveryLevel k) (by decide)]
 rw [Nat.mul_one,natRatioWhole]
 rfl
theorem originalEverySourceTrace (depth start : Nat) :
 sourceSteps depth (wholeRatio (StrongRunning.sourceCount start))=
 .ok ((List.range (depth+1)).map (fun j => wholeRatio (StrongRunning.sourceCount (start+j)))) := by
 induction depth generalizing start with
 | zero => rw [Nat.add_zero]; rfl
 | succ depth ih =>
  unfold sourceSteps
  rw [originalGeneratedSuccessor]
  dsimp only [Except.bind,Bind.bind]
  rw [ih]
  dsimp only [Except.bind,Bind.bind]
  conv => rhs; rw [SFT.Host.SHA256Chunks.rangeShift]
  change Except.ok (wholeRatio (StrongRunning.sourceCount start) :: _) = _
  congr 2
  induction List.range (depth+1) with
  | nil => rfl
  | cons j js hj =>
   change wholeRatio (StrongRunning.sourceCount (start+1+j)) :: _ = wholeRatio (StrongRunning.sourceCount (start+(j+1))) :: _
   rw [Nat.add_right_comm start 1 j,Nat.add_assoc,hj]
theorem originalNeutralSources (n : Nat) :
 (neutralSourceIteration (.integer (.ofNat (n+2)))).map Neutral.sources=
 .ok (List.replicate (n+3) (wholeRatio 1)) := rfl
theorem originalNeutralEmptyCorrection (n : Nat) :
 (neutralSourceIteration (.integer (.ofNat (n+2)))).map (fun x => (x.selfSourceRecord,x.correctionRecord,x.fixedPoint,x.fieldAbsentFromSourceUpdate))=
 .ok ([],[],wholeRatio 1,true) := rfl
-- The original B/2 quotient is normalized before taking its successor whole.
def witnessIndex (n d : Nat) (hd : 0<d) : Nat :=
 let ratio := natRatio n (d*2) (Nat.mul_pos hd (by decide))
 ratio.num.natAbs/ratio.den+1
theorem originalBoundCross (n d : Nat) (hd : 0<d) : n<(1+2*witnessIndex n d hd)*d := by
 let ratio := natRatio n (d*2) (Nat.mul_pos hd (by decide))
 have split := remainderQuotient ratio.num.natAbs ratio.den (Nat.pos_of_ne_zero ratio.den_nz)
 have floorBound := Nat.add_lt_add_right (Nat.mod_lt ratio.num.natAbs (Nat.pos_of_ne_zero ratio.den_nz)) (ratio.den*(ratio.num.natAbs/ratio.den))
 rw [split,Nat.add_comm ratio.den,←Nat.mul_succ] at floorBound
 have scaled := Nat.mul_lt_mul_of_pos_right floorBound (Nat.mul_pos hd (by decide : 0<2))
 have representation := natRatioValue n (d*2) (Nat.mul_pos hd (by decide))
 change ratio.num.natAbs*(d*2)<(ratio.den*witnessIndex n d hd)*(d*2) at scaled
 change n*ratio.den=ratio.num.natAbs*(d*2) at representation
 rw [←representation] at scaled
 have arrange : (ratio.den*witnessIndex n d hd)*(d*2)=((2*witnessIndex n d hd)*d)*ratio.den := by
  rw [mulAssoc,Nat.mul_comm ratio.den _,←mulAssoc,mulRightComm (witnessIndex n d hd) d 2,Nat.mul_comm (witnessIndex n d hd) 2]
 rw [arrange] at scaled
 have lt : n<(2*witnessIndex n d hd)*d := by
  apply Nat.lt_of_not_ge
  intro opposite
  exact Nat.not_lt_of_ge (Nat.mul_le_mul_right ratio.den opposite) scaled
 exact Nat.lt_trans lt (Nat.mul_lt_mul_of_pos_right (Nat.lt_add_of_pos_left (by decide)) hd)
theorem originalBoundSourceExceeds (n d : Nat) (hn : 0<n) (hd : 0<d) :
 (natRatio n d hd).blt (wholeRatio (1+2*witnessIndex n d hd))=true := by
 rw [←natRatioWhole]
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ hn hd (Nat.add_pos_left (by decide) _) (by decide)
 rw [Nat.mul_one]
 exact originalBoundCross n d hd
theorem originalEveryBoundRecord (n d : Nat) (hn : 0<n) (hd : 0<d) :
 strongSourceExceedsPositiveBound (.fraction (natRatio n d hd))=.ok
 ⟨natRatio n d hd,witnessIndex n d hd,wholeRatio (1+2*witnessIndex n d hd),true,true⟩ := by
 unfold strongSourceExceedsPositiveBound
 dsimp only
 rw [positiveNormalized n d hn hd]
 change (do
  let ratio ← LeptonRatios.divide (natRatio n d hd) (natRatio 2 1 (by decide))
  let count := ratio.num.natAbs/ratio.den+1
  let value := add (wholeRatio 1) (wholeRatio (2*count))
  pure (⟨natRatio n d hd,count,value,(natRatio n d hd).blt value,decide (1≤count)⟩ : BoundWitness))=_
 rw [divideNormalized n d 2 1 hd (by decide) (by decide)]
 dsimp only [Except.bind,Bind.bind]
 rw [Nat.mul_one]
 change Except.ok (⟨natRatio n d hd,witnessIndex n d hd,add (wholeRatio 1) (wholeRatio (2*witnessIndex n d hd)),(natRatio n d hd).blt (add (wholeRatio 1) (wholeRatio (2*witnessIndex n d hd))),decide (1≤witnessIndex n d hd)⟩ : BoundWitness)=_
 have value : add (wholeRatio 1) (wholeRatio (2*witnessIndex n d hd))=wholeRatio (1+2*witnessIndex n d hd) := by
  rw [←natRatioWhole,←natRatioWhole,addNormalized,natRatioWhole]
 rw [value,originalBoundSourceExceeds n d hn hd]
 rw [decide_eq_true (show 1≤witnessIndex n d hd from Nat.succ_le_succ (Nat.zero_le _))]
theorem originalEveryPositiveFixedPointExcluded (n d : Nat) (hn : 0<n) (hd : 0<d) :
 (natRatio (n+2*d) d hd == natRatio n d hd)=false := by
 change decide (natRatio (n+2*d) d hd=natRatio n d hd)=false
 apply decide_eq_false
 intro same
 have cross := CommonScaleAxis.normalizedCrossLess n d (n+2*d) d hd hd
  (Nat.mul_lt_mul_of_pos_right (Nat.lt_add_of_pos_right (Nat.mul_pos (by decide) hd)) hd)
 rw [same] at cross
 exact Nat.lt_irrefl _ cross
theorem originalEveryFixedPointTest (n d : Nat) (hn : 0<n) (hd : 0<d) :
 finiteStrongFixedPointTest (.fraction (natRatio n d hd))=.ok
 ⟨natRatio n d hd,natRatio (n+2*d) d hd,true,false,true⟩ := by
 unfold finiteStrongFixedPointTest
 dsimp only
 rw [positiveNormalized n d hn hd]
 dsimp only [Except.bind,Bind.bind]
 rw [originalEveryPositiveSuccessor n d hn hd]
 dsimp only [Except.bind,Bind.bind]
 rw [originalEveryPositiveSuccessorGrows n d hn hd,originalEveryPositiveFixedPointExcluded n d hn hd]
 rfl
end SFT.Physics.StrongFieldNonlinearFixedPointGeneral

