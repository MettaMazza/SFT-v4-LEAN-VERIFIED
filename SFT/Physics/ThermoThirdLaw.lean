import SFT.Physics.ThermoSecondLaw
import SFT.Physics.FoldFirstReturn
namespace SFT.Physics.ThermoThirdLaw
open SFT.Foundation.ExactPartCarrier SFT.Foundation.FoldDynamics
open GeneratorThreeDerivation

def retainedHistory (source : Part) (trace : List Part) := source :: trace

theorem finiteIteratePositive (source : Part) (steps : Nat) :
 0 < (iterate steps source).numerator := (iterate steps source).positive

theorem finiteIterateCannotErase (source : Part) (steps : Nat) :
 (iterate steps source).numerator ≠ 0 := Nat.ne_of_gt (finiteIteratePositive source steps)

theorem finiteIterateAdmitted (source : Part) (steps : Nat) :
 admitFraction (asFraction (iterate steps source)) = some (iterate steps source) :=
 admittedPartRoundTrip _

theorem sourceTraceRetained (source : Part) (trace : List Part) :
 source ∈ retainedHistory source trace := List.Mem.head _

theorem noEmptyRetainedHistory (source : Part) (trace : List Part) :
 retainedHistory source trace ≠ [] := by intro h; cases h

theorem everyTransitionRetainsPositiveCarrier (source : Part) (trace : List Part)
 (_lawful : Steps source trace) (state : Part) (_present : state ∈ trace) :
 0 < state.numerator := state.positive

theorem noTransitionErasesCarrier (source : Part) (trace : List Part)
 (lawful : Steps source trace) (state : Part) (present : state ∈ trace) : state.numerator ≠ 0 :=
 Nat.ne_of_gt (everyTransitionRetainsPositiveCarrier source trace lawful state present)

theorem returnPreservesSource (source : Part) (trace : List Part)
 (passed : FoldFirstReturn.firstReturn source = .ok trace) :
 ∃ before, trace = before ++ [source] ∧ Steps source trace ∧
  ∀ state, state ∈ before → state ≠ source := FoldFirstReturn.nativeFirstReturn source trace passed

theorem returnIsNotDeletion (source : Part) (trace : List Part)
 (passed : FoldFirstReturn.firstReturn source = .ok trace) : trace ≠ [] := by
 obtain ⟨before,equal,_,_⟩ := returnPreservesSource source trace passed
 intro empty
 have impossible := equal.symm.trans empty
 cases before with
 | nil => cases impossible
 | cons a rest => cases impossible

abbrev zeroMagnitudeRejected := zeroRejected
abbrev generatedSupportPositive := GeneratorThreeDerivation.supportPositive
abbrev positiveDepthRetainsDistinction := GeneratorThreeDerivation.positiveSupportBeyondOne
abbrev positiveRecurrencePredecessor := GeneratorThreeDerivation.predecessorPositive
abbrev oneStateBase := SFT.InformationScience.EntropyExtension.singletonBase
abbrev successorPreservesFibre := SFT.InformationScience.EntropyExtension.fibreSuccessor
end SFT.Physics.ThermoThirdLaw
