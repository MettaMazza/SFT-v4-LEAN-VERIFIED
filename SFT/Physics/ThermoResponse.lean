import SFT.Physics.ThermoIrreversibility
namespace SFT.Physics.ThermoResponse
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Mathematics.FoldScalar ThermoTemperature

structure HeldContext where
 support : List String
 source : Part
 recurrence : List Part
 computed : FoldFirstReturn.firstReturn source = .ok recurrence

structure Reading (context : HeldContext) where
 observation : Macrostate
 supportHeld : observation.support = context.support
 recurrenceState : Part
 recurrenceHeld : recurrenceState ∈ context.source :: context.recurrence
 value : Scalar
 sourceIdentity : String

structure Probe (context : HeldContext) where
 sourceBefore : Reading context
 sourceAfter : Reading context
 responseBefore : Reading context
 responseAfter : Reading context

variable {context : HeldContext}

def sourceChange (p : Probe context) := subtract p.sourceAfter.value p.sourceBefore.value
def responseChange (p : Probe context) := subtract p.responseAfter.value p.responseBefore.value
def coefficient (p : Probe context) := divideScalar (responseChange p) (sourceChange p)

theorem sameHeldSupport (p : Probe context) :
 p.sourceBefore.observation.support = p.sourceAfter.observation.support ∧
 p.sourceBefore.observation.support = p.responseBefore.observation.support ∧
 p.sourceBefore.observation.support = p.responseAfter.observation.support :=
 ⟨p.sourceBefore.supportHeld.trans p.sourceAfter.supportHeld.symm,
  p.sourceBefore.supportHeld.trans p.responseBefore.supportHeld.symm,
  p.sourceBefore.supportHeld.trans p.responseAfter.supportHeld.symm⟩

theorem allReadingsInSameRecurrence (p : Probe context) :
 p.sourceBefore.recurrenceState ∈ context.source :: context.recurrence ∧
 p.sourceAfter.recurrenceState ∈ context.source :: context.recurrence ∧
 p.responseBefore.recurrenceState ∈ context.source :: context.recurrence ∧
 p.responseAfter.recurrenceState ∈ context.source :: context.recurrence :=
 ⟨p.sourceBefore.recurrenceHeld,p.sourceAfter.recurrenceHeld,
 p.responseBefore.recurrenceHeld,p.responseAfter.recurrenceHeld⟩

theorem recurrenceIsGenerated (context : HeldContext) :
 GeneratorThreeDerivation.FirstReturn context.source context.recurrence :=
 FoldFirstReturn.nativeFirstReturn _ _ context.computed

theorem exactChangeRatio (p : Probe context) :
 coefficient p = divideScalar
 (subtract p.responseAfter.value p.responseBefore.value)
 (subtract p.sourceAfter.value p.sourceBefore.value) := rfl

theorem sourceChangeBoundary (p : Probe context) (unchanged : p.sourceAfter.value = p.sourceBefore.value) :
 coefficient p = .error "division by structural empty-One is undefined" := by
 unfold coefficient sourceChange
 rw [unchanged,subtractSelf]
 rfl

theorem unchangedResponse (p : Probe context) (unchanged : p.responseAfter.value = p.responseBefore.value)
 (orientation : Orientation) (magnitude : PositiveFraction)
 (sourcePresent : sourceChange p = .positive orientation magnitude) : coefficient p = .ok .emptyOne := by
 unfold coefficient responseChange
 rw [unchanged,subtractSelf,sourcePresent]
 rfl

theorem orientedCoefficient (p : Probe context) (a b : Orientation) (x y : PositiveFraction)
 (response : responseChange p = .positive a x) (source : sourceChange p = .positive b y) :
 coefficient p = .ok (.positive (productOrientation a b) (quotientMagnitude x y)) := by
 unfold coefficient
 rw [response,source]
 rfl

theorem exactCoefficientMagnitude (x y : PositiveFraction) :
 (x.numerator*y.denominator)*(quotientMagnitude x y).denominator =
 (quotientMagnitude x y).numerator*(x.denominator*y.numerator) := quotientExact x y

theorem sameChangesSameCoefficient (p q : Probe context)
 (sameSource : sourceChange p = sourceChange q) (sameResponse : responseChange p = responseChange q) :
 coefficient p = coefficient q := by
 unfold coefficient
 rw [sameSource,sameResponse]

theorem successfulCoefficientUnique (p : Probe context) (a b : Scalar)
 (ha : coefficient p = .ok a) (hb : coefficient p = .ok b) : a = b := Except.ok.inj (ha.symm.trans hb)

theorem originalReadingsRetained (p : Probe context) :
 (Probe.mk p.sourceBefore p.sourceAfter p.responseBefore p.responseAfter : Probe context) = p := rfl

abbrev computedObservationFibre := ThermoEntropy.exactHeldFibre
abbrev fullCensusWeight := ThermoStatisticalWeight.exactCensusRatio
abbrev singletonObservation := SFT.InformationScience.EntropyExtension.singletonBase
abbrev successorObservation := SFT.InformationScience.EntropyExtension.fibreSuccessor
end SFT.Physics.ThermoResponse
