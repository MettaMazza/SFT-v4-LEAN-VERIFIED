import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.EquilibriumGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Reversibility where
  | rejected | admitted

def reversibilityName : Reversibility → String
  | .rejected => "one-way-reaction"
  | .admitted => "forward-and-reverse-transitions"

inductive Activity where
  | rejected | admitted

def activityName : Activity → String
  | .rejected => "static-no-events"
  | .admitted => "persistent-opposed-events"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "unpaired-event-counts"
  | .admitted => "paired-forward-reverse-support"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "microscopic-state-fixed"
  | .admitted => "macroscopic-composition-class-recurs"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "open-material-flow"
  | .admitted => "closed-observation-boundary"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "condition-free-equilibrium"
  | .admitted => "source-bound-condition-record"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "equilibrium-constant-only"
  | .admitted => "forward-reverse-composition-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-equilibrium-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  reversibility : Reversibility
  activity : Activity
  balance : Balance
  composition : Composition
  boundary : Boundary
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [reversibilityName c.reversibility, activityName c.activity, balanceName c.balance, compositionName c.composition, boundaryName c.boundary, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "reversibility=" (reversibilityName c.reversibility), SFT.Host.Text.append "activity=" (activityName c.activity), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "forward-and-reverse-transitions__persistent-opposed-events__paired-forward-reverse-support__macroscopic-composition-class-recurs__closed-observation-boundary__source-bound-condition-record__forward-reverse-composition-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (reversibilityName c.reversibility) "forward-and-reverse-transitions" &&
  SFT.Host.Text.equal (activityName c.activity) "persistent-opposed-events" &&
  SFT.Host.Text.equal (balanceName c.balance) "paired-forward-reverse-support" &&
  SFT.Host.Text.equal (compositionName c.composition) "macroscopic-composition-class-recurs" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "closed-observation-boundary" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "source-bound-condition-record" &&
  SFT.Host.Text.equal (recordName c.record) "forward-reverse-composition-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (reversibilityName c.reversibility) "forward-and-reverse-transitions") then "No reverse support exists." else
  if !(SFT.Host.Text.equal (activityName c.activity) "persistent-opposed-events") then "Chemical equilibrium is dynamically supported." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "paired-forward-reverse-support") then "Composition would drift." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "macroscopic-composition-class-recurs") then "Individual events need not stop." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "closed-observation-boundary") then "External flow can imitate balance." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "source-bound-condition-record") then "The class can change with conditions." else
  if !(SFT.Host.Text.equal (recordName c.record) "forward-reverse-composition-trace") then "A number cannot reconstruct dynamics." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fitted constant can force a target." else
  "forward-and-reverse-transitions__persistent-opposed-events__paired-forward-reverse-support__macroscopic-composition-class-recurs__closed-observation-boundary"

def generationRule : String := "Generate the literal product of reversibility, activity, balance, composition, boundary, condition, record and extension choices."
def grammarBoundary : String := "Every finite reversible chemical transition on one closed observation boundary for which forward and reverse event recurrences persist while their complete carrier changes pair and the retained macroscopic composition class recurs."

def candidates : List Candidate :=
  ([Reversibility.rejected,Reversibility.admitted]).flatMap fun reversibility =>
  ([Activity.rejected,Activity.admitted]).flatMap fun activity =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨reversibility,activity,balance,composition,boundary,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk reversibility activity balance composition boundary conditions record extra =>
    have hreversibility : reversibility ∈ [Reversibility.rejected,Reversibility.admitted] := by
      cases reversibility <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hactivity : activity ∈ [Activity.rejected,Activity.admitted] := by
      cases activity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ reversibility _ hreversibility
    apply CommonRefinement.memFlatMap _ _ activity _ hactivity
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk reversibility activity balance composition boundary conditions record extra =>
    cases reversibility <;> cases activity <;> cases balance <;> cases composition <;> cases boundary <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk reversibility activity balance composition boundary conditions record extra =>
    cases reversibility <;> cases activity <;> cases balance <;> cases composition <;> cases boundary <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.reversibility = .admitted ∧ c.activity = .admitted ∧ c.balance = .admitted ∧ c.composition = .admitted ∧ c.boundary = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk reversibility activity balance composition boundary conditions record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem reversibility_rejected_rejected (c : Candidate) (h : c.reversibility = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reversibility eq
    rw [h] at field
    cases field

theorem activity_rejected_rejected (c : Candidate) (h : c.activity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.activity eq
    rw [h] at field
    cases field

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

theorem conditions_rejected_rejected (c : Candidate) (h : c.conditions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditions eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Chemistry.EquilibriumGrammar
