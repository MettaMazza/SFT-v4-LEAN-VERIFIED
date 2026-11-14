import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.AtomicShellPeriodicityEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "replace-or-relabel-capacity"
  | .admitted => "compose-immutable-orbit-capacity"

inductive Shell where
  | rejected | admitted

def shellName : Shell → String
  | .rejected => "selected-width-list"
  | .admitted => "all-positive-orbit-ranks-through-n"

inductive Sum where
  | rejected | admitted

def sumName : Sum → String
  | .rejected => "asserted-two-n-square"
  | .admitted => "exact-complete-capacity-sum"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "memorized-filling-table"
  | .admitted => "increasing-joint-cover-principal-tie"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "chosen-period-endpoints"
  | .admitted => "first-cell-then-complete-rank-two-boundary"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "free-reset-rule"
  | .admitted => "successor-after-held-closure"

inductive Ionization where
  | rejected | admitted

def ionizationName : Ionization → String
  | .rejected => "strict-stepwise-monotonicity"
  | .admitted => "rising-envelope-and-boundary-reset"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "external-data-readable"
  | .admitted => "target-inaccessible-until-seal"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "answer-without-dependencies"
  | .admitted => "complete-root-directed-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-exception-or-width"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  shell : Shell
  sum : Sum
  order : Order
  closure : Closure
  recurrence : Recurrence
  ionization : Ionization
  target : Target
  trace : Trace
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, shellName c.shell, sumName c.sum, orderName c.order, closureName c.closure, recurrenceName c.recurrence, ionizationName c.ionization, targetName c.target, traceName c.trace, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "shell=" (shellName c.shell), SFT.Host.Text.append "sum=" (sumName c.sum), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "ionization=" (ionizationName c.ionization), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "compose-immutable-orbit-capacity__all-positive-orbit-ranks-through-n__exact-complete-capacity-sum__increasing-joint-cover-principal-tie__first-cell-then-complete-rank-two-boundary__successor-after-held-closure__rising-envelope-and-boundary-reset__target-inaccessible-until-seal__complete-root-directed-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "compose-immutable-orbit-capacity" &&
  SFT.Host.Text.equal (shellName c.shell) "all-positive-orbit-ranks-through-n" &&
  SFT.Host.Text.equal (sumName c.sum) "exact-complete-capacity-sum" &&
  SFT.Host.Text.equal (orderName c.order) "increasing-joint-cover-principal-tie" &&
  SFT.Host.Text.equal (closureName c.closure) "first-cell-then-complete-rank-two-boundary" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "successor-after-held-closure" &&
  SFT.Host.Text.equal (ionizationName c.ionization) "rising-envelope-and-boundary-reset" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-root-directed-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "replace-or-relabel-capacity" then "A successor may not rewrite an immutable receipt." else
  if SFT.Host.Text.equal (shellName c.shell) "selected-width-list" then "A width list is an imported answer." else
  if SFT.Host.Text.equal (sumName c.sum) "asserted-two-n-square" then "Asserting the result supplies no derivation." else
  if SFT.Host.Text.equal (orderName c.order) "memorized-filling-table" then "A memorized table would select the result." else
  if SFT.Host.Text.equal (closureName c.closure) "chosen-period-endpoints" then "Chosen endpoints are measured inputs." else
  if SFT.Host.Text.equal (recurrenceName c.recurrence) "free-reset-rule" then "A reset rule is a parameter." else
  if SFT.Host.Text.equal (ionizationName c.ionization) "strict-stepwise-monotonicity" then "Strict monotonicity erases genuine within-period distinctions." else
  if SFT.Host.Text.equal (targetName c.target) "external-data-readable" then "Target-readable execution cannot seal a prediction." else
  if SFT.Host.Text.equal (traceName c.trace) "answer-without-dependencies" then "An untraced answer is inadmissible." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-exception-or-width" then "An ungenerated exception is a parameter." else
  "For every positive n, sum from orbit rank One through n of 2(1+2(r-1)) equals 2n^2. The generated closures are 2,10,18,36,54,86,118 and their successive widths are 2,8,8,18,18,32,32; ionization comparison tests endpoint-above-start and endpoint-to-next-start reset while retaining internal dips."

def generationRule : String := "Generate the complete ten-axis atomic shell, cover-order, closure, recurrence, ionization-envelope, custody, trace and extension product."
def grammarBoundary : String := "All positive principal shells, every valid principal/orbit cell in increasing joint-cover order, the admitted atomic endpoint, and the first complete empirical period/reset vector."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Shell.rejected,Shell.admitted]).flatMap fun shell =>
  ([Sum.rejected,Sum.admitted]).flatMap fun sum =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Ionization.rejected,Ionization.admitted]).flatMap fun ionization =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,shell,sum,order,closure,recurrence,ionization,target,trace,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor shell sum order closure recurrence ionization target trace extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hshell : shell ∈ [Shell.rejected,Shell.admitted] := by
      cases shell <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsum : sum ∈ [Sum.rejected,Sum.admitted] := by
      cases sum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hionization : ionization ∈ [Ionization.rejected,Ionization.admitted] := by
      cases ionization <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ shell _ hshell
    apply CommonRefinement.memFlatMap _ _ sum _ hsum
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ ionization _ hionization
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor shell sum order closure recurrence ionization target trace extension =>
    cases predecessor <;> cases shell <;> cases sum <;> cases order <;> cases closure <;> cases recurrence <;> cases ionization <;> cases target <;> cases trace <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor shell sum order closure recurrence ionization target trace extension =>
    cases predecessor <;> cases shell <;> cases sum <;> cases order <;> cases closure <;> cases recurrence <;> cases ionization <;> cases target <;> cases trace <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.shell = .admitted ∧ c.sum = .admitted ∧ c.order = .admitted ∧ c.closure = .admitted ∧ c.recurrence = .admitted ∧ c.ionization = .admitted ∧ c.target = .admitted ∧ c.trace = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor shell sum order closure recurrence ionization target trace extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
    rw [h] at field
    cases field

theorem shell_rejected_rejected (c : Candidate) (h : c.shell = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.shell eq
    rw [h] at field
    cases field

theorem sum_rejected_rejected (c : Candidate) (h : c.sum = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sum eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
    rw [h] at field
    cases field

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
    rw [h] at field
    cases field

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
    rw [h] at field
    cases field

theorem ionization_rejected_rejected (c : Candidate) (h : c.ionization = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ionization eq
    rw [h] at field
    cases field

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem trace_rejected_rejected (c : Candidate) (h : c.trace = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trace eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.AtomicShellPeriodicityEntryGrammar
