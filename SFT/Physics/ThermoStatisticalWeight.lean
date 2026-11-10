import SFT.Physics.ThermoThirdLaw
namespace SFT.Physics.ThermoStatisticalWeight
open SFT.InformationScience EntropyPartition EntropyLedger
open SFT.Foundation.ExactOperations
open ThermoTemperature

def weight (s : Macrostate) : PositiveFraction := (ThermoEntropy.record s).exactSupportPart

theorem exactCensusRatio (s : Macrostate) :
 s.members.length * (weight s).denominator = (weight s).numerator * s.support.length :=
 ThermoEntropy.exactClassWeight s

theorem positiveWeight (s : Macrostate) : 0 < (weight s).numerator := (weight s).positive

theorem denominatorNonzero (s : Macrostate) : (weight s).denominator ≠ 0 := (weight s).denominatorNonzero

theorem reducedWeight (s : Macrostate) : (weight s).numerator.Coprime (weight s).denominator :=
 (weight s).reduced

theorem throughOne (s : Macrostate) : (weight s).numerator ≤ (weight s).denominator := by
 apply normalizedThroughOne s.members.length s.support.length
  (membersPositive _ _ _ s.computed _ s.present) (supportPositive _ _ _ s.computed)
 have fibre := ThermoEntropy.exactHeldFibre s
 change s.members = SFT.Mathematics.ProbabilityObservations.fibre s.support s.observation s.label at fibre
 rw [fibre]
 exact filterLengthBound _ _

theorem canonicalNumerator (s : Macrostate) :
 (weight s).numerator = s.members.length / Nat.gcd s.members.length s.support.length := rfl

theorem canonicalDenominator (s : Macrostate) :
 (weight s).denominator = s.support.length / Nat.gcd s.members.length s.support.length := rfl

theorem censusDeterminesReadings (a b : Macrostate)
 (sameMembers : a.members.length = b.members.length) (sameSupport : a.support.length = b.support.length) :
 (weight a).numerator = (weight b).numerator ∧ (weight a).denominator = (weight b).denominator := by
 rw [canonicalNumerator,canonicalNumerator,canonicalDenominator,canonicalDenominator,sameMembers,sameSupport]
 exact ⟨rfl,rfl⟩

abbrev completeFibre := ThermoEntropy.exactHeldFibre
abbrev everyMemberCountedOnce := ThermoMicroMacro.everyPredecessorRetainedOnce
abbrev exactSuccessorRatio := EntropyExtension.successorPartValue
abbrev singletonWhole := EntropyExtension.singletonWholePart
abbrev retainedSupportAndClasses := EntropyLedger.entropyProvenance
end SFT.Physics.ThermoStatisticalWeight
