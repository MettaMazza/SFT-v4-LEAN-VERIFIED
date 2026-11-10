import SFT.Physics.CollectiveBand
namespace SFT.Physics.SuperconductivityRecurrenceProofs
open SFT.QuantumComputation.ReversibleModel

-- V3 recurrence retains the complete state, not just one scalar reading.
-- These consequences use the existing exact phase-return implementation.
theorem returningCarrierPreservesEveryReading {Reading : Type}
 (state result : State) (steps : List String) (reading : State → Reading)
 (returns : phaseAction state steps = .ok state)
 (executed : phaseAction state steps = .ok result) : reading result = reading state := by
 have same : result = state := Except.ok.inj (executed.symm.trans returns)
 exact congrArg reading same

-- V3's dissipative correspondence merges predecessors. Two exact returning
-- carriers cannot merge into the same resulting complete carrier.
theorem returningCarriersCannotMerge (left right result : State)
 (leftSteps rightSteps : List String)
 (leftReturn : phaseAction left leftSteps = .ok left)
 (rightReturn : phaseAction right rightSteps = .ok right)
 (leftResult : phaseAction left leftSteps = .ok result)
 (rightResult : phaseAction right rightSteps = .ok result) : left = right := by
 have l : left = result := Except.ok.inj (leftReturn.symm.trans leftResult)
 have r : right = result := Except.ok.inj (rightReturn.symm.trans rightResult)
 exact l.trans r.symm

theorem accessibleRecurrencePreservesEveryReading {Reading : Type}
 (boundary : CollectiveBand.Boundary) (path : List String)
 (held : path ∈ CollectiveBand.support boundary)
 (result : State) (reading : State → Reading)
 (executed : phaseAction boundary.preparation.state path = .ok result) :
 reading result = reading boundary.preparation.state :=
 returningCarrierPreservesEveryReading _ _ _ reading
 (((CollectiveBand.bandExactly boundary path).mp held).2.2) executed

end SFT.Physics.SuperconductivityRecurrenceProofs
