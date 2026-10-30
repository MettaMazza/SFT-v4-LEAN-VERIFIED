import SFT.QuantumComputation.ReversiblePhase
import SFT.QuantumComputation.ReversibleObservation
namespace SFT.QuantumComputation.PhaseInterference
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversiblePhase

theorem zeroShift (cycle : List String) (phase : String) (held : phase ∈ cycle) :
    shiftPhase cycle 0 phase = some phase := by
  obtain ⟨index,found⟩ := phaseIndexExists cycle phase held
  have original := indexReconstructs cycle phase index found
  have bound := selectedIndexBound cycle index phase original
  unfold shiftPhase
  rw [found]
  change labelAt cycle (index % cycle.length) = some phase
  rw [SFT.Foundation.ExactValueIdentity.moduloBelow _ _ (Nat.lt_of_le_of_lt (Nat.zero_le _) bound) bound]
  exact original

theorem zeroShiftBranches (cycle : List String) (branches : List (Word × String))
    (held : ∀ row, row ∈ branches → row.2 ∈ cycle) : shiftBranches cycle 0 branches = some branches := by
  induction branches with
  | nil => rfl
  | cons branch rest ih =>
    obtain ⟨word,phase⟩ := branch
    rw [shiftBranches,zeroShift cycle phase (held _ (.head _)),ih (fun row member => held row (.tail _ member))]

theorem exactPhasePeriod (state : State) (steps : List String)
    (admitted : makeState state.branches state.phaseCycle = .ok state)
    (period : steps.length = state.phaseCycle.length) : phaseAction state steps = .ok state := by
  have positive : 0 < state.phaseCycle.length :=
    Nat.lt_of_lt_of_le (by decide : 0 < 2) (admittedPhaseCycle state admitted).2.2
  have nonempty : steps.isEmpty = false := by
    cases steps with
    | nil => exact False.elim (Nat.ne_of_gt positive period.symm)
    | cons first rest => rfl
  have modulus : state.phaseCycle.length % state.phaseCycle.length = 0 := by
    have result := fullCycleReturns 0 state.phaseCycle.length positive positive
    rw [Nat.zero_add] at result
    exact result
  unfold phaseAction
  rw [nonempty,period,modulus,zeroShiftBranches state.phaseCycle state.branches (admittedPhaseMember state admitted)]
  exact admitted
open SFT.QuantumComputation.ReversibleObservation
open SFT.InformationScience.EncodingMaps

theorem predecessorFibreExactly (state : State) (mapping : Classification)
    (groups : List (String × List (Word × String))) (accepted : predecessorMerge state mapping = .ok groups)
    (label : String) (rows : List (Word × String)) (group : (label,rows) ∈ groups) (branch : Word × String) :
    branch ∈ rows ↔ branch ∈ state.branches ∧ lookupFirst mapping branch.1 = some label := by
  obtain ⟨record,generated,equal⟩ := predecessorSource state mapping groups accepted
  rw [equal] at group
  have shape := (groupedMembership record label rows).mp group
  rw [shape.2]
  exact (retainedExactly record label branch).trans (recordMembership mapping state.branches record generated branch label)

theorem sameImageRetainsBoth (state : State) (mapping : Classification)
    (groups : List (String × List (Word × String))) (accepted : predecessorMerge state mapping = .ok groups)
    (left right : Word × String) (label : String)
    (leftHeld : left ∈ state.branches) (rightHeld : right ∈ state.branches)
    (leftImage : lookupFirst mapping left.1 = some label) (rightImage : lookupFirst mapping right.1 = some label) :
    ∃ rows, (label,rows) ∈ groups ∧ left ∈ rows ∧ right ∈ rows := by
  obtain ⟨rows,group,held⟩ := predecessorRecordPreserved state mapping groups accepted left leftHeld label leftImage
  exact ⟨rows,group,held,(predecessorFibreExactly state mapping groups accepted label rows group right).mpr ⟨rightHeld,rightImage⟩⟩

theorem phaseActionSource (state result : State) (steps : List String)
    (accepted : phaseAction state steps = .ok result) :
    result.phaseCycle = state.phaseCycle ∧
    shiftBranches state.phaseCycle (steps.length % state.phaseCycle.length) state.branches = some result.branches := by
  unfold phaseAction at accepted
  split at accepted
  · cases accepted
  · cases shifted : shiftBranches state.phaseCycle (steps.length % state.phaseCycle.length) state.branches with
    | none => rw [shifted] at accepted; cases accepted
    | some branches =>
      rw [shifted] at accepted
      have exactState := makeStateSource _ _ _ accepted
      cases exactState
      exact ⟨rfl,rfl⟩

theorem phaseActionInverse (state result : State) (steps reverseSteps : List String)
    (admitted : makeState state.branches state.phaseCycle = .ok state)
    (forward : phaseAction state steps = .ok result)
    (nonempty : reverseSteps.isEmpty = false)
    (inverseAmount : reverseSteps.length % state.phaseCycle.length =
      inverseShift (steps.length % state.phaseCycle.length) state.phaseCycle.length) :
    phaseAction result reverseSteps = .ok state := by
  have source := phaseActionSource state result steps forward
  have cycle := admittedPhaseCycle state admitted
  have positive : 0 < state.phaseCycle.length := Nat.lt_of_lt_of_le (by decide : 0 < 2) cycle.2.2
  have restored := branchPhaseInverse state.phaseCycle cycle.2.1 positive
    (steps.length % state.phaseCycle.length) (Nat.mod_lt _ positive) state.branches result.branches
    (admittedPhaseMember state admitted) source.2
  unfold phaseAction
  rw [nonempty,source.1,inverseAmount,restored]
  exact admitted

end SFT.QuantumComputation.PhaseInterference
