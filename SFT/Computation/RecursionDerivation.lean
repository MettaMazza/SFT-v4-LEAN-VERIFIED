import SFT.Computation.RewritingClasses
namespace SFT.Computation.RecursionDerivation
open SFT.Mathematics.DiscreteObjects
abbrev Value := List String
abbrev Step := Value → String → Value

def values (step : Step) (base : Value) : List String → List Value
 | [] => [base]
 | position::positions => base :: values step (step base position) positions

def terminal (step : Step) (base : Value) : List String → Value
 | [] => base
 | position::positions => terminal step (step base position) positions

def structuralRecursion (base : Value) (positions : List String) (step : Step) : Except String (List Value) :=
  if !distinct positions then .error "ValueError: successor trace must contain unique generated identities"
  else .ok (values step base positions)

theorem recursionMeaning (base : Value) (positions : List String) (step : Step) (trace : List Value) :
    structuralRecursion base positions step = .ok trace ↔ distinct positions = true ∧ trace = values step base positions := by
  unfold structuralRecursion
  cases h : distinct positions with
  | false => constructor
             · intro bad; cases bad
             · intro bad; cases bad.1
  | true => constructor
            · intro eq; cases eq; exact ⟨rfl,rfl⟩
            · intro eq; rw [eq.2]; rfl

theorem recursionBase (base : Value) (step : Step) : structuralRecursion base [] step = .ok [base] := rfl

theorem valuesLength (step : Step) (base : Value) (positions : List String) :
    (values step base positions).length = positions.length + 1 := by
  induction positions generalizing base with
  | nil => rfl
  | cons position positions ih => exact congrArg Nat.succ (ih (step base position))

theorem valuesInitial (step : Step) (base : Value) (positions : List String) :
    (values step base positions).head? = some base := by
  cases positions <;> rfl

-- Every generated successor retains its exact intermediate value.
inductive Derivation (step : Step) : Value → List String → List Value → Prop
 | base (value) : Derivation step value [] [value]
 | next (value position positions trace) (rest : Derivation step (step value position) positions trace) :
     Derivation step value (position::positions) (value::trace)

theorem valuesDerivation (step : Step) (base : Value) (positions : List String) :
    Derivation step base positions (values step base positions) := by
  induction positions generalizing base with
  | nil => exact .base base
  | cons position positions ih => exact .next _ _ _ _ (ih _)

theorem derivationUnique (step : Step) (base : Value) (positions : List String) (trace : List Value)
    (h : Derivation step base positions trace) : trace = values step base positions := by
  induction h with
  | base => rfl
  | next value position positions trace rest ih => exact congrArg (List.cons value) ih

theorem recursionDerivation (base : Value) (positions : List String) (step : Step) (trace : List Value) :
    structuralRecursion base positions step = .ok trace ↔ distinct positions = true ∧ Derivation step base positions trace := by
  constructor
  · intro h
    have p := (recursionMeaning _ _ _ _).mp h
    exact ⟨p.1,p.2 ▸ valuesDerivation step base positions⟩
  · intro h
    exact (recursionMeaning _ _ _ _).mpr ⟨h.1,derivationUnique _ _ _ _ h.2⟩

def predecessors (step : Step) (base : Value) : List String → List Value
 | [] => []
 | position::positions => base :: predecessors step (step base position) positions

theorem valuesTerminal (step : Step) (base : Value) (positions : List String) :
    values step base positions = predecessors step base positions ++ [terminal step base positions] := by
  induction positions generalizing base with
  | nil => rfl
  | cons position positions ih => exact congrArg (List.cons base) (ih _)

theorem terminalComposition (step : Step) (base : Value) (left right : List String) :
    terminal step base (left++right) = terminal step (terminal step base left) right := by
  induction left generalizing base with
  | nil => rfl
  | cons position positions ih => exact ih _

theorem valuesComposition (step : Step) (base : Value) (left right : List String) :
    values step base (left++right) = predecessors step base left ++ values step (terminal step base left) right := by
  induction left generalizing base with
  | nil => rfl
  | cons position positions ih => exact congrArg (List.cons base) (ih _)

theorem valuesSuccessor (step : Step) (base : Value) (positions : List String) (position : String) :
    values step base (positions++[position]) = values step base positions ++ [step (terminal step base positions) position] := by
  induction positions generalizing base with
  | nil => rfl
  | cons head positions ih => exact congrArg (List.cons base) (ih _)

theorem terminalSuccessor (step : Step) (base : Value) (positions : List String) (position : String) :
    terminal step base (positions++[position]) = step (terminal step base positions) position := by
  exact terminalComposition _ _ _ _

theorem recursionSuccessor (step : Step) (base : Value) (positions : List String) (position : String)
    (admitted : distinct (positions++[position]) = true) :
    structuralRecursion base (positions++[position]) step =
      .ok (values step base positions ++ [step (terminal step base positions) position]) := by
  apply (recursionMeaning _ _ _ _).mpr
  exact ⟨admitted,(valuesSuccessor _ _ _ _).symm⟩

theorem recursionComposition (step : Step) (base : Value) (left right : List String)
    (admitted : distinct (left++right) = true) :
    structuralRecursion base (left++right) step =
      .ok (predecessors step base left ++ values step (terminal step base left) right) := by
  exact (recursionMeaning _ _ _ _).mpr ⟨admitted,(valuesComposition _ _ _ _).symm⟩

theorem stepRelation (step : Step) (base : Value) (positions : List String) :
    ∀ position value, (position,value) ∈ positions.zip (predecessors step base positions) →
      step value position ∈ values step base positions := by
  induction positions generalizing base with
  | nil => intro position value h; cases h
  | cons head positions ih =>
    intro position value h
    cases h with
    | head =>
      have start : step base head ∈ values step (step base head) positions := by
        cases positions <;> exact .head _
      exact .tail _ start
    | tail _ hm => exact .tail _ (ih _ _ _ hm)

end SFT.Computation.RecursionDerivation
