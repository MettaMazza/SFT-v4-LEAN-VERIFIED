import SFT.Physics.QuantumPhysicalTunnelling
namespace SFT.Physics.QuantumPhysicalSpectra
open SFT.QuantumComputation.ReversibleModel SFT.Mathematics.DiscreteObjects

def closes (p : QuantumPhysicalState.Prepared) (trace : List String) : Bool :=
  match phaseAction p.state trace with
  | .error _ => false
  | .ok result => decide (result.branches = p.state.branches) &&
      decide (result.phaseCycle = p.state.phaseCycle)

theorem closureExactly (p : QuantumPhysicalState.Prepared) (trace : List String) :
    closes p trace = true ↔ phaseAction p.state trace = .ok p.state := by
  unfold closes
  cases h : phaseAction p.state trace with
  | error message => constructor <;> intro impossible <;> cases impossible
  | ok result =>
    constructor
    · intro yes
      obtain ⟨branches,cycle⟩ := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp yes
      have hb := of_decide_eq_true branches
      have hc := of_decide_eq_true cycle
      have same : result = p.state := by
        exact (congrArg (fun b => State.mk b result.phaseCycle) hb).trans (congrArg (State.mk p.state.branches) hc)
      exact congrArg Except.ok same
    · intro same
      have eq := Except.ok.inj same
      cases eq
      change (decide (p.state.branches = p.state.branches) && decide (p.state.phaseCycle = p.state.phaseCycle)) = true
      rw [decide_eq_true (rfl : p.state.branches = p.state.branches),
        decide_eq_true (rfl : p.state.phaseCycle = p.state.phaseCycle)]
      rfl

-- All generated boundary traces are checked; no continuum or selected subset is introduced.
def spectrum (p : QuantumPhysicalState.Prepared) (generated : List (List String)) := generated.filter (closes p)

theorem generatedSpectrumExactly (p : QuantumPhysicalState.Prepared)
    (generated : List (List String)) (trace : List String) : trace ∈ spectrum p generated ↔
      trace ∈ generated ∧ phaseAction p.state trace = .ok p.state := by
  constructor
  · intro h
    have pair := (filterMemberIff _ _ _).mp h
    exact ⟨pair.1,(closureExactly p trace).mp pair.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(closureExactly p trace).mpr h.2⟩

theorem fullRecurrenceAdmitted (p : QuantumPhysicalState.Prepared)
    (generated : List (List String)) (trace : List String) (held : trace ∈ generated)
    (period : trace.length = p.state.phaseCycle.length) : trace ∈ spectrum p generated :=
  (generatedSpectrumExactly p generated trace).mpr
    ⟨held,QuantumPhysicalSpin.fullOrientationRecurrenceReturns p trace period⟩

theorem emptyTraceExcluded (p : QuantumPhysicalState.Prepared) (generated : List (List String)) :
    [] ∉ spectrum p generated := by
  intro h
  have impossible := ((generatedSpectrumExactly p generated []).mp h).2
  rw [emptyPhaseTraceRejected] at impossible
  cases impossible

structure Transition (p : QuantumPhysicalState.Prepared) (generated : List (List String)) where
  initial : List String
  terminal : List String
  initialHeld : initial ∈ spectrum p generated
  terminalHeld : terminal ∈ spectrum p generated
  distinction : initial ≠ terminal

theorem transitionBetweenClosedClasses {p : QuantumPhysicalState.Prepared}
    {generated : List (List String)} (t : Transition p generated) :
    phaseAction p.state t.initial = .ok p.state ∧ phaseAction p.state t.terminal = .ok p.state :=
  ⟨((generatedSpectrumExactly p generated t.initial).mp t.initialHeld).2,
   ((generatedSpectrumExactly p generated t.terminal).mp t.terminalHeld).2⟩

def record {p : QuantumPhysicalState.Prepared} {generated : List (List String)}
    (t : Transition p generated) := (p,generated,t.initial,t.terminal)

theorem transitionRetainsPreparationAndBoundary {p : QuantumPhysicalState.Prepared}
    {generated : List (List String)} (t : Transition p generated) :
    (record t).1 = p ∧ (record t).2.1 = generated := ⟨rfl,rfl⟩
end SFT.Physics.QuantumPhysicalSpectra
