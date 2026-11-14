import SFT.Physics.RadioactiveDecay
namespace SFT.Physics.RadioactiveDecayProofs
open RadioactiveDecay LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
theorem powerPositive (k : Nat) : 0 < 2^k := Nat.pow_pos (by decide)
def survivalValue (k : Nat) : Rat := natRatio 1 (2^k) (powerPositive k)
theorem survivalFormula (k : Nat) :
 survivalPart (.integer (.ofNat (k+1))) = .ok (survivalValue (k+1)) := by
 unfold survivalPart
 dsimp only [positiveCount,Except.bind,Bind.bind]
 rw [AlphaCovers.binaryCountTwo]
 dsimp only [Except.bind,Bind.bind]
 rw [AlphaCovers.positivePowerValue 1 k]
 dsimp only [Except.bind,Bind.bind]
 rw [← natRatioWhole 1,← natRatioWhole (2^(k+1))]
 rw [divideNormalized 1 1 (2^(k+1)) 1 (by decide) (powerPositive _) (by decide)]
 unfold survivalValue
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.one_mul]
theorem noFiniteZero (k : Nat) : 0 < (survivalValue k).num.natAbs :=
 positiveNormalizedNumerator 1 (2^k) (by decide) (powerPositive k)
theorem survivalSuccessor (k : Nat) :
 multiply (survivalValue k) (natRatio 1 2 (by decide)) = survivalValue (k+1) := by
 unfold survivalValue
 rw [multiplyNormalized]
 apply natRatioCongruence
 rw [Nat.pow_succ,Nat.one_mul]
theorem completePathSuccessor (k : Nat) : 2^(k+1) = 2^k+2^k := by
 rw [Nat.pow_succ,Nat.mul_succ,Nat.mul_one]
private theorem subtractAdded (a b : Nat) : a+b-b=a := by
 induction b with
 | zero => rfl
 | succ b ih => rw [Nat.add_succ,Nat.succ_sub_succ]; exact ih
theorem retainedReleasedEqual (k : Nat) : 2^(k+1)-2^k = 2^k := by
 rw [completePathSuccessor]
 exact subtractAdded _ _
end SFT.Physics.RadioactiveDecayProofs
