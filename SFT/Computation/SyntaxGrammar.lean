import SFT.Computation.SyntaxWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.SyntaxGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Syntax where
  | rejected | admitted

def syntaxName : Syntax → String
  | .rejected => "partial-or-ambiguous-syntax"
  | .admitted => "complete-generated-syntax"

inductive Binding where
  | rejected | admitted

def bindingName : Binding → String
  | .rejected => "presentation-name"
  | .admitted => "canonical-held-binding"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "informal-meaning"
  | .admitted => "exact-semantic-relation"

inductive Evaluation where
  | rejected | admitted

def evaluationName : Evaluation → String
  | .rejected => "result-only"
  | .admitted => "complete-evaluation-trace"

inductive Equivalence where
  | rejected | admitted

def equivalenceName : Equivalence → String
  | .rejected => "visual-equivalence"
  | .admitted => "observation-bound-equivalence"

inductive Proof where
  | rejected | admitted

def proofName : Proof → String
  | .rejected => "test-only"
  | .admitted => "machine-checkable-proof-object"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "sample-programs"
  | .admitted => "syntax-successor-certificate"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "imported-language-semantics"
  | .admitted => "no-extra-semantic-premise"

structure Candidate where
  syntaxAxis : Syntax
  binding : Binding
  relation : Relation
  evaluation : Evaluation
  equivalence : Equivalence
  proof : Proof
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [syntaxName c.syntaxAxis, bindingName c.binding, relationName c.relation, evaluationName c.evaluation, equivalenceName c.equivalence, proofName c.proof, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "syntax=" (syntaxName c.syntaxAxis), SFT.Host.Text.append "binding=" (bindingName c.binding), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "evaluation=" (evaluationName c.evaluation), SFT.Host.Text.append "equivalence=" (equivalenceName c.equivalence), SFT.Host.Text.append "proof=" (proofName c.proof), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-generated-syntax__canonical-held-binding__exact-semantic-relation__complete-evaluation-trace__observation-bound-equivalence__machine-checkable-proof-object__syntax-successor-certificate__no-extra-semantic-premise"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (syntaxName c.syntaxAxis) "complete-generated-syntax" &&
  SFT.Host.Text.equal (bindingName c.binding) "canonical-held-binding" &&
  SFT.Host.Text.equal (relationName c.relation) "exact-semantic-relation" &&
  SFT.Host.Text.equal (evaluationName c.evaluation) "complete-evaluation-trace" &&
  SFT.Host.Text.equal (equivalenceName c.equivalence) "observation-bound-equivalence" &&
  SFT.Host.Text.equal (proofName c.proof) "machine-checkable-proof-object" &&
  SFT.Host.Text.equal (generalityName c.generality) "syntax-successor-certificate" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-semantic-premise"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (syntaxName c.syntaxAxis) "complete-generated-syntax") then "partial-or-ambiguous-syntax removes a required exact syntax condition." else
  if !(SFT.Host.Text.equal (bindingName c.binding) "canonical-held-binding") then "presentation-name removes a required exact binding condition." else
  if !(SFT.Host.Text.equal (relationName c.relation) "exact-semantic-relation") then "informal-meaning removes a required exact relation condition." else
  if !(SFT.Host.Text.equal (evaluationName c.evaluation) "complete-evaluation-trace") then "result-only removes a required exact evaluation condition." else
  if !(SFT.Host.Text.equal (equivalenceName c.equivalence) "observation-bound-equivalence") then "visual-equivalence removes a required exact equivalence condition." else
  if !(SFT.Host.Text.equal (proofName c.proof) "machine-checkable-proof-object") then "test-only removes a required exact proof condition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "syntax-successor-certificate") then "sample-programs removes a required exact generality condition." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-semantic-premise") then "imported-language-semantics removes a required exact addition condition." else
  "The forced generated program forms kernel retains complete token alphabet; formation productions; syntax trees; held constructor identities; membership derivation; malformed rejection; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."

def generationRule : String := "Generate the literal product of the eight registered Semantics and Mathematical Programming Theory structural axes for generated program forms."
def grammarBoundary : String := "All generated finite generated program forms structures whose carriers, relations, traces and interfaces are composed from admitted Foundation, Mathematics and Information Science forms. Syntax alone assigns no execution meaning."

def candidates : List Candidate :=
  ([Syntax.rejected,Syntax.admitted]).flatMap fun syntaxAxis =>
  ([Binding.rejected,Binding.admitted]).flatMap fun binding =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Evaluation.rejected,Evaluation.admitted]).flatMap fun evaluation =>
  ([Equivalence.rejected,Equivalence.admitted]).flatMap fun equivalence =>
  ([Proof.rejected,Proof.admitted]).flatMap fun proof =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨syntaxAxis,binding,relation,evaluation,equivalence,proof,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk syntaxAxis binding relation evaluation equivalence proof generality addition =>
    have hsyntax : syntaxAxis ∈ [Syntax.rejected,Syntax.admitted] := by
      cases syntaxAxis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbinding : binding ∈ [Binding.rejected,Binding.admitted] := by
      cases binding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevaluation : evaluation ∈ [Evaluation.rejected,Evaluation.admitted] := by
      cases evaluation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequivalence : equivalence ∈ [Equivalence.rejected,Equivalence.admitted] := by
      cases equivalence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproof : proof ∈ [Proof.rejected,Proof.admitted] := by
      cases proof <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ syntaxAxis _ hsyntax
    apply CommonRefinement.memFlatMap _ _ binding _ hbinding
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ evaluation _ hevaluation
    apply CommonRefinement.memFlatMap _ _ equivalence _ hequivalence
    apply CommonRefinement.memFlatMap _ _ proof _ hproof
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk syntaxAxis binding relation evaluation equivalence proof generality addition =>
    cases syntaxAxis <;> cases binding <;> cases relation <;> cases evaluation <;> cases equivalence <;> cases proof <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk syntaxAxis binding relation evaluation equivalence proof generality addition =>
    cases syntaxAxis <;> cases binding <;> cases relation <;> cases evaluation <;> cases equivalence <;> cases proof <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.syntaxAxis = .admitted ∧ c.binding = .admitted ∧ c.relation = .admitted ∧ c.evaluation = .admitted ∧ c.equivalence = .admitted ∧ c.proof = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk syntaxAxis binding relation evaluation equivalence proof generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem syntax_rejected_rejected (c : Candidate) (h : c.syntaxAxis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.syntaxAxis eq
    rw [h] at field
    cases field

theorem binding_rejected_rejected (c : Candidate) (h : c.binding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.binding eq
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

theorem evaluation_rejected_rejected (c : Candidate) (h : c.evaluation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.evaluation eq
    rw [h] at field
    cases field

theorem equivalence_rejected_rejected (c : Candidate) (h : c.equivalence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equivalence eq
    rw [h] at field
    cases field

theorem proof_rejected_rejected (c : Candidate) (h : c.proof = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.proof eq
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

end SFT.Computation.SyntaxGrammar
