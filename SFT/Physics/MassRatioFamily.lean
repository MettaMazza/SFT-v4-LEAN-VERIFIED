import SFT.Physics.MixingCorrespondence
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.MassRatioFamily
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
open SFT.Foundation.FractionReduction SFT.Foundation.ExactOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Result where
 support : Nat
 light : Rat
 central : Rat
 heavy : Rat
 heavyOverLight : Rat

def massRatioFamily : CountInput → Except String Result
 | .boolean _ => .error "mass-ratio depth must be a positive count"
 | .integer (.negSucc _) => .error "mass-ratio depth must be a positive count"
 | .integer (.ofNat 0) => .error "mass-ratio depth must be a positive count"
 | .integer (.ofNat (d+1)) => do
   let binary ← AlphaCovers.binaryCount
   let generator ← FoldFirstReturn.generatorPeriod
   let power ← AlphaCovers.positivePower (.integer (.ofNat generator)) (.integer (.ofNat (d+1)))
   let support := binary*power
   let light ← LeptonRatios.divide (wholeRatio 1) (wholeRatio support)
   let predecessor ← positivePredecessor (.integer (.ofNat support))
   let heavy ← LeptonRatios.divide (wholeRatio predecessor) (wholeRatio support)
   let ratio ← LeptonRatios.divide heavy light
   if !(ratio == wholeRatio predecessor) then throw "mass-ratio complement and count routes disagree"
   pure ⟨support,light,normalize 1 2 (by decide),heavy,ratio⟩

def supportAt (depth : Nat) : Nat := 2*3^depth
theorem supportSuccessor (d : Nat) : supportAt (d+1) = supportAt d*3 := by
 unfold supportAt
 rw [Nat.pow_succ,mulAssoc]
theorem supportPositive (d : Nat) : 0 < supportAt d := by
 induction d with
 | zero => exact Nat.zero_lt_succ 1
 | succ d ih => rw [supportSuccessor]; exact Nat.mul_pos ih (by decide)
theorem complementRatioEveryDepth (d : Nat) :
 (supportAt d-1)*supportAt d = (supportAt d-1)*(supportAt d*1) := by
 rw [Nat.mul_one]
theorem lightComplementPartition (d : Nat) : 1+(supportAt d-1)=supportAt d := by
 rw [Nat.add_comm]
 exact subtractAdd _ 1 (supportPositive d)
theorem exactComplementRatio (n : Nat) (positive : 0<n) :
 LeptonRatios.divide (natRatio (n-1) n positive) (natRatio 1 n positive) =
 .ok (wholeRatio (n-1)) := by
 rw [VacuumScaleProofs.divideNormalized _ _ _ _ positive (by decide) positive]
 apply congrArg Except.ok
 rw [←natRatioWhole]
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.mul_one]

theorem allDepthRatio (d : Nat) :
 LeptonRatios.divide (natRatio (supportAt d-1) (supportAt d) (supportPositive d))
 (natRatio 1 (supportAt d) (supportPositive d)) = .ok (wholeRatio (supportAt d-1)) :=
 exactComplementRatio _ (supportPositive d)

theorem wholeDivision (a n : Nat) (positive : 0<n) :
 LeptonRatios.divide (wholeRatio a) (wholeRatio n)=.ok (natRatio a n positive) := by
 rw [←natRatioWhole a,←natRatioWhole n]
 rw [VacuumScaleProofs.divideNormalized _ _ _ _ (by decide) positive (by decide)]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.one_mul]

theorem supportBeyondOne (d : Nat) : 1<supportAt d := by
 induction d with
 | zero => exact Nat.lt_succ_self 1
 | succ d ih =>
   rw [supportSuccessor,Nat.mul_succ]
   exact Nat.lt_of_lt_of_le ih (Nat.le_add_left _ _)

theorem predecessorAtSupport (d : Nat) : positivePredecessor (.integer (.ofNat (supportAt d))) = .ok (supportAt d-1) := by
 have h := supportBeyondOne d
 generalize supportAt d=n at h ⊢
 cases n with
 | zero => cases h
 | succ n => cases n with
   | zero => exact False.elim (Nat.not_lt_of_ge (Nat.le_refl 1) h)
   | succ n => rfl

theorem completeEveryPositiveDepth (d : Nat) : massRatioFamily (.integer (.ofNat (d+1))) =
 .ok ⟨supportAt (d+1),natRatio 1 (supportAt (d+1)) (supportPositive _),normalize 1 2 (by decide),
 natRatio (supportAt (d+1)-1) (supportAt (d+1)) (supportPositive _),wholeRatio (supportAt (d+1)-1)⟩ := by
 unfold massRatioFamily
 rw [AlphaCovers.binaryCountTwo,FoldFirstReturn.generatorPeriodThree]
 dsimp only [Bind.bind,Except.bind]
 rw [AlphaCovers.positivePowerValue 2 d]
 dsimp only [Bind.bind,Except.bind]
 change (do
   let light ← LeptonRatios.divide (wholeRatio 1) (wholeRatio (supportAt (d+1)))
   let predecessor ← positivePredecessor (.integer (.ofNat (supportAt (d+1))))
   let heavy ← LeptonRatios.divide (wholeRatio predecessor) (wholeRatio (supportAt (d+1)))
   let ratio ← LeptonRatios.divide heavy light
   if !(ratio == wholeRatio predecessor) then throw "mass-ratio complement and count routes disagree"
   pure (⟨supportAt (d+1),light,normalize 1 2 (by decide),heavy,ratio⟩ : Result)) = _
 rw [wholeDivision _ _ (supportPositive _),predecessorAtSupport]
 dsimp only [Bind.bind,Except.bind]
 rw [wholeDivision _ _ (supportPositive _)]
 dsimp only [Bind.bind,Except.bind]
 rw [allDepthRatio]
 dsimp only [Bind.bind,Except.bind]
 rw [ratEqualSelf]
 rfl

theorem firstThreeRatios :
 ([1,2,3].mapM fun d => do let r ← massRatioFamily (.integer (.ofNat d)); pure r.heavyOverLight) =
 Except.ok [wholeRatio 5,wholeRatio 17,wholeRatio 53] := rfl
end SFT.Physics.MassRatioFamily
