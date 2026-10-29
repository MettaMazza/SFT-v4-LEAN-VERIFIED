import SFT.Computation.AlgebraGeometryTrace
import SFT.Computation.OrderingTrace
import SFT.InformationScience.EncodingMaps
namespace SFT.Computation.DynamicProgrammingTrace
open SFT.Foundation.Count.TraceDerivation
open SFT.InformationScience.EncodingMaps

-- Typed retained rows for the decomposition, exact recurrence and result table
-- named by the pinned Dynamic Programming carrier law. No recurrence is chosen.
abbrev Table := List (String × String)
abbrev Rule := String × List String × String
abbrev Task := String × List String

def inputs (table : Table) : List String → Option (List String)
 | [] => some []
 | key :: rest => match lookupFirst table key with
   | none => none
   | some value => match inputs table rest with
     | none => none
     | some values => some (value :: values)

def matchingResults (rules : List Rule) (key : String) (values : List String) : List String :=
  (rules.filter (fun row => decide (row.1 = key ∧ row.2.1 = values))).map (fun row => row.2.2)

def result (rules : List Rule) (key : String) (values : List String) : Option String :=
  match matchingResults rules key values with
  | [] => none
  | value :: rest => match rest with
    | [] => some value
    | _ :: _ => none

def run (rules : List Rule) (table : Table) : List Task → Option Table
 | [] => some table
 | (key,deps) :: rest => match inputs table deps with
   | none => none
   | some values => match result rules key values with
     | none => none
     | some value => run rules (table ++ [(key,value)]) rest

inductive Reads (table : Table) : List String → List String → Prop where
 | empty : Reads table [] []
 | next (key value keys values) (held : lookupFirst table key = some value)
     (tail : Reads table keys values) : Reads table (key :: keys) (value :: values)

theorem readsReconstruct (table : Table) (keys values : List String) (h : Reads table keys values) :
    inputs table keys = some values := by
  induction h with
  | empty => rfl
  | next key value keys values held tail ih => unfold inputs; rw [held,ih]

theorem inputsReads (table : Table) (keys values : List String) (h : inputs table keys = some values) :
    Reads table keys values := by
  induction keys generalizing values with
  | nil => cases h; exact .empty
  | cons key keys ih =>
    unfold inputs at h
    cases found : lookupFirst table key with
    | none => rw [found] at h; contradiction
    | some value =>
      rw [found] at h
      dsimp only at h
      cases tail : inputs table keys with
      | none => rw [tail] at h; contradiction
      | some more => rw [tail] at h; cases h; exact .next _ _ _ _ found (ih _ tail)

theorem readCount (table : Table) (keys values : List String) (h : Reads table keys values) :
    values.length = keys.length := by
  induction h with
  | empty => rfl
  | next key value keys values held tail ih => exact congrArg Nat.succ ih

inductive Execution (rules : List Rule) : Table → List Task → Table → Prop where
 | base (table) : Execution rules table [] table
 | next (table key deps values value rest terminal)
     (dependencies : Reads table deps values) (recurrence : result rules key values = some value)
     (tail : Execution rules (table ++ [(key,value)]) rest terminal) :
     Execution rules table ((key,deps) :: rest) terminal

theorem executionReplays (rules : List Rule) (table terminal : Table) (tasks : List Task)
    (h : Execution rules table tasks terminal) : run rules table tasks = some terminal := by
  induction h with
  | base => rfl
  | next table key deps values value rest terminal dependencies recurrence tail ih =>
    unfold run; rw [readsReconstruct _ _ _ dependencies]; dsimp only; rw [recurrence]; exact ih

theorem runExecution (rules : List Rule) (table terminal : Table) (tasks : List Task)
    (h : run rules table tasks = some terminal) : Execution rules table tasks terminal := by
  induction tasks generalizing table with
  | nil => cases h; exact .base _
  | cons task rest ih =>
    cases task with
    | mk key deps =>
      unfold run at h
      cases dep : inputs table deps with
      | none => rw [dep] at h; contradiction
      | some values =>
        rw [dep] at h
        dsimp only at h
        cases rec : result rules key values with
        | none => rw [rec] at h; contradiction
        | some value => rw [rec] at h; exact .next _ _ _ _ _ _ _ (inputsReads _ _ _ dep) rec (ih _ h)

theorem matchedRow (rules : List Rule) (key value : String) (values : List String)
    (h : value ∈ matchingResults rules key values) : (key,values,value) ∈ rules := by
  obtain ⟨row,member,same⟩ := memMapPreimage (fun row : Rule => row.2.2) _ _ h
  have parts := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp member
  have identities := of_decide_eq_true parts.2
  cases row with
  | mk a bc => cases bc with
    | mk b c => dsimp only at identities same; cases identities.1; cases identities.2; cases same; exact parts.1

theorem selectedRow (rules : List Rule) (key value : String) (values : List String)
    (h : result rules key values = some value) : (key,values,value) ∈ rules := by
  unfold result at h
  cases found : matchingResults rules key values with
  | nil => rw [found] at h; contradiction
  | cons first rest =>
    cases rest with
    | nil => rw [found] at h; cases h; exact matchedRow _ _ _ _ (by rw [found]; exact .head _)
    | cons second more => rw [found] at h; contradiction

-- A retained result has a finite expansion through exact recurrence rows.
inductive Derivation (graph : List Task) (rules : List Rule) : String → String → Prop where
 | step (key value : String) (deps values : List String)
     (decomposition : (key,deps) ∈ graph)
     (row : (key,values,value) ∈ rules)
     (count : deps.length = values.length)
     (children : ∀ dep answer, (dep,answer) ∈ deps.zip values → Derivation graph rules dep answer) :
     Derivation graph rules key value


def Validated (property : String → String → Prop) (table : Table) : Prop :=
  ∀ key value, (key,value) ∈ table → property key value

theorem readProvenance (table : Table) (keys values : List String) (h : Reads table keys values) :
    ∀ key value, (key,value) ∈ keys.zip values → (key,value) ∈ table := by
  induction h with
  | empty => intro key value impossible; cases impossible
  | next key value keys values held tail ih =>
    intro dep answer member
    cases member with
    | head => exact lookupRow _ _ _ held
    | tail _ member => exact ih dep answer member

theorem extendValidated (property : String → String → Prop) (table : Table) (key value : String)
    (old : Validated property table) (added : property key value) :
    Validated property (table ++ [(key,value)]) := by
  intro dep answer member
  cases memAppendCases _ _ _ member with
  | inl prior => exact old dep answer prior
  | inr fresh => cases fresh with
    | head => exact added
    | tail _ impossible => cases impossible

-- Each local recurrence must establish the particular problem's invariant.
-- This is the source's explicit decomposition/optimal-substructure obligation.
theorem problemInvariant (rules : List Rule) (graph tasks : List Task) (table terminal : Table)
    (property : String → String → Prop)
    (localRule : ∀ key deps values value, (key,deps) ∈ graph →
      (key,values,value) ∈ rules → deps.length = values.length →
      (∀ dep answer, (dep,answer) ∈ deps.zip values → property dep answer) → property key value)
    (covered : ∀ task, task ∈ tasks → task ∈ graph)
    (initial : Validated property table) (trace : Execution rules table tasks terminal) :
    Validated property terminal := by
  induction trace with
  | base => exact initial
  | next table key deps values value rest terminal dependencies recurrence tail ih =>
    have proved := localRule key deps values value (covered _ (.head _))
      (selectedRow _ _ _ _ recurrence) (readCount _ _ _ dependencies).symm
      (fun dep answer held => initial dep answer (readProvenance _ _ _ dependencies dep answer held))
    exact ih (fun task held => covered task (.tail _ held)) (extendValidated _ _ _ _ initial proved)

theorem finalReconstruction (rules : List Rule) (graph tasks : List Task) (table terminal : Table)
    (covered : ∀ task, task ∈ tasks → task ∈ graph)
    (initial : Validated (Derivation graph rules) table)
    (trace : Execution rules table tasks terminal) : Validated (Derivation graph rules) terminal :=
  problemInvariant rules graph tasks table terminal (Derivation graph rules)
    (fun key deps values value decomposition row count children => .step key value deps values decomposition row count children)
    covered initial trace

theorem fromEmpty (rules : List Rule) (tasks : List Task) (terminal : Table)
    (finished : run rules [] tasks = some terminal) : Validated (Derivation tasks rules) terminal :=
  finalReconstruction _ _ _ _ _ (fun _ held => held) (fun _ _ impossible => by cases impossible)
    (runExecution _ _ _ _ finished)

theorem reusedResult (table suffix : Table) (key value : String)
    (held : lookupFirst table key = some value) : lookupFirst (table ++ suffix) key = some value := by
  induction table with
  | nil => cases held
  | cons row rest ih =>
    cases row with
    | mk name answer =>
      unfold lookupFirst at held
      change (if name = key then some answer else lookupFirst (rest ++ suffix) key) = some value
      by_cases same : name = key
      · rw [ite_eq_left same] at held ⊢; exact held
      · rw [ite_eq_right same] at held ⊢; exact ih held

theorem appendIdentity (table : Table) : table ++ [] = table := by
  induction table with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row) ih

theorem terminalExtension (rules : List Rule) (table terminal : Table) (tasks : List Task)
    (trace : Execution rules table tasks terminal) : ∃ suffix, terminal = table ++ suffix := by
  induction trace with
  | base => exact ⟨[],(appendIdentity _).symm⟩
  | next table key deps values value rest terminal dependencies recurrence tail ih =>
    obtain ⟨suffix,h⟩ := ih
    exact ⟨(key,value) :: suffix,h.trans (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _)⟩

theorem cachedIdentityRetained (rules : List Rule) (table terminal : Table) (tasks : List Task)
    (trace : Execution rules table tasks terminal) (key value : String)
    (held : lookupFirst table key = some value) : lookupFirst terminal key = some value := by
  obtain ⟨suffix,h⟩ := terminalExtension _ _ _ _ trace
  cases h; exact reusedResult _ _ _ _ held

theorem composition (rules : List Rule) (table middle terminal : Table) (first second : List Task)
    (left : Execution rules table first middle) (right : Execution rules middle second terminal) :
    Execution rules table (first ++ second) terminal := by
  induction left with
  | base => exact right
  | next table key deps values value rest middle dependencies recurrence tail ih =>
    exact .next _ _ _ _ _ _ _ dependencies recurrence (ih right)

theorem missingDependency (rules : List Rule) (table : Table) (key : String) (deps : List String) (rest : List Task)
    (missing : inputs table deps = none) : run rules table ((key,deps) :: rest) = none := by
  unfold run; rw [missing]

theorem unresolvedRecurrence (rules : List Rule) (table : Table) (key : String) (deps values : List String) (rest : List Task)
    (held : inputs table deps = some values) (missing : result rules key values = none) :
    run rules table ((key,deps) :: rest) = none := by
  unfold run; rw [held]; dsimp only; rw [missing]

theorem identityBase (rules : List Rule) (table : Table) : run rules table [] = some table := rfl


theorem successor (rules : List Rule) (table current : Table) (tasks : List Task)
    (trace : Execution rules table tasks current) (key value : String) (deps values : List String)
    (dependencies : Reads current deps values) (recurrence : result rules key values = some value) :
    Execution rules table (tasks ++ [(key,deps)]) (current ++ [(key,value)]) :=
  composition _ _ _ _ _ _ trace (.next _ _ _ _ _ _ _ dependencies recurrence (.base _))

theorem tableCount (rules : List Rule) (table terminal : Table) (tasks : List Task)
    (trace : Execution rules table tasks terminal) : terminal.length = table.length + tasks.length := by
  induction trace with
  | base => exact (Nat.add_zero _).symm
  | next table key deps values value rest terminal dependencies recurrence tail ih =>
    rw [SFT.Foundation.CommonRefinement.appendLength] at ih
    exact ih.trans (Nat.add_right_comm _ 1 rest.length)


theorem tableIdentities (rules : List Rule) (table terminal : Table) (tasks : List Task)
    (trace : Execution rules table tasks terminal) :
    terminal.map Prod.fst = table.map Prod.fst ++ tasks.map Prod.fst := by
  induction trace with
  | base =>
    have identity : ∀ xs : List String, xs ++ [] = xs := by
      intro xs
      induction xs with
      | nil => rfl
      | cons x rest ih => exact congrArg (List.cons x) ih
    exact (identity _).symm
  | next table key deps values value rest terminal dependencies recurrence tail ih =>
    rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend] at ih
    exact ih.trans (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _)

theorem distinctResults (rules : List Rule) (table terminal : Table) (tasks : List Task)
    (trace : Execution rules table tasks terminal)
    (identities : SFT.Mathematics.DiscreteObjects.distinct
      (table.map Prod.fst ++ tasks.map Prod.fst) = true) :
    SFT.Mathematics.DiscreteObjects.distinct (terminal.map Prod.fst) = true := by
  rw [tableIdentities _ _ _ _ trace]; exact identities

end SFT.Computation.DynamicProgrammingTrace


