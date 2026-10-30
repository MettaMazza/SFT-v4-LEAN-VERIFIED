import SFT.Mathematics.DiscreteComposition
namespace SFT.Computation.HighDimensional
open SFT.Mathematics.DiscreteObjects SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

def productSupport : List (List String) → List (List String)
  | [] => [[]]
  | axis :: rest => axis.flatMap (fun value => (productSupport rest).map (List.cons value))

inductive CoordinateTrace : List (List String) → List String → Prop where
  | nil : CoordinateTrace [] []
  | cons {axis : List String} {axes : List (List String)} {value : String} {row : List String} :
      value ∈ axis → CoordinateTrace axes row → CoordinateTrace (axis :: axes) (value :: row)

theorem completeProduct (axes : List (List String)) (row : List String) :
    row ∈ productSupport axes ↔ CoordinateTrace axes row := by
  induction axes generalizing row with
  | nil =>
    constructor
    · intro member
      cases member with
      | head => exact .nil
      | tail _ impossible => cases impossible
    · intro trace
      cases trace
      exact List.Mem.head []
  | cons axis axes ih =>
    constructor
    · intro member
      obtain ⟨value,held,mapped⟩ := memFlatMapOrigin _ axis row member
      obtain ⟨tail,tailMember,equal⟩ := memMapPreimage (List.cons value) row _ mapped
      cases equal
      exact .cons held ((ih tail).mp tailMember)
    · intro trace
      cases trace with
      | cons held tail => exact memFlatMap _ axis _ _ held (memMap _ _ _ ((ih _).mpr tail))

theorem coordinateCount (axes : List (List String)) (row : List String)
    (trace : CoordinateTrace axes row) : row.length = axes.length := by
  induction trace with
  | nil => rfl
  | cons _ _ ih => exact congrArg Nat.succ ih

theorem coordinateComposition (left right : List (List String)) (before after : List String)
    (first : CoordinateTrace left before) (second : CoordinateTrace right after) :
    CoordinateTrace (left ++ right) (before ++ after) := by
  induction first with
  | nil => exact second
  | cons held tail ih => exact .cons held ih

theorem productComposition (left right : List (List String)) (before after : List String)
    (first : before ∈ productSupport left) (second : after ∈ productSupport right) :
    before ++ after ∈ productSupport (left ++ right) :=
  (completeProduct _ _).mpr (coordinateComposition left right before after
    ((completeProduct _ _).mp first) ((completeProduct _ _).mp second))

theorem coordinateSuccessor (axes : List (List String)) (row axis : List String) (value : String)
    (prior : row ∈ productSupport axes) (held : value ∈ axis) :
    row ++ [value] ∈ productSupport (axes ++ [axis]) :=
  (completeProduct _ _).mpr (coordinateComposition axes [axis] row [value]
    ((completeProduct _ _).mp prior) (.cons held .nil))

def productCardinality : List (List String) → Nat
  | [] => 1
  | axis :: rest => axis.length * productCardinality rest

theorem branchCardinality (axis : List String) (rows : List (List String)) :
    (axis.flatMap (fun value => rows.map (List.cons value))).length = axis.length * rows.length := by
  induction axis with
  | nil => exact (Nat.zero_mul _).symm
  | cons value rest ih =>
    change ((rows.map (List.cons value)) ++ rest.flatMap (fun value => rows.map (List.cons value))).length = (rest.length + 1) * rows.length
    rw [appendLength,mapLength,ih,Nat.succ_mul]
    exact Nat.add_comm _ _

theorem exactProductCardinality (axes : List (List String)) :
    (productSupport axes).length = productCardinality axes := by
  induction axes with
  | nil => rfl
  | cons axis rest ih =>
    change (axis.flatMap (fun value => (productSupport rest).map (List.cons value))).length = _
    rw [branchCardinality,ih]
    rfl

theorem branchesDistinct (axis : List String) (rows : List (List String))
    (axisUnique : distinct axis = true) (rowsUnique : distinct rows = true) :
    distinct (axis.flatMap (fun value => rows.map (List.cons value))) = true := by
  induction axis with
  | nil => rfl
  | cons value rest ih =>
    have parts := (distinctCons _ _).mp axisUnique
    apply appendDistinct
    · exact mapDistinct (List.cons value) (fun a b equal => (List.cons.inj equal).2) rows rowsUnique
    · exact ih parts.2
    · intro row first remaining
      obtain ⟨tail,_,equal⟩ := memMapPreimage (List.cons value) row rows first
      obtain ⟨other,member,branch⟩ := memFlatMapOrigin _ rest row remaining
      obtain ⟨otherTail,_,otherEqual⟩ := memMapPreimage (List.cons other) row rows branch
      have same := (List.cons.inj (equal.trans otherEqual.symm)).1
      cases same
      exact (absentIff _ _).mp parts.1 member

theorem productDistinct (axes : List (List String))
    (unique : ∀ axis, axis ∈ axes → distinct axis = true) : distinct (productSupport axes) = true := by
  induction axes with
  | nil => rfl
  | cons axis rest ih =>
    exact branchesDistinct axis (productSupport rest) (unique axis (List.Mem.head _))
      (ih (fun other member => unique other (List.Mem.tail axis member)))

structure Model where
  axes : List (List String)
  canonical : ∀ axis, axis ∈ axes → axis.isEmpty = false ∧ distinct axis = true

def sparseRelation (model : Model) (rows : Relation) : Except String Relation :=
  generatedRelation (productSupport model.axes) (productSupport model.axes) rows

theorem sparseEndpoints (model : Model) (rows admitted : Relation)
    (accepted : sparseRelation model rows = .ok admitted) (pair : List String × List String)
    (member : pair ∈ admitted) : CoordinateTrace model.axes pair.1 ∧ CoordinateTrace model.axes pair.2 := by
  have endpoints := generatedRelationContained _ _ rows admitted accepted pair member
  exact ⟨(completeProduct _ _).mp endpoints.1,(completeProduct _ _).mp endpoints.2⟩

inductive Execution (relation : Relation) : List String → Relation → List String → Prop where
  | identity (state : List String) : Execution relation state [] state
  | step {state next terminal : List String} {rest : Relation} :
      (state,next) ∈ relation → Execution relation next rest terminal →
      Execution relation state ((state,next) :: rest) terminal

def replay (relation : Relation) (initial : List String) : Relation → Option (List String)
  | [] => some initial
  | (source,target) :: rest =>
      if source = initial then
        if has relation (source,target) then replay relation target rest else none
      else none

theorem replayExactly (relation trace : Relation) (initial terminal : List String) :
    replay relation initial trace = some terminal ↔ Execution relation initial trace terminal := by
  induction trace generalizing initial with
  | nil =>
    constructor
    · intro h; cases h; exact .identity _
    · intro h; cases h; rfl
  | cons pair rest ih =>
    cases pair with
    | mk source target =>
      change (if source = initial then
        if has relation (source,target) then replay relation target rest else none
        else none) = some terminal ↔ _
      constructor
      · intro accepted
        split at accepted
        · rename_i same
          cases same
          split at accepted
          · rename_i held
            exact .step ((hasIff _ _).mp held) ((ih target).mp accepted)
          · cases accepted
        · cases accepted
      · intro trace
        cases trace with
        | step held tail =>
          rw [ite_eq_left rfl,ite_eq_left ((hasIff _ _).mpr held)]
          exact (ih target).mpr tail

theorem executionComposition (relation left right : Relation) (initial middle terminal : List String)
    (first : Execution relation initial left middle) (second : Execution relation middle right terminal) :
    Execution relation initial (left ++ right) terminal := by
  induction first with
  | identity => exact second
  | step held tail ih => exact .step held (ih second)

theorem executionRows (relation trace : Relation) (initial terminal : List String)
    (execution : Execution relation initial trace terminal) : ∀ pair, pair ∈ trace → pair ∈ relation := by
  induction execution with
  | identity => intro pair member; cases member
  | step held tail ih =>
    intro pair member
    cases member with
    | head => exact held
    | tail _ h => exact ih pair h

structure Resources where
  generatedRows : Nat
  retainedRelationRows : Nat
  executedRows : Nat

def resources (model : Model) (relation trace : Relation) : Resources :=
  ⟨(productSupport model.axes).length,relation.length,trace.length⟩

theorem resourceLedger (model : Model) (relation trace : Relation) :
    (resources model relation trace).generatedRows = productCardinality model.axes ∧
    (resources model relation trace).retainedRelationRows = relation.length ∧
    (resources model relation trace).executedRows = trace.length :=
  ⟨exactProductCardinality model.axes,rfl,rfl⟩

def coordinateValue : List String → Nat → Option String
  | [], _ => none
  | head :: _, 0 => some head
  | _ :: rest, index + 1 => coordinateValue rest index

def project : List Nat → List String → Option (List String)
  | [], _ => some []
  | coordinate :: rest, row => match coordinateValue row coordinate with
    | none => none
    | some value => match project rest row with
      | none => none
      | some values => some (value :: values)

theorem projectionCount (coordinates : List Nat) (row projected : List String)
    (accepted : project coordinates row = some projected) : projected.length = coordinates.length := by
  induction coordinates generalizing projected with
  | nil => cases accepted; rfl
  | cons coordinate rest ih =>
    unfold project at accepted
    cases cell : coordinateValue row coordinate with
    | none => rw [cell] at accepted; cases accepted
    | some value =>
      rw [cell] at accepted
      cases tail : project rest row with
      | none => rw [tail] at accepted; cases accepted
      | some values =>
        rw [tail] at accepted
        cases accepted
        exact congrArg Nat.succ (ih values tail)

theorem lostInteractionBoundary (coordinates : List Nat) (left right projected : List String)
    (leftProjection : project coordinates left = some projected)
    (rightProjection : project coordinates right = some projected)
    (different : left ≠ right) :
    ¬ ∃ decoder : Option (List String) → List String,
      decoder (project coordinates left) = left ∧ decoder (project coordinates right) = right := by
  intro ⟨decoder,leftInverse,rightInverse⟩
  rw [leftProjection] at leftInverse
  rw [rightProjection] at rightInverse
  exact different (leftInverse.symm.trans rightInverse)

def factorRows : List (List (String × String)) → Relation
  | [] => [([],[])]
  | factor :: rest => factor.flatMap (fun pair => (factorRows rest).map
      (fun row => (pair.1 :: row.1,pair.2 :: row.2)))

inductive FactorTrace : List (List (String × String)) → List String → List String → Prop where
  | nil : FactorTrace [] [] []
  | cons {factor : List (String × String)} {rest : List (List (String × String))}
      {left right : String} {before after : List String} :
      (left,right) ∈ factor → FactorTrace rest before after →
      FactorTrace (factor :: rest) (left :: before) (right :: after)

theorem completeFactors (factors : List (List (String × String))) (left right : List String) :
    (left,right) ∈ factorRows factors ↔ FactorTrace factors left right := by
  induction factors generalizing left right with
  | nil =>
    constructor
    · intro member
      cases member with
      | head => exact .nil
      | tail _ impossible => cases impossible
    · intro trace; cases trace; exact List.Mem.head []
  | cons factor rest ih =>
    constructor
    · intro member
      obtain ⟨pair,held,mapped⟩ := memFlatMapOrigin _ factor (left,right) member
      obtain ⟨row,tailMember,equal⟩ := memMapPreimage
        (fun row : List String × List String => (pair.1 :: row.1,pair.2 :: row.2)) (left,right) _ mapped
      cases equal
      exact .cons held ((ih row.1 row.2).mp tailMember)
    · intro trace
      cases trace with
      | cons held tail =>
        exact memFlatMap _ factor _ _ held (memMap _ _ _ ((ih _ _).mpr tail))

def run (model : Model) (rows : Relation) (initial : List String) (trace : Relation) : Option (List String) :=
  match sparseRelation model rows with
  | .error _ => none
  | .ok relation => if has (productSupport model.axes) initial then replay relation initial trace else none

theorem runSource (model : Model) (rows trace : Relation) (initial terminal : List String)
    (accepted : run model rows initial trace = some terminal) :
    ∃ relation, sparseRelation model rows = .ok relation ∧
      CoordinateTrace model.axes initial ∧ Execution relation initial trace terminal := by
  unfold run at accepted
  cases relationResult : sparseRelation model rows with
  | error e => rw [relationResult] at accepted; cases accepted
  | ok relation =>
    rw [relationResult] at accepted
    dsimp only at accepted
    split at accepted
    · rename_i initialHeld
      exact ⟨relation,rfl,(completeProduct _ _).mp ((hasIff _ _).mp initialHeld),
        (replayExactly relation trace initial terminal).mp accepted⟩
    · cases accepted

theorem executionTerminal (model : Model) (rows relation trace : Relation)
    (admitted : sparseRelation model rows = .ok relation) (initial terminal : List String)
    (held : CoordinateTrace model.axes initial) (execution : Execution relation initial trace terminal) :
    CoordinateTrace model.axes terminal := by
  induction execution with
  | identity => exact held
  | step edge tail ih => exact ih ((sparseEndpoints model rows relation admitted _ edge).2)

end SFT.Computation.HighDimensional
