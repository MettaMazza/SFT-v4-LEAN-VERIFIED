import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.FunctionalGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "whole-molecule-only"
  | .admitted => "named-atom-or-group-support"

inductive Embedding where
  | rejected | admitted

def embeddingName : Embedding → String
  | .rejected => "isolated-fragment"
  | .admitted => "molecular-embedding-held"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "one-molecule-only"
  | .admitted => "recurs-across-molecules"

inductive Reaction where
  | rejected | admitted

def reactionName : Reaction → String
  | .rejected => "shape-without-transition-role"
  | .admitted => "characteristic-reaction-role"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "context-erases-group"
  | .admitted => "group-identity-retained"

inductive Context where
  | rejected | admitted

def contextName : Context → String
  | .rejected => "universal-context-free-response"
  | .admitted => "molecular-context-bounded"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "group-name-only"
  | .admitted => "substructure-and-reaction-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-functional-taxonomy"
  | .admitted => "no-extra-rule"

structure Candidate where
  support : Support
  embedding : Embedding
  recurrence : Recurrence
  reaction : Reaction
  identity : Identity
  context : Context
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [supportName c.support, embeddingName c.embedding, recurrenceName c.recurrence, reactionName c.reaction, identityName c.identity, contextName c.context, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "embedding=" (embeddingName c.embedding), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "reaction=" (reactionName c.reaction), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "context=" (contextName c.context), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "named-atom-or-group-support__molecular-embedding-held__recurs-across-molecules__characteristic-reaction-role__group-identity-retained__molecular-context-bounded__substructure-and-reaction-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "named-atom-or-group-support" &&
  SFT.Host.Text.equal (embeddingName c.embedding) "molecular-embedding-held" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "recurs-across-molecules" &&
  SFT.Host.Text.equal (reactionName c.reaction) "characteristic-reaction-role" &&
  SFT.Host.Text.equal (identityName c.identity) "group-identity-retained" &&
  SFT.Host.Text.equal (contextName c.context) "molecular-context-bounded" &&
  SFT.Host.Text.equal (recordName c.record) "substructure-and-reaction-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "named-atom-or-group-support") then "No recurrent substructure is identified." else
  if !(SFT.Host.Text.equal (embeddingName c.embedding) "molecular-embedding-held") then "A functional group acts in a molecule." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "recurs-across-molecules") then "No group class is established." else
  if !(SFT.Host.Text.equal (reactionName c.reaction) "characteristic-reaction-role") then "Function requires chemical behavior." else
  if !(SFT.Host.Text.equal (identityName c.identity) "group-identity-retained") then "The group cannot be followed." else
  if !(SFT.Host.Text.equal (contextName c.context) "molecular-context-bounded") then "Neighboring structure can modify response." else
  if !(SFT.Host.Text.equal (recordName c.record) "substructure-and-reaction-trace") then "Recurrence cannot be reproduced." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An imported list selects the group." else
  "named-atom-or-group-support__molecular-embedding-held__recurs-across-molecules__characteristic-reaction-role__group-identity-retained"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete carrier preservation, exact equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite molecular carrier with complete named substructures, boundary bonds and generated source-bound reaction traces."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Embedding.rejected,Embedding.admitted]).flatMap fun embedding =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Reaction.rejected,Reaction.admitted]).flatMap fun reaction =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Context.rejected,Context.admitted]).flatMap fun context =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨support,embedding,recurrence,reaction,identity,context,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support embedding recurrence reaction identity context record extra =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hembedding : embedding ∈ [Embedding.rejected,Embedding.admitted] := by
      cases embedding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreaction : reaction ∈ [Reaction.rejected,Reaction.admitted] := by
      cases reaction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontext : context ∈ [Context.rejected,Context.admitted] := by
      cases context <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ embedding _ hembedding
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ reaction _ hreaction
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ context _ hcontext
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support embedding recurrence reaction identity context record extra =>
    cases support <;> cases embedding <;> cases recurrence <;> cases reaction <;> cases identity <;> cases context <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support embedding recurrence reaction identity context record extra =>
    cases support <;> cases embedding <;> cases recurrence <;> cases reaction <;> cases identity <;> cases context <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.embedding = .admitted ∧ c.recurrence = .admitted ∧ c.reaction = .admitted ∧ c.identity = .admitted ∧ c.context = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support embedding recurrence reaction identity context record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem embedding_rejected_rejected (c : Candidate) (h : c.embedding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.embedding eq
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

theorem reaction_rejected_rejected (c : Candidate) (h : c.reaction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reaction eq
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

theorem context_rejected_rejected (c : Candidate) (h : c.context = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.context eq
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

end SFT.Chemistry.FunctionalGrammar
