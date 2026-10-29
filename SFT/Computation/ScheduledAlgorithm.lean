import SFT.Computation.OptimizationTrace
import SFT.Computation.RandomnessResources
import SFT.Mathematics.ProbabilityEvents
namespace SFT.Computation.ScheduledAlgorithm
open RandomnessResources StateTransition UniversalInterpretation ResourceRecord
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics DiscreteObjects ProbabilityEvents GeometryTopology AlgebraOperations

-- One held deterministic kernel, every registered action schedule in order.
def branches (machine : System) (initial : String) (schedules : List (String × List String)) : Schedule :=
  schedules.map (fun row => (row.1,Request.mk machine initial row.2))

def successNames (schedule : Schedule) (target : Outcome) : List String :=
  (outputClass schedule target).map Prod.fst

def successPart (schedule : Schedule) (target : Outcome) : Except String Weight :=
  exactWeight (schedule.map Prod.fst) (successNames schedule target)

variable (occupied : Branch → List String)

def resource (branch : Branch) : Except String Ledger :=
  match run branch.2.machine branch.2.initial branch.2.actions with
  | .error reason => .error reason
  | .ok trace => resourceLedger trace (occupied branch)

def records (schedule : Schedule) := schedule.map (fun branch => (execute branch,resource occupied branch))

theorem branchIdentity (machine : System) (initial : String) (schedules : List (String × List String)) :
    (branches machine initial schedules).map Prod.fst = schedules.map Prod.fst := by
  induction schedules with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.1) ih

theorem exactScheduledRun (machine : System) (initial : String) (schedules : List (String × List String))
    (name : String) (actions trace : List String) (held : (name,actions) ∈ schedules)
    (executed : run machine initial actions = .ok trace) :
    (name,.ok trace) ∈ executions (branches machine initial schedules) := by
  have present := memMap (fun row : String × List String => (row.1,Request.mk machine initial row.2)) _ _ held
  exact (allBranchTraces _ _ present _ executed).1

theorem completeRecords (schedule : Schedule) :
    (records occupied schedule).map Prod.fst = executions schedule := by
  induction schedule with
  | nil => rfl
  | cons branch rest ih => exact congrArg (List.cons (execute branch)) ih

theorem recordCount (schedule : Schedule) : (records occupied schedule).length = schedule.length :=
  CommunicationResources.mapLength _ _

theorem branchRecord (schedule : Schedule) (branch : Branch) (held : branch ∈ schedule) :
    (execute branch,resource occupied branch) ∈ records occupied schedule := memMap _ _ _ held

theorem successProvenance (schedule : Schedule) (target : Outcome) (name : String) :
    name ∈ successNames schedule target ↔
      ∃ branch, branch ∈ schedule ∧ branch.1 = name ∧ outcome branch = target := by
  constructor
  · intro h
    obtain ⟨branch,held,same⟩ := memMapPreimage Prod.fst _ _ h
    have p := (outputClassMeaning _ _ _).mp held
    exact ⟨branch,p.1,same,p.2⟩
  · intro ⟨branch,held,same,returned⟩
    rw [← same]
    exact memMap Prod.fst _ _ ((outputClassMeaning _ _ _).mpr ⟨held,returned⟩)

theorem successContained (schedule : Schedule) (target : Outcome) (name : String)
    (held : name ∈ successNames schedule target) : name ∈ schedule.map Prod.fst := by
  obtain ⟨branch,present,same,returned⟩ := (successProvenance _ _ _).mp held
  rw [← same]; exact memMap Prod.fst _ _ present

theorem selectedIdentityDistinct (schedule : Schedule) (predicate : Branch → Bool)
    (unique : distinct (schedule.map Prod.fst) = true) :
    distinct ((schedule.filter predicate).map Prod.fst) = true := by
  induction schedule with
  | nil => rfl
  | cons branch rest ih =>
    have p := (distinctCons _ _).mp unique
    cases decision : predicate branch with
    | false =>
      rw [List.filter_cons_of_neg (p := predicate) (by rw [decision]; intro h; cases h)]
      exact ih p.2
    | true =>
      rw [List.filter_cons_of_pos (p := predicate) decision]
      apply (distinctCons _ _).mpr
      refine ⟨?_,ih p.2⟩
      apply (absentIff _ _).mpr
      intro held
      obtain ⟨other,member,same⟩ := memMapPreimage Prod.fst _ _ held
      have prior := (filterMemberIff _ _ _).mp member
      apply (absentIff _ _).mp p.1
      rw [← same]; exact memMap Prod.fst _ _ prior.1

theorem admittedSuccessEvent (schedule : Schedule) (target : Outcome)
    (canonical : (schedule.map Prod.fst).isEmpty = false)
    (unique : distinct (schedule.map Prod.fst) = true) :
    exactEvent (schedule.map Prod.fst) (successNames schedule target) =
      .ok (if (successNames schedule target).isEmpty then emptyOne else successNames schedule target) := by
  apply eventAdmitted
  · rw [canonical,unique]; rfl
  · have selection : distinct (successNames schedule target) = true :=
      selectedIdentityDistinct _ _ unique
    have contained : (successNames schedule target).any (fun name => !has (schedule.map Prod.fst) name) = false :=
      anyFalseOfMembers _ _ (fun name held => by rw [(hasIff _ _).mpr (successContained _ _ _ held)]; rfl)
    rw [selection,contained]; rfl

theorem exactSuccessRatio (schedule : Schedule) (target : Outcome)
    (fraction : SFT.Foundation.ExactOperations.PositiveFraction)
    (accepted : successPart schedule target = .ok (.inr fraction)) :
    (successNames schedule target).length * fraction.denominator =
      fraction.numerator * (schedule.map Prod.fst).length := weightExactRatio _ _ _ accepted

theorem successThroughOne (schedule : Schedule) (target : Outcome)
    (fraction : SFT.Foundation.ExactOperations.PositiveFraction)
    (accepted : successPart schedule target = .ok (.inr fraction)) :
    fraction.numerator ≤ fraction.denominator := weightThroughOne _ _ _ accepted

theorem noSuccessMarker (schedule : Schedule) (target : Outcome)
    (canonical : ((schedule.map Prod.fst).isEmpty || !distinct (schedule.map Prod.fst)) = false)
    (empty : successNames schedule target = []) :
    successPart schedule target = .ok (.inl emptyOne) := by
  unfold successPart; rw [empty]; exact emptyEventWeight _ canonical

theorem resourceReconstruction (branch : Branch) (trace : List String) (ledger : Ledger)
    (executed : run branch.2.machine branch.2.initial branch.2.actions = .ok trace)
    (recorded : resource occupied branch = .ok ledger) :
    ledger.timeTrace.map Prod.snd = trace ∧ ledger.spaceSupport = (occupied branch) ∧
      ledger.timeCount = branch.2.actions.length + 1 ∧ ledger.spaceCount = (occupied branch).length := by
  unfold resource at recorded; rw [executed] at recorded
  have p := recordReconstructs _ _ _ recorded
  exact ⟨p.1,p.2.1,executionObservationCount _ _ _ _ _ _ executed recorded,p.2.2.2⟩

theorem failureRetained (branch : Branch) (reason : String)
    (failed : run branch.2.machine branch.2.initial branch.2.actions = .error reason) :
    resource occupied branch = .error reason := by
  unfold resource; rw [failed]

theorem recordComposition (first second : Schedule) :
    records occupied (first ++ second) = records occupied first ++ records occupied second := CommunicationResources.mapAppend _ _ _

theorem successor (schedule : Schedule) (branch : Branch) :
    records occupied (schedule ++ [branch]) = records occupied schedule ++ [(execute branch,resource occupied branch)] := recordComposition _ _ _

theorem oneBase (branch : Branch) : records occupied [branch] = [(execute branch,resource occupied branch)] := rfl
end SFT.Computation.ScheduledAlgorithm
