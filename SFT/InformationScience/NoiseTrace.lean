import SFT.InformationScience.NoiseCorrection
namespace SFT.InformationScience.NoiseTrace
open NoiseRelation SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation
abbrev PositionCell := Nat × String × String
abbrev PrintedCell := String × String × String
inductive ErrorTrace where
  | emptyOne
  | changes : List PrintedCell → ErrorTrace
  deriving DecidableEq

def labelAt : Word → Nat → Option String
  | [], _ => none
  | first :: rest, index => match index with
    | 0 => some first
    | n+1 => labelAt rest n

def positionPairs (start : Nat) : Word → Word → List PositionCell
  | [], _ => []
  | left :: ls, received => match received with
    | [] => []
    | right :: rs => (start,left,right) :: positionPairs (start+1) ls rs

def changedPositions (start : Nat) (source received : Word) : List PositionCell :=
  (positionPairs start source received).filter (fun row => decide (row.2.1 ≠ row.2.2))

def printCell (row : PositionCell) : PrintedCell :=
  (SFT.Host.Text.append "position-" (Nat.repr (row.1+1)),row.2.1,row.2.2)

def present (rows : List PositionCell) : ErrorTrace :=
  match rows with
  | [] => .emptyOne
  | first :: rest => .changes ((first :: rest).map printCell)

def errorTrace (source received : Word) : Except String ErrorTrace :=
  if source.length = received.length then .ok (present (changedPositions 0 source received))
  else .error "ValueError: word comparison requires the same generated position carrier"

def detectable (valid : List Word) (source received : Word) : Except String Bool :=
  match errorTrace source received with
  | .error e => .error e
  | .ok trace => match trace with
    | .emptyOne => .ok true
    | .changes _ => .ok (!has valid received)

theorem pairsLength (source received : Word) (same : source.length = received.length) (start : Nat) :
    (positionPairs start source received).length = source.length := by
  induction source generalizing received start with
  | nil => rfl
  | cons left ls ih => cases received with
    | nil => cases same
    | cons right rs => exact congrArg Nat.succ (ih rs (Nat.succ.inj same) (start+1))

theorem pairsMembership (source received : Word) (start index : Nat) (left right : String) :
    (index,left,right) ∈ positionPairs start source received ↔
      ∃ offset, index = start+offset ∧ labelAt source offset = some left ∧ labelAt received offset = some right := by
  induction source generalizing received start with
  | nil =>
    constructor
    · intro h; cases h
    · intro ⟨offset,_,h,_⟩; cases h
  | cons first ls ih => cases received with
    | nil =>
      constructor
      · intro h; cases h
      · intro ⟨offset,_,_,h⟩; cases h
    | cons second rs =>
      constructor
      · intro h
        cases h with
        | head => exact ⟨0,rfl,rfl,rfl⟩
        | tail _ hr =>
          obtain ⟨offset,hi,hl,hr⟩ := (ih rs (start+1)).mp hr
          refine ⟨offset+1,?_,hl,hr⟩
          exact hi.trans (Nat.add_assoc start 1 offset |>.trans (congrArg (start+·) (Nat.add_comm 1 offset)))
      · intro ⟨offset,hi,hl,hr⟩
        cases offset with
        | zero =>
          have a := Option.some.inj hl
          have b := Option.some.inj hr
          have c : index = start := hi
          cases a; cases b; cases c; exact List.Mem.head _
        | succ offset =>
          apply List.Mem.tail
          apply (ih rs (start+1)).mpr
          refine ⟨offset,?_,hl,hr⟩
          exact hi.trans ((Nat.add_assoc start 1 offset |>.trans (congrArg (start+·) (Nat.add_comm 1 offset))).symm)

theorem changedMembership (source received : Word) (start index : Nat) (left right : String) :
    (index,left,right) ∈ changedPositions start source received ↔
      left ≠ right ∧ ∃ offset, index = start+offset ∧ labelAt source offset = some left ∧ labelAt received offset = some right := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨of_decide_eq_true p.2,(pairsMembership _ _ _ _ _ _).mp p.1⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨(pairsMembership _ _ _ _ _ _).mpr h.2,decide_eq_true h.1⟩

theorem changesIdentity (source : Word) (start : Nat) : changedPositions start source source = [] := by
  induction source generalizing start with
  | nil => rfl
  | cons first rest ih =>
    unfold changedPositions
    rw [positionPairs, List.filter_cons_of_neg (p := fun row : PositionCell => decide (row.2.1 ≠ row.2.2))
      (a := (start,first,first)) (fun h => of_decide_eq_true h rfl)]
    exact ih (start+1)

theorem changesEmptyMeaning (source received : Word) (same : source.length = received.length) (start : Nat) :
    changedPositions start source received = [] ↔ source = received := by
  constructor
  · intro empty
    induction source generalizing received start with
    | nil => cases received with
      | nil => rfl
      | cons x xs => cases same
    | cons first ls ih => cases received with
      | nil => cases same
      | cons second rs =>
        by_cases equal : first = second
        · cases equal
          unfold changedPositions at empty
          rw [positionPairs, List.filter_cons_of_neg (p := fun row : PositionCell => decide (row.2.1 ≠ row.2.2))
            (a := (start,first,first)) (fun h => of_decide_eq_true h rfl)] at empty
          exact congrArg (first :: ·) (ih rs (Nat.succ.inj same) (start+1) empty)
        · unfold changedPositions at empty
          rw [positionPairs, List.filter_cons_of_pos (p := fun row : PositionCell => decide (row.2.1 ≠ row.2.2))
            (a := (start,first,second)) (decide_eq_true equal)] at empty
          cases empty
  · intro eq; cases eq; exact changesIdentity source start

theorem presentEmpty (rows : List PositionCell) : present rows = .emptyOne ↔ rows = [] := by
  cases rows with
  | nil => exact ⟨fun _ => rfl,fun _ => rfl⟩
  | cons first rest => constructor <;> intro h <;> cases h

theorem identityTrace (source : Word) : errorTrace source source = .ok .emptyOne := by
  unfold errorTrace
  rw [if_pos rfl,changesIdentity]; rfl

theorem traceEmptyMeaning (source received : Word) :
    errorTrace source received = .ok .emptyOne ↔ source = received := by
  unfold errorTrace
  split
  · rename_i same
    constructor
    · intro h
      exact (changesEmptyMeaning _ _ same 0).mp ((presentEmpty _).mp (Except.ok.inj h))
    · intro h; cases h; rw [changesIdentity]; rfl
  · rename_i different
    constructor
    · intro h; cases h
    · intro h; cases h; exact False.elim (different rfl)

theorem traceChangesMeaning (source received : Word) (rows : List PrintedCell) :
    errorTrace source received = .ok (.changes rows) ↔
      source.length = received.length ∧ source ≠ received ∧ rows = (changedPositions 0 source received).map printCell := by
  unfold errorTrace
  split
  · rename_i same
    cases hc : changedPositions 0 source received with
    | nil =>
      constructor
      · intro h; cases h
      · intro h; exact False.elim (h.2.1 ((changesEmptyMeaning _ _ same 0).mp hc))
    | cons first rest =>
      constructor
      · intro h
        have eq := ErrorTrace.changes.inj (Except.ok.inj h)
        refine ⟨same,?_,eq.symm⟩
        intro identical; cases identical
        have no := changesIdentity source 0
        rw [hc] at no; cases no
      · intro h; rw [h.2.2]; rfl
  · rename_i different
    constructor
    · intro h; cases h
    · intro h; exact False.elim (different h.1)

theorem detectionMeaning (valid : List Word) (source received : Word) (same : source.length = received.length) :
    detectable valid source received = .ok (if source = received then true else !has valid received) := by
  unfold detectable errorTrace
  rw [if_pos same]
  cases hc : changedPositions 0 source received with
  | nil =>
    have eq := (changesEmptyMeaning _ _ same 0).mp hc
    rw [if_pos eq]; rfl
  | cons first rest =>
    have ne : source ≠ received := by
      intro eq; cases eq
      have no := changesIdentity source 0; rw [hc] at no; cases no
    rw [if_neg ne]; rfl

theorem unequalWidthError (valid : List Word) (source received : Word) (different : source.length ≠ received.length) :
    errorTrace source received = .error "ValueError: word comparison requires the same generated position carrier" ∧
    detectable valid source received = .error "ValueError: word comparison requires the same generated position carrier" := by
  have h : errorTrace source received = .error "ValueError: word comparison requires the same generated position carrier" := by
    unfold errorTrace; rw [if_neg different]
  exact ⟨h,by unfold detectable; rw [h]⟩

end SFT.InformationScience.NoiseTrace
