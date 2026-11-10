import SFT.Physics.ThermoFirstLawBalance
import SFT.InformationScience.EntropyExtension
namespace SFT.Physics.ThermoEntropy
open ThermoTemperature SFT.InformationScience EntropyPartition EntropyLedger

def record (s : Macrostate) : EntropyLedger.Record :=
  makeRecord s.support (supportPositive _ _ _ s.computed) (s.label,s.members)
    (membersPositive _ _ _ s.computed (s.label,s.members) s.present)

def conditionalEntropy (s : Macrostate) : Uncertainty := (record s).unresolvedDistinctions

theorem exactHeldFibre (s : Macrostate) :
    (record s).microstates = SFT.Mathematics.ProbabilityObservations.fibre s.support s.observation s.label :=
  ((partitionMembership _ _ _ s.computed s.label s.members).mp s.present).2

theorem fullConditionalDistinctions (s : Macrostate) :
    uncertaintyPairs (conditionalEntropy s) = EncodingLoss.sourcePairs s.members :=
  unresolvedContents s.members

theorem retainedObservationLabel (s : Macrostate) : (record s).observation = s.label := rfl

theorem exactClassWeight (s : Macrostate) :
    s.members.length * (record s).exactSupportPart.denominator =
      (record s).exactSupportPart.numerator * s.support.length :=
  SFT.Foundation.ExactOperations.normalizedValuePreserved s.members.length s.support.length
    (membersPositive s.support s.observation s.partition s.computed (s.label,s.members) s.present)
    (supportPositive s.support s.observation s.partition s.computed)

theorem noUnresolvedDistinctionIffSingleton (s : Macrostate) :
    conditionalEntropy s = .emptyOne ↔ s.members.length = 1 := by
  change unresolvedPairs s.members = .emptyOne ↔ s.members.length = 1
  constructor
  · intro empty
    have upper := (certaintyIff s.members).mp empty
    have lower := membersPositive _ _ _ s.computed (s.label,s.members) s.present
    exact Nat.le_antisymm upper lower
  · intro one
    apply (certaintyIff s.members).mpr
    rw [one]
    exact Nat.le_refl _

theorem sameRetainedFibreSameEntropy (a b : Macrostate) (same : a.members = b.members) :
    conditionalEntropy a = conditionalEntropy b := congrArg unresolvedPairs same

abbrev oneStateBase := EntropyExtension.singletonBase
abbrev oneStateExactWhole := EntropyExtension.singletonWholePart
abbrev completeSuccessorPairs := EntropyExtension.classPairSuccessor
abbrev exactSuccessorWeight := EntropyExtension.successorPartValue
end SFT.Physics.ThermoEntropy
