import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AnalyticalAccuracyGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "nominal-value-premise"
  | .admitted => "traceable-reference-identity"

inductive Measurand where
  | rejected | admitted

def measurandName : Measurand → String
  | .rejected => "result-without-measurand"
  | .admitted => "held-sample-measurand-method"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-result"
  | .admitted => "complete-ordered-result-support"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "signed-error-scalar"
  | .admitted => "held-side-positive-distance-or-EmptyOne"

inductive Trueness where
  | rejected | admitted

def truenessName : Trueness → String
  | .rejected => "declared-accurate-label"
  | .admitted => "exact-observed-reference-relation"

inductive Uncertainty where
  | rejected | admitted

def uncertaintyName : Uncertainty → String
  | .rejected => "single-certain-value"
  | .admitted => "complete-exact-uncertainty-support"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "universal-method-accuracy"
  | .admitted => "registered-material-method-boundary"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "renormalized-new-results"
  | .admitted => "successor-retains-and-recomputes-all-results"

structure Candidate where
  reference : Reference
  measurand : Measurand
  support : Support
  comparison : Comparison
  trueness : Trueness
  uncertainty : Uncertainty
  boundary : Boundary
  extension : Extension

def sourceFields (c : Candidate) : List String := [referenceName c.reference, measurandName c.measurand, supportName c.support, comparisonName c.comparison, truenessName c.trueness, uncertaintyName c.uncertainty, boundaryName c.boundary, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "measurand=" (measurandName c.measurand), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "trueness=" (truenessName c.trueness), SFT.Host.Text.append "uncertainty=" (uncertaintyName c.uncertainty), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "traceable-reference-identity__held-sample-measurand-method__complete-ordered-result-support__held-side-positive-distance-or-EmptyOne__exact-observed-reference-relation__complete-exact-uncertainty-support__registered-material-method-boundary__successor-retains-and-recomputes-all-results"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (referenceName c.reference) "traceable-reference-identity" &&
  SFT.Host.Text.equal (measurandName c.measurand) "held-sample-measurand-method" &&
  SFT.Host.Text.equal (supportName c.support) "complete-ordered-result-support" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "held-side-positive-distance-or-EmptyOne" &&
  SFT.Host.Text.equal (truenessName c.trueness) "exact-observed-reference-relation" &&
  SFT.Host.Text.equal (uncertaintyName c.uncertainty) "complete-exact-uncertainty-support" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "registered-material-method-boundary" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-recomputes-all-results"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (referenceName c.reference) "traceable-reference-identity") then "A name is not a reference." else
  if !(SFT.Host.Text.equal (measurandName c.measurand) "held-sample-measurand-method") then "No comparison identity exists." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-ordered-result-support") then "Selection hides variation." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "held-side-positive-distance-or-EmptyOne") then "A sign is not a native proof value." else
  if !(SFT.Host.Text.equal (truenessName c.trueness) "exact-observed-reference-relation") then "A label cannot force trueness." else
  if !(SFT.Host.Text.equal (uncertaintyName c.uncertainty) "complete-exact-uncertainty-support") then "Alternatives are hidden." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "registered-material-method-boundary") then "Accuracy is method and material bound." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-recomputes-all-results") then "Renormalization erases custody." else
  "traceable-reference-identity__held-sample-measurand-method__complete-ordered-result-support__held-side-positive-distance-or-EmptyOne__exact-observed-reference-relation__complete-exact-uncertainty-support__registered-material-method-boundary__successor-retains-and-recomputes-all-results"

def generationRule : String := "Generate the literal product of eight registered analytical decisions."
def grammarBoundary : String := "Eight dimensions exhaust reference, measurand, support, comparison, trueness, uncertainty, boundary and extension."

def candidates : List Candidate :=
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Measurand.rejected,Measurand.admitted]).flatMap fun measurand =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Trueness.rejected,Trueness.admitted]).flatMap fun trueness =>
  ([Uncertainty.rejected,Uncertainty.admitted]).flatMap fun uncertainty =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨reference,measurand,support,comparison,trueness,uncertainty,boundary,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk reference measurand support comparison trueness uncertainty boundary extension =>
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurand : measurand ∈ [Measurand.rejected,Measurand.admitted] := by
      cases measurand <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrueness : trueness ∈ [Trueness.rejected,Trueness.admitted] := by
      cases trueness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huncertainty : uncertainty ∈ [Uncertainty.rejected,Uncertainty.admitted] := by
      cases uncertainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ measurand _ hmeasurand
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ trueness _ htrueness
    apply CommonRefinement.memFlatMap _ _ uncertainty _ huncertainty
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (trueness : Trueness) (uncertainty : Uncertainty) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,trueness,uncertainty,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,trueness,uncertainty,boundary,extension⟩ := by
 cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk reference measurand support comparison trueness uncertainty boundary extension =>
  cases reference <;> cases measurand <;> cases support <;> cases comparison
  · exact sourceDecisionBlock0000 trueness uncertainty boundary extension
  · exact sourceDecisionBlock0001 trueness uncertainty boundary extension
  · exact sourceDecisionBlock0010 trueness uncertainty boundary extension
  · exact sourceDecisionBlock0011 trueness uncertainty boundary extension
  · exact sourceDecisionBlock0100 trueness uncertainty boundary extension
  · exact sourceDecisionBlock0101 trueness uncertainty boundary extension
  · exact sourceDecisionBlock0110 trueness uncertainty boundary extension
  · exact sourceDecisionBlock0111 trueness uncertainty boundary extension
  · exact sourceDecisionBlock1000 trueness uncertainty boundary extension
  · exact sourceDecisionBlock1001 trueness uncertainty boundary extension
  · exact sourceDecisionBlock1010 trueness uncertainty boundary extension
  · exact sourceDecisionBlock1011 trueness uncertainty boundary extension
  · exact sourceDecisionBlock1100 trueness uncertainty boundary extension
  · exact sourceDecisionBlock1101 trueness uncertainty boundary extension
  · exact sourceDecisionBlock1110 trueness uncertainty boundary extension
  · exact sourceDecisionBlock1111 trueness uncertainty boundary extension

theorem referenceCriterion (value : Reference) : SFT.Host.Text.equal (referenceName value) "traceable-reference-identity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem measurandCriterion (value : Measurand) : SFT.Host.Text.equal (measurandName value) "held-sample-measurand-method" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-ordered-result-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem comparisonCriterion (value : Comparison) : SFT.Host.Text.equal (comparisonName value) "held-side-positive-distance-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem truenessCriterion (value : Trueness) : SFT.Host.Text.equal (truenessName value) "exact-observed-reference-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem uncertaintyCriterion (value : Uncertainty) : SFT.Host.Text.equal (uncertaintyName value) "complete-exact-uncertainty-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "registered-material-method-boundary" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-and-recomputes-all-results" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [referenceCriterion, measurandCriterion, supportCriterion, comparisonCriterion, truenessCriterion, uncertaintyCriterion, boundaryCriterion, extensionCriterion]
  cases c with
  | mk reference measurand support comparison trueness uncertainty boundary extension =>
    cases reference <;> cases measurand <;> cases support <;> cases comparison <;> cases trueness <;> cases uncertainty <;> cases boundary <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.reference = .admitted ∧ c.measurand = .admitted ∧ c.support = .admitted ∧ c.comparison = .admitted ∧ c.trueness = .admitted ∧ c.uncertainty = .admitted ∧ c.boundary = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk reference measurand support comparison trueness uncertainty boundary extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
    rw [h] at field
    cases field

theorem measurand_rejected_rejected (c : Candidate) (h : c.measurand = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measurand eq
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

theorem comparison_rejected_rejected (c : Candidate) (h : c.comparison = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparison eq
    rw [h] at field
    cases field

theorem trueness_rejected_rejected (c : Candidate) (h : c.trueness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trueness eq
    rw [h] at field
    cases field

theorem uncertainty_rejected_rejected (c : Candidate) (h : c.uncertainty = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.uncertainty eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.AnalyticalAccuracyGrammar
