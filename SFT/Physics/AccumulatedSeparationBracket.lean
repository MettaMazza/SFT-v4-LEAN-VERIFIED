import SFT.Physics.AccumulatedSeparationLedger
namespace SFT.Physics.AccumulatedSeparationBracket
open AccumulatedSeparation AccumulatedSeparationLedger LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
open SFT.Mathematics.SelfSimilarConvergence
set_option maxHeartbeats 100000000
theorem originalHeadTailLedger (count : Nat) :
 partialLedger 0 (count+1)=
 (12*(partialLedger 1 count).1+(partialLedger 1 count).2,12*(partialLedger 1 count).2) := by
 induction count with
 | zero => rfl
 | succ count ih =>
  change ((partialLedger 0 (count+1)).1*gapDenominator (0+(count+1))+(partialLedger 0 (count+1)).2,
    (partialLedger 0 (count+1)).2*gapDenominator (0+(count+1)))=_
  rw [ih,Nat.zero_add]
  conv => lhs; rw [Nat.add_comm count 1]
  change ((12*(partialLedger 1 count).1+(partialLedger 1 count).2)*gapDenominator (1+count)+12*(partialLedger 1 count).2,
   (12*(partialLedger 1 count).2)*gapDenominator (1+count))=
   (12*((partialLedger 1 count).1*gapDenominator (1+count)+(partialLedger 1 count).2)+(partialLedger 1 count).2*gapDenominator (1+count),
   12*((partialLedger 1 count).2*gapDenominator (1+count)))
  apply Prod.ext
  · rw [VacuumLedgerProofs.addMul,Nat.mul_add,mulAssoc]
    conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
    all_goals conv => rhs; simp only [Nat.add_assoc,Nat.add_comm,Nat.add_left_comm]
  · exact mulAssoc _ _ _
theorem originalEveryUpperBracketCross (count : Nat) :
 (partialLedger 0 (count+1)).1*60<11*(partialLedger 0 (count+1)).2 := by
 rw [originalHeadTailLedger]
 dsimp only
 have tail := originalEveryFiniteTailCross 0 count
 change (partialLedger 1 count).1*20<2*(partialLedger 1 count).2 at tail
 let n := (partialLedger 1 count).1
 let d := (partialLedger 1 count).2
 change (12*n+d)*60<11*(12*d)
 calc
  (12*n+d)*60=36*(n*20)+60*d := by
   rw [VacuumLedgerProofs.addMul,mulRightComm 12 n 60,Nat.mul_comm d 60,Nat.mul_comm n 20,←mulAssoc 36 20 n]
  _ < 36*(2*d)+60*d := Nat.add_lt_add_right (Nat.mul_lt_mul_of_pos_left tail (by decide)) _
  _ = 11*(12*d) := by
   rw [←mulAssoc 36 2 d,←VacuumLedgerProofs.addMul,←mulAssoc 11 12 d]
theorem originalEveryLowerBracketCross (count : Nat) :
 (partialLedger 0 (count+1)).2≤12*(partialLedger 0 (count+1)).1 := by
 rw [originalHeadTailLedger]
 dsimp only
 rw [Nat.mul_add]
 exact Nat.le_add_left _ _
theorem originalSuccessorLowerStrict (k : Nat) :
 (partialLedger 0 (k+2)).2<12*(partialLedger 0 (k+2)).1 := by
 rw [originalHeadTailLedger (k+1)]
 dsimp only
 rw [Nat.mul_add]
 exact Nat.lt_add_of_pos_left (Nat.mul_pos (by decide) (Nat.mul_pos (by decide) (originalPositiveLedgerNumerator 1 k)))
theorem originalEveryUpperFlag (k : Nat) :
 (natRatio (partialLedger 0 (k+1)).1 (partialLedger 0 (k+1)).2 (ledgerDenominatorPositive 0 (k+1))).blt
 (natRatio 11 60 (by decide))=true :=
 CommonScaleAxis.positiveNormalizedLess _ _ _ _ (originalPositiveLedgerNumerator _ _) (ledgerDenominatorPositive _ _) (by decide) (by decide)
 (originalEveryUpperBracketCross k)
theorem originalSuccessorLowerFlag (k : Nat) :
 (natRatio (partialLedger 0 (k+2)).1 (partialLedger 0 (k+2)).2 (ledgerDenominatorPositive 0 (k+2))).blt
 (natRatio 1 12 (by decide))=false := by
 let n := (partialLedger 0 (k+2)).1
 let d := (partialLedger 0 (k+2)).2
 have hn : 0<n := originalPositiveLedgerNumerator 0 (k+1)
 have hd : 0<d := ledgerDenominatorPositive 0 (k+2)
 have cross : 1*d<n*12 := by
  rw [Nat.one_mul,Nat.mul_comm n 12]
  exact originalSuccessorLowerStrict k
 have ap := positiveNormalizedNumerator n d hn hd
 have bp := positiveNormalizedNumerator 1 12 (by decide) (by decide)
 have less := CommonScaleAxis.normalizedCrossLess 1 12 n d (by decide) hd cross
 change (natRatio n d hd).blt (natRatio 1 12 (by decide))=false
 unfold Rat.blt
 rw [natRatioNonnegative n d hd,natRatioNonnegative 1 12 (by decide)]
 generalize ha : (natRatio n d hd).num.natAbs=na at ap less ⊢
 generalize hb : (natRatio 1 12 (by decide)).num.natAbs=nb at bp less ⊢
 cases na with
 | zero => cases ap
 | succ na =>
  cases nb with
  | zero => cases bp
  | succ nb =>
   have notNeg : ¬Int.ofNat (na+1)<0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (na+2)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   have notZero : Int.ofNat (na+1)≠0 := fun h => Nat.noConfusion (congrArg Int.toNat h)
   have notNonpos : ¬Int.ofNat (nb+1)≤0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (nb+1)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   rw [decide_eq_false notNeg,if_neg notZero,decide_eq_false notNonpos,Bool.and_false,Bool.false_and]
   change decide (Int.ofNat ((na+1)*(natRatio 1 12 (by decide)).den)<Int.ofNat ((nb+1)*(natRatio n d hd).den))=false
   apply decide_eq_false
   intro h
   let a := (na+1)*(natRatio 1 12 (by decide)).den
   let b := (nb+1)*(natRatio n d hd).den
   change Int.NonNeg (Int.subNatNat b (a+1)) at h
   unfold Int.subNatNat at h
   have positive := RunningConvergence.orderedDifferencePositive b (a+1) (Nat.lt_succ_of_le (Nat.le_of_lt less))
   cases hs : (a+1)-b with
   | zero => rw [hs] at positive; cases positive
   | succ j => rw [hs] at h; cases h
theorem originalEveryBracketCheck (k : Nat) :
 accumulationIsBounded (.integer (.ofNat (k+1)))=.ok true := by
 cases k with
 | zero => rfl
 | succ k =>
  unfold accumulationIsBounded
  rw [originalEveryPartialSum]
  dsimp only [Except.bind,Bind.bind]
  rw [originalSuccessorLowerFlag k,originalEveryUpperFlag (k+1)]
  rfl
end SFT.Physics.AccumulatedSeparationBracket
