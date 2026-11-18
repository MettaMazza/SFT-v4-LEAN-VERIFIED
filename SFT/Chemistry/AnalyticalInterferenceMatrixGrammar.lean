import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AnalyticalInterferenceMatrixGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "response-without-analyte"
  | .admitted => "held-analyte-method-condition"

inductive Matrix where
  | rejected | admitted

def matrixName : Matrix → String
  | .rejected => "selected-interferent"
  | .admitted => "complete-declared-interferent-matrix"

inductive Baselines where
  | rejected | admitted

def baselinesName : Baselines → String
  | .rejected => "mixture-only-result"
  | .admitted => "analyte-and-interferent-baselines-held"

inductive Mixtures where
  | rejected | admitted

def mixturesName : Mixtures → String
  | .rejected => "accepted-mixtures-only"
  | .admitted => "all-analyte-interferent-mixtures-held"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "signed-bias-scalar"
  | .admitted => "held-side-positive-distance-or-EmptyOne"

inductive Selectivity where
  | rejected | admitted

def selectivityName : Selectivity → String
  | .rejected => "universal-specificity-label"
  | .admitted => "exact-response-distinguishability-class"

inductive Adverse where
  | rejected | admitted

def adverseName : Adverse → String
  | .rejected => "false-positive-rows-erased"
  | .admitted => "favorable-adverse-error-rows-retained"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "matrix-renormalized"
  | .admitted => "successor-retains-and-adds-interferent"

structure Candidate where
  identity : Identity
  matrix : Matrix
  baselines : Baselines
  mixtures : Mixtures
  comparison : Comparison
  selectivity : Selectivity
  adverse : Adverse
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, matrixName c.matrix, baselinesName c.baselines, mixturesName c.mixtures, comparisonName c.comparison, selectivityName c.selectivity, adverseName c.adverse, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "matrix=" (matrixName c.matrix), SFT.Host.Text.append "baselines=" (baselinesName c.baselines), SFT.Host.Text.append "mixtures=" (mixturesName c.mixtures), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "selectivity=" (selectivityName c.selectivity), SFT.Host.Text.append "adverse=" (adverseName c.adverse), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-analyte-method-condition__complete-declared-interferent-matrix__analyte-and-interferent-baselines-held__all-analyte-interferent-mixtures-held__held-side-positive-distance-or-EmptyOne__exact-response-distinguishability-class__favorable-adverse-error-rows-retained__successor-retains-and-adds-interferent"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-analyte-method-condition" &&
  SFT.Host.Text.equal (matrixName c.matrix) "complete-declared-interferent-matrix" &&
  SFT.Host.Text.equal (baselinesName c.baselines) "analyte-and-interferent-baselines-held" &&
  SFT.Host.Text.equal (mixturesName c.mixtures) "all-analyte-interferent-mixtures-held" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "held-side-positive-distance-or-EmptyOne" &&
  SFT.Host.Text.equal (selectivityName c.selectivity) "exact-response-distinguishability-class" &&
  SFT.Host.Text.equal (adverseName c.adverse) "favorable-adverse-error-rows-retained" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-adds-interferent"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-analyte-method-condition") then "No target is attributable." else
  if !(SFT.Host.Text.equal (matrixName c.matrix) "complete-declared-interferent-matrix") then "Selection can hide interference." else
  if !(SFT.Host.Text.equal (baselinesName c.baselines) "analyte-and-interferent-baselines-held") then "Attribution is impossible." else
  if !(SFT.Host.Text.equal (mixturesName c.mixtures) "all-analyte-interferent-mixtures-held") then "Adverse mixtures disappear." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "held-side-positive-distance-or-EmptyOne") then "A sign alone loses response custody." else
  if !(SFT.Host.Text.equal (selectivityName c.selectivity) "exact-response-distinguishability-class") then "Selectivity is method-bound." else
  if !(SFT.Host.Text.equal (adverseName c.adverse) "favorable-adverse-error-rows-retained") then "Erasure inflates selectivity." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-adds-interferent") then "Prior comparisons disappear." else
  "held-analyte-method-condition__complete-declared-interferent-matrix__analyte-and-interferent-baselines-held__all-analyte-interferent-mixtures-held__held-side-positive-distance-or-EmptyOne__exact-response-distinguishability-class__favorable-adverse-error-rows-retained__successor-retains-and-adds-interferent"

def generationRule : String := "Generate the literal product of eight registered analytical decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, matrix, baselines, mixtures, comparison, selectivity, adverse custody and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Matrix.rejected,Matrix.admitted]).flatMap fun matrix =>
  ([Baselines.rejected,Baselines.admitted]).flatMap fun baselines =>
  ([Mixtures.rejected,Mixtures.admitted]).flatMap fun mixtures =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Selectivity.rejected,Selectivity.admitted]).flatMap fun selectivity =>
  ([Adverse.rejected,Adverse.admitted]).flatMap fun adverse =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,matrix,baselines,mixtures,comparison,selectivity,adverse,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity matrix baselines mixtures comparison selectivity adverse extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmatrix : matrix ∈ [Matrix.rejected,Matrix.admitted] := by
      cases matrix <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbaselines : baselines ∈ [Baselines.rejected,Baselines.admitted] := by
      cases baselines <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmixtures : mixtures ∈ [Mixtures.rejected,Mixtures.admitted] := by
      cases mixtures <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hselectivity : selectivity ∈ [Selectivity.rejected,Selectivity.admitted] := by
      cases selectivity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadverse : adverse ∈ [Adverse.rejected,Adverse.admitted] := by
      cases adverse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ matrix _ hmatrix
    apply CommonRefinement.memFlatMap _ _ baselines _ hbaselines
    apply CommonRefinement.memFlatMap _ _ mixtures _ hmixtures
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ selectivity _ hselectivity
    apply CommonRefinement.memFlatMap _ _ adverse _ hadverse
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (comparison : Comparison) (selectivity : Selectivity) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,comparison,selectivity,adverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,comparison,selectivity,adverse,extension⟩ := by
 cases comparison <;> cases selectivity <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity matrix baselines mixtures comparison selectivity adverse extension =>
  cases identity <;> cases matrix <;> cases baselines <;> cases mixtures
  · exact sourceDecisionBlock0000 comparison selectivity adverse extension
  · exact sourceDecisionBlock0001 comparison selectivity adverse extension
  · exact sourceDecisionBlock0010 comparison selectivity adverse extension
  · exact sourceDecisionBlock0011 comparison selectivity adverse extension
  · exact sourceDecisionBlock0100 comparison selectivity adverse extension
  · exact sourceDecisionBlock0101 comparison selectivity adverse extension
  · exact sourceDecisionBlock0110 comparison selectivity adverse extension
  · exact sourceDecisionBlock0111 comparison selectivity adverse extension
  · exact sourceDecisionBlock1000 comparison selectivity adverse extension
  · exact sourceDecisionBlock1001 comparison selectivity adverse extension
  · exact sourceDecisionBlock1010 comparison selectivity adverse extension
  · exact sourceDecisionBlock1011 comparison selectivity adverse extension
  · exact sourceDecisionBlock1100 comparison selectivity adverse extension
  · exact sourceDecisionBlock1101 comparison selectivity adverse extension
  · exact sourceDecisionBlock1110 comparison selectivity adverse extension
  · exact sourceDecisionBlock1111 comparison selectivity adverse extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-analyte-method-condition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem matrixCriterion (value : Matrix) : SFT.Host.Text.equal (matrixName value) "complete-declared-interferent-matrix" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem baselinesCriterion (value : Baselines) : SFT.Host.Text.equal (baselinesName value) "analyte-and-interferent-baselines-held" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem mixturesCriterion (value : Mixtures) : SFT.Host.Text.equal (mixturesName value) "all-analyte-interferent-mixtures-held" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem comparisonCriterion (value : Comparison) : SFT.Host.Text.equal (comparisonName value) "held-side-positive-distance-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem selectivityCriterion (value : Selectivity) : SFT.Host.Text.equal (selectivityName value) "exact-response-distinguishability-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem adverseCriterion (value : Adverse) : SFT.Host.Text.equal (adverseName value) "favorable-adverse-error-rows-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-and-adds-interferent" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, matrixCriterion, baselinesCriterion, mixturesCriterion, comparisonCriterion, selectivityCriterion, adverseCriterion, extensionCriterion]
  cases c with
  | mk identity matrix baselines mixtures comparison selectivity adverse extension =>
    cases identity <;> cases matrix <;> cases baselines <;> cases mixtures <;> cases comparison <;> cases selectivity <;> cases adverse <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.matrix = .admitted ∧ c.baselines = .admitted ∧ c.mixtures = .admitted ∧ c.comparison = .admitted ∧ c.selectivity = .admitted ∧ c.adverse = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity matrix baselines mixtures comparison selectivity adverse extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem matrix_rejected_rejected (c : Candidate) (h : c.matrix = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.matrix eq
    rw [h] at field
    cases field

theorem baselines_rejected_rejected (c : Candidate) (h : c.baselines = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.baselines eq
    rw [h] at field
    cases field

theorem mixtures_rejected_rejected (c : Candidate) (h : c.mixtures = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mixtures eq
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

theorem selectivity_rejected_rejected (c : Candidate) (h : c.selectivity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.selectivity eq
    rw [h] at field
    cases field

theorem adverse_rejected_rejected (c : Candidate) (h : c.adverse = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adverse eq
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

end SFT.Chemistry.AnalyticalInterferenceMatrixGrammar
