import SFT.Physics.SymmetryAction
namespace SFT.Physics.SymmetryActionOddCore
open SymmetryAction SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
open SFT.Mathematics.OrbitBinaryDepth
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
theorem originalCoreRunUnique (n a b : Nat) (left : SourceOddCoreRun n a)
 (right : SourceOddCoreRun n b) : a=b := by
 induction left generalizing b with
 | stop n odd =>
  cases right with
  | stop _ _ => rfl
  | step _ _ even _ => rw [odd] at even; cases even
 | step n a even tail ih =>
  cases right with
  | stop _ odd => rw [even] at odd; cases odd
  | step _ _ _ later => exact ih _ later
theorem originalFactorCoreRun (depth core : Nat) (odd : core%2=1) :
 SourceOddCoreRun (2^depth*core) core := by
 induction depth with
 | zero =>
  rw [Nat.pow_zero,Nat.one_mul]
  apply SourceOddCoreRun.stop
  rw [odd]
  rfl
 | succ depth ih =>
  apply SourceOddCoreRun.step
  · rw [positiveRemainingDepthEven core depth]
    rfl
  · rw [Nat.pow_succ,Nat.mul_comm (2^depth) 2,mulAssoc,divisionMultiple 2 (2^depth*core) (by decide)]
    exact ih
theorem originalCoreFromDenominatorFactors (p : Part) (depth core : Nat)
 (odd : core%2=1) (shape : p.denominator=2^depth*core) :
 reducedOddDenominatorCore (.fraction (asFraction p))=.ok core := by
 rw [originalAdmittedCore]
 apply congrArg Except.ok
 have executed := originalOddCoreRun p.denominator p.denominator (denominatorPositive p) (Nat.le_refl _)
 have factor := originalFactorCoreRun depth core odd
 rw [←shape] at factor
 exact originalCoreRunUnique _ _ _ executed factor
end SFT.Physics.SymmetryActionOddCore
