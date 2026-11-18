import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AnalyticalDetectionGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "unidentified-signal"
  | .admitted => "held-analyte-method-condition"

inductive Blank where
  | rejected | admitted

def blankName : Blank → String
  | .rejected => "single-numerical-zero-blank"
  | .admitted => "complete-positive-blank-support"

inductive Levels where
  | rejected | admitted

def levelsName : Levels → String
  | .rejected => "selected-low-result"
  | .admitted => "complete-positive-ordered-level-support"

inductive Detection where
  | rejected | admitted

def detectionName : Detection → String
  | .rejected => "declared-limit-number"
  | .admitted => "exact-blank-sample-distinguishability"

inductive Errors where
  | rejected | admitted

def errorsName : Errors → String
  | .rejected => "false-results-erased"
  | .admitted => "false-positive-negative-custody"

inductive Quantification where
  | rejected | admitted

def quantificationName : Quantification → String
  | .rejected => "detection-equals-quantification"
  | .admitted => "repeatability-and-recovery-required"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "negative-undetected-value"
  | .admitted => "detected-quantified-label-or-EmptyOne"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "threshold-refitted"
  | .admitted => "successor-retains-and-recomputes-levels"

structure Candidate where
  identity : Identity
  blank : Blank
  levels : Levels
  detection : Detection
  errors : Errors
  quantification : Quantification
  absence : Absence
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, blankName c.blank, levelsName c.levels, detectionName c.detection, errorsName c.errors, quantificationName c.quantification, absenceName c.absence, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "blank=" (blankName c.blank), SFT.Host.Text.append "levels=" (levelsName c.levels), SFT.Host.Text.append "detection=" (detectionName c.detection), SFT.Host.Text.append "errors=" (errorsName c.errors), SFT.Host.Text.append "quantification=" (quantificationName c.quantification), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-analyte-method-condition__complete-positive-blank-support__complete-positive-ordered-level-support__exact-blank-sample-distinguishability__false-positive-negative-custody__repeatability-and-recovery-required__detected-quantified-label-or-EmptyOne__successor-retains-and-recomputes-levels"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "held-analyte-method-condition" &&
  SFT.Host.Text.equal (blankName c.blank) "complete-positive-blank-support" &&
  SFT.Host.Text.equal (levelsName c.levels) "complete-positive-ordered-level-support" &&
  SFT.Host.Text.equal (detectionName c.detection) "exact-blank-sample-distinguishability" &&
  SFT.Host.Text.equal (errorsName c.errors) "false-positive-negative-custody" &&
  SFT.Host.Text.equal (quantificationName c.quantification) "repeatability-and-recovery-required" &&
  SFT.Host.Text.equal (absenceName c.absence) "detected-quantified-label-or-EmptyOne" &&
  SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-recomputes-levels"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "held-analyte-method-condition") then "No analyte boundary exists." else
  if !(SFT.Host.Text.equal (blankName c.blank) "complete-positive-blank-support") then "Numerical zero cannot represent background." else
  if !(SFT.Host.Text.equal (levelsName c.levels) "complete-positive-ordered-level-support") then "Selection hides failures." else
  if !(SFT.Host.Text.equal (detectionName c.detection) "exact-blank-sample-distinguishability") then "A number alone cannot prove distinction." else
  if !(SFT.Host.Text.equal (errorsName c.errors) "false-positive-negative-custody") then "Error classes are hidden." else
  if !(SFT.Host.Text.equal (quantificationName c.quantification) "repeatability-and-recovery-required") then "Identity is weaker than measurement." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "detected-quantified-label-or-EmptyOne") then "Undetected is not negative amount." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "successor-retains-and-recomputes-levels") then "A refit changes prior classifications." else
  "held-analyte-method-condition__complete-positive-blank-support__complete-positive-ordered-level-support__exact-blank-sample-distinguishability__false-positive-negative-custody__repeatability-and-recovery-required__detected-quantified-label-or-EmptyOne__successor-retains-and-recomputes-levels"

def generationRule : String := "Generate the literal product of eight registered analytical decisions."
def grammarBoundary : String := "Eight dimensions exhaust identity, blank, levels, detection, errors, quantification, absence and extension."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Blank.rejected,Blank.admitted]).flatMap fun blank =>
  ([Levels.rejected,Levels.admitted]).flatMap fun levels =>
  ([Detection.rejected,Detection.admitted]).flatMap fun detection =>
  ([Errors.rejected,Errors.admitted]).flatMap fun errors =>
  ([Quantification.rejected,Quantification.admitted]).flatMap fun quantification =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,blank,levels,detection,errors,quantification,absence,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity blank levels detection errors quantification absence extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hblank : blank ∈ [Blank.rejected,Blank.admitted] := by
      cases blank <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlevels : levels ∈ [Levels.rejected,Levels.admitted] := by
      cases levels <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdetection : detection ∈ [Detection.rejected,Detection.admitted] := by
      cases detection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have herrors : errors ∈ [Errors.rejected,Errors.admitted] := by
      cases errors <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantification : quantification ∈ [Quantification.rejected,Quantification.admitted] := by
      cases quantification <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ blank _ hblank
    apply CommonRefinement.memFlatMap _ _ levels _ hlevels
    apply CommonRefinement.memFlatMap _ _ detection _ hdetection
    apply CommonRefinement.memFlatMap _ _ errors _ herrors
    apply CommonRefinement.memFlatMap _ _ quantification _ hquantification
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (errors : Errors) (quantification : Quantification) (absence : Absence) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,errors,quantification,absence,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,errors,quantification,absence,extension⟩ := by
 cases errors <;> cases quantification <;> cases absence <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity blank levels detection errors quantification absence extension =>
  cases identity <;> cases blank <;> cases levels <;> cases detection
  · exact sourceDecisionBlock0000 errors quantification absence extension
  · exact sourceDecisionBlock0001 errors quantification absence extension
  · exact sourceDecisionBlock0010 errors quantification absence extension
  · exact sourceDecisionBlock0011 errors quantification absence extension
  · exact sourceDecisionBlock0100 errors quantification absence extension
  · exact sourceDecisionBlock0101 errors quantification absence extension
  · exact sourceDecisionBlock0110 errors quantification absence extension
  · exact sourceDecisionBlock0111 errors quantification absence extension
  · exact sourceDecisionBlock1000 errors quantification absence extension
  · exact sourceDecisionBlock1001 errors quantification absence extension
  · exact sourceDecisionBlock1010 errors quantification absence extension
  · exact sourceDecisionBlock1011 errors quantification absence extension
  · exact sourceDecisionBlock1100 errors quantification absence extension
  · exact sourceDecisionBlock1101 errors quantification absence extension
  · exact sourceDecisionBlock1110 errors quantification absence extension
  · exact sourceDecisionBlock1111 errors quantification absence extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-analyte-method-condition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem blankCriterion (value : Blank) : SFT.Host.Text.equal (blankName value) "complete-positive-blank-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem levelsCriterion (value : Levels) : SFT.Host.Text.equal (levelsName value) "complete-positive-ordered-level-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem detectionCriterion (value : Detection) : SFT.Host.Text.equal (detectionName value) "exact-blank-sample-distinguishability" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem errorsCriterion (value : Errors) : SFT.Host.Text.equal (errorsName value) "false-positive-negative-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem quantificationCriterion (value : Quantification) : SFT.Host.Text.equal (quantificationName value) "repeatability-and-recovery-required" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "detected-quantified-label-or-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "successor-retains-and-recomputes-levels" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, blankCriterion, levelsCriterion, detectionCriterion, errorsCriterion, quantificationCriterion, absenceCriterion, extensionCriterion]
  cases c with
  | mk identity blank levels detection errors quantification absence extension =>
    cases identity <;> cases blank <;> cases levels <;> cases detection <;> cases errors <;> cases quantification <;> cases absence <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.blank = .admitted ∧ c.levels = .admitted ∧ c.detection = .admitted ∧ c.errors = .admitted ∧ c.quantification = .admitted ∧ c.absence = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity blank levels detection errors quantification absence extension =>
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

theorem blank_rejected_rejected (c : Candidate) (h : c.blank = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.blank eq
    rw [h] at field
    cases field

theorem levels_rejected_rejected (c : Candidate) (h : c.levels = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.levels eq
    rw [h] at field
    cases field

theorem detection_rejected_rejected (c : Candidate) (h : c.detection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.detection eq
    rw [h] at field
    cases field

theorem errors_rejected_rejected (c : Candidate) (h : c.errors = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.errors eq
    rw [h] at field
    cases field

theorem quantification_rejected_rejected (c : Candidate) (h : c.quantification = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.quantification eq
    rw [h] at field
    cases field

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

end SFT.Chemistry.AnalyticalDetectionGrammar
