import SFT.Computation.TraversalTrace
import SFT.Mathematics.AlgebraTableCoverage
import SFT.Mathematics.GeometryDimension
namespace SFT.Computation.AlgebraGeometryTrace
open SFT.Mathematics AlgebraOperations DiscreteObjects GeometryTopology

abbrev Row := String × String × String

def run (table : OperationTable) (initial : String) : List String → Except String (List Row × String)
 | [] => .ok ([],initial)
 | right :: rest => match applyOperation table initial right with
   | .error reason => .error reason
   | .ok next => match run table next rest with
     | .error reason => .error reason
     | .ok (rows,terminal) => .ok ((initial,right,next) :: rows,terminal)

inductive Execution (table : OperationTable) : String → List String → List Row → String → Prop where
 | base (initial) : Execution table initial [] [] initial
 | next (initial right next terminal rest rows)
     (step : applyOperation table initial right = .ok next)
     (tail : Execution table next rest rows terminal) :
     Execution table initial (right :: rest) ((initial,right,next) :: rows) terminal

theorem executionReplays (table : OperationTable) (initial terminal : String) (inputs : List String) (rows : List Row)
    (trace : Execution table initial inputs rows terminal) : run table initial inputs = .ok (rows,terminal) := by
  induction trace with
  | base => rfl
  | next initial right next terminal rest rows step tail ih =>
    unfold run; rw [step]; dsimp only; rw [ih]

theorem closedExecution (carrier : List String) (tableRows : List Row) (table : OperationTable)
    (accepted : makeTable carrier tableRows = .ok table) (initial : String) (inputs : List String)
    (held : initial ∈ carrier) (covered : ∀ item, item ∈ inputs → item ∈ carrier) :
    ∃ rows terminal, Execution table initial inputs rows terminal ∧ terminal ∈ carrier ∧
      ∀ row, row ∈ rows → row.1 ∈ carrier ∧ row.2.1 ∈ carrier ∧ row.2.2 ∈ carrier := by
  induction inputs generalizing initial with
  | nil => exact ⟨[],initial,.base _,held,fun row impossible => by cases impossible⟩
  | cons right rest ih =>
    have rightHeld := covered right (.head _)
    obtain ⟨next,step,nextHeld⟩ := acceptedLookupTotal _ _ _ accepted _ _ held rightHeld
    obtain ⟨rows,terminal,tail,terminalHeld,rowsHeld⟩ := ih next nextHeld (fun item member => covered item (.tail right member))
    refine ⟨(initial,right,next) :: rows,terminal,.next _ _ _ _ _ _ step tail,terminalHeld,?_⟩
    intro row member
    cases member with
    | head => exact ⟨held,rightHeld,nextHeld⟩
    | tail _ member => exact rowsHeld row member

theorem traceLength (table : OperationTable) (initial terminal : String) (inputs : List String) (rows : List Row)
    (trace : Execution table initial inputs rows terminal) : rows.length = inputs.length := by
  induction trace with
  | base => rfl
  | next initial right next terminal rest rows step tail ih => exact congrArg Nat.succ ih

theorem traceInputOrder (table : OperationTable) (initial terminal : String) (inputs : List String) (rows : List Row)
    (trace : Execution table initial inputs rows terminal) : rows.map (fun row => row.2.1) = inputs := by
  induction trace with
  | base => rfl
  | next initial right next terminal rest rows step tail ih => exact congrArg (List.cons right) ih

theorem operationRowsReplay (table : OperationTable) (initial terminal : String) (inputs : List String) (rows : List Row)
    (trace : Execution table initial inputs rows terminal) :
    ∀ row, row ∈ rows → applyOperation table row.1 row.2.1 = .ok row.2.2 := by
  induction trace with
  | base => intro row impossible; cases impossible
  | next initial right next terminal rest rows step tail ih =>
    intro row member
    cases member with
    | head => exact step
    | tail _ member => exact ih row member

theorem composition (table : OperationTable) (initial middle terminal : String)
    (first second : List String) (left right : List Row)
    (one : Execution table initial first left middle) (two : Execution table middle second right terminal) :
    Execution table initial (first ++ second) (left ++ right) terminal := by
  induction one with
  | base => exact two
  | next initial value next middle rest rows step tail ih => exact .next _ _ _ _ _ _ step (ih two)

theorem successor (table : OperationTable) (initial current next right : String)
    (inputs : List String) (rows : List Row) (trace : Execution table initial inputs rows current)
    (step : applyOperation table current right = .ok next) :
    Execution table initial (inputs ++ [right]) (rows ++ [(current,right,next)]) next :=
  composition _ _ _ _ _ _ _ _ trace (.next _ _ _ _ _ _ step (.base next))

theorem rejectedStep (table : OperationTable) (initial right : String) (rest : List String) (reason : String)
    (failed : applyOperation table initial right = .error reason) :
    run table initial (right :: rest) = .error reason := by
  unfold run; rw [failed]

theorem exactIncidenceCoordinate (boundary : Boundary) (cell face : String) :
    face ∈ faces boundary cell ↔ (face,cell) ∈ boundary := by
  constructor
  · intro held
    obtain ⟨edge,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage Prod.fst _ _ held
    have parts := (filterMemberIff _ _ _).mp member
    have second := of_decide_eq_true parts.2
    cases edge with
    | mk a b => dsimp only at same second; cases same; cases second; exact parts.1
  · intro held
    exact SFT.Foundation.Count.TraceDerivation.memMap Prod.fst (face,cell) _
      ((filterMemberIff _ _ _).mpr ⟨held,decide_eq_true rfl⟩)

theorem finiteDimensionCertificate (cells : List String) (boundary : Boundary) (cell : String) (height : Nat)
    (admitted : (incidenceWellFormed cells boundary && has cells cell) = true) :
    cellDimension cells boundary cell = .ok height ↔ DepthDerivation boundary [] cell height :=
  dimensionIffDerivation _ _ _ _ admitted

theorem identityBase (table : OperationTable) (initial : String) : Execution table initial [] [] initial := .base _

end SFT.Computation.AlgebraGeometryTrace
