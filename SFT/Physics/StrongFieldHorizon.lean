import SFT.Physics.GravityWaveTrace
import SFT.Physics.FiniteLoopProofs
namespace SFT.Physics.StrongFieldHorizon
open SFT.Foundation ExactOperations ExactPartCarrier
open GeneratorOperations LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
structure Result where
 mass : Rat
 radius : Rat
 entropyCoefficient : Rat
 areaCells : Nat
 entropyCells : Rat
 normalizedThermalCarrier : Rat

def strongFieldHorizon : Except String Result := do
 let mass : Rat := ⟨1,4,by decide,by decide⟩
 let massPart ← fromPair mass.num (.ofNat mass.den)
 let radius := asFraction (foldPart massPart)
 let binary ← AlphaCovers.binaryCount
 let square ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat binary))
 let coefficient ← LeptonRatios.divide (asFraction one) (wholeRatio square)
 let area ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer 5)
 let entropy := multiply coefficient (wholeRatio area)
 let thermalSquare ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat binary))
 let thermal ← LeptonRatios.divide (asFraction one) (wholeRatio thermalSquare)
 let expected ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer 3)
 let doubled := add mass mass
 let entropyCount := wholeRatio expected
 if !radius.blt doubled && !doubled.blt radius && !entropy.blt entropyCount && !entropyCount.blt entropy then
  pure ⟨mass,radius,coefficient,area,entropy,thermal⟩
 else throw "strong-field horizon counts did not cross-close"

def finiteDistanceFloor (depth : CountInput) : Except String Rat := do
 let n ← match depth with
  | .boolean _ => .error "distance floor requires positive depth"
  | .integer (.negSucc _) => .error "distance floor requires positive depth"
  | .integer (.ofNat 0) => .error "distance floor requires positive depth"
  | .integer (.ofNat (n+1)) => .ok (n+1)
 let binary ← AlphaCovers.binaryCount
 let support ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat n))
 LeptonRatios.divide (asFraction one) (wholeRatio support)

def originalRecord : Result := ⟨⟨1,4,by decide,by decide⟩,⟨1,2,by decide,by decide⟩,
 ⟨1,4,by decide,by decide⟩,32,⟨8,1,by decide,by decide⟩,⟨1,4,by decide,by decide⟩⟩

theorem completeSourceRecord : strongFieldHorizon=.ok originalRecord := by
 unfold strongFieldHorizon
 rw [AlphaCovers.binaryCountTwo]
 rfl

theorem doubledMassRadius : originalRecord.radius=add originalRecord.mass originalRecord.mass := rfl

theorem quarterAreaEntropy : originalRecord.entropyCells=multiply originalRecord.entropyCoefficient (wholeRatio originalRecord.areaCells) := rfl

theorem everyPositiveDepth (n : Nat) : finiteDistanceFloor (.integer (.ofNat (n+1)))=
 .ok (natRatio 1 (2^(n+1)) (Nat.pow_pos (by decide))) := by
 unfold finiteDistanceFloor
 rw [AlphaCovers.binaryCountTwo]
 dsimp only [Except.bind,Bind.bind]
 rw [AlphaCovers.positivePowerValue 1 n]
 dsimp only [Except.bind,Bind.bind]
 rw [← natRatioWhole]
 change LeptonRatios.divide (natRatio 1 1 (by decide)) (natRatio (2^(n+1)) 1 (by decide))= _
 rw [divideNormalized 1 1 (2^(n+1)) 1 (by decide) (Nat.pow_pos (by decide)) (by decide)]
 apply congrArg Except.ok
 apply natRatioCongruence
 exact (Nat.one_mul (1*(2^(n+1)))).symm

theorem everyFiniteFloorPositive (n : Nat) :
 zero.blt (natRatio 1 (2^(n+1)) (Nat.pow_pos (by decide)))=true :=
 positiveNormalized _ _ (by decide) _
end SFT.Physics.StrongFieldHorizon
