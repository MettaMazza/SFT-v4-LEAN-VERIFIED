import SFT.Physics.NuclearLevels
namespace SFT.Physics.NuclearRadioactivity
open SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations
open SFT.QuantumComputation.ReversibleModel

structure Support (p : QuantumPhysicalState.Prepared) where
  paths : List (QuantumPhysicalEvolution.Evolution p)
  nonempty : 0 < paths.length
  observed : State → String
  noStableReturn : ∀ path ∈ paths, observed path.terminal ≠ observed p.state

def selected {p : QuantumPhysicalState.Prepared} (s : Support p) (event : String) :=
  s.paths.filter (fun path => s.observed path.terminal == event)

theorem forcedObservedTransition {p : QuantumPhysicalState.Prepared} (s : Support p)
    (path : QuantumPhysicalEvolution.Evolution p) (held : path ∈ s.paths) : path.terminal ≠ p.state :=
  fun equal => s.noStableReturn path held (congrArg s.observed equal)

theorem everyTerminalBranchHasSource {p : QuantumPhysicalState.Prepared} (s : Support p)
    (path : QuantumPhysicalEvolution.Evolution p) (_held : path ∈ s.paths) (branch : Word × String) :
    branch ∈ path.terminal.branches ↔ ∃ source, source ∈ p.state.branches ∧
      SFT.QuantumComputation.Algorithms.BranchTrace p.state.phaseCycle path.gates source branch :=
  QuantumPhysicalEvolution.everyBranchHasSource path branch

theorem completePathSupportRetained {p : QuantumPhysicalState.Prepared} (s : Support p)
    (path : QuantumPhysicalEvolution.Evolution p) (_held : path ∈ s.paths) :
    path.terminal.branches.length = p.state.branches.length := QuantumPhysicalEvolution.allSupportRetained path

theorem exactEventSelection {p : QuantumPhysicalState.Prepared} (s : Support p) (event : String)
    (path : QuantumPhysicalEvolution.Evolution p) :
    path ∈ selected s event ↔ path ∈ s.paths ∧ (s.observed path.terminal == event) = true := by
  have all (paths : List (QuantumPhysicalEvolution.Evolution p)) :
      path ∈ paths.filter (fun x => s.observed x.terminal == event) ↔
      path ∈ paths ∧ (s.observed path.terminal == event) = true := by
    induction paths with
    | nil => constructor
             · intro h; cases h
             · intro h; cases h.1
    | cons a rest ih =>
      cases h : s.observed a.terminal == event <;> simp only [List.filter,h]
      · constructor
        · intro h; have z := ih.mp h; exact ⟨.tail _ z.1,z.2⟩
        · intro hp; cases hp.1 with
          | head => exact Bool.noConfusion (h.symm.trans hp.2)
          | tail _ hm => exact ih.mpr ⟨hm,hp.2⟩
      · constructor
        · intro hp; cases hp with
          | head => exact ⟨.head _,h⟩
          | tail _ hm => have z := ih.mp hm; exact ⟨.tail _ z.1,z.2⟩
        · intro hp; cases hp.1 with
          | head => exact .head _
          | tail _ hm => exact .tail _ (ih.mpr ⟨hm,hp.2⟩)
  exact all _

def eventWeight {p : QuantumPhysicalState.Prepared} (s : Support p) (event : String)
    (present : 0 < (selected s event).length) := ratio (selected s event).length s.paths.length present s.nonempty

theorem exactCompletePathWeight {p : QuantumPhysicalState.Prepared} (s : Support p) (event : String)
    (present : 0 < (selected s event).length) :
    (selected s event).length * (eventWeight s event present).denominator =
      (eventWeight s event present).numerator * s.paths.length := ratioValue _ _ _ _

theorem onlyCompletePathWeight {p : QuantumPhysicalState.Prepared} (s : Support p) (event : String)
    (present : 0 < (selected s event).length) (candidate : PositiveFraction)
    (equation : (selected s event).length * candidate.denominator = candidate.numerator * s.paths.length) :
    candidate = eventWeight s event present := by
  exact (FieldGeometricDilution.positiveNormalizationRepresents _ _ present s.nonempty candidate equation).symm.trans
    (FieldGeometricDilution.positiveNormalizationRepresents _ _ present s.nonempty (eventWeight s event present)
      (exactCompletePathWeight s event present))

theorem allGatePredecessorsRetained {p : QuantumPhysicalState.Prepared} (s : Support p)
    (path : QuantumPhysicalEvolution.Evolution p) (_held : path ∈ s.paths) :
    path.predecessors.length = path.gates.length := QuantumPhysicalEvolution.everyPredecessorRecorded path
end SFT.Physics.NuclearRadioactivity
