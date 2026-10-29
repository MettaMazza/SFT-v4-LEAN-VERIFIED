import SFT.Computation.CommunicationResources
import SFT.Foundation.MeasurementProtocol
namespace SFT.Computation.RandomnessResources
open UniversalInterpretation StateTransition StateComposition
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.DiscreteObjects

abbrev Branch := String × Request
abbrev Schedule := List Branch

def execute (branch : Branch) : String × Except String (List String) :=
  (branch.1,run branch.2.machine branch.2.initial branch.2.actions)

def executions (schedule : Schedule) := schedule.map execute

theorem completeSchedule (schedule : Schedule) :
    (executions schedule).map Prod.fst = schedule.map Prod.fst := by
  induction schedule with
  | nil => rfl
  | cons branch rest ih => exact congrArg (List.cons branch.1) ih

theorem everyExecution (schedule : Schedule) (row : String × Except String (List String)) :
    row ∈ executions schedule ↔ ∃ branch, branch ∈ schedule ∧ execute branch = row := by
  constructor
  · intro h
    induction schedule with
    | nil => cases h
    | cons branch rest ih =>
      cases h with
      | head => exact ⟨branch,.head _,rfl⟩
      | tail _ member =>
        obtain ⟨other,held,equal⟩ := ih member
        exact ⟨other,.tail _ held,equal⟩
  · intro ⟨branch,held,equal⟩
    rw [← equal]
    exact memMap execute branch schedule held

theorem allBranchTraces (schedule : Schedule) (branch : Branch) (held : branch ∈ schedule)
    (trace : List String) (observed : run branch.2.machine branch.2.initial branch.2.actions = .ok trace) :
    (branch.1,.ok trace) ∈ executions schedule ∧
      ∃ before terminal, trace = before ++ [terminal] ∧
        Path branch.2.machine branch.2.initial branch.2.actions before terminal := by
  obtain ⟨initial,before,terminal,equal,path⟩ := nativePath _ _ _ _ observed
  refine ⟨(everyExecution _ _).mpr ⟨branch,held,?_⟩,before,terminal,equal,path⟩
  unfold execute
  rw [observed]

theorem failedBranchRetained (schedule : Schedule) (branch : Branch) (held : branch ∈ schedule)
    (reason : String) (failed : run branch.2.machine branch.2.initial branch.2.actions = .error reason) :
    (branch.1,.error reason) ∈ executions schedule := by
  apply (everyExecution _ _).mpr
  refine ⟨branch,held,?_⟩
  unfold execute
  rw [failed]

def endLabel : List String → Option String
 | [] => none
 | [label] => some label
 | _ :: next :: rest => endLabel (next :: rest)

theorem terminalLabel (before : List String) (terminal : String) :
    endLabel (before ++ [terminal]) = some terminal := by
  induction before with
  | nil => rfl
  | cons row rest ih =>
    cases rest with
    | nil => rfl
    | cons next tail => exact ih

inductive Outcome where
 | failed : String → Outcome
 | returned : Option String → Outcome
 deriving DecidableEq

def outcome (branch : Branch) : Outcome :=
  match run branch.2.machine branch.2.initial branch.2.actions with
  | .error reason => .failed reason
  | .ok trace => .returned (endLabel trace)

theorem terminalOutcome (branch : Branch) (before : List String) (terminal : String)
    (executed : run branch.2.machine branch.2.initial branch.2.actions = .ok (before ++ [terminal])) :
    outcome branch = .returned (some terminal) := by
  unfold outcome
  rw [executed]
  exact congrArg Outcome.returned (terminalLabel _ _)

def outputClass (schedule : Schedule) (value : Outcome) : Schedule :=
  schedule.filter fun branch => decide (outcome branch = value)

theorem outputClassMeaning (schedule : Schedule) (value : Outcome)
    (branch : Branch) : branch ∈ outputClass schedule value ↔
      branch ∈ schedule ∧ outcome branch = value := by
  constructor
  · intro h
    have parts := (filterMemberIff _ _ _).mp h
    exact ⟨parts.1,of_decide_eq_true parts.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem outputClassesCover (schedule : Schedule) (branch : Branch) (held : branch ∈ schedule) :
    branch ∈ outputClass schedule (outcome branch) :=
  (outputClassMeaning _ _ _).mpr ⟨held,rfl⟩

theorem outputClassesDisjoint (schedule : Schedule) (first second : Outcome)
    (branch : Branch) (left : branch ∈ outputClass schedule first)
    (right : branch ∈ outputClass schedule second) : first = second :=
  ((outputClassMeaning _ _ _).mp left).2.symm.trans ((outputClassMeaning _ _ _).mp right).2

theorem deterministicOutcome (branch : Branch) (first second : Outcome)
    (left : outcome branch = first) (right : outcome branch = second) : first = second :=
  left.symm.trans right

theorem scheduleComposition (first second : Schedule) :
    executions (first ++ second) = executions first ++ executions second :=
  CommunicationResources.mapAppend _ _ _

theorem completeScheduleCount (schedule : Schedule) :
    (executions schedule).length = schedule.length := CommunicationResources.mapLength _ _

theorem successorSchedule (schedule : Schedule) (branch : Branch) :
    executions (schedule ++ [branch]) = executions schedule ++ [execute branch] :=
  scheduleComposition _ _

theorem singletonSchedule (branch : Branch) : executions [branch] = [execute branch] := rfl

theorem scheduleDescriptionCost (word : SFT.InformationScience.EncodingClasses.Codeword)
    (cells : List (String × String)) (ledger : ResourceRecord.Ledger)
    (recorded : InputExtent.ExactExtent word cells ledger) :
    ledger.timeTrace.map Prod.snd = word ∧ ledger.spaceSupport = cells.map Prod.fst ∧
      ledger.timeCount = word.length ∧ ledger.spaceCount = word.length :=
  InputExtent.completeExtent _ _ _ recorded

-- The external-source alternative retains the original measurement boundary.
-- A measured record does not supply a new causal or probability axiom.
theorem measuredSourceBoundary (preSeal mutation allRows identified : Bool)
    (accepted : SFT.Foundation.MeasurementProtocol.accepts preSeal mutation allRows identified = true) :
    preSeal = false ∧ mutation = false ∧ allRows = true ∧ identified = true :=
  (SFT.Foundation.MeasurementProtocol.acceptanceIff _ _ _ _).mp accepted
open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder

theorem registeredScheduleDescription (registry : List (String × Schedule))
    (support : List Codeword) (encoding : Encoding) (decoder : Decoder)
    (valid : validateEncoding (registry.map Prod.fst) support encoding = true)
    (inverse : exactDecoder (registry.map Prod.fst) encoding = some decoder)
    (name : String) (schedule : Schedule) (held : (name,schedule) ∈ registry) :
    ∃ word, word ∈ support ∧ lookupFirst encoding name = some word ∧ decode word decoder = .ok name :=
  InputExtent.canonicalInput _ _ _ _ valid inverse name (memMap Prod.fst _ _ held)

theorem retainedDescriptionCost (registry : List (String × Schedule)) (name : String)
    (schedule : Schedule) (selected : lookupFirst registry name = some schedule)
    (encoding : Encoding) (word : Codeword) (encoded : lookupFirst encoding name = some word)
    (cells : List (String × String)) (ledger : ResourceRecord.Ledger)
    (recorded : InputExtent.ExactExtent word cells ledger) :
    (name,schedule) ∈ registry ∧ (name,word) ∈ encoding ∧
      ledger.spaceCount = word.length ∧ ledger.timeCount = word.length :=
  ⟨lookupRow _ _ _ selected,lookupRow _ _ _ encoded,
    (InputExtent.completeExtent _ _ _ recorded).2.2.2,
    (InputExtent.completeExtent _ _ _ recorded).2.2.1⟩
end SFT.Computation.RandomnessResources
