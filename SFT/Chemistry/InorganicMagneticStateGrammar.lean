import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.InorganicMagneticStateGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "free-magnetic-number"
  | .admitted => "one-retained-complex-carrier"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-or-averaged-spin"
  | .admitted => "complete-unpaired-occurrence-support"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "numerical-zero-paired-state"
  | .admitted => "pairwise-closure-to-EmptyOne"

inductive Moment where
  | rejected | admitted

def momentName : Moment → String
  | .rejected => "square-root-spin-only-formula"
  | .admitted => "exact-unpaired-support-count"

inductive Width where
  | rejected | admitted

def widthName : Width → String
  | .rejected => "asserted-multiplicity"
  | .admitted => "unpaired-successor-spin-width"

inductive Direction where
  | rejected | admitted

def directionName : Direction → String
  | .rejected => "signed-susceptibility-proof"
  | .admitted => "held-drawn-or-repelled-field-relation"

inductive Classification where
  | rejected | admitted

def classificationName : Classification → String
  | .rejected => "species-magnetic-lookup"
  | .admitted => "EmptyOne-diamagnetic-positive-paramagnetic"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "fitted-g-factor-or-complex-exception"
  | .admitted => "unpaired-successor-with-no-extra-rule"

structure Candidate where
  carrier : Carrier
  support : Support
  balance : Balance
  moment : Moment
  width : Width
  direction : Direction
  classification : Classification
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, supportName c.support, balanceName c.balance, momentName c.moment, widthName c.width, directionName c.direction, classificationName c.classification, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "moment=" (momentName c.moment), SFT.Host.Text.append "width=" (widthName c.width), SFT.Host.Text.append "direction=" (directionName c.direction), SFT.Host.Text.append "classification=" (classificationName c.classification), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-complex-carrier__complete-unpaired-occurrence-support__pairwise-closure-to-EmptyOne__exact-unpaired-support-count__unpaired-successor-spin-width__held-drawn-or-repelled-field-relation__EmptyOne-diamagnetic-positive-paramagnetic__unpaired-successor-with-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-complex-carrier" &&
  SFT.Host.Text.equal (supportName c.support) "complete-unpaired-occurrence-support" &&
  SFT.Host.Text.equal (balanceName c.balance) "pairwise-closure-to-EmptyOne" &&
  SFT.Host.Text.equal (momentName c.moment) "exact-unpaired-support-count" &&
  SFT.Host.Text.equal (widthName c.width) "unpaired-successor-spin-width" &&
  SFT.Host.Text.equal (directionName c.direction) "held-drawn-or-repelled-field-relation" &&
  SFT.Host.Text.equal (classificationName c.classification) "EmptyOne-diamagnetic-positive-paramagnetic" &&
  SFT.Host.Text.equal (extensionName c.extension) "unpaired-successor-with-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-complex-carrier") then "A free magnetic number is detached from the inorganic state." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-unpaired-occurrence-support") then "A selected or averaged spin loses electron occurrences." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "pairwise-closure-to-EmptyOne") then "Numerical zero is not a native state or proof magnitude." else
  if !(SFT.Host.Text.equal (momentName c.moment) "exact-unpaired-support-count") then "A square-root formula imports irrational continuum magnitude." else
  if !(SFT.Host.Text.equal (widthName c.width) "unpaired-successor-spin-width") then "An asserted multiplicity can contradict complete support." else
  if !(SFT.Host.Text.equal (directionName c.direction) "held-drawn-or-repelled-field-relation") then "A signed scalar imports negative proof quantity." else
  if !(SFT.Host.Text.equal (classificationName c.classification) "EmptyOne-diamagnetic-positive-paramagnetic") then "A species lookup lets observed class select the rule." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "unpaired-successor-with-no-extra-rule") then "A fitted factor or species exception destroys zero-parameter closure." else
  "one-retained-complex-carrier__complete-unpaired-occurrence-support__pairwise-closure-to-EmptyOne__exact-unpaired-support-count__unpaired-successor-spin-width__held-drawn-or-repelled-field-relation__EmptyOne-diamagnetic-positive-paramagnetic__unpaired-successor-with-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, support, balance, moment, width, direction, classification and extension choices; decide all 256 candidates solely from admitted exact spin, exclusion, occupancy, magnetic-response and INORG-006/007 dependencies."
def grammarBoundary : String := "Every finite complete unpaired electron occurrence support on one retained coordination entity; structural EmptyOne or positive cardinality; both held field relations; all three frozen IUPAC definitions and all 174 shared sealed NIST magnetic-response cells."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Moment.rejected,Moment.admitted]).flatMap fun moment =>
  ([Width.rejected,Width.admitted]).flatMap fun width =>
  ([Direction.rejected,Direction.admitted]).flatMap fun direction =>
  ([Classification.rejected,Classification.admitted]).flatMap fun classification =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,support,balance,moment,width,direction,classification,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier support balance moment width direction classification extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmoment : moment ∈ [Moment.rejected,Moment.admitted] := by
      cases moment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hwidth : width ∈ [Width.rejected,Width.admitted] := by
      cases width <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdirection : direction ∈ [Direction.rejected,Direction.admitted] := by
      cases direction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclassification : classification ∈ [Classification.rejected,Classification.admitted] := by
      cases classification <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ moment _ hmoment
    apply CommonRefinement.memFlatMap _ _ width _ hwidth
    apply CommonRefinement.memFlatMap _ _ direction _ hdirection
    apply CommonRefinement.memFlatMap _ _ classification _ hclassification
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,width,direction,classification,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,width,direction,classification,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,width,direction,classification,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,width,direction,classification,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,width,direction,classification,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,width,direction,classification,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,width,direction,classification,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,width,direction,classification,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,width,direction,classification,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,width,direction,classification,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,width,direction,classification,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,width,direction,classification,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,width,direction,classification,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,width,direction,classification,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,width,direction,classification,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (width : Width) (direction : Direction) (classification : Classification) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,width,direction,classification,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,width,direction,classification,extension⟩ := by
 cases width <;> cases direction <;> cases classification <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier support balance moment width direction classification extension =>
  cases carrier <;> cases support <;> cases balance <;> cases moment
  · exact sourceDecisionBlock0000 width direction classification extension
  · exact sourceDecisionBlock0001 width direction classification extension
  · exact sourceDecisionBlock0010 width direction classification extension
  · exact sourceDecisionBlock0011 width direction classification extension
  · exact sourceDecisionBlock0100 width direction classification extension
  · exact sourceDecisionBlock0101 width direction classification extension
  · exact sourceDecisionBlock0110 width direction classification extension
  · exact sourceDecisionBlock0111 width direction classification extension
  · exact sourceDecisionBlock1000 width direction classification extension
  · exact sourceDecisionBlock1001 width direction classification extension
  · exact sourceDecisionBlock1010 width direction classification extension
  · exact sourceDecisionBlock1011 width direction classification extension
  · exact sourceDecisionBlock1100 width direction classification extension
  · exact sourceDecisionBlock1101 width direction classification extension
  · exact sourceDecisionBlock1110 width direction classification extension
  · exact sourceDecisionBlock1111 width direction classification extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-complex-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-unpaired-occurrence-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem balanceCriterion (value : Balance) : SFT.Host.Text.equal (balanceName value) "pairwise-closure-to-EmptyOne" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem momentCriterion (value : Moment) : SFT.Host.Text.equal (momentName value) "exact-unpaired-support-count" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem widthCriterion (value : Width) : SFT.Host.Text.equal (widthName value) "unpaired-successor-spin-width" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem directionCriterion (value : Direction) : SFT.Host.Text.equal (directionName value) "held-drawn-or-repelled-field-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem classificationCriterion (value : Classification) : SFT.Host.Text.equal (classificationName value) "EmptyOne-diamagnetic-positive-paramagnetic" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "unpaired-successor-with-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, supportCriterion, balanceCriterion, momentCriterion, widthCriterion, directionCriterion, classificationCriterion, extensionCriterion]
  cases c with
  | mk carrier support balance moment width direction classification extension =>
    cases carrier <;> cases support <;> cases balance <;> cases moment <;> cases width <;> cases direction <;> cases classification <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.support = .admitted ∧ c.balance = .admitted ∧ c.moment = .admitted ∧ c.width = .admitted ∧ c.direction = .admitted ∧ c.classification = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier support balance moment width direction classification extension =>
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
    rw [h] at field
    cases field

theorem moment_rejected_rejected (c : Candidate) (h : c.moment = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.moment eq
    rw [h] at field
    cases field

theorem width_rejected_rejected (c : Candidate) (h : c.width = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.width eq
    rw [h] at field
    cases field

theorem direction_rejected_rejected (c : Candidate) (h : c.direction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.direction eq
    rw [h] at field
    cases field

theorem classification_rejected_rejected (c : Candidate) (h : c.classification = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.classification eq
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

end SFT.Chemistry.InorganicMagneticStateGrammar
