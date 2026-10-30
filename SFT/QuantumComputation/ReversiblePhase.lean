import SFT.QuantumComputation.ReversibleModel
import SFT.Foundation.ExactValueIdentity
namespace SFT.QuantumComputation.ReversiblePhase
open SFT.Foundation.ExactValueIdentity

theorem subtractPrefix (part rest : Nat) : (part+rest)-part = rest := by
  induction part with
  | zero => rw [Nat.zero_add]; rfl
  | succ part ih => rw [Nat.succ_add,Nat.succ_sub_succ_eq_sub]; exact ih

theorem subtractFromSum (n d k : Nat) (bound : d ≤ n) : (n+k)-d = (n-d)+k := by
  induction d generalizing n with
  | zero => rfl
  | succ d ih =>
    cases n with
    | zero => exact False.elim (Nat.not_succ_le_zero d bound)
    | succ n => rw [Nat.succ_add,Nat.succ_sub_succ_eq_sub,Nat.succ_sub_succ_eq_sub]; exact ih n (Nat.le_of_succ_le_succ bound)

theorem restoreDifference (a b : Nat) (bound : a ≤ b) : a+(b-a) = b := by
  induction a generalizing b with
  | zero => rw [Nat.zero_add]; rfl
  | succ a ih =>
    cases b with
    | zero => exact False.elim (Nat.not_succ_le_zero a bound)
    | succ b =>
      rw [Nat.succ_sub_succ_eq_sub]
      rw [Nat.succ_add]
      exact congrArg Nat.succ (ih b (Nat.le_of_succ_le_succ bound))

theorem remainderBeforeAddition (n k d : Nat) (positive : 0 < d) :
    (n%d+k)%d = (n+k)%d := by
  induction n using Nat.strongRecOn with
  | ind n ih =>
    by_cases bound : d ≤ n
    · have smaller := Nat.sub_lt (Nat.lt_of_lt_of_le positive bound) positive
      rw [moduloRemoves n d positive bound]
      rw [ih (n-d) smaller]
      have sumBound : d ≤ n+k := Nat.le_trans bound (Nat.le_add_right n k)
      rw [moduloRemoves (n+k) d positive sumBound,subtractFromSum n d k bound]
    · rw [moduloBelow n d positive (Nat.lt_of_not_ge bound)]

theorem fullCycleReturns (index d : Nat) (positive : 0 < d) (bound : index < d) :
    (index+d)%d = index := by
  rw [Nat.add_comm index d,moduloRemoves (d+index) d positive (Nat.le_add_right d index),
    subtractPrefix,moduloBelow index d positive bound]

def inverseShift (shift d : Nat) : Nat := if shift = 0 then 0 else d-shift

theorem inverseIndex (index shift d : Nat) (positive : 0 < d)
    (indexBound : index < d) (shiftBound : shift < d) :
    ((index+shift)%d+inverseShift shift d)%d = index := by
  unfold inverseShift
  by_cases zero : shift = 0
  · rw [ite_eq_left zero,zero]
    change (index%d)%d = index
    rw [moduloBelow index d positive indexBound,moduloBelow index d positive indexBound]
  · rw [ite_eq_right zero,remainderBeforeAddition _ _ d positive,Nat.add_assoc,
      restoreDifference shift d (Nat.le_of_lt shiftBound)]
    exact fullCycleReturns index d positive indexBound

open SFT.QuantumComputation.ReversibleModel SFT.Mathematics.DiscreteObjects

theorem selectedLabelMember (cycle : List String) (index : Nat) (phase : String)
    (selected : labelAt cycle index = some phase) : phase ∈ cycle := by
  induction cycle generalizing index with
  | nil => cases selected
  | cons first rest ih =>
    cases index with
    | zero => cases selected; exact .head _
    | succ index => exact .tail _ (ih index selected)

theorem selectedIndexBound (cycle : List String) (index : Nat) (phase : String)
    (selected : labelAt cycle index = some phase) : index < cycle.length := by
  induction cycle generalizing index with
  | nil => cases selected
  | cons first rest ih =>
    cases index with
    | zero => exact Nat.zero_lt_succ _
    | succ index => exact Nat.succ_lt_succ (ih index selected)

theorem indexOfSelected (cycle : List String) (unique : distinct cycle = true)
    (index : Nat) (phase : String) (selected : labelAt cycle index = some phase) :
    phaseIndex phase cycle = some index := by
  induction cycle generalizing index with
  | nil => cases selected
  | cons first rest ih =>
    have parts := (distinctCons _ _).mp unique
    cases index with
    | zero =>
      cases selected
      unfold phaseIndex
      rw [ite_eq_left rfl]
    | succ index =>
      have member := selectedLabelMember rest index phase selected
      have different : first ≠ phase := by
        intro eq
        cases eq
        exact (absentIff _ _).mp parts.1 member
      have found := ih parts.2 index selected
      unfold phaseIndex
      rw [ite_eq_right different,found]
      rfl

theorem phaseInverse (cycle : List String) (unique : distinct cycle = true)
    (positive : 0 < cycle.length) (phase shifted : String) (amount : Nat)
    (held : phase ∈ cycle) (amountBound : amount < cycle.length)
    (forward : shiftPhase cycle amount phase = some shifted) :
    shiftPhase cycle (inverseShift amount cycle.length) shifted = some phase := by
  obtain ⟨index,found⟩ := phaseIndexExists cycle phase held
  have original := indexReconstructs cycle phase index found
  have bound := selectedIndexBound cycle index phase original
  unfold shiftPhase at forward
  rw [found] at forward
  have newIndex := indexOfSelected cycle unique ((index+amount)%cycle.length) shifted forward
  unfold shiftPhase
  rw [newIndex]
  dsimp only
  rw [inverseIndex index amount cycle.length positive bound amountBound]
  exact original

theorem branchPhaseInverse (cycle : List String) (unique : distinct cycle = true)
    (positive : 0 < cycle.length) (amount : Nat) (amountBound : amount < cycle.length)
    (branches shifted : List (Word × String))
    (held : ∀ row, row ∈ branches → row.2 ∈ cycle)
    (forward : shiftBranches cycle amount branches = some shifted) :
    shiftBranches cycle (inverseShift amount cycle.length) shifted = some branches := by
  induction branches generalizing shifted with
  | nil => cases forward; rfl
  | cons row rest ih =>
    obtain ⟨word,phase⟩ := row
    unfold shiftBranches at forward
    cases p : shiftPhase cycle amount phase with
    | none => rw [p] at forward; cases forward
    | some result =>
      rw [p] at forward
      cases t : shiftBranches cycle amount rest with
      | none => rw [t] at forward; cases forward
      | some tail =>
        rw [t] at forward
        cases forward
        have restored := phaseInverse cycle unique positive phase result amount (held _ (.head _)) amountBound p
        have restRestored := ih tail (fun row member => held row (.tail _ member)) t
        unfold shiftBranches
        rw [restored,restRestored]

end SFT.QuantumComputation.ReversiblePhase
