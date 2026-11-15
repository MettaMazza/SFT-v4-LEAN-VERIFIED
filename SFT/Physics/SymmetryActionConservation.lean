import SFT.Physics.SymmetryActionOddCore
import SFT.Physics.VacuumOddTrace
namespace SFT.Physics.SymmetryActionConservation
open SymmetryAction SymmetryActionOddCore
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.ExactValueIdentity SFT.Foundation.FractionReduction
open SFT.Mathematics.OrbitOrderIdentity SFT.Mathematics.OrbitBinaryDepth
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
theorem originalFoldDenominator (p : Part) :
 (SFT.Foundation.ExactOperations.foldPart p).denominator = executedDenominator p.numerator p.denominator 1 := by
 have self : normalizePart p.numerator p.denominator p.positive p.throughOne = p :=
  normalizedRepresents _ _ _ _ p rfl
 have step := VacuumOddTrace.normalizedFoldStep p.numerator p.denominator p.positive p.throughOne
 rw [self] at step
 exact congrArg Part.denominator step
theorem originalFoldPreservesFactoredCore (p : Part) (depth core : Nat)
 (hc : 0<core) (odd : core%2=1) (shape : p.denominator=2^depth*core) :
 reducedOddDenominatorCore (.fraction (asFraction (SFT.Foundation.ExactOperations.foldPart p)))=.ok core := by
 have red : Nat.gcd p.numerator (2^depth*core)=1 := shape ▸ p.reduced
 cases depth with
 | zero =>
  apply originalCoreFromDenominatorFactors _ 0 core odd
  rw [originalFoldDenominator,shape]
  have h := executedDenominatorAfterDepth p.numerator core 0 1 hc odd red
  rw [Nat.pow_zero,Nat.one_mul] at h ⊢
  exact h
 | succ depth =>
  apply originalCoreFromDenominatorFactors _ depth core odd
  rw [originalFoldDenominator,shape]
  have idx : depth+1=1+depth := Nat.add_comm _ _
  rw [idx] at red ⊢
  exact executedDenominatorBeforeDepth p.numerator core 1 depth hc red
theorem originalEveryPartConservesCore (p : Part) :
 oddCoreIsConserved (.fraction (asFraction p))=.ok true := by
 obtain ⟨depth,core,hc,odd,shape⟩ := SFT.Mathematics.BoundedFoldTransient.denominatorDecomposes p.denominator (denominatorPositive p)
 unfold oddCoreIsConserved
 rw [originalCoreFromDenominatorFactors p depth core odd shape]
 dsimp only [Except.bind,Bind.bind]
 rw [originalAdmittedFold]
 dsimp only [Except.bind,Bind.bind]
 rw [originalFoldPreservesFactoredCore p depth core hc odd shape]
 dsimp only [Except.bind,Bind.bind]
 apply congrArg Except.ok
 exact SFT.Mathematics.OrbitLoopCompletion.natBeqSelf core
end SFT.Physics.SymmetryActionConservation
