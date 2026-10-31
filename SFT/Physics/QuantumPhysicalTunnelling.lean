import SFT.Physics.QuantumPhysicalExclusion
import SFT.Mathematics.DiscreteComplement
namespace SFT.Physics.QuantumPhysicalTunnelling
open SFT.QuantumComputation.ReversibleModel QuantumPhysicalEvolution
open SFT.Mathematics.DiscreteObjects

-- The two tests are the held barrier/phase record and its original coarse projection.
def traversal {p : QuantumPhysicalState.Prepared} (e : Evolution p)
    (compatible coarse : Word × String → Bool) :=
  e.terminal.branches.filter (fun row => compatible row && !coarse row)

theorem traversalExactly {p : QuantumPhysicalState.Prepared} (e : Evolution p)
    (compatible coarse : Word × String → Bool) (row : Word × String) :
    row ∈ traversal e compatible coarse ↔
      row ∈ e.terminal.branches ∧ compatible row = true ∧ coarse row = false := by
  constructor
  · intro h
    obtain ⟨held,test⟩ := (filterMemberIff _ _ _).mp h
    cases hc : compatible row <;> cases hp : coarse row <;>
      simp only [hc,hp,Bool.not_false,Bool.not_true,Bool.and_false,Bool.and_true] at test
    · cases test
    · cases test
    · exact ⟨held,rfl,rfl⟩
    · cases test
  · intro ⟨held,hc,hp⟩
    apply (filterMemberIff _ _ _).mpr
    exact ⟨held,by rw [hc,hp]; rfl⟩

theorem everyTraversalHasGeneratedPath {p : QuantumPhysicalState.Prepared} (e : Evolution p)
    (compatible coarse : Word × String → Bool) (row : Word × String)
    (observed : row ∈ traversal e compatible coarse) :
    ∃ source, source ∈ p.state.branches ∧
      SFT.QuantumComputation.Algorithms.BranchTrace p.state.phaseCycle e.gates source row :=
  (everyBranchHasSource e row).mp ((traversalExactly e compatible coarse row).mp observed).1

theorem coarseProjectionClosesTraversal {p : QuantumPhysicalState.Prepared} (e : Evolution p)
    (compatible coarse : Word × String → Bool) (row : Word × String)
    (observed : row ∈ traversal e compatible coarse) :
    row ∉ e.terminal.branches.filter coarse := by
  intro h
  have no := ((traversalExactly e compatible coarse row).mp observed).2.2
  have yes := ((filterMemberIff _ _ _).mp h).2
  rw [no] at yes
  cases yes

theorem completeSupportDoesNotDeletePath {p : QuantumPhysicalState.Prepared} (e : Evolution p)
    (compatible coarse : Word × String → Bool) (row : Word × String)
    (held : row ∈ e.terminal.branches) (phase : compatible row = true) (closed : coarse row = false) :
    row ∈ traversal e compatible coarse := (traversalExactly e compatible coarse row).mpr ⟨held,phase,closed⟩

theorem fullUnderlyingEvolutionReversible {p : QuantumPhysicalState.Prepared} (e : Evolution p) :
    SFT.QuantumComputation.ReversibleExecution.Backward e.terminal
      (SFT.QuantumComputation.ReversibleExecution.reverseOrder e.gates) p.state := exactlyReversible e

def record {p : QuantumPhysicalState.Prepared} (e : Evolution p)
    (compatible coarse : Word × String → Bool) :=
  (QuantumPhysicalEvolution.record e,traversal e compatible coarse)

theorem preparationAndAllPathsRetained {p : QuantumPhysicalState.Prepared} (e : Evolution p)
    (compatible coarse : Word × String → Bool) :
    (record e compatible coarse).1.1 = p ∧
      (record e compatible coarse).1.2.2.1 = e.predecessors := ⟨rfl,rfl⟩
end SFT.Physics.QuantumPhysicalTunnelling
