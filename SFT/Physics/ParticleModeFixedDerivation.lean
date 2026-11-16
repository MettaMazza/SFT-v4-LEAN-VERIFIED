import SFT.Physics.ParticleModeFibreDerivation
namespace SFT.Physics.ParticleModeFixedDerivation
open ParticleModeFibres ParticleModeFibreDerivation LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def fixedValue (k j : Nat) : Rat := natRatio (j+1) (k+1) (Nat.zero_lt_succ k)
def completeFixedModes (k : Nat) : List Rat := (List.range k).map (fixedValue k)
theorem originalFixedValue (k j : Nat) :
 LeptonRatios.divide (wholeRatio (j+1)) (wholeRatio (k+1))=.ok (fixedValue k j) :=
 MassRatioFamily.wholeDivision _ _ (Nat.zero_lt_succ k)
theorem originalFixedReturn (k j : Nat) :
 multiply (wholeRatio (k+2)) (fixedValue k j) = add (fixedValue k j) (wholeRatio (j+1)) := by
 have whole : wholeRatio (j+1)=natRatio ((j+1)*(k+1)) (k+1) (Nat.zero_lt_succ k) := by
  rw [←natRatioWhole (j+1)];apply natRatioCongruence;rw [Nat.mul_one]
 rw [whole]
 unfold fixedValue
 rw [addNormalized,←natRatioWhole (k+2),multiplyNormalized]
 apply natRatioCongruence
 have numerator : (k+2)*(j+1)=(j+1)+(j+1)*(k+1) := by
  calc
   (k+2)*(j+1)=(j+1)*(k+2) := Nat.mul_comm _ _
   _ = (j+1)*(k+1)+(j+1) := Nat.mul_succ _ _
   _ = (j+1)+(j+1)*(k+1) := Nat.add_comm _ _
 rw [Nat.one_mul,numerator]
theorem originalFixedAsOffset (k j : Nat) : fixedValue k j=
 offsetValue (k+1) 1 1 j (Nat.zero_lt_succ k) (by decide) := by
 unfold fixedValue offsetValue
 apply natRatioCongruence
 rw [Nat.mul_one,Nat.one_mul,Nat.add_comm 1 j]
theorem originalFixedInjective (k i j : Nat) (same : fixedValue k i=fixedValue k j) : i=j := by
 rw [originalFixedAsOffset,originalFixedAsOffset] at same
 exact originalOffsetInjective _ _ _ _ _ _ _ same
theorem originalFixedInterior (k j : Nat) (inside : j<k) :
 0<(fixedValue k j).num.natAbs ∧ (fixedValue k j).num.natAbs<(fixedValue k j).den := by
 refine ⟨positiveNormalizedNumerator (j+1) (k+1) (Nat.zero_lt_succ _) (Nat.zero_lt_succ _),?_⟩
 have val := natRatioValue (j+1) (k+1) (Nat.zero_lt_succ k)
 change (j+1)*(fixedValue k j).den=(fixedValue k j).num.natAbs*(k+1) at val
 have strict := Nat.mul_lt_mul_of_pos_right (Nat.succ_lt_succ inside)
  (Nat.pos_of_ne_zero (fixedValue k j).den_nz)
 rw [val,Nat.mul_comm (k+1)] at strict
 apply Nat.lt_of_not_ge
 intro opposite
 exact Nat.not_lt_of_ge (Nat.mul_le_mul_right (k+1) opposite) strict
theorem originalFixedCount (k : Nat) : (completeFixedModes k).length=k := by
 unfold completeFixedModes
 rw [VacuumSpectrum.mappedLength]
 exact (VacuumSpectrum.rangeLoopLength k []).trans (Nat.add_zero _)
theorem originalFixedIndicesSuccessor (k : Nat) :
 (List.range (k+1)).map Nat.succ=(List.range k).map Nat.succ++[k+1] := by
 have append : ∀ xs : List Nat, (xs++[k]).map Nat.succ=xs.map Nat.succ++[k+1] := by
  intro xs
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons (x+1)) ih
 rw [rangeSuccessor]
 exact append _
theorem originalEmptyOne : completeFixedModes 0=[] := rfl
#print axioms originalFixedValue
#print axioms originalFixedReturn
#print axioms originalFixedAsOffset
#print axioms originalFixedInjective
#print axioms originalFixedInterior
#print axioms originalFixedCount
#print axioms originalFixedIndicesSuccessor
#print axioms originalEmptyOne
end SFT.Physics.ParticleModeFixedDerivation
