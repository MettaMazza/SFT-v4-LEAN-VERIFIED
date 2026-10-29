import SFT.Computation.ParallelAlgorithm
import SFT.Computation.ProcessFailure
namespace SFT.Computation.DistributedReplay
open StateTransition
open SFT.InformationScience.EncodingMaps
open SFT.Foundation.Count.TraceDerivation

abbrev Registry := List (String × System)
abbrev Store := List (String × String)

structure Event where
  identity : String
  process : String
  before : String
  action : String
  after : String

def update (store : Store) (process value : String) : Store :=
  store.map (fun row => if row.1 = process then (row.1,value) else row)

-- Checker for retained local execution rows, using the unchanged source step.
def replayEvent (registry : Registry) (store : Store) (event : Event) : Option Store :=
  match lookupFirst registry event.process with
  | none => none
  | some machine => match lookupFirst store event.process with
    | none => none
    | some current => if current = event.before then
        match step machine current event.action with
        | .error _ => none
        | .ok next => if next = event.after then some (update store event.process next) else none
      else none

def replay (registry : Registry) (store : Store) : List Event → Option Store
 | [] => some store
 | event :: rest => match replayEvent registry store event with
   | none => none
   | some next => replay registry next rest

inductive LocalStep (registry : Registry) (store : Store) (event : Event) : Prop where
 | witnessed (machine : System)
     (registered : lookupFirst registry event.process = some machine)
     (current : lookupFirst store event.process = some event.before)
     (transition : step machine event.before event.action = .ok event.after) : LocalStep registry store event

theorem localReplay (registry : Registry) (store : Store) (event : Event)
    (certificate : LocalStep registry store event) :
    replayEvent registry store event = some (update store event.process event.after) := by
  cases certificate with
  | witnessed machine registered current transition =>
    unfold replayEvent; rw [registered]; dsimp only; rw [current]; dsimp only
    rw [ite_eq_left rfl,transition]; dsimp only; rw [ite_eq_left rfl]

theorem replayLocal (registry : Registry) (store next : Store) (event : Event)
    (accepted : replayEvent registry store event = some next) :
    LocalStep registry store event ∧ next = update store event.process event.after := by
  unfold replayEvent at accepted
  cases registered : lookupFirst registry event.process with
  | none => rw [registered] at accepted; contradiction
  | some machine =>
    rw [registered] at accepted; dsimp only at accepted
    cases current : lookupFirst store event.process with
    | none => rw [current] at accepted; contradiction
    | some state =>
      rw [current] at accepted; dsimp only at accepted
      by_cases same : state = event.before
      · rw [ite_eq_left same] at accepted
        cases moved : step machine state event.action with
        | error reason => rw [moved] at accepted; contradiction
        | ok value =>
          rw [moved] at accepted; dsimp only at accepted
          by_cases target : value = event.after
          · rw [ite_eq_left target] at accepted
            cases same; cases target
            exact ⟨.witnessed _ registered current moved,(Option.some.inj accepted).symm⟩
          · rw [ite_eq_right target] at accepted; contradiction
      · rw [ite_eq_right same] at accepted; contradiction

theorem updateOther (store : Store) (process value other : String) (different : process ≠ other) :
    lookupFirst (update store process value) other = lookupFirst store other := by
  induction store with
  | nil => rfl
  | cons row rest ih =>
    cases row with
    | mk name old =>
      change lookupFirst ((if name = process then (name,value) else (name,old)) :: update rest process value) other =
        (if name = other then some old else lookupFirst rest other)
      by_cases selected : name = process
      · rw [ite_eq_left selected]
        change (if name = other then some value else lookupFirst (update rest process value) other) =
          (if name = other then some old else lookupFirst rest other)
        have differentName : name ≠ other := fun h => different (selected.symm.trans h)
        rw [ite_eq_right differentName,ite_eq_right differentName]; exact ih
      · rw [ite_eq_right selected]
        change (if name = other then some old else lookupFirst (update rest process value) other) =
          (if name = other then some old else lookupFirst rest other)
        by_cases named : name = other
        · rw [ite_eq_left named,ite_eq_left named]
        · rw [ite_eq_right named,ite_eq_right named]; exact ih

theorem updateSelected (store : Store) (process old value : String)
    (held : lookupFirst store process = some old) :
    lookupFirst (update store process value) process = some value := by
  induction store with
  | nil => cases held
  | cons row rest ih =>
    cases row with
    | mk name prior =>
      change lookupFirst ((if name = process then (name,value) else (name,prior)) :: update rest process value) process = some value
      by_cases same : name = process
      · rw [ite_eq_left same]; unfold lookupFirst; rw [ite_eq_left same]
      · unfold lookupFirst at held; rw [ite_eq_right same] at held
        rw [ite_eq_right same]; unfold lookupFirst; rw [ite_eq_right same]; exact ih held

theorem retainedIdentities (store : Store) (process value : String) :
    (update store process value).map Prod.fst = store.map Prod.fst := by
  induction store with
  | nil => rfl
  | cons row rest ih =>
    cases row with
    | mk name prior =>
      change (if name = process then (name,value) else (name,prior)).1 :: (update rest process value).map Prod.fst = name :: rest.map Prod.fst
      by_cases same : name = process
      · rw [ite_eq_left same]; exact congrArg (List.cons name) ih
      · rw [ite_eq_right same]; exact congrArg (List.cons name) ih

inductive GlobalTrace (registry : Registry) : Store → List Event → Store → Prop where
 | base (store) : GlobalTrace registry store [] store
 | next (store event rest terminal)
     (localStep : LocalStep registry store event)
     (tail : GlobalTrace registry (update store event.process event.after) rest terminal) :
     GlobalTrace registry store (event :: rest) terminal

theorem globalReplay (registry : Registry) (store terminal : Store) (events : List Event)
    (trace : GlobalTrace registry store events terminal) : replay registry store events = some terminal := by
  induction trace with
  | base => rfl
  | next store event rest terminal localStep tail ih =>
    unfold replay; rw [localReplay _ _ _ localStep]; exact ih

theorem globalDerivation (registry : Registry) (store terminal : Store) (events : List Event)
    (accepted : replay registry store events = some terminal) : GlobalTrace registry store events terminal := by
  induction events generalizing store with
  | nil => cases accepted; exact .base _
  | cons event rest ih =>
    unfold replay at accepted
    cases h : replayEvent registry store event with
    | none => rw [h] at accepted; contradiction
    | some next =>
      rw [h] at accepted
      have p := replayLocal _ _ _ _ h
      rw [p.2] at accepted
      exact .next _ _ _ _ p.1 (ih _ accepted)

theorem globalIdentities (registry : Registry) (store terminal : Store) (events : List Event)
    (trace : GlobalTrace registry store events terminal) : terminal.map Prod.fst = store.map Prod.fst := by
  induction trace with
  | base => rfl
  | next store event rest terminal localStep tail ih => exact ih.trans (retainedIdentities _ _ _)

theorem unaffectedProcess (registry : Registry) (store terminal : Store) (events : List Event)
    (trace : GlobalTrace registry store events terminal) (process : String)
    (absent : ∀ event, event ∈ events → event.process ≠ process) :
    lookupFirst terminal process = lookupFirst store process := by
  induction trace with
  | base => rfl
  | next store event rest terminal localStep tail ih =>
    exact (ih (fun event held => absent event (.tail _ held))).trans (updateOther _ _ _ _ (absent _ (.head _)))

theorem composition (registry : Registry) (store middle terminal : Store) (first second : List Event)
    (one : GlobalTrace registry store first middle) (two : GlobalTrace registry middle second terminal) :
    GlobalTrace registry store (first ++ second) terminal := by
  induction one with
  | base => exact two
  | next store event rest middle localStep tail ih => exact .next _ _ _ _ localStep (ih two)

theorem successor (registry : Registry) (store middle : Store) (events : List Event) (event : Event)
    (prior : GlobalTrace registry store events middle) (next : LocalStep registry middle event) :
    GlobalTrace registry store (events ++ [event]) (update middle event.process event.after) :=
  composition _ _ _ _ _ _ prior (.next _ _ _ _ next (.base _))
end SFT.Computation.DistributedReplay
