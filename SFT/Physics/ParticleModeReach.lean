import SFT.Physics.MassRatioFamily
import SFT.Physics.SpinStatisticsCondensation
namespace SFT.Physics.ParticleModeReach
open GeneratorOperations LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Result where
 depth : Nat
 support : Nat
 light : Rat
 heavy : Rat
 heavyToLight : Nat
 subtractionReach : Nat
 identity : Bool
def massRatioReach (depth : CountInput) : Except String Result := do
 let d ← SpinStatisticsCondensation.positiveWhole depth "mass family depth"
 let support := 2*3^d
 let light ← LeptonRatios.divide (wholeRatio 1) (wholeRatio support)
 let heavy ← LeptonRatios.divide (wholeRatio (support-1)) (wholeRatio support)
 let ratio ← LeptonRatios.divide heavy light
 pure ⟨d,support,light,heavy,support-1,support-1,ratio==wholeRatio (support-1)⟩
theorem originalEveryPositiveDepth (d : Nat) : massRatioReach (.integer (.ofNat (d+1)))=
 .ok ⟨d+1,MassRatioFamily.supportAt (d+1),
 natRatio 1 (MassRatioFamily.supportAt (d+1)) (MassRatioFamily.supportPositive _),
 natRatio (MassRatioFamily.supportAt (d+1)-1) (MassRatioFamily.supportAt (d+1)) (MassRatioFamily.supportPositive _),
 MassRatioFamily.supportAt (d+1)-1,MassRatioFamily.supportAt (d+1)-1,true⟩ := by
 unfold massRatioReach
 change (do
  let light ← LeptonRatios.divide (wholeRatio 1) (wholeRatio (MassRatioFamily.supportAt (d+1)))
  let heavy ← LeptonRatios.divide (wholeRatio (MassRatioFamily.supportAt (d+1)-1)) (wholeRatio (MassRatioFamily.supportAt (d+1)))
  let ratio ← LeptonRatios.divide heavy light
  pure (Result.mk (d+1) (MassRatioFamily.supportAt (d+1)) light heavy (MassRatioFamily.supportAt (d+1)-1) (MassRatioFamily.supportAt (d+1)-1) (ratio==wholeRatio (MassRatioFamily.supportAt (d+1)-1)))) = _
 rw [MassRatioFamily.wholeDivision _ _ (MassRatioFamily.supportPositive _)]
 dsimp only [Bind.bind,Except.bind]
 rw [MassRatioFamily.wholeDivision _ _ (MassRatioFamily.supportPositive _)]
 dsimp only [Bind.bind,Except.bind]
 rw [MassRatioFamily.allDepthRatio]
 dsimp only [Bind.bind,Except.bind]
 rw [ratEqualSelf]
 rfl
#print axioms massRatioReach
#print axioms originalEveryPositiveDepth
end SFT.Physics.ParticleModeReach
