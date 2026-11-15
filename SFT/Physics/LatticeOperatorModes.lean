import SFT.Physics.LatticeOperator
namespace SFT.Physics.LatticeOperatorModes
open LatticeOperator SFT.Foundation.Count.TraceDerivation
private theorem rangeLoopMember (n i : Nat) (acc : List Nat) :
 i∈List.range.loop n acc ↔ i<n ∨ i∈acc := by
 induction n generalizing acc with
 | zero =>
  constructor
  · intro h; exact Or.inr h
  · intro h; cases h with
    | inl h => exact False.elim (Nat.not_lt_zero _ h)
    | inr h => exact h
 | succ n ih =>
  change i∈List.range.loop n (n::acc) ↔ _
  constructor
  · intro h
    cases (ih (n::acc)).mp h with
    | inl h => exact Or.inl (Nat.lt_succ_of_lt h)
    | inr h =>
     cases h with
     | head => exact Or.inl (Nat.lt_succ_self _)
     | tail _ h => exact Or.inr h
  · intro h
    apply (ih (n::acc)).mpr
    cases h with
    | inr h => exact Or.inr (List.Mem.tail _ h)
    | inl h =>
     cases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ h) with
     | inl h => exact Or.inl h
     | inr h => cases h; exact Or.inr (List.Mem.head _)

theorem originalModeCoverage (n : Nat) (m : PhaseModeCarrier) :
 m∈modeCarriers n ↔ ∃ i, i<n ∧ mode n (i+1)=m := by
 constructor
 · intro h
   obtain ⟨i,hi,eq⟩ := memMapPreimage _ _ _ h
   cases (rangeLoopMember n i []).mp hi with
   | inl hi => exact ⟨i,hi,eq⟩
   | inr hi => cases hi
 · intro h
   obtain ⟨i,hi,eq⟩ := h
   cases eq
   exact memMap _ i _ ((rangeLoopMember n i []).mpr (Or.inl hi))

theorem originalUniqueIdentity (n : Nat) (m : PhaseModeCarrier)
 (held : m∈modeCarriers n) : m.identityPhase=true ↔ m=mode n n := by
 obtain ⟨i,hi,eq⟩ := (originalModeCoverage n m).mp held
 cases eq
 constructor
 · intro h
   have e : i+1=n := Nat.eq_of_beq_eq_true h
   exact congrArg (mode n) e
 · intro h
   have e : i+1=n := congrArg PhaseModeCarrier.index h
   change (i+1==n)=true
   rw [e]
   exact SFT.Foundation.CommonRefinement.naturalEqualityReflexive n

theorem originalIdentityPresent (n : Nat) (hn : 0<n) : mode n n∈modeCarriers n := by
 cases n with
 | zero => cases hn
 | succ k =>
  exact (originalModeCoverage (k+1) (mode (k+1) (k+1))).mpr ⟨k,Nat.lt_succ_self k,rfl⟩

theorem originalPhaseLabelsDistinct (n i j : Nat)
 (same : mode n i=mode n j) : i=j := congrArg PhaseModeCarrier.index same
end SFT.Physics.LatticeOperatorModes
