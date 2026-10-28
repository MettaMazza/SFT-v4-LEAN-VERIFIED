import SFT.Mathematics.GeometryTopology
namespace SFT.Mathematics.DynamicsTraces
open DiscreteObjects AlgebraOperations GeometryTopology GraphOperations SFT.Foundation.Count.TraceDerivation

abbrev Transitions := List (String × String)
abbrev Time := Sum (List String) Transitions

def validDynamics (states : List String) (transitions : Transitions) : Bool :=
  !states.isEmpty && distinct states && distinct transitions &&
    transitions.all (fun pair => has states pair.1 && has states pair.2)

def trajectoryValid (transitions : Transitions) (trajectory : List String) : Bool :=
  !trajectory.isEmpty && (adjacentPairs trajectory).all (has transitions)

def transitionTime : List String → Except String Time
  | [] => .error "time requires a generated trajectory"
  | state :: rest => match rest with
    | [] => .ok (.inl ["empty-One"])
    | next :: tail => .ok (.inr (adjacentPairs (state :: next :: tail)))

def fixedForms (transitions : Transitions) : List String :=
  (transitions.filter (fun pair => decide (pair.1 = pair.2))).map Prod.fst

def predecessorRecords (transitions : Transitions) (target : String) : List String :=
  (transitions.filter (fun pair => decide (pair.2 = target))).map Prod.fst

def reversibleWithRecord (transitions retained : Transitions) : Bool :=
  transitions.all (has retained) && distinct retained

theorem dynamicsMeaning (states : List String) (transitions : Transitions) :
    validDynamics states transitions = true ↔ states.isEmpty = false ∧ distinct states = true ∧
      distinct transitions = true ∧ ∀ pair, pair ∈ transitions → pair.1 ∈ states ∧ pair.2 ∈ states := by
  constructor
  · intro h
    have a := (andTrue _ _).mp h
    have b := (andTrue _ _).mp a.1
    have c := (andTrue _ _).mp b.1
    refine ⟨(notTrue _).mp c.1,c.2,b.2,?_⟩
    intro pair member
    have p := (andTrue _ _).mp (allTrueAtMember _ _ a.2 pair member)
    exact ⟨(hasIff _ _).mp p.1,(hasIff _ _).mp p.2⟩
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,h.2.1⟩,h.2.2.1⟩,?_⟩
    apply (allTrueIffMembers _ _).mpr
    intro pair member
    have p := h.2.2.2 pair member
    exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr p.1,(hasIff _ _).mpr p.2⟩

theorem trajectoryMeaning (transitions : Transitions) (trajectory : List String) :
    trajectoryValid transitions trajectory = true ↔ trajectory.isEmpty = false ∧
      ∀ pair, pair ∈ adjacentPairs trajectory → pair ∈ transitions := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    exact ⟨(notTrue _).mp p.1,fun pair member => (hasIff _ _).mp (allTrueAtMember _ _ p.2 pair member)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(notTrue _).mpr h.1,(allTrueIffMembers _ _).mpr (fun pair member => (hasIff _ _).mpr (h.2 pair member))⟩

theorem identityTrajectory (transitions : Transitions) (state : String) :
    trajectoryValid transitions [state] = true := rfl

theorem emptyTrajectory (transitions : Transitions) : trajectoryValid transitions [] = false := rfl

theorem trajectoryComposition (transitions : Transitions) (prefixNodes suffixNodes : List String) (state : String) :
    trajectoryValid transitions (prefixNodes ++ state :: suffixNodes) = true ↔
      trajectoryValid transitions (prefixNodes ++ [state]) = true ∧ trajectoryValid transitions (state :: suffixNodes) = true := by
  constructor
  · intro h
    have p := (trajectoryMeaning _ _).mp h
    rw [adjacentPairsComposition] at p
    constructor
    · apply (trajectoryMeaning _ _).mpr
      refine ⟨by cases prefixNodes <;> rfl,?_⟩
      intro pair member
      exact p.2 pair (memAppendLeft _ _ _ member)
    · apply (trajectoryMeaning _ _).mpr
      refine ⟨rfl,?_⟩
      intro pair member
      exact p.2 pair (memAppendRight _ _ _ member)
  · intro h
    have left := (trajectoryMeaning _ _).mp h.1
    have right := (trajectoryMeaning _ _).mp h.2
    apply (trajectoryMeaning _ _).mpr
    refine ⟨by cases prefixNodes <;> rfl,?_⟩
    intro pair member
    rw [adjacentPairsComposition] at member
    cases memAppendCases _ _ _ member with
    | inl hl => exact left.2 pair hl
    | inr hr => exact right.2 pair hr

theorem transitionCount (state : String) (rest : List String) :
    (adjacentPairs (state :: rest)).length = rest.length := by
  induction rest generalizing state with
  | nil => rfl
  | cons next tail ih => exact congrArg Nat.succ (ih next)

theorem identityTime (state : String) : transitionTime [state] = .ok (.inl ["empty-One"]) := rfl

theorem generatedTime (state next : String) (rest : List String) :
    transitionTime (state :: next :: rest) = .ok (.inr ((state,next) :: adjacentPairs (next :: rest))) := rfl

theorem emptyTimeRejected : transitionTime [] = .error "time requires a generated trajectory" := rfl

theorem positiveTransitionTime (state next : String) (rest : List String) :
    0 < (adjacentPairs (state :: next :: rest)).length := Nat.zero_lt_succ _

theorem fixedMembership (transitions : Transitions) (state : String) :
    state ∈ fixedForms transitions ↔ (state,state) ∈ transitions := by
  constructor
  · intro h
    obtain ⟨pair,member,same⟩ := memMapPreimage _ _ _ h
    have p := (filterMemberIff _ _ _).mp member
    have equal := of_decide_eq_true p.2
    cases pair with
    | mk left right => cases same; cases equal; exact p.1
  · intro h
    apply memMap Prod.fst (state,state) _
    exact (filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩

theorem predecessorMembership (transitions : Transitions) (target source : String) :
    source ∈ predecessorRecords transitions target ↔ (source,target) ∈ transitions := by
  constructor
  · intro h
    obtain ⟨pair,member,same⟩ := memMapPreimage _ _ _ h
    have p := (filterMemberIff _ _ _).mp member
    have equal := of_decide_eq_true p.2
    cases pair with
    | mk left right => cases same; cases equal; exact p.1
  · intro h
    apply memMap Prod.fst (source,target) _
    exact (filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩

theorem reversalMeaning (transitions retained : Transitions) :
    reversibleWithRecord transitions retained = true ↔
      (∀ pair, pair ∈ transitions → pair ∈ retained) ∧ distinct retained = true := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    exact ⟨fun pair member => (hasIff _ _).mp (allTrueAtMember _ _ p.1 pair member),p.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr (fun pair member => (hasIff _ _).mpr (h.1 pair member)),h.2⟩

theorem retainedPredecessor (transitions retained : Transitions) (source target : String)
    (reversible : reversibleWithRecord transitions retained = true) (step : (source,target) ∈ transitions) :
    source ∈ predecessorRecords retained target :=
  (predecessorMembership _ _ _).mpr (((reversalMeaning _ _).mp reversible).1 (source,target) step)

theorem missingRecordRejected (transitions retained : Transitions) (pair : String × String)
    (step : pair ∈ transitions) (missing : ¬ pair ∈ retained) : reversibleWithRecord transitions retained = false := by
  cases h : reversibleWithRecord transitions retained with
  | false => rfl
  | true => exact False.elim (missing (((reversalMeaning _ _).mp h).1 pair step))

end SFT.Mathematics.DynamicsTraces
