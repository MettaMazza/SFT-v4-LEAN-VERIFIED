import SFT.Mathematics.DynamicsTraces
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Mathematics.DynamicsReturns
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

def firstSuffix (state : String) : List String → Option (List String)
  | [] => none
  | head :: tail => if head = state then some (head :: tail) else firstSuffix state tail

def scanReturn (seen : List String) : List String → Option (List String)
  | [] => none
  | terminal :: rest => match firstSuffix terminal seen with
    | some held => some (held ++ [terminal])
    | none => scanReturn (seen ++ [terminal]) rest

def firstReturn (trajectory : List String) : Option (List String) := scanReturn [] trajectory

theorem suffixNoneIff (state : String) (seen : List String) :
    firstSuffix state seen = none ↔ ¬ state ∈ seen := by
  induction seen with
  | nil => constructor
           · intro _ h; cases h
           · intro _; rfl
  | cons head tail ih =>
    change (if head = state then some (head :: tail) else firstSuffix state tail) = none ↔ _
    by_cases same : head = state
    · rw [ite_eq_left same]
      constructor
      · intro h; cases h
      · intro missing; cases same; exact False.elim (missing (List.Mem.head _))
    · rw [ite_eq_right same]
      constructor
      · intro h member
        cases member with
        | head => exact same rfl
        | tail _ ht => exact ih.mp h ht
      · intro missing
        exact ih.mpr (fun member => missing (List.Mem.tail head member))

theorem suffixFirst (state : String) (seen held : List String)
    (found : firstSuffix state seen = some held) :
    ∃ before middle, seen = before ++ state :: middle ∧ held = state :: middle ∧ ¬ state ∈ before := by
  induction seen with
  | nil => cases found
  | cons head tail ih =>
    change (if head = state then some (head :: tail) else firstSuffix state tail) = _ at found
    by_cases same : head = state
    · rw [ite_eq_left same] at found
      cases same
      cases found
      exact ⟨[],tail,rfl,rfl,fun h => by cases h⟩
    · rw [ite_eq_right same] at found
      obtain ⟨before,middle,splitSeen,splitHeld,absent⟩ := ih found
      refine ⟨head :: before,middle,?_,splitHeld,?_⟩
      · exact congrArg (List.cons head) splitSeen
      · intro member
        cases member with
        | head => exact same rfl
        | tail _ h => exact absent h

theorem distinctPrefix (left right : List String) (unique : distinct (left ++ right) = true) :
    distinct left = true := by
  induction left with
  | nil => rfl
  | cons head tail ih =>
    have p := (distinctCons head (tail ++ right)).mp unique
    apply (distinctCons _ _).mpr
    refine ⟨(absentIff _ _).mpr ?_,ih p.2⟩
    intro member
    exact (absentIff _ _).mp p.1 (memAppendLeft _ _ _ member)

theorem freshAtBoundary (seen : List String) (state : String) (rest : List String)
    (unique : distinct (seen ++ state :: rest) = true) : ¬ state ∈ seen := by
  induction seen with
  | nil => intro h; cases h
  | cons head tail ih =>
    have p := (distinctCons head (tail ++ state :: rest)).mp unique
    intro member
    cases member with
    | head => exact (absentIff _ _).mp p.1 (memAppendRight _ _ _ (List.Mem.head _))
    | tail _ h => exact ih p.2 h

theorem scanNoneIff (seen rest : List String) (unique : distinct seen = true) :
    scanReturn seen rest = none ↔ distinct (seen ++ rest) = true := by
  induction rest generalizing seen with
  | nil =>
    have appendNil : seen ++ [] = seen := by
      clear unique
      induction seen with
      | nil => rfl
      | cons head tail ih => exact congrArg (List.cons head) ih
    constructor
    · intro _; rw [appendNil]; exact unique
    · intro _; rfl
  | cons terminal tail ih =>
    change (match firstSuffix terminal seen with | some held => some (held ++ [terminal]) | none => scanReturn (seen ++ [terminal]) tail) = none ↔ _
    cases hit : firstSuffix terminal seen with
    | some held =>
      constructor
      · intro h; cases h
      · intro h
        have fresh := freshAtBoundary seen terminal tail h
        have none := (suffixNoneIff _ _).mpr fresh
        rw [hit] at none
        cases none
    | none =>
      have fresh := (suffixNoneIff _ _).mp hit
      have extended := freshAppendDistinct seen terminal unique ((absentIff _ _).mpr fresh)
      have joined : (seen ++ [terminal]) ++ tail = seen ++ terminal :: tail :=
        ExactTraceArithmetic.appendAssociative seen [terminal] tail
      constructor
      · intro result
        have h := (ih (seen ++ [terminal]) extended).mp result
        rw [joined] at h
        exact h
      · intro h
        apply (ih (seen ++ [terminal]) extended).mpr
        rw [joined]
        exact h

theorem scanEarliest (seen rest held : List String) (unique : distinct seen = true)
    (found : scanReturn seen rest = some held) :
    ∃ before middle terminal after,
      seen ++ rest = (before ++ terminal :: middle) ++ terminal :: after ∧
      held = (terminal :: middle) ++ [terminal] ∧
      distinct (before ++ terminal :: middle) = true ∧ ¬ terminal ∈ before := by
  induction rest generalizing seen with
  | nil => cases found
  | cons terminal tail ih =>
    change (match firstSuffix terminal seen with | some part => some (part ++ [terminal]) | none => scanReturn (seen ++ [terminal]) tail) = _ at found
    cases hit : firstSuffix terminal seen with
    | some part =>
      rw [hit] at found
      obtain ⟨before,middle,splitSeen,splitPart,absent⟩ := suffixFirst terminal seen part hit
      cases found
      refine ⟨before,middle,terminal,tail,?_,?_,?_,absent⟩
      · exact congrArg (fun xs => xs ++ terminal :: tail) splitSeen
      · rw [splitPart]
      · rw [← splitSeen]; exact unique
    | none =>
      rw [hit] at found
      have fresh := (suffixNoneIff _ _).mp hit
      have extended := freshAppendDistinct seen terminal unique ((absentIff _ _).mpr fresh)
      obtain ⟨before,middle,last,after,splitInput,splitHeld,priorDistinct,priorAbsent⟩ := ih (seen ++ [terminal]) extended found
      refine ⟨before,middle,last,after,?_,splitHeld,priorDistinct,priorAbsent⟩
      have joined : (seen ++ [terminal]) ++ tail = seen ++ terminal :: tail :=
        ExactTraceArithmetic.appendAssociative seen [terminal] tail
      exact joined.symm.trans splitInput

theorem firstReturnNoneIff (trajectory : List String) :
    firstReturn trajectory = none ↔ distinct trajectory = true :=
  scanNoneIff [] trajectory rfl

theorem firstReturnEarliest (trajectory held : List String) (found : firstReturn trajectory = some held) :
    ∃ before middle terminal after,
      trajectory = (before ++ terminal :: middle) ++ terminal :: after ∧
      held = (terminal :: middle) ++ [terminal] ∧
      distinct (before ++ terminal :: middle) = true ∧ ¬ terminal ∈ before :=
  scanEarliest [] trajectory held rfl found

theorem returnedTracePositive (trajectory held : List String) (found : firstReturn trajectory = some held) :
    ∃ terminal middle, held = (terminal :: middle) ++ [terminal] := by
  obtain ⟨before,middle,terminal,after,_,same,_,_⟩ := firstReturnEarliest trajectory held found
  exact ⟨terminal,middle,same⟩

theorem returnedTraceLength (trajectory held : List String) (found : firstReturn trajectory = some held) :
    ∃ middle : List String, held.length = middle.length + 2 := by
  obtain ⟨terminal,middle,same⟩ := returnedTracePositive trajectory held found
  refine ⟨middle,?_⟩
  rw [same,SFT.Foundation.CommonRefinement.appendLength]
  rfl

theorem returnedTrajectoryValid (transitions : DynamicsTraces.Transitions) (trajectory held : List String)
    (valid : DynamicsTraces.trajectoryValid transitions trajectory = true)
    (found : firstReturn trajectory = some held) : DynamicsTraces.trajectoryValid transitions held = true := by
  obtain ⟨before,middle,terminal,after,splitInput,splitHeld,_,_⟩ := firstReturnEarliest trajectory held found
  rw [splitInput] at valid
  have firstPart := ((DynamicsTraces.trajectoryComposition transitions (before ++ terminal :: middle) after terminal).mp valid).1
  have joined : (before ++ terminal :: middle) ++ [terminal] = before ++ terminal :: (middle ++ [terminal]) :=
    ExactTraceArithmetic.appendAssociative before (terminal :: middle) [terminal]
  rw [joined] at firstPart
  have returnPart := ((DynamicsTraces.trajectoryComposition transitions before (middle ++ [terminal]) terminal).mp firstPart).2
  rw [splitHeld]
  exact returnPart

end SFT.Mathematics.DynamicsReturns
