import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Consciousness.SleepDreamCycleGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "continuum-or-signed-state"
  | .admitted => "exact-positive-fold-parts-and-held-labels"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "name-or-analogy-only"
  | .admitted => "one-third-two-thirds-closed-orbit-with-half-one-balance"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "unbounded-or-untraceable-content"
  | .admitted => "generated-support-and-retained-record-boundary"

inductive Reports where
  | rejected | admitted

def reportsName : Reports → String
  | .rejected => "dismissed-or-ontologized-report"
  | .admitted => "report-preserved-ontology-separate"

inductive Enumeration where
  | rejected | admitted

def enumerationName : Enumeration → String
  | .rejected => "selected-example"
  | .admitted => "complete-declared-product"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "target-before-seal"
  | .admitted => "derivation-seal-before-target"

inductive Outcomes where
  | rejected | admitted

def outcomesName : Outcomes → String
  | .rejected => "favorable-only"
  | .admitted => "favorable-adverse-absent-heterogeneous-unresolved"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  relation : Relation
  boundary : Boundary
  reports : Reports
  enumeration : Enumeration
  target : Target
  outcomes : Outcomes
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, relationName c.relation, boundaryName c.boundary, reportsName c.reports, enumerationName c.enumeration, targetName c.target, outcomesName c.outcomes, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "reports=" (reportsName c.reports), SFT.Host.Text.append "enumeration=" (enumerationName c.enumeration), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "outcomes=" (outcomesName c.outcomes), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "exact-positive-fold-parts-and-held-labels__one-third-two-thirds-closed-orbit-with-half-one-balance__generated-support-and-retained-record-boundary__report-preserved-ontology-separate__complete-declared-product__derivation-seal-before-target__favorable-adverse-absent-heterogeneous-unresolved__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "exact-positive-fold-parts-and-held-labels" &&
  SFT.Host.Text.equal (relationName c.relation) "one-third-two-thirds-closed-orbit-with-half-one-balance" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "generated-support-and-retained-record-boundary" &&
  SFT.Host.Text.equal (reportsName c.reports) "report-preserved-ontology-separate" &&
  SFT.Host.Text.equal (enumerationName c.enumeration) "complete-declared-product" &&
  SFT.Host.Text.equal (targetName c.target) "derivation-seal-before-target" &&
  SFT.Host.Text.equal (outcomesName c.outcomes) "favorable-adverse-absent-heterogeneous-unresolved" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "exact-positive-fold-parts-and-held-labels") then "It imports a prohibited magnitude grammar." else
  if !(SFT.Host.Text.equal (relationName c.relation) "one-third-two-thirds-closed-orbit-with-half-one-balance") then "A name contains no operational mechanism." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "generated-support-and-retained-record-boundary") then "Untraceable content cannot be forced from the Fold." else
  if !(SFT.Host.Text.equal (reportsName c.reports) "report-preserved-ontology-separate") then "Either move exceeds the evidence." else
  if !(SFT.Host.Text.equal (enumerationName c.enumeration) "complete-declared-product") then "One favorable example cannot force uniqueness." else
  if !(SFT.Host.Text.equal (targetName c.target) "derivation-seal-before-target") then "Pre-seal access is fitting." else
  if !(SFT.Host.Text.equal (outcomesName c.outcomes) "favorable-adverse-absent-heterogeneous-unresolved") then "Selective retention destroys empirical force." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A free exception is an unforced parameter." else
  "The exact orbit 1/3 -> 2/3 -> 1/3 is the least two-state held cycle. Its states sum to One, their balance is half-One and that balance Folds to One. Deep-sleep, REM, dream and waking are empirical correspondence labels; no universal clock duration is fitted into the formal law."

def generationRule : String := "Generate the complete eight-axis product for SFT-CONSC-SLEEP-DREAM-PERIOD-TWO-002 and reconstruct its exact operational witness independently."
def grammarBoundary : String := "The exact positive period-two Fold orbit with state-label, balance, waking and duration controls."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Reports.rejected,Reports.admitted]).flatMap fun reports =>
  ([Enumeration.rejected,Enumeration.admitted]).flatMap fun enumeration =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Outcomes.rejected,Outcomes.admitted]).flatMap fun outcomes =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,relation,boundary,reports,enumeration,target,outcomes,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier relation boundary reports enumeration target outcomes extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreports : reports ∈ [Reports.rejected,Reports.admitted] := by
      cases reports <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henumeration : enumeration ∈ [Enumeration.rejected,Enumeration.admitted] := by
      cases enumeration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have houtcomes : outcomes ∈ [Outcomes.rejected,Outcomes.admitted] := by
      cases outcomes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ reports _ hreports
    apply CommonRefinement.memFlatMap _ _ enumeration _ henumeration
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ outcomes _ houtcomes
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (enumeration : Enumeration) (target : Target) (outcomes : Outcomes) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,enumeration,target,outcomes,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,enumeration,target,outcomes,extension⟩ := by
 cases enumeration <;> cases target <;> cases outcomes <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier relation boundary reports enumeration target outcomes extension =>
  cases carrier <;> cases relation <;> cases boundary <;> cases reports
  · exact sourceDecisionBlock0000 enumeration target outcomes extension
  · exact sourceDecisionBlock0001 enumeration target outcomes extension
  · exact sourceDecisionBlock0010 enumeration target outcomes extension
  · exact sourceDecisionBlock0011 enumeration target outcomes extension
  · exact sourceDecisionBlock0100 enumeration target outcomes extension
  · exact sourceDecisionBlock0101 enumeration target outcomes extension
  · exact sourceDecisionBlock0110 enumeration target outcomes extension
  · exact sourceDecisionBlock0111 enumeration target outcomes extension
  · exact sourceDecisionBlock1000 enumeration target outcomes extension
  · exact sourceDecisionBlock1001 enumeration target outcomes extension
  · exact sourceDecisionBlock1010 enumeration target outcomes extension
  · exact sourceDecisionBlock1011 enumeration target outcomes extension
  · exact sourceDecisionBlock1100 enumeration target outcomes extension
  · exact sourceDecisionBlock1101 enumeration target outcomes extension
  · exact sourceDecisionBlock1110 enumeration target outcomes extension
  · exact sourceDecisionBlock1111 enumeration target outcomes extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "exact-positive-fold-parts-and-held-labels" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "one-third-two-thirds-closed-orbit-with-half-one-balance" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "generated-support-and-retained-record-boundary" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem reportsCriterion (value : Reports) : SFT.Host.Text.equal (reportsName value) "report-preserved-ontology-separate" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem enumerationCriterion (value : Enumeration) : SFT.Host.Text.equal (enumerationName value) "complete-declared-product" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem targetCriterion (value : Target) : SFT.Host.Text.equal (targetName value) "derivation-seal-before-target" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem outcomesCriterion (value : Outcomes) : SFT.Host.Text.equal (outcomesName value) "favorable-adverse-absent-heterogeneous-unresolved" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, relationCriterion, boundaryCriterion, reportsCriterion, enumerationCriterion, targetCriterion, outcomesCriterion, extensionCriterion]
  cases c with
  | mk carrier relation boundary reports enumeration target outcomes extension =>
    cases carrier <;> cases relation <;> cases boundary <;> cases reports <;> cases enumeration <;> cases target <;> cases outcomes <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.relation = .admitted ∧ c.boundary = .admitted ∧ c.reports = .admitted ∧ c.enumeration = .admitted ∧ c.target = .admitted ∧ c.outcomes = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier relation boundary reports enumeration target outcomes extension =>
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

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
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

theorem reports_rejected_rejected (c : Candidate) (h : c.reports = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reports eq
    rw [h] at field
    cases field

theorem enumeration_rejected_rejected (c : Candidate) (h : c.enumeration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.enumeration eq
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

theorem outcomes_rejected_rejected (c : Candidate) (h : c.outcomes = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.outcomes eq
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

end SFT.Consciousness.SleepDreamCycleGrammar
