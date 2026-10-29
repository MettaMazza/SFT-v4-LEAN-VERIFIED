import SFT.Computation.SymbolicEvaluation
namespace SFT.Computation.SymbolicContext
open SymbolicEvaluation NumericalError SFT.Foundation.ExactOperations

inductive Generated : Expr → Prop where
 | value (part : PositiveFraction) : Generated (.value (some (.positive part)))
 | name (label : String) : Generated (.name label)
 | join (left right : Expr) (a : Generated left) (b : Generated right) : Generated (.join left right)

inductive Context where
 | hole
 | left : Context → Expr → Context
 | right : Expr → Context → Context

def plug : Context → Expr → Expr
 | .hole, expression => expression
 | .left context right, expression => .join (plug context expression) right
 | .right left context, expression => .join left (plug context expression)

inductive GeneratedContext : Context → Prop where
 | hole : GeneratedContext .hole
 | left (context : Context) (right : Expr) (inside : GeneratedContext context) (sibling : Generated right) : GeneratedContext (.left context right)
 | right (left : Expr) (context : Context) (sibling : Generated left) (inside : GeneratedContext context) : GeneratedContext (.right left context)

theorem plugGenerated (context : Context) (expression : Expr)
    (outside : GeneratedContext context) (inside : Generated expression) : Generated (plug context expression) := by
  induction outside with
  | hole => exact inside
  | left context right hc hr ih => exact .join _ _ ih hr
  | right left context hl hc ih => exact .join _ _ hl ih

def SameValue (environment : Environment) (left right : Expr) : Prop :=
  ∀ value, evaluate environment left = .ok value ↔ evaluate environment right = .ok value

theorem sameIdentity (environment : Environment) (expression : Expr) : SameValue environment expression expression :=
  fun _ => ⟨fun h => h,fun h => h⟩

theorem sameComposition (environment : Environment) (first middle last : Expr)
    (left : SameValue environment first middle) (right : SameValue environment middle last) : SameValue environment first last :=
  fun value => ⟨fun h => (right value).mp ((left value).mp h),fun h => (left value).mpr ((right value).mpr h)⟩

theorem joinResult (environment : Environment) (left right : Expr) (a b : Number)
    (first : evaluate environment left = .ok a) (second : evaluate environment right = .ok b) :
    evaluate environment (.join left right) = .ok (SymbolicValues.add a b) := by
  have h := (sourceAdmission _ _ _).mp first
  exact SymbolicEvaluation.replay _ _ _ h.1 (.join _ _ _ _ h.2 (SymbolicEvaluation.reconstruct _ _ _ second))

theorem joinCongruence (environment : Environment) (a b c d : Expr)
    (left : SameValue environment a b) (right : SameValue environment c d) :
    SameValue environment (.join a c) (.join b d) := by
  intro value
  constructor
  · intro accepted
    obtain ⟨x,y,first,second,same⟩ := joinReconstruction _ _ _ _ accepted
    rw [same]
    exact joinResult _ _ _ _ _ ((left x).mp first) ((right y).mp second)
  · intro accepted
    obtain ⟨x,y,first,second,same⟩ := joinReconstruction _ _ _ _ accepted
    rw [same]
    exact joinResult _ _ _ _ _ ((left x).mpr first) ((right y).mpr second)

theorem contextualEquivalence (environment : Environment) (context : Context) (left right : Expr)
    (same : SameValue environment left right) : SameValue environment (plug context left) (plug context right) := by
  induction context with
  | hole => exact same
  | left context sibling ih => exact joinCongruence _ _ _ _ _ ih (sameIdentity _ _)
  | right sibling context ih => exact joinCongruence _ _ _ _ _ (sameIdentity _ _) ih

-- The address is a generated occurrence trace, not a numerical coordinate.
inductive Direction where | left | right

def address : Context → List Direction
 | .hole => []
 | .left context _ => .left :: address context
 | .right _ context => .right :: address context

def focus (expression : Expr) (path : List Direction) : Option Expr :=
 match path with
 | [] => some expression
 | direction :: rest => match expression with
   | .value _ => none
   | .name _ => none
   | .outside _ => none
   | .join left right => match direction with
     | .left => focus left rest
     | .right => focus right rest
termination_by structural path

theorem heldOccurrence (context : Context) (expression : Expr) :
    focus (plug context expression) (address context) = some expression := by
  induction context with
  | hole => rfl
  | left context sibling ih => exact ih
  | right sibling context ih => exact ih


theorem focusContext (expression : Expr) (path : List Direction) (selected : Expr)
    (found : focus expression path = some selected) :
    ∃ context, plug context selected = expression ∧ address context = path := by
  induction path generalizing expression with
  | nil => cases found; exact ⟨.hole,rfl,rfl⟩
  | cons direction path ih =>
    cases expression with
    | value value => cases found
    | name label => cases found
    | outside tag => cases found
    | join left right =>
      cases direction with
      | left =>
        obtain ⟨context,same,location⟩ := ih left found
        exact ⟨.left context right,congrArg (fun x => Expr.join x right) same,congrArg (List.cons Direction.left) location⟩
      | right =>
        obtain ⟨context,same,location⟩ := ih right found
        exact ⟨.right left context,congrArg (Expr.join left) same,congrArg (List.cons Direction.right) location⟩

theorem generatedDecomposition (context : Context) (expression : Expr)
    (generated : Generated (plug context expression)) : GeneratedContext context ∧ Generated expression := by
  induction context with
  | hole => exact ⟨.hole,generated⟩
  | left context sibling ih =>
    cases generated with
    | join left right hl hr =>
      have parts := ih hl
      exact ⟨.left _ _ parts.1 hr,parts.2⟩
  | right sibling context ih =>
    cases generated with
    | join left right hl hr =>
      have parts := ih hr
      exact ⟨.right _ _ hl parts.1,parts.2⟩

end SFT.Computation.SymbolicContext
