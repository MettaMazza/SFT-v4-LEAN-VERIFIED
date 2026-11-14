import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.TerminalLambEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "replace-or-erase-predecessor"
  | .admitted => "retain-and-version-predecessor"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-partial-support"
  | .admitted => "complete-typed-terminal-support"

inductive Operation where
  | rejected | admitted

def operationName : Operation → String
  | .rejected => "signed-floating-or-complex-series"
  | .admitted => "ordered-positive-held-parts"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "selected-or-open-order"
  | .admitted => "finite-carrier-exhaustion-order"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "untyped-coefficient-list"
  | .admitted => "role-preserving-exact-composition"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "unbounded-extra-correction"
  | .admitted => "no-generated-carrier-remains"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "measurement-readable-execution"
  | .admitted => "target-inaccessible-until-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "hidden-fit-or-forward-claim"
  | .admitted => "disclosed-observational-prediction-protocol"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "result-without-root-trace"
  | .admitted => "complete-root-directed-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-term"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  support : Support
  operation : Operation
  order : Order
  composition : Composition
  closure : Closure
  target : Target
  provenance : Provenance
  trace : Trace
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, supportName c.support, operationName c.operation, orderName c.order, compositionName c.composition, closureName c.closure, targetName c.target, provenanceName c.provenance, traceName c.trace, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "operation=" (operationName c.operation), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "retain-and-version-predecessor__complete-typed-terminal-support__ordered-positive-held-parts__finite-carrier-exhaustion-order__role-preserving-exact-composition__no-generated-carrier-remains__target-inaccessible-until-seal__disclosed-observational-prediction-protocol__complete-root-directed-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "retain-and-version-predecessor" &&
  SFT.Host.Text.equal (supportName c.support) "complete-typed-terminal-support" &&
  SFT.Host.Text.equal (operationName c.operation) "ordered-positive-held-parts" &&
  SFT.Host.Text.equal (orderName c.order) "finite-carrier-exhaustion-order" &&
  SFT.Host.Text.equal (compositionName c.composition) "role-preserving-exact-composition" &&
  SFT.Host.Text.equal (closureName c.closure) "no-generated-carrier-remains" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "disclosed-observational-prediction-protocol" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-root-directed-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "replace-or-erase-predecessor" then "An immutable admitted receipt cannot be rewritten." else
  if SFT.Host.Text.equal (supportName c.support) "selected-partial-support" then "A selected subset can tune a precision value." else
  if SFT.Host.Text.equal (operationName c.operation) "signed-floating-or-complex-series" then "Signed, floating, irrational or complex proof values violate the Fold domain." else
  if SFT.Host.Text.equal (orderName c.order) "selected-or-open-order" then "A selected truncation or open series is a free choice." else
  if SFT.Host.Text.equal (compositionName c.composition) "untyped-coefficient-list" then "An untyped list does not force a relation." else
  if SFT.Host.Text.equal (closureName c.closure) "unbounded-extra-correction" then "An unbounded correction family is not closed." else
  if SFT.Host.Text.equal (targetName c.target) "measurement-readable-execution" then "A target-readable execution cannot issue a prediction seal." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "hidden-fit-or-forward-claim" then "Hiding prior target knowledge or calling it blind forward forcing is invalid." else
  if SFT.Host.Text.equal (traceName c.trace) "result-without-root-trace" then "An untraced value is inadmissible." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-extra-term" then "An extra term is a parameter." else
  "The unique target-inaccessible ratio is alpha^3[53/64-(10/109)alpha-alpha^2/(3*53*64)-alpha^3/(53*64)]."

def generationRule : String := "Generate the complete ten-axis terminal Lamb successor product and exhaust the typed heavy/support/bridge/return carriers."
def grammarBoundary : String := "All first terminal alpha-cubed completions of the admitted live-vacuum n=2 Lamb direction using depth-three heavy complement, predecessor-up binary support, down-depth transport, generator support and the sole terminal return exactly once."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Operation.rejected,Operation.admitted]).flatMap fun operation =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,support,operation,order,composition,closure,target,provenance,trace,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor support operation order composition closure target provenance trace extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperation : operation ∈ [Operation.rejected,Operation.admitted] := by
      cases operation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ operation _ hoperation
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor support operation order composition closure target provenance trace extension =>
    cases predecessor <;> cases support <;> cases operation <;> cases order <;> cases composition <;> cases closure <;> cases target <;> cases provenance <;> cases trace <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor support operation order composition closure target provenance trace extension =>
    cases predecessor <;> cases support <;> cases operation <;> cases order <;> cases composition <;> cases closure <;> cases target <;> cases provenance <;> cases trace <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.support = .admitted ∧ c.operation = .admitted ∧ c.order = .admitted ∧ c.composition = .admitted ∧ c.closure = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.trace = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor support operation order composition closure target provenance trace extension =>
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem operation_rejected_rejected (c : Candidate) (h : c.operation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.operation eq
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
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

end SFT.Physics.TerminalLambEntryGrammar
