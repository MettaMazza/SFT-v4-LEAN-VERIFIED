import SFT.Mathematics.LogicWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.LogicGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Proposition where
  | rejected | admitted

def propositionName : Proposition → String
  | .rejected => "presentation-sentence"
  | .admitted => "canonical-distinguished-form"

inductive Denial where
  | rejected | admitted

def denialName : Denial → String
  | .rejected => "negative-truth-value"
  | .admitted => "complementary-held-orientation"

inductive Conjunction where
  | rejected | admitted

def conjunctionName : Conjunction → String
  | .rejected => "single-side-proof"
  | .admitted => "joint-complete-proof"

inductive Disjunction where
  | rejected | admitted

def disjunctionName : Disjunction → String
  | .rejected => "unidentified-choice"
  | .admitted => "held-alternative-with-support"

inductive Implication where
  | rejected | admitted

def implicationName : Implication → String
  | .rejected => "truth-table-import"
  | .admitted => "proof-carrying-transition"

inductive Inference where
  | rejected | admitted

def inferenceName : Inference → String
  | .rejected => "conclusion-only"
  | .admitted => "complete-dependency-trace"

inductive Consistency where
  | rejected | admitted

def consistencyName : Consistency → String
  | .rejected => "assumed-consistent"
  | .admitted => "no-opposed-admission"

inductive Soundness where
  | rejected | admitted

def soundnessName : Soundness → String
  | .rejected => "authority-or-name"
  | .admitted => "rule-and-witness-preservation"

inductive Completeness where
  | rejected | admitted

def completenessName : Completeness → String
  | .rejected => "unbounded-global-claim"
  | .admitted => "registered-grammar-exhaustion"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-logical-axiom"
  | .admitted => "no-extra-logical-axiom"

structure Candidate where
  proposition : Proposition
  denial : Denial
  conjunction : Conjunction
  disjunction : Disjunction
  implication : Implication
  inference : Inference
  consistency : Consistency
  soundness : Soundness
  completeness : Completeness
  addition : Addition

def sourceFields (c : Candidate) : List String := [propositionName c.proposition, denialName c.denial, conjunctionName c.conjunction, disjunctionName c.disjunction, implicationName c.implication, inferenceName c.inference, consistencyName c.consistency, soundnessName c.soundness, completenessName c.completeness, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "proposition=" (propositionName c.proposition), SFT.Host.Text.append "denial=" (denialName c.denial), SFT.Host.Text.append "conjunction=" (conjunctionName c.conjunction), SFT.Host.Text.append "disjunction=" (disjunctionName c.disjunction), SFT.Host.Text.append "implication=" (implicationName c.implication), SFT.Host.Text.append "inference=" (inferenceName c.inference), SFT.Host.Text.append "consistency=" (consistencyName c.consistency), SFT.Host.Text.append "soundness=" (soundnessName c.soundness), SFT.Host.Text.append "completeness=" (completenessName c.completeness), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "canonical-distinguished-form__complementary-held-orientation__joint-complete-proof__held-alternative-with-support__proof-carrying-transition__complete-dependency-trace__no-opposed-admission__rule-and-witness-preservation__registered-grammar-exhaustion__no-extra-logical-axiom"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (propositionName c.proposition) "canonical-distinguished-form" &&
  SFT.Host.Text.equal (denialName c.denial) "complementary-held-orientation" &&
  SFT.Host.Text.equal (conjunctionName c.conjunction) "joint-complete-proof" &&
  SFT.Host.Text.equal (disjunctionName c.disjunction) "held-alternative-with-support" &&
  SFT.Host.Text.equal (implicationName c.implication) "proof-carrying-transition" &&
  SFT.Host.Text.equal (inferenceName c.inference) "complete-dependency-trace" &&
  SFT.Host.Text.equal (consistencyName c.consistency) "no-opposed-admission" &&
  SFT.Host.Text.equal (soundnessName c.soundness) "rule-and-witness-preservation" &&
  SFT.Host.Text.equal (completenessName c.completeness) "registered-grammar-exhaustion" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-logical-axiom"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (propositionName c.proposition) "canonical-distinguished-form") then "A sentence presentation can alias or hide the judged form." else
  if !(SFT.Host.Text.equal (denialName c.denial) "complementary-held-orientation") then "A negative magnitude is outside the admitted domain." else
  if !(SFT.Host.Text.equal (conjunctionName c.conjunction) "joint-complete-proof") then "One side cannot establish the joint claim." else
  if !(SFT.Host.Text.equal (disjunctionName c.disjunction) "held-alternative-with-support") then "An unidentified choice erases which alternative is supported." else
  if !(SFT.Host.Text.equal (implicationName c.implication) "proof-carrying-transition") then "A borrowed table installs conventional logical values." else
  if !(SFT.Host.Text.equal (inferenceName c.inference) "complete-dependency-trace") then "A bare conclusion erases its premises and rules." else
  if !(SFT.Host.Text.equal (consistencyName c.consistency) "no-opposed-admission") then "An assertion does not search for opposed admitted orientations." else
  if !(SFT.Host.Text.equal (soundnessName c.soundness) "rule-and-witness-preservation") then "Authority cannot replace validation against registered rules." else
  if !(SFT.Host.Text.equal (completenessName c.completeness) "registered-grammar-exhaustion") then "A finite proof kernel cannot establish an ungenerated universal domain." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-logical-axiom") then "An extra axiom is not supplied by the canonical form and rule traces." else
  "The logic/proof kernel is canonical distinguished propositions, complementary held denial, joint and held alternative proof forms, proof-carrying implication, complete inference traces, explicit consistency and soundness, and completeness only over the exhausted registered grammar."

def generationRule : String := "Generate the complete product of proposition identity, denial, conjunction, disjunction, implication, inference provenance, consistency, soundness, grammar completeness and extra-logical status."
def grammarBoundary : String := "All propositions and finite proofs generated from canonical forms, two held orientations, joint and alternative constructions, registered inference transitions and complete dependency traces."

def candidates : List Candidate :=
  ([Proposition.rejected,Proposition.admitted]).flatMap fun proposition =>
  ([Denial.rejected,Denial.admitted]).flatMap fun denial =>
  ([Conjunction.rejected,Conjunction.admitted]).flatMap fun conjunction =>
  ([Disjunction.rejected,Disjunction.admitted]).flatMap fun disjunction =>
  ([Implication.rejected,Implication.admitted]).flatMap fun implication =>
  ([Inference.rejected,Inference.admitted]).flatMap fun inference =>
  ([Consistency.rejected,Consistency.admitted]).flatMap fun consistency =>
  ([Soundness.rejected,Soundness.admitted]).flatMap fun soundness =>
  ([Completeness.rejected,Completeness.admitted]).flatMap fun completeness =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨proposition,denial,conjunction,disjunction,implication,inference,consistency,soundness,completeness,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk proposition denial conjunction disjunction implication inference consistency soundness completeness addition =>
    have hproposition : proposition ∈ [Proposition.rejected,Proposition.admitted] := by
      cases proposition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdenial : denial ∈ [Denial.rejected,Denial.admitted] := by
      cases denial <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconjunction : conjunction ∈ [Conjunction.rejected,Conjunction.admitted] := by
      cases conjunction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdisjunction : disjunction ∈ [Disjunction.rejected,Disjunction.admitted] := by
      cases disjunction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have himplication : implication ∈ [Implication.rejected,Implication.admitted] := by
      cases implication <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinference : inference ∈ [Inference.rejected,Inference.admitted] := by
      cases inference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconsistency : consistency ∈ [Consistency.rejected,Consistency.admitted] := by
      cases consistency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsoundness : soundness ∈ [Soundness.rejected,Soundness.admitted] := by
      cases soundness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcompleteness : completeness ∈ [Completeness.rejected,Completeness.admitted] := by
      cases completeness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ proposition _ hproposition
    apply CommonRefinement.memFlatMap _ _ denial _ hdenial
    apply CommonRefinement.memFlatMap _ _ conjunction _ hconjunction
    apply CommonRefinement.memFlatMap _ _ disjunction _ hdisjunction
    apply CommonRefinement.memFlatMap _ _ implication _ himplication
    apply CommonRefinement.memFlatMap _ _ inference _ hinference
    apply CommonRefinement.memFlatMap _ _ consistency _ hconsistency
    apply CommonRefinement.memFlatMap _ _ soundness _ hsoundness
    apply CommonRefinement.memFlatMap _ _ completeness _ hcompleteness
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk proposition denial conjunction disjunction implication inference consistency soundness completeness addition =>
    cases proposition <;> cases denial <;> cases conjunction <;> cases disjunction <;> cases implication <;> cases inference <;> cases consistency <;> cases soundness <;> cases completeness <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk proposition denial conjunction disjunction implication inference consistency soundness completeness addition =>
    cases proposition <;> cases denial <;> cases conjunction <;> cases disjunction <;> cases implication <;> cases inference <;> cases consistency <;> cases soundness <;> cases completeness <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.proposition = .admitted ∧ c.denial = .admitted ∧ c.conjunction = .admitted ∧ c.disjunction = .admitted ∧ c.implication = .admitted ∧ c.inference = .admitted ∧ c.consistency = .admitted ∧ c.soundness = .admitted ∧ c.completeness = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk proposition denial conjunction disjunction implication inference consistency soundness completeness addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem proposition_rejected_rejected (c : Candidate) (h : c.proposition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.proposition eq
    rw [h] at field
    cases field

theorem denial_rejected_rejected (c : Candidate) (h : c.denial = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.denial eq
    rw [h] at field
    cases field

theorem conjunction_rejected_rejected (c : Candidate) (h : c.conjunction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conjunction eq
    rw [h] at field
    cases field

theorem disjunction_rejected_rejected (c : Candidate) (h : c.disjunction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.disjunction eq
    rw [h] at field
    cases field

theorem implication_rejected_rejected (c : Candidate) (h : c.implication = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.implication eq
    rw [h] at field
    cases field

theorem inference_rejected_rejected (c : Candidate) (h : c.inference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.inference eq
    rw [h] at field
    cases field

theorem consistency_rejected_rejected (c : Candidate) (h : c.consistency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.consistency eq
    rw [h] at field
    cases field

theorem soundness_rejected_rejected (c : Candidate) (h : c.soundness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.soundness eq
    rw [h] at field
    cases field

theorem completeness_rejected_rejected (c : Candidate) (h : c.completeness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.completeness eq
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

end SFT.Mathematics.LogicGrammar
