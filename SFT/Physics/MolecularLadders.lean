import SFT.Physics.MolecularSpectroscopy
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.MolecularLadders
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
inductive OrdinalInput where
 | count (value : CountInput)
 | nonInteger
def emptyRotationalGround : List Unit := []
def rotationalLevel : OrdinalInput → Except String Int
 | .nonInteger => .error "rotational ordinal must be a positive count"
 | .count value => match SectorInventory.countValue value with
   | .negSucc _ => .error "rotational ordinal must be a positive count"
   | .ofNat 0 => .error "rotational ordinal must be a positive count"
   | .ofNat (n+1) => .ok (.ofNat ((n+1)*(n+2)))
def adjacentRotationalGap : OrdinalInput → Except String Int
 | .nonInteger => .error "upper rotational ordinal must be a positive count"
 | .count value => match SectorInventory.countValue value with
   | .negSucc _ => .error "upper rotational ordinal must be a positive count"
   | .ofNat 0 => .error "upper rotational ordinal must be a positive count"
   | .ofNat (n+1) => do pure (.ofNat ((← AlphaCovers.binaryCount)*(n+1)))
def oddVibrationalCarrier : OrdinalInput → Except String Int
 | .nonInteger => .error "vibrational ordinal must be a positive count"
 | .count value => match SectorInventory.countValue value with
   | .negSucc _ => .error "vibrational ordinal must be a positive count"
   | .ofNat 0 => .error "vibrational ordinal must be a positive count"
   | .ofNat (n+1) => do
     let binary ← AlphaCovers.binaryCount
     let carrier ← RunningConvergence.positiveTake (wholeRatio (binary*(n+1))) (wholeRatio 1)
     if carrier.den != 1 then throw "odd vibrational carrier did not close as a count"
     pure carrier.num
def vibrationalLevel (harmonic anharmonic : FoldFirstReturn.Input) (ordinal : OrdinalInput) : Except String Rat := do
 let harmonic ← match harmonic with
  | .nonFraction => .error "harmonic carrier must be an exact positive fraction"
  | .fraction q => if zero.blt q then .ok q else .error "harmonic carrier must be an exact positive fraction"
 let anharmonic ← match anharmonic with
  | .nonFraction => .error "anharmonic carrier must be an exact positive fraction"
  | .fraction q => if zero.blt q then .ok q else .error "anharmonic carrier must be an exact positive fraction"
 let q ← oddVibrationalCarrier ordinal
 let binary ← AlphaCovers.binaryCount
 let leading ← LeptonRatios.divide (multiply harmonic (normalize q 1 (by decide))) (wholeRatio binary)
 let square ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat binary))
 let returned ← LeptonRatios.divide (multiply (multiply anharmonic (normalize q 1 (by decide))) (normalize q 1 (by decide))) (wholeRatio square)
 RunningConvergence.positiveTake leading returned
def adjacentVibrationalGap (harmonic anharmonic : FoldFirstReturn.Input) (upper : OrdinalInput) : Except String Rat := do
 let n ← match upper with
  | .nonInteger => .error "an adjacent vibrational gap requires a positive upper ordinal above the first"
  | .count value => match SectorInventory.countValue value with
    | .negSucc _ => .error "an adjacent vibrational gap requires a positive upper ordinal above the first"
    | .ofNat 0 => .error "an adjacent vibrational gap requires a positive upper ordinal above the first"
    | .ofNat 1 => .error "an adjacent vibrational gap requires a positive upper ordinal above the first"
    | .ofNat (k+2) => .ok k
 let high ← vibrationalLevel harmonic anharmonic upper
 let low ← vibrationalLevel harmonic anharmonic (.count (.integer (.ofNat (n+1))))
 RunningConvergence.positiveTake high low
theorem everyRotationalLevel (n : Nat) : rotationalLevel (.count (.integer (.ofNat (n+1))))=.ok (.ofNat ((n+1)*(n+2))) := rfl
theorem everyRotationalGap (n : Nat) : adjacentRotationalGap (.count (.integer (.ofNat (n+1))))=.ok (.ofNat (2*(n+1))) := rfl
theorem emptyGround : emptyRotationalGround=[] := rfl
theorem firstOddCarrier : oddVibrationalCarrier (.count (.integer 1))=.ok 1 := rfl
theorem secondOddCarrier : oddVibrationalCarrier (.count (.integer 2))=.ok 3 := rfl
theorem thirdOddCarrier : oddVibrationalCarrier (.count (.integer 3))=.ok 5 := rfl
theorem trueOrdinalRetained : rotationalLevel (.count (.boolean true))=.ok 2 := rfl
theorem falseOrdinalRejected : rotationalLevel (.count (.boolean false))=.error "rotational ordinal must be a positive count" := rfl
theorem everyOddCarrier (n : Nat) : oddVibrationalCarrier (.count (.integer (.ofNat (n+1))))=.ok (.ofNat (2*n+1)) := by
 unfold oddVibrationalCarrier
 change (do
  let carrier ← RunningConvergence.positiveTake (wholeRatio (2*(n+1))) (wholeRatio 1)
  if carrier.den != 1 then throw "odd vibrational carrier did not close as a count"
  pure carrier.num) = .ok (.ofNat (2*n+1))
 rw [Nat.mul_add,Nat.mul_one]
 have take : RunningConvergence.positiveTake (wholeRatio (2*n+2)) (wholeRatio 1) = .ok (wholeRatio (2*n+1)) := by
  unfold RunningConvergence.positiveTake
  have ordered : (wholeRatio 1).blt (wholeRatio (2*n+2)) = true := by
   rw [← natRatioWhole 1,← natRatioWhole (2*n+2)]
   apply SFT.Physics.CommonScaleAxis.positiveNormalizedLess 1 1 (2*n+2) 1 (by decide) (by decide) (Nat.zero_lt_succ _) (by decide)
   simp only [Nat.mul_one]
   exact Nat.succ_lt_succ (Nat.zero_lt_succ (2*n))
  rw [ordered]
  change Except.ok (subtract (wholeRatio (2*n+2)) (wholeRatio 1)) = _
  unfold subtract
  change Except.ok (normalize (Int.ofNat (2*n+2)*1-1*1) 1 _) = _
  change Except.ok (normalize (Int.ofNat ((2*n+2)*1)-1) 1 _) = _
  rw [Nat.mul_one]
  change Except.ok (normalize ((Int.ofNat (2*n+1)+1)-1) 1 _) = _
  change Except.ok (normalize (Int.subNatNat (2*n+2) 1) 1 _) = _
  unfold Int.subNatNat
  rw [SFT.Physics.CommonScaleAxis.subtractionZeroOfBound 1 (2*n+2) (Nat.succ_le_succ (Nat.zero_le (2*n+1)))]
  change Except.ok (natRatio ((2*n+1)+1-1) 1 _) = _
  rw [SFT.Foundation.ExactCast.addSubtract]
  change Except.ok (natRatio (2*n+1) 1 _) = _
  rw [natRatioWhole]
 rw [take]
 rfl
theorem rotationalAppend (n : Nat) :
 (n+2)*(n+3)=(n+1)*(n+2)+2*(n+2) := by
 have split : n+3=(n+1)+2 := rfl
 rw [split,Nat.mul_add,Nat.mul_comm (n+2) (n+1),Nat.mul_comm (n+2) 2]
end SFT.Physics.MolecularLadders
