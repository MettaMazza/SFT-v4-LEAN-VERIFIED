import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.InternalEnergyCompositionGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-signed-energy-scalar"
  | .admitted => "complete-held-chemical-internal-energy-state"

inductive Parts where
  | rejected | admitted

def partsName : Parts → String
  | .rejected => "fitted-total-or-unnamed-contribution"
  | .admitted => "nonempty-exact-positive-named-part-composition"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-proof-magnitude"
  | .admitted => "held-transfer-orientation-plus-positive-magnitude"

inductive Equality where
  | rejected | admitted

def equalityName : Equality → String
  | .rejected => "numerical-zero-energy-change"
  | .admitted => "structural-EmptyOne-equality"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "endpoint-only-or-signed-cancellation"
  | .admitted => "complete-same-orientation-step-composition"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "internal-energy-target-readable-before-seal"
  | .admitted => "complete-value-free-thermochemical-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-state-or-single-phase-vector"
  | .admitted => "complete-13-row-14-column-state-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-prior-parts-after-successor"
  | .admitted => "depth-independent-append-only-positive-part-successor"

structure Candidate where
  carrier : Carrier
  parts : Parts
  orientation : Orientation
  equality : Equality
  path : Path
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, partsName c.parts, orientationName c.orientation, equalityName c.equality, pathName c.path, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "parts=" (partsName c.parts), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "equality=" (equalityName c.equality), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-held-chemical-internal-energy-state__nonempty-exact-positive-named-part-composition__held-transfer-orientation-plus-positive-magnitude__structural-EmptyOne-equality__complete-same-orientation-step-composition__complete-value-free-thermochemical-identity-seal__complete-13-row-14-column-state-vector__depth-independent-append-only-positive-part-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-held-chemical-internal-energy-state" &&
  SFT.Host.Text.equal (partsName c.parts) "nonempty-exact-positive-named-part-composition" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-transfer-orientation-plus-positive-magnitude" &&
  SFT.Host.Text.equal (equalityName c.equality) "structural-EmptyOne-equality" &&
  SFT.Host.Text.equal (pathName c.path) "complete-same-orientation-step-composition" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-thermochemical-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-13-row-14-column-state-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-only-positive-part-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-held-chemical-internal-energy-state") then "A signed scalar erases composition, state, phase and environment." else
  if !(SFT.Host.Text.equal (partsName c.parts) "nonempty-exact-positive-named-part-composition") then "A fitted total or unnamed term can absorb any target discrepancy." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-transfer-orientation-plus-positive-magnitude") then "A negative proof magnitude conflates direction with content." else
  if !(SFT.Host.Text.equal (equalityName c.equality) "structural-EmptyOne-equality") then "Numerical zero is not an SFT number or proof object." else
  if !(SFT.Host.Text.equal (pathName c.path) "complete-same-orientation-step-composition") then "Endpoint-only cancellation deletes intermediate transfer provenance." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-thermochemical-identity-seal") then "A target value could select the parts or orientation." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-13-row-14-column-state-vector") then "A selected state can hide phase and unfavorable rows." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-only-positive-part-successor") then "Refitting earlier parts destroys compositional invariance." else
  "complete-held-chemical-internal-energy-state__nonempty-exact-positive-named-part-composition__held-transfer-orientation-plus-positive-magnitude__structural-EmptyOne-equality__complete-same-orientation-step-composition__complete-value-free-thermochemical-identity-seal__complete-13-row-14-column-state-vector__depth-independent-append-only-positive-part-successor"

def generationRule : String := "Generate the literal product of carrier, parts, orientation, equality, path, prediction, record and extension forms; decide all 256 candidates only from admitted exact composition, order, energy-conservation and finite-state laws."
def grammarBoundary : String := "Every finite nonempty named positive energy-part tuple and every finite same-orientation chemical-state path, with append-only successor closure. External testing uses every row and every column returned by the frozen NIST one-bar water query from 300 to 400 K, including both phase-boundary states."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Parts.rejected,Parts.admitted]).flatMap fun parts =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Equality.rejected,Equality.admitted]).flatMap fun equality =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,parts,orientation,equality,path,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier parts orientation equality path prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hparts : parts ∈ [Parts.rejected,Parts.admitted] := by
      cases parts <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequality : equality ∈ [Equality.rejected,Equality.admitted] := by
      cases equality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ parts _ hparts
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ equality _ hequality
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,path,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,path,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,path,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,path,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,path,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,path,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,path,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,path,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,path,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,path,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,path,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,path,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,path,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,path,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,path,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (path : Path) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,path,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,path,prediction,record,extension⟩ := by
 cases path <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier parts orientation equality path prediction record extension =>
  cases carrier <;> cases parts <;> cases orientation <;> cases equality
  · exact sourceDecisionBlock0000 path prediction record extension
  · exact sourceDecisionBlock0001 path prediction record extension
  · exact sourceDecisionBlock0010 path prediction record extension
  · exact sourceDecisionBlock0011 path prediction record extension
  · exact sourceDecisionBlock0100 path prediction record extension
  · exact sourceDecisionBlock0101 path prediction record extension
  · exact sourceDecisionBlock0110 path prediction record extension
  · exact sourceDecisionBlock0111 path prediction record extension
  · exact sourceDecisionBlock1000 path prediction record extension
  · exact sourceDecisionBlock1001 path prediction record extension
  · exact sourceDecisionBlock1010 path prediction record extension
  · exact sourceDecisionBlock1011 path prediction record extension
  · exact sourceDecisionBlock1100 path prediction record extension
  · exact sourceDecisionBlock1101 path prediction record extension
  · exact sourceDecisionBlock1110 path prediction record extension
  · exact sourceDecisionBlock1111 path prediction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-held-chemical-internal-energy-state" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partsCriterion (value : Parts) : SFT.Host.Text.equal (partsName value) "nonempty-exact-positive-named-part-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-transfer-orientation-plus-positive-magnitude" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem equalityCriterion (value : Equality) : SFT.Host.Text.equal (equalityName value) "structural-EmptyOne-equality" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "complete-same-orientation-step-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-thermochemical-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-13-row-14-column-state-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-append-only-positive-part-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, partsCriterion, orientationCriterion, equalityCriterion, pathCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier parts orientation equality path prediction record extension =>
    cases carrier <;> cases parts <;> cases orientation <;> cases equality <;> cases path <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.parts = .admitted ∧ c.orientation = .admitted ∧ c.equality = .admitted ∧ c.path = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier parts orientation equality path prediction record extension =>
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

theorem parts_rejected_rejected (c : Candidate) (h : c.parts = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.parts eq
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

theorem equality_rejected_rejected (c : Candidate) (h : c.equality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equality eq
    rw [h] at field
    cases field

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
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

end SFT.Chemistry.InternalEnergyCompositionGrammar
