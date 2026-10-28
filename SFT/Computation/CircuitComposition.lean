import SFT.Mathematics.CategoryPaths
import SFT.Computation.StateExtension
namespace SFT.Computation.CircuitComposition
open SFT.Mathematics.CategoryPaths

-- Typed retained composition records from the Circuit topic's exact interface
-- and evaluation-trace clauses, using its admitted Category dependency.
-- This relation is not an additional executable operation attributed to V3.
inductive Evaluation : Arrow → List Arrow → Arrow → Prop
 | identity (current) : Evaluation current [] current
 | next (current component combined : Arrow) (rest : List Arrow) (result : Arrow)
     (edge : compose current component = .ok combined)
     (later : Evaluation combined rest result) :
     Evaluation current (component :: rest) result

def localTraces : List Arrow → List String
 | [] => []
 | component :: rest => component.trace ++ localTraces rest

theorem traceAppend (left right : List Arrow) :
    localTraces (left ++ right) = localTraces left ++ localTraces right := by
  induction left with
  | nil => rfl
  | cons component rest ih =>
    change component.trace ++ localTraces (rest ++ right) = _
    rw [ih]
    exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _).symm

theorem completeTrace (initial result : Arrow) (locals : List Arrow)
    (evaluation : Evaluation initial locals result) :
    result.trace = initial.trace ++ localTraces locals := by
  induction evaluation with
  | identity current =>
    change current.trace = current.trace ++ []
    induction current.trace with
    | nil => rfl
    | cons row rest ih => exact congrArg (List.cons row) ih
  | next current component combined rest result edge later ih =>
    rw [ih,(composeRetains _ _ _ edge).2.2]
    exact SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _

theorem sourceRetained (initial result : Arrow) (locals : List Arrow)
    (evaluation : Evaluation initial locals result) : result.source = initial.source := by
  induction evaluation with
  | identity => rfl
  | next current component combined rest result edge later ih =>
    exact ih.trans (composeRetains _ _ _ edge).1

theorem exactFirstInterface (initial component result : Arrow) (rest : List Arrow)
    (evaluation : Evaluation initial (component :: rest) result) :
    initial.target = component.source := by
  cases evaluation with
  | next current component combined rest result edge later => exact (composeResult _ _ _ edge).1

theorem interfaceMismatchExcluded (initial component result : Arrow) (rest : List Arrow)
    (mismatch : initial.target ≠ component.source) : ¬ Evaluation initial (component :: rest) result :=
  fun h => mismatch (exactFirstInterface _ _ _ _ h)

theorem serial (initial middle result : Arrow) (left right : List Arrow)
    (first : Evaluation initial left middle) (second : Evaluation middle right result) :
    Evaluation initial (left ++ right) result := by
  induction first with
  | identity => exact second
  | next current component combined rest middle edge later ih =>
    exact .next current component combined (rest ++ right) result edge (ih second)

theorem successor (initial terminal component result : Arrow) (locals : List Arrow)
    (prior : Evaluation initial locals terminal)
    (edge : compose terminal component = .ok result) :
    Evaluation initial (locals ++ [component]) result :=
  serial _ _ _ _ _ prior (.next terminal component result [] result edge (.identity result))

theorem earlierRowsRetained (initial result : Arrow) (locals : List Arrow)
    (evaluation : Evaluation initial locals result) (row : String)
    (member : row ∈ initial.trace) : row ∈ result.trace := by
  rw [completeTrace _ _ _ evaluation]
  exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ member

end SFT.Computation.CircuitComposition
