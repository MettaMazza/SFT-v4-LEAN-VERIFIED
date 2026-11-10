import SFT.Physics.ThermoKineticTransport
namespace SFT.Physics.ThermoFluctuation
open SFT.Foundation.ExactPartCarrier SFT.Foundation.FoldDynamics
open SFT.Foundation.ExactOperations
open GeneratorThreeDerivation ThermoTemperature
open SFT.Mathematics.FoldScalar

structure Observation where
 macrostate : Part → Macrostate
 transfers : Part → List String

def fibreCount (o : Observation) (state : Part) := (o.macrostate state).members.length
def transferCount (o : Observation) (state : Part) := (o.transfers state).length
def countRows (o : Observation) (trace : List Part) :=
 trace.map (fun state => (state,fibreCount o state,transferCount o state))
def fluctuation (o : Observation) (source current : Part) : Scalar :=
 subtract (.positive .forward (multiplicity (o.macrostate current)))
  (.positive .forward (multiplicity (o.macrostate source)))
def censusWeight (o : Observation) (state : Part) := ThermoStatisticalWeight.weight (o.macrostate state)

theorem deterministicSteps (source : Part) (left : List Part) (path : Steps source left) :
 ∀ right, Steps source right → left.length = right.length → left = right := by
 induction path with
 | identity source =>
   intro right other same
   cases other with
   | identity => rfl
   | next source rest tail => cases same
 | next source rest tail ih =>
   intro right other same
   cases other with
   | identity => cases same
   | next source otherRest otherTail =>
     exact congrArg (List.cons (foldPart source)) (ih otherRest otherTail (Nat.succ.inj same))

theorem deterministicObservedHistory (o : Observation) (source : Part) (left right : List Part)
 (a : Steps source left) (b : Steps source right) (same : left.length = right.length) :
 countRows o left = countRows o right := congrArg (countRows o) (deterministicSteps source left a right b same)

theorem everyTraceRowRetained (o : Observation) (trace : List Part) :
 (countRows o trace).length = trace.length := by
 induction trace with
 | nil => rfl
 | cons state rest ih => exact congrArg Nat.succ ih

theorem countRowsSuccessor (o : Observation) (state : Part) (rest : List Part) :
 countRows o (state :: rest) = (state,fibreCount o state,transferCount o state) :: countRows o rest := rfl

theorem exactCensusWeight (o : Observation) (state : Part) :
 (fibreCount o state) * (censusWeight o state).denominator =
 (censusWeight o state).numerator * (o.macrostate state).support.length :=
 ThermoStatisticalWeight.exactCensusRatio _

theorem recurrenceRestoresCounts (o : Observation) (source current : Part) (returned : current = source) :
 fibreCount o current = fibreCount o source ∧ transferCount o current = transferCount o source :=
 ⟨congrArg (fibreCount o) returned,congrArg (transferCount o) returned⟩

theorem recurrenceRestoresWeight (o : Observation) (source current : Part) (returned : current = source) :
 censusWeight o current = censusWeight o source := congrArg (censusWeight o) returned

theorem recurrenceClosesFluctuation (o : Observation) (source current : Part) (returned : current = source) :
 fluctuation o source current = .emptyOne := by
 cases returned
 exact subtractSelf _

theorem nativeReturnHistory (source : Part) (trace : List Part)
 (passed : FoldFirstReturn.firstReturn source = .ok trace) :
 ∃ before, trace = before ++ [source] ∧ Steps source trace ∧ ∀ state, state ∈ before → state ≠ source :=
 FoldFirstReturn.nativeFirstReturn source trace passed

abbrev completeObservationFibre := ThermoEntropy.exactHeldFibre
abbrev noUnrecordedPredecessor := ThermoSecondLaw.noUnrecordedReverse
abbrev generatedWeightHasNoFreeReading := ThermoStatisticalWeight.censusDeterminesReadings
end SFT.Physics.ThermoFluctuation
