import SFT.InformationScience.ConservationExtension
namespace SFT.Computation.StateTransition
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
abbrev Row := String × String × String
structure System where
  states : List String
  actions : List String
  transitions : List Row
  deriving DecidableEq

def rowBound (states actions : List String) (row : Row) : Bool :=
  has states row.1 && has states row.2.2 && has actions row.2.1

def validateRows (states actions : List String) : List (String × String) → List Row → Except String Unit
 | _, [] => .ok ()
 | seen, row::rows =>
   if !rowBound states actions row then .error "ValueError: a transition row escapes the generated carriers"
   else if has seen (row.1,row.2.1) then .error "ValueError: a deterministic transition coordinate occurs twice"
   else validateRows states actions ((row.1,row.2.1)::seen) rows

def create (states actions : List String) (transitions : List Row) : Except String System :=
  if !distinct states then .error "ValueError: states must contain unique generated identities"
  else if !distinct actions then .error "ValueError: actions must contain unique generated identities"
  else if states.isEmpty || actions.isEmpty then .error "ValueError: a transition system requires generated states and actions"
  else match validateRows states actions [] transitions with
  | .error e => .error e
  | .ok () => .ok ⟨states,actions,transitions⟩

def targets (rows : List Row) (state action : String) : List String :=
  (rows.filter (fun row => decide (row.1 = state) && decide (row.2.1 = action))).map (fun row => row.2.2)

def step (system : System) (state action : String) : Except String String :=
  match targets system.transitions state action with
  | [] => .error "ValueError: the requested transition is not exactly generated"
  | target::rest => if rest.isEmpty then .ok target else .error "ValueError: the requested transition is not exactly generated"

def runFrom (system : System) (state : String) : List String → Except String (List String)
 | [] => .ok [state]
 | action::actions => match step system state action with
   | .error e => .error e
   | .ok next => match runFrom system next actions with
     | .error e => .error e
     | .ok rest => .ok (state::rest)

def run (system : System) (initial : String) (actions : List String) : Except String (List String) :=
  if !has system.states initial then .error "ValueError: initial state is outside the carrier"
  else runFrom system initial actions

theorem rowBoundMeaning (states actions : List String) (row : Row) :
    rowBound states actions row = true ↔ row.1 ∈ states ∧ row.2.2 ∈ states ∧ row.2.1 ∈ actions := by
  constructor
  · intro h
    have p := (SFT.Foundation.Count.Representation.andTrue _ _).mp h
    have q := (SFT.Foundation.Count.Representation.andTrue _ _).mp p.1
    exact ⟨(hasIff _ _).mp q.1,(hasIff _ _).mp q.2,(hasIff _ _).mp p.2⟩
  · intro ⟨hs,ht,ha⟩
    exact (SFT.Foundation.Count.Representation.andTrue _ _).mpr
      ⟨(SFT.Foundation.Count.Representation.andTrue _ _).mpr ⟨(hasIff _ _).mpr hs,(hasIff _ _).mpr ht⟩,(hasIff _ _).mpr ha⟩

theorem stepMeaning (system : System) (state action target : String) :
    step system state action = .ok target ↔ targets system.transitions state action = [target] := by
  unfold step
  cases h : targets system.transitions state action with
  | nil => constructor <;> intro h <;> cases h
  | cons t ts => cases ts with
    | nil => constructor <;> intro h <;> cases h <;> rfl
    | cons x xs => constructor <;> intro h <;> cases h

theorem runBase (system : System) (initial : String) (held : initial ∈ system.states) :
    run system initial [] = .ok [initial] := by
  unfold run
  rw [(hasIff _ _).mpr held]
  rfl

theorem runAdmission (system : System) (initial : String) (actions trace : List String) :
    run system initial actions = .ok trace ↔ initial ∈ system.states ∧ runFrom system initial actions = .ok trace := by
  unfold run
  cases h : has system.states initial with
  | false =>
    constructor
    · intro bad; cases bad
    · intro p; have bad := (hasIff _ _).mpr p.1; rw [h] at bad; cases bad
  | true => exact ⟨fun h' => ⟨(hasIff _ _).mp h,h'⟩,fun p => p.2⟩

-- Every successful execution is an exact chain of the original step results.
inductive Execution (system : System) : String → List String → List String → Prop
 | base (state : String) : Execution system state [] [state]
 | next (state action target : String) (actions trace : List String)
     (edge : step system state action = .ok target)
     (rest : Execution system target actions trace) :
     Execution system state (action::actions) (state::trace)

theorem runFromMeaning (system : System) (state : String) (actions trace : List String) :
    runFrom system state actions = .ok trace ↔ Execution system state actions trace := by
  induction actions generalizing state trace with
  | nil =>
    constructor
    · intro h; cases h; exact .base state
    · intro h; cases h; rfl
  | cons action actions ih =>
    constructor
    · intro h
      unfold runFrom at h
      cases edge : step system state action with
      | error e => rw [edge] at h; cases h
      | ok target =>
        rw [edge] at h
        dsimp only at h
        cases rest : runFrom system target actions with
        | error e => rw [rest] at h; cases h
        | ok tail => rw [rest] at h; cases h; exact .next _ _ _ _ _ edge ((ih _ _).mp rest)
    · intro h
      cases h with
      | next _ _ target _ tail edge rest =>
        unfold runFrom
        rw [edge]
        dsimp only
        rw [(ih _ _).mpr rest]


theorem executionLength (system : System) (state : String) (actions trace : List String)
    (h : Execution system state actions trace) : trace.length = actions.length + 1 := by
  induction h with
  | base => rfl
  | next _ _ _ _ _ _ _ ih => exact congrArg Nat.succ ih

theorem executionInitial (system : System) (state : String) (actions trace : List String)
    (h : Execution system state actions trace) : trace.head? = some state := by
  cases h <;> rfl



inductive RowsValid (states actions : List String) : List (String × String) → List Row → Prop
 | nil (seen) : RowsValid states actions seen []
 | cons (seen row rows) (bound : rowBound states actions row = true)
     (fresh : has seen (row.1,row.2.1) = false)
     (rest : RowsValid states actions ((row.1,row.2.1)::seen) rows) :
     RowsValid states actions seen (row::rows)

theorem validateMeaning (states actions : List String) (seen : List (String × String)) (rows : List Row) :
    validateRows states actions seen rows = .ok () ↔ RowsValid states actions seen rows := by
  induction rows generalizing seen with
  | nil => exact ⟨fun _ => .nil seen,fun _ => rfl⟩
  | cons row rows ih =>
    constructor
    · intro h
      unfold validateRows at h
      cases bound : rowBound states actions row with
      | false => rw [bound] at h; cases h
      | true =>
        rw [bound] at h
        cases fresh : has seen (row.1,row.2.1) with
        | true => rw [fresh] at h; cases h
        | false => rw [fresh] at h; exact .cons _ _ _ bound fresh ((ih _).mp h)
    · intro h
      cases h with
      | cons _ _ _ bound fresh rest =>
        unfold validateRows
        rw [bound,fresh]
        exact (ih _).mpr rest

theorem createMeaning (states actions : List String) (rows : List Row) (system : System) :
    create states actions rows = .ok system ↔
      distinct states = true ∧ distinct actions = true ∧ states.isEmpty = false ∧ actions.isEmpty = false ∧
      RowsValid states actions [] rows ∧ system = System.mk states actions rows := by
  unfold create
  cases hs : distinct states <;> cases ha : distinct actions <;> cases es : states.isEmpty <;> cases ea : actions.isEmpty
  all_goals try { constructor; intro h; cases h; intro h; cases h.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.2.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.2.2.1 }
  cases hv : validateRows states actions [] rows with
  | error e =>
    constructor
    · intro h; cases h
    · intro h
      have valid := (validateMeaning _ _ _ _).mpr h.2.2.2.2.1
      rw [hv] at valid; cases valid
  | ok unit =>
    cases unit
    constructor
    · intro h; cases h
      exact ⟨rfl,rfl,rfl,rfl,(validateMeaning _ _ _ _).mp hv,rfl⟩
    · intro h; rw [h.2.2.2.2.2]; rfl

theorem checkedRowsBound (states actions : List String) (seen : List (String × String)) (rows : List Row)
    (valid : RowsValid states actions seen rows) (row : Row) (member : row ∈ rows) :
    row.1 ∈ states ∧ row.2.2 ∈ states ∧ row.2.1 ∈ actions := by
  induction valid with
  | nil => cases member
  | cons _ r rs bound _ _ ih =>
    cases member with
    | head => exact (rowBoundMeaning _ _ _).mp bound
    | tail _ h => exact ih h



theorem targetMembership (rows : List Row) (state action target : String) :
    target ∈ targets rows state action ↔ (state,action,target) ∈ rows := by
  constructor
  · intro h
    obtain ⟨row,hr,eq⟩ := memMapPreimage _ _ _ h
    have p := (filterMemberIff _ _ _).mp hr
    have q := (SFT.Foundation.Count.Representation.andTrue _ _).mp p.2
    have hs : row.1 = state := of_decide_eq_true q.1
    have ha : row.2.1 = action := of_decide_eq_true q.2
    cases row with
    | mk source rest => cases rest with
      | mk label result => cases hs; cases ha; cases eq; exact p.1
  · intro h
    exact memMap _ (state,action,target) _ ((filterMemberIff _ _ _).mpr ⟨h,by
      exact (SFT.Foundation.Count.Representation.andTrue _ _).mpr
        ⟨decide_eq_true rfl,decide_eq_true rfl⟩⟩)

theorem stepSourceRow (system : System) (state action target : String)
    (h : step system state action = .ok target) : (state,action,target) ∈ system.transitions := by
  apply (targetMembership _ _ _ _).mp
  rw [(stepMeaning _ _ _ _).mp h]
  exact List.Mem.head []

theorem admittedStepBound (states actions : List String) (rows : List Row) (system : System)
    (admitted : create states actions rows = .ok system) (state action target : String)
    (h : step system state action = .ok target) : state ∈ states ∧ target ∈ states ∧ action ∈ actions := by
  have p := (createMeaning _ _ _ _).mp admitted
  have row := stepSourceRow _ _ _ _ h
  rw [p.2.2.2.2.2] at row
  exact checkedRowsBound states actions [] rows p.2.2.2.2.1 (state,action,target) row

theorem executionStates (states actions : List String) (rows : List Row) (system : System)
    (admitted : create states actions rows = .ok system) (initial : String) (held : initial ∈ states)
    (requested trace : List String) (execution : Execution system initial requested trace) :
    ∀ state, state ∈ trace → state ∈ states := by
  induction execution with
  | base initial =>
    intro state member
    cases member with
    | head => exact held
    | tail _ member => cases member
  | next initial action target requested tail edge rest ih =>
    intro state member
    cases member with
    | head => exact held
    | tail _ member => exact ih (admittedStepBound _ _ _ _ admitted _ _ _ edge).2.1 state member

end SFT.Computation.StateTransition
