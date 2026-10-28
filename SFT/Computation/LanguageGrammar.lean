import SFT.Computation.LanguageWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.LanguageGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "sampled-carrier"
  | .admitted => "complete-generated-carrier"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "presentation-identity"
  | .admitted => "canonical-held-identity"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "assumed-operation"
  | .admitted => "source-bound-exact-relation"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "result-only"
  | .admitted => "complete-retained-trace"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "implicit-terminal-boundary"
  | .admitted => "explicit-initial-terminal-boundary"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "opaque-assembly"
  | .admitted => "interface-preserving-composition"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "fixed-examples"
  | .admitted => "structural-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "imported-machine-model"
  | .admitted => "no-extra-computational-premise"

structure Candidate where
  carrier : Carrier
  identity : Identity
  relation : Relation
  trace : Trace
  boundary : Boundary
  composition : Composition
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, identityName c.identity, relationName c.relation, traceName c.trace, boundaryName c.boundary, compositionName c.composition, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-generated-carrier__canonical-held-identity__source-bound-exact-relation__complete-retained-trace__explicit-initial-terminal-boundary__interface-preserving-composition__structural-successor__no-extra-computational-premise"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-generated-carrier" &&
  SFT.Host.Text.equal (identityName c.identity) "canonical-held-identity" &&
  SFT.Host.Text.equal (relationName c.relation) "source-bound-exact-relation" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-retained-trace" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "explicit-initial-terminal-boundary" &&
  SFT.Host.Text.equal (compositionName c.composition) "interface-preserving-composition" &&
  SFT.Host.Text.equal (generalityName c.generality) "structural-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-computational-premise"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-generated-carrier") then "sampled-carrier removes a required exact carrier condition." else
  if !(SFT.Host.Text.equal (identityName c.identity) "canonical-held-identity") then "presentation-identity removes a required exact identity condition." else
  if !(SFT.Host.Text.equal (relationName c.relation) "source-bound-exact-relation") then "assumed-operation removes a required exact relation condition." else
  if !(SFT.Host.Text.equal (traceName c.trace) "complete-retained-trace") then "result-only removes a required exact trace condition." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "explicit-initial-terminal-boundary") then "implicit-terminal-boundary removes a required exact boundary condition." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "interface-preserving-composition") then "opaque-assembly removes a required exact composition condition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "structural-successor") then "fixed-examples removes a required exact generality condition." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-computational-premise") then "imported-machine-model removes a required exact addition condition." else
  "The forced generated symbol words and formation kernel retains complete alphabet; empty-One word; finite successor words; named productions; derivation trees; exact membership certificates; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."

def generationRule : String := "Generate the literal product of the eight registered Formal Computation structural axes for generated symbol words and formation."
def grammarBoundary : String := "All generated finite generated symbol words and formation structures whose carriers, relations, traces and interfaces are composed from admitted Foundation, Mathematics and Information Science forms. Closes generated finite languages and depth-independent word succession, not a completed infinite language object."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨carrier,identity,relation,trace,boundary,composition,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier identity relation trace boundary composition generality addition =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier identity relation trace boundary composition generality addition =>
    cases carrier <;> cases identity <;> cases relation <;> cases trace <;> cases boundary <;> cases composition <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier identity relation trace boundary composition generality addition =>
    cases carrier <;> cases identity <;> cases relation <;> cases trace <;> cases boundary <;> cases composition <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.identity = .admitted ∧ c.relation = .admitted ∧ c.trace = .admitted ∧ c.boundary = .admitted ∧ c.composition = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier identity relation trace boundary composition generality addition =>
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
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

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
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

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Computation.LanguageGrammar
