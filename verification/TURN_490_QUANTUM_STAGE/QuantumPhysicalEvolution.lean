import SFT.Physics.QuantumPhysicalState
import SFT.QuantumComputation.ClassicalCorrespondence
namespace SFT.Physics.QuantumPhysicalEvolution
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleExecution

structure Evolution (initial : QuantumPhysicalState.Prepared) where
  terminal : State
  gates : List Gate
  predecessors : List State
  trace : Forward initial.state gates predecessors terminal

def record {initial : QuantumPhysicalState.Prepared} (e : Evolution initial) :=
  (initial,e.gates,e.predecessors,e.terminal)

theorem exactlyReversible {initial : QuantumPhysicalState.Prepared} (e : Evolution initial) :
    Backward e.terminal (reverseOrder e.gates) initial.state := exactInverseTrace _ _ _ _ e.trace

theorem allSupportRetained {initial : QuantumPhysicalState.Prepared} (e : Evolution initial) :
    e.terminal.branches.length = initial.state.branches.length := fullSupportRetained _ _ _ _ e.trace

theorem everyPredecessorRecorded {initial : QuantumPhysicalState.Prepared} (e : Evolution initial) :
    e.predecessors.length = e.gates.length := retainedPredecessorCount _ _ _ _ e.trace

theorem originalPreparationRetained {initial : QuantumPhysicalState.Prepared} (e : Evolution initial) :
    (record e).1.preparation = initial.preparation ∧ (record e).1.sourceIdentity = initial.sourceIdentity := ⟨rfl,rfl⟩

theorem everyBranchHasSource {initial : QuantumPhysicalState.Prepared} (e : Evolution initial) (branch : Word × String) :
    branch ∈ e.terminal.branches ↔ ∃ source, source ∈ initial.state.branches ∧
      SFT.QuantumComputation.Algorithms.BranchTrace initial.state.phaseCycle e.gates source branch :=
  SFT.QuantumComputation.Algorithms.everyBranchHasExactTrace _ _ _ _ e.trace branch
end SFT.Physics.QuantumPhysicalEvolution
