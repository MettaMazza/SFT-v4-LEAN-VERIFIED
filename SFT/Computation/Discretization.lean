import SFT.Computation.RepresentationLearning
namespace SFT.Computation.Discretization
open SFT.InformationScience.EncodingClasses SFT.InformationScience.EncodingMaps

structure Model where
  source : List String
  cells : List Codeword
  coverage : Encoding
  relation : List (String × String)
  admission : validateEncoding source cells coverage = true
  relationHeld : ∀ edge, edge ∈ relation → edge.1 ∈ source ∧ edge.2 ∈ source

structure OperatorRow where
  sourceEdge : String × String
  sourceCell : Codeword
  targetCell : Codeword

def localOperator (coverage : Encoding) (edge : String × String) : Option OperatorRow :=
  match lookupFirst coverage edge.1 with
  | none => none
  | some a => match lookupFirst coverage edge.2 with
    | none => none
    | some b => some ⟨edge,a,b⟩

def operators (coverage : Encoding) : List (String × String) → Option (List OperatorRow)
  | [] => some []
  | edge::rest => match localOperator coverage edge with
    | none => none
    | some row => match operators coverage rest with
      | none => none
      | some rows => some (row::rows)

theorem localReconstruction (coverage : Encoding) (edge : String × String) (row : OperatorRow)
    (accepted : localOperator coverage edge = some row) :
    row.sourceEdge = edge ∧ lookupFirst coverage edge.1 = some row.sourceCell ∧
      lookupFirst coverage edge.2 = some row.targetCell := by
  unfold localOperator at accepted
  cases a : lookupFirst coverage edge.1 with
  | none => rw [a] at accepted; cases accepted
  | some left =>
    rw [a] at accepted
    cases b : lookupFirst coverage edge.2 with
    | none => rw [b] at accepted; cases accepted
    | some right =>
      rw [b] at accepted
      cases accepted
      exact ⟨rfl,rfl,rfl⟩

theorem completeSourceRelation (coverage : Encoding) (edges : List (String × String))
    (rows : List OperatorRow) (accepted : operators coverage edges = some rows) :
    rows.map OperatorRow.sourceEdge = edges := by
  induction edges generalizing rows with
  | nil => cases accepted; rfl
  | cons edge rest ih =>
    unfold operators at accepted
    cases a : localOperator coverage edge with
    | none => rw [a] at accepted; cases accepted
    | some row =>
      rw [a] at accepted
      cases b : operators coverage rest with
      | none => rw [b] at accepted; cases accepted
      | some tail =>
        rw [b] at accepted
        cases accepted
        change row.sourceEdge :: tail.map OperatorRow.sourceEdge = edge::rest
        rw [(localReconstruction _ _ _ a).1,ih _ b]

theorem exactLocalOperator (coverage : Encoding) (edge : String × String) (a b : Codeword)
    (left : lookupFirst coverage edge.1 = some a) (right : lookupFirst coverage edge.2 = some b) :
    localOperator coverage edge = some ⟨edge,a,b⟩ := by
  unfold localOperator
  rw [left,right]

theorem missingSourceRejected (coverage : Encoding) (edge : String × String)
    (missing : lookupFirst coverage edge.1 = none) : localOperator coverage edge = none := by
  unfold localOperator
  rw [missing]

theorem retainedOperator (first second : Encoding) (edge : String × String) (row : OperatorRow)
    (accepted : localOperator first edge = some row)
    (retain : ∀ source cell, lookupFirst first source = some cell → lookupFirst second source = some cell) :
    localOperator second edge = some row := by
  obtain ⟨same,left,right⟩ := localReconstruction _ _ _ accepted
  have result := exactLocalOperator second edge row.sourceCell row.targetCell
    (retain _ _ left) (retain _ _ right)
  cases row with
  | mk old a b =>
    dsimp at same result
    cases same
    exact result

open SFT.Mathematics.DiscreteObjects SFT.InformationScience.EncodingLoss SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

theorem completeCoverage (m : Model) (item : String) (held : item ∈ m.source) :
    ∃ cell, lookupFirst m.coverage item = some cell ∧ cell ∈ m.cells :=
  admittedSourceCode _ _ _ m.admission item held

theorem declaredOperatorExists (m : Model) (edge : String × String) (held : edge ∈ m.relation) :
    ∃ row, localOperator m.coverage edge = some row := by
  have registered := m.relationHeld edge held
  obtain ⟨a,ha,ca⟩ := completeCoverage m edge.1 registered.1
  obtain ⟨b,hb,cb⟩ := completeCoverage m edge.2 registered.2
  exact ⟨⟨edge,a,b⟩,exactLocalOperator _ _ _ _ ha hb⟩

theorem allOperatorsExist (coverage : Encoding) (edges : List (String × String))
    (each : ∀ edge, edge ∈ edges → ∃ row, localOperator coverage edge = some row) :
    ∃ rows, operators coverage edges = some rows := by
  induction edges with
  | nil => exact ⟨[],rfl⟩
  | cons edge rest ih =>
    obtain ⟨row,hr⟩ := each edge (.head _)
    obtain ⟨tail,ht⟩ := ih (fun e he => each e (.tail _ he))
    refine ⟨row::tail,?_⟩
    unfold operators
    rw [hr,ht]

theorem modelOperatorsExist (m : Model) : ∃ rows, operators m.coverage m.relation = some rows :=
  allOperatorsExist _ _ (declaredOperatorExists m)

def closedLedger (m : Model) : Except String (List Pair) := closedDistinctions m.source m.coverage

theorem closedLedgerExists (m : Model) : ∃ rows, closedLedger m = .ok rows :=
  admittedLossExists _ _ _ m.admission

theorem closedLedgerMeaning (m : Model) (rows : List Pair) (accepted : closedLedger m = .ok rows)
    (a b : String) : (a,b) ∈ rows ↔ (a,b) ∈ sourcePairs m.source ∧
      ∃ cell, a ∈ membersFor m.source m.coverage cell ∧ b ∈ membersFor m.source m.coverage cell :=
  closedLedgerClass _ _ _ m.admission rows accepted a b

def retainedLedger (m : Model) : List Pair := (sourcePairs m.source).filter
  (fun pair => decide (lookupFirst m.coverage pair.1 ≠ lookupFirst m.coverage pair.2))

theorem retainedLedgerMeaning (m : Model) (a b : String) : (a,b) ∈ retainedLedger m ↔
    (a,b) ∈ sourcePairs m.source ∧ lookupFirst m.coverage a ≠ lookupFirst m.coverage b := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

structure Refinement (coarse fine : Model) where
  projection : List (Codeword × Codeword)
  sourceRetained : ∀ item, item ∈ coarse.source → item ∈ fine.source
  relationRetained : ∀ edge, edge ∈ coarse.relation → edge ∈ fine.relation
  projects : ∀ item oldCell newCell,
    lookupFirst coarse.coverage item = some oldCell →
    lookupFirst fine.coverage item = some newCell →
    lookupFirst projection newCell = some oldCell

theorem refinementRetainsDistinction (coarse fine : Model) (r : Refinement coarse fine)
    (a b : String) (ca cb fa fb : Codeword)
    (ha : lookupFirst coarse.coverage a = some ca) (hb : lookupFirst coarse.coverage b = some cb)
    (hfa : lookupFirst fine.coverage a = some fa) (hfb : lookupFirst fine.coverage b = some fb)
    (different : ca ≠ cb) : fa ≠ fb := by
  intro same
  have left := r.projects a ca fa ha hfa
  have right := r.projects b cb fb hb hfb
  rw [same,right] at left
  exact different (Option.some.inj left).symm

theorem refinementClosedContained (coarse fine : Model) (r : Refinement coarse fine)
    (a b : String) (ca cb cell : Codeword)
    (ha : lookupFirst coarse.coverage a = some ca) (hb : lookupFirst coarse.coverage b = some cb)
    (hfa : lookupFirst fine.coverage a = some cell) (hfb : lookupFirst fine.coverage b = some cell) :
    ca = cb := by
  have left := r.projects a ca cell ha hfa
  have right := r.projects b cb cell hb hfb
  exact (Option.some.inj (left.symm.trans right))

theorem operatorsComposition (coverage : Encoding) (first second : List (String × String))
    (left right : List OperatorRow) (ha : operators coverage first = some left)
    (hb : operators coverage second = some right) :
    operators coverage (first++second) = some (left++right) := by
  induction first generalizing left with
  | nil => cases ha; exact hb
  | cons edge rest ih =>
    unfold operators at ha
    cases a : localOperator coverage edge with
    | none => rw [a] at ha; cases ha
    | some row =>
      rw [a] at ha
      cases b : operators coverage rest with
      | none => rw [b] at ha; cases ha
      | some tail =>
        rw [b] at ha
        cases ha
        change operators coverage (edge::(rest++second)) = _
        unfold operators
        rw [a,ih tail b]
        rfl

theorem appendOperator (coverage : Encoding) (edges : List (String × String))
    (rows : List OperatorRow) (edge : String × String) (row : OperatorRow)
    (prior : operators coverage edges = some rows) (next : localOperator coverage edge = some row) :
    operators coverage (edges++[edge]) = some (rows++[row]) := by
  apply operatorsComposition _ _ _ _ _ prior
  unfold operators
  rw [next]
  rfl

end SFT.Computation.Discretization
