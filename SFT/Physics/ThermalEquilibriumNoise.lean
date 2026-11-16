import SFT.Physics.ThermalEquilibriumResponse
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.ThermalEquilibriumNoise
open ThermalEquilibriumResponse LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def originalCycle (n : Nat) : List Rat :=
 (List.replicate n [natRatio 1 4 (by decide),natRatio 1 2 (by decide),natRatio 3 4 (by decide),natRatio 1 2 (by decide)]).flatten

theorem originalCycleSum (n acc : Nat) :
 (originalCycle n).foldl add (natRatio acc 4 (by decide)) = natRatio (acc+8*n) 4 (by decide) := by
 induction n generalizing acc with
 | zero => rw [Nat.mul_zero,Nat.add_zero]; rfl
 | succ n ih =>
   change ([natRatio 1 4 (by decide),natRatio 2 4 (by decide),natRatio 3 4 (by decide),natRatio 2 4 (by decide)]++originalCycle n).foldl add (natRatio acc 4 (by decide)) = _
   rw [foldAppend]
   change (originalCycle n).foldl add (add (add (add (add (natRatio acc 4 (by decide)) (natRatio 1 4 (by decide))) (natRatio 2 4 (by decide))) (natRatio 3 4 (by decide))) (natRatio 2 4 (by decide))) = _
   rw [addNormalized,addNormalized,addNormalized,addNormalized,ih]
   apply congrArg (fun a => natRatio a 4 (by decide))
   repeat rw [Nat.add_assoc]
   rw [Nat.mul_succ]
   rw [Nat.add_comm (8*n) 8]
   repeat rw [←Nat.add_assoc]

theorem originalCycleLength (n : Nat) : (originalCycle n).length=4*n := by
 induction n with
 | zero => rfl
 | succ n ih =>
   change (originalCycle 1++originalCycle n).length=4*(n+1)
   rw [SFT.Foundation.CommonRefinement.appendLength]
   change 4+(originalCycle n).length=4*(n+1)
   rw [ih,Nat.mul_succ,Nat.add_comm]

theorem originalNoiseMean (n : Nat) (positive : 0<n) :
 deterministicNoiseCycle (.integer (.ofNat n)) = .ok ⟨originalCycle n,natRatio 1 2 (by decide),4⟩ := by
 have quotient : LeptonRatios.divide ((originalCycle n).foldl add zero) (wholeRatio (originalCycle n).length)=
   .ok (natRatio 1 2 (by decide)) := by
   have z : zero=natRatio 0 4 (by decide) := rfl
   rw [z,originalCycleSum,Nat.zero_add,originalCycleLength,←natRatioWhole]
   rw [divideNormalized _ _ _ _ (by decide) (Nat.mul_pos (by decide) positive) (by decide)]
   apply congrArg Except.ok
   apply natRatioCongruence
   rw [Nat.mul_one,Nat.one_mul]
   rw [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm n 2,←SFT.Foundation.FractionReduction.mulAssoc]
   rw [←SFT.Foundation.FractionReduction.mulAssoc]
 cases n with
 | zero => cases positive
 | succ n =>
   unfold deterministicNoiseCycle
   dsimp only [CollectiveRadiation.positiveCount,Except.bind,Bind.bind]
   change (do let mean ← LeptonRatios.divide ((originalCycle (n+1)).foldl add zero) (wholeRatio (originalCycle (n+1)).length)
              pure (⟨originalCycle (n+1),mean,4⟩ : NoiseCycle)) = _
   rw [quotient]
   rfl
end SFT.Physics.ThermalEquilibriumNoise
