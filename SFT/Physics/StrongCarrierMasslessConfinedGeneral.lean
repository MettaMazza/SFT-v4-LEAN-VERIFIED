import SFT.Physics.StrongCarrierMasslessConfinedCertificate
namespace SFT.Physics.StrongCarrierMasslessConfinedGeneral
open StrongCarrierMasslessConfined LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
set_option maxHeartbeats 100000000
private theorem productLeftComm (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [←mulAssoc,Nat.mul_comm a b,mulAssoc]
private theorem successorWholeExceeds (a d : Nat) (hd : 0<d) : a<d*(a/d+1) := by
 have split := remainderQuotient a d hd
 have bound := Nat.add_lt_add_right (Nat.mod_lt a hd) (d*(a/d))
 rw [split,Nat.add_comm d,←Nat.mul_succ] at bound
 exact bound
-- This is exactly the quotient-and-successor used by the source operation.
def witnessIndex (n d : Nat) (hd : 0<d) : Nat :=
 let ratio := natRatio (n*3) (d*2) (Nat.mul_pos hd (by decide))
 ratio.num.natAbs/ratio.den+1
theorem originalBoundCross (n d : Nat) (hd : 0<d) : n*3<(2*witnessIndex n d hd)*d := by
 let ratio := natRatio (n*3) (d*2) (Nat.mul_pos hd (by decide))
 have representation := natRatioValue (n*3) (d*2) (Nat.mul_pos hd (by decide))
 have floorBound := successorWholeExceeds ratio.num.natAbs ratio.den (Nat.pos_of_ne_zero ratio.den_nz)
 have scaled := Nat.mul_lt_mul_of_pos_right floorBound (Nat.mul_pos hd (by decide : 0<2))
 change ratio.num.natAbs*(d*2)<(ratio.den*witnessIndex n d hd)*(d*2) at scaled
 change n*3*ratio.den=ratio.num.natAbs*(d*2) at representation
 rw [←representation] at scaled
 have arrange : (ratio.den*witnessIndex n d hd)*(d*2)=((2*witnessIndex n d hd)*d)*ratio.den := by
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
  all_goals conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 rw [arrange] at scaled
 apply Nat.lt_of_not_ge
 intro opposite
 exact Nat.not_lt_of_ge (Nat.mul_le_mul_right ratio.den opposite) scaled

theorem originalBoundWorkExceeds (n d : Nat) (hn : 0<n) (hd : 0<d) :
 (natRatio n d hd).blt (natRatio (2*witnessIndex n d hd) 3 (by decide))=true := by
 exact CommonScaleAxis.positiveNormalizedLess _ _ _ _ hn hd
  (Nat.mul_pos (by decide) (Nat.zero_lt_succ _)) (by decide) (originalBoundCross n d hd)

theorem originalFiniteWitness (n d : Nat) (hd : 0<d) : 1≤witnessIndex n d hd :=
 Nat.succ_le_succ (Nat.zero_le _)

theorem originalEveryBoundRecord (n d : Nat) (hn : 0<n) (hd : 0<d) :
 workExceedsPositiveBound (.fraction (natRatio n d hd))=.ok
  ⟨natRatio n d hd,witnessIndex n d hd,natRatio (2*witnessIndex n d hd) 3 (by decide),true,true⟩ := by
 unfold workExceedsPositiveBound
 dsimp only
 rw [positiveNormalized n d hn hd]
 rw [originalSector]
 dsimp only [Except.bind,Bind.bind]
 change (do
  let ratio ← LeptonRatios.divide (natRatio n d hd) (natRatio 2 3 (by decide))
  let successor := ratio.num.natAbs/ratio.den+1
  let work := multiply (natRatio 2 3 (by decide)) (wholeRatio successor)
  pure (⟨natRatio n d hd,successor,work,(natRatio n d hd).blt work,decide (1≤successor)⟩ : BoundWitness))=_
 rw [divideNormalized n d 2 3 hd (by decide) (by decide)]
 dsimp only [Except.bind,Bind.bind]
 change (Except.ok (⟨natRatio n d hd,witnessIndex n d hd,
  multiply (natRatio 2 3 (by decide)) (wholeRatio (witnessIndex n d hd)),
  (natRatio n d hd).blt (multiply (natRatio 2 3 (by decide)) (wholeRatio (witnessIndex n d hd))),
  decide (1≤witnessIndex n d hd)⟩ : BoundWitness))=_
 rw [←natRatioWhole,multiplyNormalized]
 rw [originalBoundWorkExceeds n d hn hd,decide_eq_true (originalFiniteWitness n d hd)]
theorem originalEveryCausalPositionTrace (n : Nat) :
 (masslessCausalTrace (.integer (.ofNat (n+2)))).map Causal.positions =
 .ok ((List.range (n+3)).map (fun tick => wholeRatio (tick+1))) := rfl

theorem originalEveryRetainedPhaseTrace (n : Nat) :
 (masslessCausalTrace (.integer (.ofNat (n+2)))).map Causal.phaseTrace =
 .ok (List.replicate (n+3) (normalize 1 3 (by decide))) := rfl

theorem originalEveryCausalEmptyMass (n : Nat) :
 (masslessCausalTrace (.integer (.ofNat (n+2)))).map (fun c => (c.massLabel,c.restCaptureRecord,c.causalSpeed))=
 .ok ([],[],wholeRatio 1) := rfl

theorem originalEveryTubeRow (n : Nat) :
 (confiningTubeTrace (.integer (.ofNat (n+2)))).map Tube.rows =
 .ok ((List.range (n+2)).map (fun step => (⟨wholeRatio (step+1),normalize 1 2 (by decide),normalize 2 3 (by decide),multiply (normalize 2 3 (by decide)) (wholeRatio (step+1))⟩ : TubeRow))) := rfl

theorem originalEveryTubeBoundary (n : Nat) :
 (confiningTubeTrace (.integer (.ofNat (n+2)))).map (fun t => (t.tubeWidth,t.fieldCarrier,t.isolatedColourCarrierRecord,t.completedInfinityUsed))=
 .ok (normalize 1 2 (by decide),normalize 2 3 (by decide),[],false) := rfl

theorem originalCausalSuccessor (k : Nat) :
 wholeRatio (k+2)=add (wholeRatio (k+1)) (wholeRatio 1) := by
 rw [←natRatioWhole,←natRatioWhole,←natRatioWhole,addNormalized]

theorem originalWorkRepresentation (k : Nat) :
 multiply (normalize 2 3 (by decide)) (wholeRatio (k+1))=
 natRatio (2*(k+1)) 3 (by decide) := by
 change multiply (natRatio 2 3 (by decide)) (wholeRatio (k+1))=_
 rw [←natRatioWhole,multiplyNormalized]

theorem originalConfinementSuccessor (k : Nat) :
 multiply (normalize 2 3 (by decide)) (wholeRatio (k+2))=
 add (multiply (normalize 2 3 (by decide)) (wholeRatio (k+1))) (normalize 2 3 (by decide)) := by
 rw [originalWorkRepresentation (k+1),originalWorkRepresentation]
 change natRatio (2*(k+2)) 3 (by decide)=add (natRatio (2*(k+1)) 3 (by decide)) (natRatio 2 3 (by decide))
 rw [addNormalized,Nat.mul_succ]

theorem originalWorkStrictlyIncreases (k : Nat) :
 (multiply (normalize 2 3 (by decide)) (wholeRatio (k+1))).blt
  (multiply (normalize 2 3 (by decide)) (wholeRatio (k+2)))=true := by
 rw [originalWorkRepresentation,originalWorkRepresentation (k+1)]
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _
  (Nat.mul_pos (by decide) (Nat.zero_lt_succ _)) (by decide)
  (Nat.mul_pos (by decide) (Nat.zero_lt_succ _)) (by decide)
 apply Nat.mul_lt_mul_of_pos_right _ (by decide)
 rw [Nat.mul_succ]
 exact Nat.lt_add_of_pos_right (by decide)

end SFT.Physics.StrongCarrierMasslessConfinedGeneral
