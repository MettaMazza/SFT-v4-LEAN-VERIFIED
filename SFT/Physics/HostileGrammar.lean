import SFT.Physics.HostilePackage
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.HostileGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Package where
  | rejected | admitted

def packageName : Package → String
  | .rejected => "mixed-code-and-data"
  | .admitted => "data-only-fold-document"

inductive Parser where
  | rejected | admitted

def parserName : Parser → String
  | .rejected => "permissive-parser"
  | .admitted => "exact-schema-parser"

inductive Field where
  | rejected | admitted

def fieldName : Field → String
  | .rejected => "ignore-extra-field"
  | .admitted => "reject-extra-field"

inductive Execution where
  | rejected | admitted

def executionName : Execution → String
  | .rejected => "execute-contributor-source"
  | .admitted => "interpreter-only-execution"

inductive Authority where
  | rejected | admitted

def authorityName : Authority → String
  | .rejected => "mutable-authority-tree"
  | .admitted => "unchanged-protected-tree"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "embedded-comparison"
  | .admitted => "postseal-separate-comparison"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "warn-and-continue"
  | .admitted => "halt-without-admission"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-route"
  | .admitted => "no-extra-route"

structure Candidate where
  package : Package
  parser : Parser
  field : Field
  execution : Execution
  authority : Authority
  comparison : Comparison
  response : Response
  extension : Extension

def sourceFields (c : Candidate) : List String := [packageName c.package, parserName c.parser, fieldName c.field, executionName c.execution, authorityName c.authority, comparisonName c.comparison, responseName c.response, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "package=" (packageName c.package), SFT.Host.Text.append "parser=" (parserName c.parser), SFT.Host.Text.append "field=" (fieldName c.field), SFT.Host.Text.append "execution=" (executionName c.execution), SFT.Host.Text.append "authority=" (authorityName c.authority), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "data-only-fold-document__exact-schema-parser__reject-extra-field__interpreter-only-execution__unchanged-protected-tree__postseal-separate-comparison__halt-without-admission__no-extra-route"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (packageName c.package) "data-only-fold-document" &&
  SFT.Host.Text.equal (parserName c.parser) "exact-schema-parser" &&
  SFT.Host.Text.equal (fieldName c.field) "reject-extra-field" &&
  SFT.Host.Text.equal (executionName c.execution) "interpreter-only-execution" &&
  SFT.Host.Text.equal (authorityName c.authority) "unchanged-protected-tree" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "postseal-separate-comparison" &&
  SFT.Host.Text.equal (responseName c.response) "halt-without-admission" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-route"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (packageName c.package) "data-only-fold-document") then "Mixed packages can execute contributor-selected behavior." else
  if !(SFT.Host.Text.equal (parserName c.parser) "exact-schema-parser") then "A permissive parser admits undeclared behavior." else
  if !(SFT.Host.Text.equal (fieldName c.field) "reject-extra-field") then "An ignored field creates divergent or hidden meaning." else
  if !(SFT.Host.Text.equal (executionName c.execution) "interpreter-only-execution") then "Direct execution exposes every ambient host capability." else
  if !(SFT.Host.Text.equal (authorityName c.authority) "unchanged-protected-tree") then "Changing census or accepted receipts can manufacture admission." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "postseal-separate-comparison") then "Embedded comparison can expose or optimize against targets." else
  if !(SFT.Host.Text.equal (responseName c.response) "halt-without-admission") then "Continuation admits a known authority or capability breach." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-route") then "An extra route bypasses the protected admission path." else
  "Strict data-only Fold document, exact parser, no unknown fields or direct source execution, unchanged authority trees, separate comparison, fail-closed response and no extra route."

def generationRule : String := "Generate the complete product of package, parser, field, execution, authority, comparison, response and extension forms."
def grammarBoundary : String := "All finite empirical prediction packages admitted through a strict data-only parser while census and model-admitted receipt authority remain protected."

def candidates : List Candidate :=
  ([Package.rejected,Package.admitted]).flatMap fun package =>
  ([Parser.rejected,Parser.admitted]).flatMap fun parser =>
  ([Field.rejected,Field.admitted]).flatMap fun field =>
  ([Execution.rejected,Execution.admitted]).flatMap fun execution =>
  ([Authority.rejected,Authority.admitted]).flatMap fun authority =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨package,parser,field,execution,authority,comparison,response,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk package parser field execution authority comparison response extension =>
    have hpackage : package ∈ [Package.rejected,Package.admitted] := by
      cases package <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hparser : parser ∈ [Parser.rejected,Parser.admitted] := by
      cases parser <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfield : field ∈ [Field.rejected,Field.admitted] := by
      cases field <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexecution : execution ∈ [Execution.rejected,Execution.admitted] := by
      cases execution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hauthority : authority ∈ [Authority.rejected,Authority.admitted] := by
      cases authority <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ package _ hpackage
    apply CommonRefinement.memFlatMap _ _ parser _ hparser
    apply CommonRefinement.memFlatMap _ _ field _ hfield
    apply CommonRefinement.memFlatMap _ _ execution _ hexecution
    apply CommonRefinement.memFlatMap _ _ authority _ hauthority
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk package parser field execution authority comparison response extension =>
    cases package <;> cases parser <;> cases field <;> cases execution <;> cases authority <;> cases comparison <;> cases response <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk package parser field execution authority comparison response extension =>
    cases package <;> cases parser <;> cases field <;> cases execution <;> cases authority <;> cases comparison <;> cases response <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.package = .admitted ∧ c.parser = .admitted ∧ c.field = .admitted ∧ c.execution = .admitted ∧ c.authority = .admitted ∧ c.comparison = .admitted ∧ c.response = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk package parser field execution authority comparison response extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem package_rejected_rejected (c : Candidate) (h : c.package = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.package eq
    rw [h] at field
    cases field

theorem parser_rejected_rejected (c : Candidate) (h : c.parser = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.parser eq
    rw [h] at field
    cases field

theorem field_rejected_rejected (c : Candidate) (h : c.field = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.field eq
    rw [h] at field
    cases field

theorem execution_rejected_rejected (c : Candidate) (h : c.execution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.execution eq
    rw [h] at field
    cases field

theorem authority_rejected_rejected (c : Candidate) (h : c.authority = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.authority eq
    rw [h] at field
    cases field

theorem comparison_rejected_rejected (c : Candidate) (h : c.comparison = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparison eq
    rw [h] at field
    cases field

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
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

end SFT.Physics.HostileGrammar
