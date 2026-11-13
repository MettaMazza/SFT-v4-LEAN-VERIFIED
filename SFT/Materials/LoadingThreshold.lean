import SFT.Mathematics.FoldScalar
import SFT.Host.Canonical
namespace SFT.Materials.LoadingThreshold
open SFT.Host.Canonical

inductive Kind where
 | plastic | indentation | failure

inductive Outcome (before after : Value) where
 | restored (same : after = before)
 | persistent (kind : Kind) (changed : after ≠ before)

structure Event where
 load : SFT.Mathematics.FoldScalar.Scalar
 beforeOrganization : Value
 afterReleaseOrganization : Value
 outcome : Outcome beforeOrganization afterReleaseOrganization
 completeTrace : Value

def persistent (event : Event) : Bool :=
 match event.outcome with
 | .restored _ => false
 | .persistent _ _ => true

theorem persistentChangesOrganization (event : Event) (held : persistent event = true) :
 event.afterReleaseOrganization ≠ event.beforeOrganization := by
 cases event with
 | mk load before after outcome trace =>
  cases outcome with
  | restored same => cases held
  | persistent kind changed => exact changed

theorem precedingRestoresOrganization (event : Event) (held : persistent event = false) :
 event.afterReleaseOrganization = event.beforeOrganization := by
 cases event with
 | mk load before after outcome trace =>
  cases outcome with
  | restored same => exact same
  | persistent kind changed => cases held

def first : List Event → Option Event
 | [] => none
 | event::rest =>
  match persistent event with
  | true => some event
  | false => first rest

theorem firstMeaning (events : List Event) (event : Event) (found : first events = some event) :
 ∃ earlierRows suffix, events = earlierRows ++ event::suffix ∧
 (∀ prior, prior ∈ earlierRows → persistent prior = false) ∧ persistent event = true := by
 induction events with
 | nil => cases found
 | cons head rest ih =>
  cases hp : persistent head with
  | false =>
   rw [first,hp] at found
   obtain ⟨earlierRows,suffix,same,earlier,changed⟩ := ih found
   refine ⟨head::earlierRows,suffix,?_,?_,changed⟩
   · exact congrArg (List.cons head) same
   · intro prior member
     cases member with
     | head => exact hp
     | tail _ member => exact earlier prior member
  | true =>
   rw [first,hp] at found
   have same := Option.some.inj found
   cases same
   exact ⟨[],rest,rfl,(fun _ absent => by cases absent),hp⟩

theorem noThresholdMeaning (events : List Event) (noneFound : first events = none) :
 ∀ event, event ∈ events → persistent event = false := by
 induction events with
 | nil => intro event absent; cases absent
 | cons head rest ih =>
  cases hp : persistent head with
  | false =>
   rw [first,hp] at noneFound
   intro event member
   cases member with
   | head => exact hp
   | tail _ held => exact ih noneFound event held
  | true => rw [first,hp] at noneFound; cases noneFound

structure Test where
 material : Value
 method : Value
 geometry : Value
 scale : Value
 conditions : Value
 events : List Event

def threshold (test : Test) := (first test.events).map Event.load

def record (test : Test) := (test,first test.events,threshold test)

theorem thresholdIsActualLoad (test : Test) (event : Event) (found : first test.events = some event) :
 threshold test = some event.load := by
 unfold threshold
 rw [found]
 rfl

theorem thresholdHasNoEarlierPersistentChange (test : Test) (event : Event)
 (found : first test.events = some event) :
 ∃ earlierRows suffix, test.events = earlierRows ++ event::suffix ∧
 (∀ prior, prior ∈ earlierRows → prior.afterReleaseOrganization = prior.beforeOrganization) ∧
 event.afterReleaseOrganization ≠ event.beforeOrganization := by
 obtain ⟨earlierRows,suffix,shape,prior,changed⟩ := firstMeaning test.events event found
 exact ⟨earlierRows,suffix,shape,(fun row held => precedingRestoresOrganization row (prior row held)),
  persistentChangesOrganization event changed⟩

theorem testBoundaryRetained (test : Test) :
 (record test).1.method = test.method ∧ (record test).1.geometry = test.geometry ∧
 (record test).1.scale = test.scale ∧ (record test).1.conditions = test.conditions :=
 ⟨rfl,rfl,rfl,rfl⟩

theorem completeLoadingPathRetained (test : Test) : (record test).1.events = test.events := rfl

def records (tests : List Test) := tests.map record

theorem base (test : Test) : records [test] = [record test] := rfl

theorem successor (tests : List Test) (next : Test) :
 records (tests ++ [next]) = records tests ++ [record next] := by
 induction tests with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (record head)) ih

end SFT.Materials.LoadingThreshold
