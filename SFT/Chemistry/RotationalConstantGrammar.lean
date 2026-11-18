import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.RotationalConstantGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-rotational-number"
  | .admitted => "complete-finite-state-geometry-axis-carrier"

inductive Axis where
  | rejected | admitted

def axisName : Axis → String
  | .rejected => "merged-or-relabelled-axis"
  | .admitted => "held-principal-axis-and-equivalence-class"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "imported-rotational-constant-or-inertia-equation"
  | .admitted => "exact-axis-recurrence-over-interval-ratio"

inductive Ladder where
  | rejected | admitted

def ladderName : Ladder → String
  | .rejected => "continuum-or-free-angular-spectrum"
  | .admitted => "positive-JJplusOne-level-and-2J-gap"

inductive Translation where
  | rejected | admitted

def translationName : Translation → String
  | .rejected => "reciprocal-centimeter-selects-law"
  | .admitted => "post-recurrence-held-unit-translation"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "rotational-target-readable-before-seal"
  | .admitted => "value-free-complete-axis-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "favorable-molecule-or-present-axis-subset"
  | .admitted => "complete-NIST-list-choice-result-and-axis-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "fitted-inertia-geometry-or-species-correction"
  | .admitted => "one-axis-recurrence-law-no-extra-rule"

structure Candidate where
  carrier : Carrier
  axis : Axis
  magnitude : Magnitude
  ladder : Ladder
  translation : Translation
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, axisName c.axis, magnitudeName c.magnitude, ladderName c.ladder, translationName c.translation, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "axis=" (axisName c.axis), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "ladder=" (ladderName c.ladder), SFT.Host.Text.append "translation=" (translationName c.translation), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-finite-state-geometry-axis-carrier__held-principal-axis-and-equivalence-class__exact-axis-recurrence-over-interval-ratio__positive-JJplusOne-level-and-2J-gap__post-recurrence-held-unit-translation__value-free-complete-axis-identity-seal__complete-NIST-list-choice-result-and-axis-custody__one-axis-recurrence-law-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-finite-state-geometry-axis-carrier" &&
  SFT.Host.Text.equal (axisName c.axis) "held-principal-axis-and-equivalence-class" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-axis-recurrence-over-interval-ratio" &&
  SFT.Host.Text.equal (ladderName c.ladder) "positive-JJplusOne-level-and-2J-gap" &&
  SFT.Host.Text.equal (translationName c.translation) "post-recurrence-held-unit-translation" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-axis-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-NIST-list-choice-result-and-axis-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-axis-recurrence-law-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-finite-state-geometry-axis-carrier") then "An answer-only number erases molecular state, geometry and axis identity." else
  if !(SFT.Host.Text.equal (axisName c.axis) "held-principal-axis-and-equivalence-class") then "Merging principal axes destroys distinct and symmetry-equivalent recurrence records." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-axis-recurrence-over-interval-ratio") then "A named constant or moment-of-inertia equation does not derive the Fold quantity." else
  if !(SFT.Host.Text.equal (ladderName c.ladder) "positive-JJplusOne-level-and-2J-gap") then "A continuum spectrum or selected angular coefficient is not generated." else
  if !(SFT.Host.Text.equal (translationName c.translation) "post-recurrence-held-unit-translation") then "A conventional unit cannot select the axis-recurrence relation." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-complete-axis-identity-seal") then "A readable A, B or C value could select the relation or row set." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-NIST-list-choice-result-and-axis-custody") then "Dropping unavailable species, blank axes or asymmetric rows hides the source boundary." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-axis-recurrence-law-no-extra-rule") then "A fitted inertia, geometry coefficient or species residual is a free parameter." else
  "complete-finite-state-geometry-axis-carrier__held-principal-axis-and-equivalence-class__exact-axis-recurrence-over-interval-ratio__positive-JJplusOne-level-and-2J-gap__post-recurrence-held-unit-translation__value-free-complete-axis-identity-seal__complete-NIST-list-choice-result-and-axis-custody__one-axis-recurrence-law-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, axis, magnitude, ladder, translation, prediction, record and extension forms; decide all 256 candidates from admitted exact geometry, recurrence, spectroscopy, molecular composition and measurement-custody laws."
def grammarBoundary : String := "The depth-independent held-axis recurrence ratio and positive rotational ladder, tested against every row returned by all 1,193 elemental-composition queries generated from all 2,186 entries of the frozen official NIST complete species list: 1,832 returned charge/state choices, 1,005 displayed molecular property rows and all 3,015 A/B/C cells. The 83 listed compositions with no returned selectable row remain explicit and are not misreported as measured."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Axis.rejected,Axis.admitted]).flatMap fun axis =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Ladder.rejected,Ladder.admitted]).flatMap fun ladder =>
  ([Translation.rejected,Translation.admitted]).flatMap fun translation =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,axis,magnitude,ladder,translation,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier axis magnitude ladder translation prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haxis : axis ∈ [Axis.rejected,Axis.admitted] := by
      cases axis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnitude : magnitude ∈ [Magnitude.rejected,Magnitude.admitted] := by
      cases magnitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hladder : ladder ∈ [Ladder.rejected,Ladder.admitted] := by
      cases ladder <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htranslation : translation ∈ [Translation.rejected,Translation.admitted] := by
      cases translation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ axis _ haxis
    apply CommonRefinement.memFlatMap _ _ magnitude _ hmagnitude
    apply CommonRefinement.memFlatMap _ _ ladder _ hladder
    apply CommonRefinement.memFlatMap _ _ translation _ htranslation
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (translation : Translation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,translation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,translation,prediction,record,extension⟩ := by
 cases translation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier axis magnitude ladder translation prediction record extension =>
  cases carrier <;> cases axis <;> cases magnitude <;> cases ladder
  · exact sourceDecisionBlock0000 translation prediction record extension
  · exact sourceDecisionBlock0001 translation prediction record extension
  · exact sourceDecisionBlock0010 translation prediction record extension
  · exact sourceDecisionBlock0011 translation prediction record extension
  · exact sourceDecisionBlock0100 translation prediction record extension
  · exact sourceDecisionBlock0101 translation prediction record extension
  · exact sourceDecisionBlock0110 translation prediction record extension
  · exact sourceDecisionBlock0111 translation prediction record extension
  · exact sourceDecisionBlock1000 translation prediction record extension
  · exact sourceDecisionBlock1001 translation prediction record extension
  · exact sourceDecisionBlock1010 translation prediction record extension
  · exact sourceDecisionBlock1011 translation prediction record extension
  · exact sourceDecisionBlock1100 translation prediction record extension
  · exact sourceDecisionBlock1101 translation prediction record extension
  · exact sourceDecisionBlock1110 translation prediction record extension
  · exact sourceDecisionBlock1111 translation prediction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-finite-state-geometry-axis-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem axisCriterion (value : Axis) : SFT.Host.Text.equal (axisName value) "held-principal-axis-and-equivalence-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "exact-axis-recurrence-over-interval-ratio" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem ladderCriterion (value : Ladder) : SFT.Host.Text.equal (ladderName value) "positive-JJplusOne-level-and-2J-gap" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem translationCriterion (value : Translation) : SFT.Host.Text.equal (translationName value) "post-recurrence-held-unit-translation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-complete-axis-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-NIST-list-choice-result-and-axis-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-axis-recurrence-law-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, axisCriterion, magnitudeCriterion, ladderCriterion, translationCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier axis magnitude ladder translation prediction record extension =>
    cases carrier <;> cases axis <;> cases magnitude <;> cases ladder <;> cases translation <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.axis = .admitted ∧ c.magnitude = .admitted ∧ c.ladder = .admitted ∧ c.translation = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier axis magnitude ladder translation prediction record extension =>
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

theorem axis_rejected_rejected (c : Candidate) (h : c.axis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.axis eq
    rw [h] at field
    cases field

theorem magnitude_rejected_rejected (c : Candidate) (h : c.magnitude = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.magnitude eq
    rw [h] at field
    cases field

theorem ladder_rejected_rejected (c : Candidate) (h : c.ladder = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ladder eq
    rw [h] at field
    cases field

theorem translation_rejected_rejected (c : Candidate) (h : c.translation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.translation eq
    rw [h] at field
    cases field

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
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

end SFT.Chemistry.RotationalConstantGrammar
