import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.DefectGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "continuum-defect-density"
  | .admitted => "finite-complete-reference-and-observed-motif"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "nominal-formula-only"
  | .admitted => "complete-reference-site-and-species-support"

inductive Vacancy where
  | rejected | admitted

def vacancyName : Vacancy → String
  | .rejected => "numerical-zero-occupancy"
  | .admitted => "reference-site-with-structural-EmptyOne"

inductive Difference where
  | rejected | admitted

def differenceName : Difference → String
  | .rejected => "signed-stoichiometric-subtraction"
  | .admitted => "separate-positive-missing-and-added-supports"

inductive Class where
  | rejected | admitted

def classAxisName : Class → String
  | .rejected => "selected-defect-name"
  | .admitted => "complete-vacancy-substitution-interstitial-classes"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "fitted-nonstoichiometric-variable"
  | .admitted => "exact-reference-observed-primitive-formulas"

inductive Origin where
  | rejected | admitted

def originName : Origin → String
  | .rejected => "assumed-intrinsic-or-extrinsic-label"
  | .admitted => "reference-membership-forces-origin-class"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "catalogue-specific-defect-exception"
  | .admitted => "site-occurrence-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  reference : Reference
  vacancy : Vacancy
  difference : Difference
  classAxis : Class
  composition : Composition
  origin : Origin
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, referenceName c.reference, vacancyName c.vacancy, differenceName c.difference, classAxisName c.classAxis, compositionName c.composition, originName c.origin, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "vacancy=" (vacancyName c.vacancy), SFT.Host.Text.append "difference=" (differenceName c.difference), SFT.Host.Text.append "class=" (classAxisName c.classAxis), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "origin=" (originName c.origin), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "finite-complete-reference-and-observed-motif__complete-reference-site-and-species-support__reference-site-with-structural-EmptyOne__separate-positive-missing-and-added-supports__complete-vacancy-substitution-interstitial-classes__exact-reference-observed-primitive-formulas__reference-membership-forces-origin-class__site-occurrence-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "finite-complete-reference-and-observed-motif" &&
  SFT.Host.Text.equal (referenceName c.reference) "complete-reference-site-and-species-support" &&
  SFT.Host.Text.equal (vacancyName c.vacancy) "reference-site-with-structural-EmptyOne" &&
  SFT.Host.Text.equal (differenceName c.difference) "separate-positive-missing-and-added-supports" &&
  SFT.Host.Text.equal (classAxisName c.classAxis) "complete-vacancy-substitution-interstitial-classes" &&
  SFT.Host.Text.equal (compositionName c.composition) "exact-reference-observed-primitive-formulas" &&
  SFT.Host.Text.equal (originName c.origin) "reference-membership-forces-origin-class" &&
  SFT.Host.Text.equal (extensionName c.extension) "site-occurrence-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "finite-complete-reference-and-observed-motif") then "A continuum density loses the exact local defect occurrences." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "complete-reference-site-and-species-support") then "A nominal formula does not identify the occupied sites." else
  if !(SFT.Host.Text.equal (vacancyName c.vacancy) "reference-site-with-structural-EmptyOne") then "Numerical zero is not a Fold form." else
  if !(SFT.Host.Text.equal (differenceName c.difference) "separate-positive-missing-and-added-supports") then "Signed subtraction imports negative values." else
  if !(SFT.Host.Text.equal (classAxisName c.classAxis) "complete-vacancy-substitution-interstitial-classes") then "A selected name omits alternative interruptions." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "exact-reference-observed-primitive-formulas") then "A fitted variable is neither exact nor unique." else
  if !(SFT.Host.Text.equal (originName c.origin) "reference-membership-forces-origin-class") then "An assumed label does not follow from composition." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "site-occurrence-successor-no-extra-rule") then "A catalogue exception destroys closure." else
  "finite-complete-reference-and-observed-motif__complete-reference-site-and-species-support__reference-site-with-structural-EmptyOne__separate-positive-missing-and-added-supports__complete-vacancy-substitution-interstitial-classes__exact-reference-observed-primitive-formulas__reference-membership-forces-origin-class__site-occurrence-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, reference, vacancy, difference, class, composition, origin and extension alternatives; decide all 256 forms from admitted exact arithmetic, discrete support, stoichiometry and local-solid coordination."
def grammarBoundary : String := "Every finite complete reference-site and observed local motif with explicit vacancy, substitution and interstitial supports, exact positive reconciliation and primitive formulas; all fifteen frozen solid-solution, lattice-defect, noncrystal-scope, extrinsic and intrinsic-defect surfaces including two definition-note surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Vacancy.rejected,Vacancy.admitted]).flatMap fun vacancy =>
  ([Difference.rejected,Difference.admitted]).flatMap fun difference =>
  ([Class.rejected,Class.admitted]).flatMap fun classAxis =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Origin.rejected,Origin.admitted]).flatMap fun origin =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,reference,vacancy,difference,classAxis,composition,origin,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier reference vacancy difference classAxis composition origin extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvacancy : vacancy ∈ [Vacancy.rejected,Vacancy.admitted] := by
      cases vacancy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdifference : difference ∈ [Difference.rejected,Difference.admitted] := by
      cases difference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclassAxis : classAxis ∈ [Class.rejected,Class.admitted] := by
      cases classAxis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horigin : origin ∈ [Origin.rejected,Origin.admitted] := by
      cases origin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ vacancy _ hvacancy
    apply CommonRefinement.memFlatMap _ _ difference _ hdifference
    apply CommonRefinement.memFlatMap _ _ classAxis _ hclassAxis
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ origin _ horigin
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (classAxis : Class) (composition : Composition) (origin : Origin) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,classAxis,composition,origin,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,classAxis,composition,origin,extension⟩ := by
 cases classAxis <;> cases composition <;> cases origin <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier reference vacancy difference classAxis composition origin extension =>
  cases carrier <;> cases reference <;> cases vacancy <;> cases difference
  · exact sourceDecisionBlock0000 classAxis composition origin extension
  · exact sourceDecisionBlock0001 classAxis composition origin extension
  · exact sourceDecisionBlock0010 classAxis composition origin extension
  · exact sourceDecisionBlock0011 classAxis composition origin extension
  · exact sourceDecisionBlock0100 classAxis composition origin extension
  · exact sourceDecisionBlock0101 classAxis composition origin extension
  · exact sourceDecisionBlock0110 classAxis composition origin extension
  · exact sourceDecisionBlock0111 classAxis composition origin extension
  · exact sourceDecisionBlock1000 classAxis composition origin extension
  · exact sourceDecisionBlock1001 classAxis composition origin extension
  · exact sourceDecisionBlock1010 classAxis composition origin extension
  · exact sourceDecisionBlock1011 classAxis composition origin extension
  · exact sourceDecisionBlock1100 classAxis composition origin extension
  · exact sourceDecisionBlock1101 classAxis composition origin extension
  · exact sourceDecisionBlock1110 classAxis composition origin extension
  · exact sourceDecisionBlock1111 classAxis composition origin extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "finite-complete-reference-and-observed-motif" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem referenceCriterion (value : Reference) : SFT.Host.Text.equal (referenceName value) "complete-reference-site-and-species-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem vacancyCriterion (value : Vacancy) : SFT.Host.Text.equal (vacancyName value) "reference-site-with-structural-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem differenceCriterion (value : Difference) : SFT.Host.Text.equal (differenceName value) "separate-positive-missing-and-added-supports" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem classAxisCriterion (value : Class) : SFT.Host.Text.equal (classAxisName value) "complete-vacancy-substitution-interstitial-classes" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "exact-reference-observed-primitive-formulas" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem originCriterion (value : Origin) : SFT.Host.Text.equal (originName value) "reference-membership-forces-origin-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "site-occurrence-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, referenceCriterion, vacancyCriterion, differenceCriterion, classAxisCriterion, compositionCriterion, originCriterion, extensionCriterion]
  cases c with
  | mk carrier reference vacancy difference classAxis composition origin extension =>
    cases carrier <;> cases reference <;> cases vacancy <;> cases difference <;> cases classAxis <;> cases composition <;> cases origin <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.reference = .admitted ∧ c.vacancy = .admitted ∧ c.difference = .admitted ∧ c.classAxis = .admitted ∧ c.composition = .admitted ∧ c.origin = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier reference vacancy difference classAxis composition origin extension =>
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

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
    rw [h] at field
    cases field

theorem vacancy_rejected_rejected (c : Candidate) (h : c.vacancy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.vacancy eq
    rw [h] at field
    cases field

theorem difference_rejected_rejected (c : Candidate) (h : c.difference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.difference eq
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

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem origin_rejected_rejected (c : Candidate) (h : c.origin = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.origin eq
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

end SFT.Chemistry.DefectGrammar
