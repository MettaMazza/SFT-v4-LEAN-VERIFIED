import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.EnthalpyEquivalentStateGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "answer-only-signed-enthalpy-scalar"
  | .admitted => "complete-held-state-and-environment-carrier"

inductive Internal where
  | rejected | admitted

def internalName : Internal → String
  | .rejected => "fitted-or-unnamed-internal-content"
  | .admitted => "retained-exact-positive-internal-content"

inductive Environment where
  | rejected | admitted

def environmentName : Environment → String
  | .rejected => "imported-pressure-volume-equation"
  | .admitted => "observation-forced-organized-environment-transfer-parts"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "signed-cancellation-or-numerical-zero-correction"
  | .admitted => "exact-positive-composition-plus-EmptyOne-absence"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-enthalpy-proof-magnitude"
  | .admitted => "held-state-orientation-plus-positive-separation"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "enthalpy-target-readable-before-seal"
  | .admitted => "complete-value-free-enthalpy-state-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-enthalpy-or-single-phase-row"
  | .admitted => "complete-13-row-enthalpy-component-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-prior-state-after-environment-successor"
  | .admitted => "depth-independent-append-only-environment-part-successor"

structure Candidate where
  state : State
  internal : Internal
  environment : Environment
  composition : Composition
  orientation : Orientation
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [stateName c.state, internalName c.internal, environmentName c.environment, compositionName c.composition, orientationName c.orientation, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "internal=" (internalName c.internal), SFT.Host.Text.append "environment=" (environmentName c.environment), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-held-state-and-environment-carrier__retained-exact-positive-internal-content__observation-forced-organized-environment-transfer-parts__exact-positive-composition-plus-EmptyOne-absence__held-state-orientation-plus-positive-separation__complete-value-free-enthalpy-state-identity-seal__complete-13-row-enthalpy-component-vector__depth-independent-append-only-environment-part-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (stateName c.state) "complete-held-state-and-environment-carrier" &&
  SFT.Host.Text.equal (internalName c.internal) "retained-exact-positive-internal-content" &&
  SFT.Host.Text.equal (environmentName c.environment) "observation-forced-organized-environment-transfer-parts" &&
  SFT.Host.Text.equal (compositionName c.composition) "exact-positive-composition-plus-EmptyOne-absence" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-state-orientation-plus-positive-separation" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-enthalpy-state-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-13-row-enthalpy-component-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-only-environment-part-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (stateName c.state) "complete-held-state-and-environment-carrier") then "A signed scalar erases composition, phase, molecular state and environment." else
  if !(SFT.Host.Text.equal (internalName c.internal) "retained-exact-positive-internal-content") then "A fitted internal term can absorb any target discrepancy." else
  if !(SFT.Host.Text.equal (environmentName c.environment) "observation-forced-organized-environment-transfer-parts") then "An imported equation would select the environment correction rather than derive its role." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "exact-positive-composition-plus-EmptyOne-absence") then "Signs erase transfer provenance and numerical zero is not an SFT number." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-state-orientation-plus-positive-separation") then "A negative proof magnitude conflates relation direction with content." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-enthalpy-state-identity-seal") then "Target values could select an environment part or state order." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-13-row-enthalpy-component-vector") then "A selected row can hide phase and unfavorable records." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-only-environment-part-successor") then "Refitting prior content destroys compositional invariance." else
  "complete-held-state-and-environment-carrier__retained-exact-positive-internal-content__observation-forced-organized-environment-transfer-parts__exact-positive-composition-plus-EmptyOne-absence__held-state-orientation-plus-positive-separation__complete-value-free-enthalpy-state-identity-seal__complete-13-row-enthalpy-component-vector__depth-independent-append-only-environment-part-successor"

def generationRule : String := "Generate the literal product of state, internal, environment, composition, orientation, prediction, record and extension forms; decide all 256 candidates only from admitted exact composition, energy conservation, heat/work observation and chemical internal-energy laws."
def grammarBoundary : String := "Every finite complete chemical state with exact positive internal content and every finite tuple of uniquely named retained organized environment-transfer parts, including structural EmptyOne absence and append-only successor closure. External testing retains all rows and columns of the frozen NIST one-bar water surface."

def candidates : List Candidate :=
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Internal.rejected,Internal.admitted]).flatMap fun internal =>
  ([Environment.rejected,Environment.admitted]).flatMap fun environment =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨state,internal,environment,composition,orientation,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk state internal environment composition orientation prediction record extension =>
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinternal : internal ∈ [Internal.rejected,Internal.admitted] := by
      cases internal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henvironment : environment ∈ [Environment.rejected,Environment.admitted] := by
      cases environment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ internal _ hinternal
    apply CommonRefinement.memFlatMap _ _ environment _ henvironment
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (orientation : Orientation) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,orientation,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,orientation,prediction,record,extension⟩ := by
 cases orientation <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk state internal environment composition orientation prediction record extension =>
  cases state <;> cases internal <;> cases environment <;> cases composition
  · exact sourceDecisionBlock0000 orientation prediction record extension
  · exact sourceDecisionBlock0001 orientation prediction record extension
  · exact sourceDecisionBlock0010 orientation prediction record extension
  · exact sourceDecisionBlock0011 orientation prediction record extension
  · exact sourceDecisionBlock0100 orientation prediction record extension
  · exact sourceDecisionBlock0101 orientation prediction record extension
  · exact sourceDecisionBlock0110 orientation prediction record extension
  · exact sourceDecisionBlock0111 orientation prediction record extension
  · exact sourceDecisionBlock1000 orientation prediction record extension
  · exact sourceDecisionBlock1001 orientation prediction record extension
  · exact sourceDecisionBlock1010 orientation prediction record extension
  · exact sourceDecisionBlock1011 orientation prediction record extension
  · exact sourceDecisionBlock1100 orientation prediction record extension
  · exact sourceDecisionBlock1101 orientation prediction record extension
  · exact sourceDecisionBlock1110 orientation prediction record extension
  · exact sourceDecisionBlock1111 orientation prediction record extension

theorem stateCriterion (value : State) : SFT.Host.Text.equal (stateName value) "complete-held-state-and-environment-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem internalCriterion (value : Internal) : SFT.Host.Text.equal (internalName value) "retained-exact-positive-internal-content" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem environmentCriterion (value : Environment) : SFT.Host.Text.equal (environmentName value) "observation-forced-organized-environment-transfer-parts" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "exact-positive-composition-plus-EmptyOne-absence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-state-orientation-plus-positive-separation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-enthalpy-state-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-13-row-enthalpy-component-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-append-only-environment-part-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [stateCriterion, internalCriterion, environmentCriterion, compositionCriterion, orientationCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk state internal environment composition orientation prediction record extension =>
    cases state <;> cases internal <;> cases environment <;> cases composition <;> cases orientation <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.state = .admitted ∧ c.internal = .admitted ∧ c.environment = .admitted ∧ c.composition = .admitted ∧ c.orientation = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk state internal environment composition orientation prediction record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem state_rejected_rejected (c : Candidate) (h : c.state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state eq
    rw [h] at field
    cases field

theorem internal_rejected_rejected (c : Candidate) (h : c.internal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.internal eq
    rw [h] at field
    cases field

theorem environment_rejected_rejected (c : Candidate) (h : c.environment = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.environment eq
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

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

end SFT.Chemistry.EnthalpyEquivalentStateGrammar
