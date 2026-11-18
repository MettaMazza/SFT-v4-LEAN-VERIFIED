import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AnalyticalPrecisionGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "replicates-without-sample"
  | .admitted => "held-sample-measurand-method"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "mixed-condition-pool"
  | .admitted => "same-held-repeatability-conditions"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "summary-only"
  | .admitted => "complete-positive-ordered-replicates"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "signed-deviation-list"
  | .admitted => "all-pair-positive-distance-or-EmptyOne"

inductive Spread where
  | rejected | admitted

def spreadName : Spread → String
  | .rejected => "fitted-dispersion-parameter"
  | .admitted => "exact-extreme-distance-or-EmptyOne"

inductive Class where
  | rejected | admitted

def classAxisName : Class → String
  | .rejected => "precision-equals-trueness"
  | .admitted => "repeatability-class-held-separately"

inductive Adverse where
  | rejected | admitted

def adverseName : Adverse → String
  | .rejected => "outlier-deleted"
  | .admitted => "all-adverse-replicates-retained"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "summary-renormalized"
  | .admitted => "successor-retains-and-recomputes-pairs"

structure Candidate where
  identity : Identity
  conditions : Conditions
  support : Support
  comparison : Comparison
  spread : Spread
  classAxis : Class
  adverse : Adverse
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, conditionsName c.conditions, supportName c.support, comparisonName c.comparison, spreadName c.spread, classAxisName c.classAxis, adverseName c.adverse, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "spread=" (spreadName c.spread), SFT.Host.Text.append "class=" (classAxisName c.classAxis), SFT.Host.Text.append "adverse=" (adverseName c.adverse), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-sample-measurand-method__same-held-repeatability-conditions__complete-positive-ordered-replicates__all-pair-positive-distance-or-EmptyOne__exact-extreme-distance-or-EmptyOne__repeatability-class-held-separately__all-adverse-replicates-retained__successor-retains-and-recomputes-pairs"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-sample-measurand-method" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "same-held-repeatability-conditions" &&
  SFT.Host.Text.equal (supportName c.support) "complete-positive-ordered-replicates" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "all-pair-positive-distance-or-EmptyOne" &&
  SFT.Host.Text.equal (spreadName c.spread) "exact-extreme-distance-or-EmptyOne" &&
  SFT.Host.Text.equal (classAxisName c.classAxis) "repeatability-class-held-separately" &&
  SFT.Host.Text.equal (adverseName c.adverse) "all-adverse-replicates-retained" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-recomputes-pairs"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-sample-measurand-method") then "Results cannot be paired." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "same-held-repeatability-conditions") then "Repeatability is obscured." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-positive-ordered-replicates") then "A summary erases rows." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "all-pair-positive-distance-or-EmptyOne") then "Signed values are not native proof distances." else
  if !(SFT.Host.Text.equal (spreadName c.spread) "exact-extreme-distance-or-EmptyOne") then "A fit cannot define observed spread." else
  if !(SFT.Host.Text.equal (classAxisName c.classAxis) "repeatability-class-held-separately") then "Agreement with a reference is distinct." else
  if !(SFT.Host.Text.equal (adverseName c.adverse) "all-adverse-replicates-retained") then "Deletion inflates precision." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-recomputes-pairs") then "Earlier distances disappear." else
  "held-sample-measurand-method__same-held-repeatability-conditions__complete-positive-ordered-replicates__all-pair-positive-distance-or-EmptyOne__exact-extreme-distance-or-EmptyOne__repeatability-class-held-separately__all-adverse-replicates-retained__successor-retains-and-recomputes-pairs"

def generationRule : String := "Generate the literal product of eight registered analytical decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, conditions, support, pair comparison, spread, class, adverse custody and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Spread.rejected,Spread.admitted]).flatMap fun spread =>
  ([Class.rejected,Class.admitted]).flatMap fun classAxis =>
  ([Adverse.rejected,Adverse.admitted]).flatMap fun adverse =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,conditions,support,comparison,spread,classAxis,adverse,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity conditions support comparison spread classAxis adverse extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspread : spread ∈ [Spread.rejected,Spread.admitted] := by
      cases spread <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclassAxis : classAxis ∈ [Class.rejected,Class.admitted] := by
      cases classAxis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadverse : adverse ∈ [Adverse.rejected,Adverse.admitted] := by
      cases adverse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ spread _ hspread
    apply CommonRefinement.memFlatMap _ _ classAxis _ hclassAxis
    apply CommonRefinement.memFlatMap _ _ adverse _ hadverse
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (spread : Spread) (classAxis : Class) (adverse : Adverse) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,spread,classAxis,adverse,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,spread,classAxis,adverse,extension⟩ := by
 cases spread <;> cases classAxis <;> cases adverse <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity conditions support comparison spread classAxis adverse extension =>
  cases identity <;> cases conditions <;> cases support <;> cases comparison
  · exact sourceDecisionBlock0000 spread classAxis adverse extension
  · exact sourceDecisionBlock0001 spread classAxis adverse extension
  · exact sourceDecisionBlock0010 spread classAxis adverse extension
  · exact sourceDecisionBlock0011 spread classAxis adverse extension
  · exact sourceDecisionBlock0100 spread classAxis adverse extension
  · exact sourceDecisionBlock0101 spread classAxis adverse extension
  · exact sourceDecisionBlock0110 spread classAxis adverse extension
  · exact sourceDecisionBlock0111 spread classAxis adverse extension
  · exact sourceDecisionBlock1000 spread classAxis adverse extension
  · exact sourceDecisionBlock1001 spread classAxis adverse extension
  · exact sourceDecisionBlock1010 spread classAxis adverse extension
  · exact sourceDecisionBlock1011 spread classAxis adverse extension
  · exact sourceDecisionBlock1100 spread classAxis adverse extension
  · exact sourceDecisionBlock1101 spread classAxis adverse extension
  · exact sourceDecisionBlock1110 spread classAxis adverse extension
  · exact sourceDecisionBlock1111 spread classAxis adverse extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-sample-measurand-method" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem conditionsCriterion (value : Conditions) : SFT.Host.Text.equal (conditionsName value) "same-held-repeatability-conditions" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-positive-ordered-replicates" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem comparisonCriterion (value : Comparison) : SFT.Host.Text.equal (comparisonName value) "all-pair-positive-distance-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem spreadCriterion (value : Spread) : SFT.Host.Text.equal (spreadName value) "exact-extreme-distance-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem classAxisCriterion (value : Class) : SFT.Host.Text.equal (classAxisName value) "repeatability-class-held-separately" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem adverseCriterion (value : Adverse) : SFT.Host.Text.equal (adverseName value) "all-adverse-replicates-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-and-recomputes-pairs" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, conditionsCriterion, supportCriterion, comparisonCriterion, spreadCriterion, classAxisCriterion, adverseCriterion, extensionCriterion]
  cases c with
  | mk identity conditions support comparison spread classAxis adverse extension =>
    cases identity <;> cases conditions <;> cases support <;> cases comparison <;> cases spread <;> cases classAxis <;> cases adverse <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.conditions = .admitted ∧ c.support = .admitted ∧ c.comparison = .admitted ∧ c.spread = .admitted ∧ c.classAxis = .admitted ∧ c.adverse = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity conditions support comparison spread classAxis adverse extension =>
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

theorem conditions_rejected_rejected (c : Candidate) (h : c.conditions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditions eq
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

theorem spread_rejected_rejected (c : Candidate) (h : c.spread = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.spread eq
    rw [h] at field
    cases field

theorem classAxis_rejected_rejected (c : Candidate) (h : c.classAxis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.classAxis eq
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

end SFT.Chemistry.AnalyticalPrecisionGrammar
