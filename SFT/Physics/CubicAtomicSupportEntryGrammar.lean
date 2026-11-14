import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CubicAtomicSupportEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "untyped-observed-label"
  | .admitted => "generated-exact-Fold-carrier"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-partial-support"
  | .admitted => "complete-typed-support"

inductive Operation where
  | rejected | admitted

def operationName : Operation → String
  | .rejected => "imported-continuum-operation"
  | .admitted => "exact-positive-Fold-operation"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-or-erased-direction"
  | .admitted => "held-label-orientation"

inductive Depth where
  | rejected | admitted

def depthName : Depth → String
  | .rejected => "selected-depth"
  | .admitted => "forced-counted-depth"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "measurement-readable-relation"
  | .admitted => "target-inaccessible-formal-relation"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "result-without-dependency-trace"
  | .admitted => "complete-root-directed-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  support : Support
  operation : Operation
  orientation : Orientation
  depth : Depth
  provenance : Provenance
  trace : Trace
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, supportName c.support, operationName c.operation, orientationName c.orientation, depthName c.depth, provenanceName c.provenance, traceName c.trace, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "operation=" (operationName c.operation), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "depth=" (depthName c.depth), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "generated-exact-Fold-carrier__complete-typed-support__exact-positive-Fold-operation__held-label-orientation__forced-counted-depth__target-inaccessible-formal-relation__complete-root-directed-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "generated-exact-Fold-carrier" &&
  SFT.Host.Text.equal (supportName c.support) "complete-typed-support" &&
  SFT.Host.Text.equal (operationName c.operation) "exact-positive-Fold-operation" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-label-orientation" &&
  SFT.Host.Text.equal (depthName c.depth) "forced-counted-depth" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "target-inaccessible-formal-relation" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-root-directed-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "untyped-observed-label" then "A label alone is not a generated law." else
  if SFT.Host.Text.equal (supportName c.support) "selected-partial-support" then "A selected subset can tune the result." else
  if SFT.Host.Text.equal (operationName c.operation) "imported-continuum-operation" then "An imported continuum operation violates the exact domain." else
  if SFT.Host.Text.equal (orientationName c.orientation) "signed-or-erased-direction" then "Signed proof values or erased direction violate the domain." else
  if SFT.Host.Text.equal (depthName c.depth) "selected-depth" then "A chosen depth is a parameter." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "measurement-readable-relation" then "A measured target cannot construct or select the survivor." else
  if SFT.Host.Text.equal (traceName c.trace) "result-without-dependency-trace" then "An untraced result cannot be admitted." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-extra-rule" then "An extra rule introduces a choice." else
  "The unique cubic support has 2*3=6 nearest neighbours, exact weight 1/12 per neighbour and complete balance 6/12=1/2."

def generationRule : String := "Generate the complete eight-axis cubic-support product."
def grammarBoundary : String := "All nearest-neighbour organizations using every held direction on every forced spatial axis and an exact equal partition of the half-One balance."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Operation.rejected,Operation.admitted]).flatMap fun operation =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Depth.rejected,Depth.admitted]).flatMap fun depth =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,support,operation,orientation,depth,provenance,trace,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier support operation orientation depth provenance trace extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperation : operation ∈ [Operation.rejected,Operation.admitted] := by
      cases operation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepth : depth ∈ [Depth.rejected,Depth.admitted] := by
      cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ operation _ hoperation
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ depth _ hdepth
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier support operation orientation depth provenance trace extension =>
    cases carrier <;> cases support <;> cases operation <;> cases orientation <;> cases depth <;> cases provenance <;> cases trace <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier support operation orientation depth provenance trace extension =>
    cases carrier <;> cases support <;> cases operation <;> cases orientation <;> cases depth <;> cases provenance <;> cases trace <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.support = .admitted ∧ c.operation = .admitted ∧ c.orientation = .admitted ∧ c.depth = .admitted ∧ c.provenance = .admitted ∧ c.trace = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier support operation orientation depth provenance trace extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
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

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
    rw [h] at field
    cases field

theorem depth_rejected_rejected (c : Candidate) (h : c.depth = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.depth eq
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

end SFT.Physics.CubicAtomicSupportEntryGrammar
