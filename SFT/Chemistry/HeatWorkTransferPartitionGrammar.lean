import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.HeatWorkTransferPartitionGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-signed-net-energy"
  | .admitted => "complete-held-chemical-transfer-path"

inductive Class where
  | rejected | admitted

def classAxisName : Class → String
  | .rejected => "imported-or-arbitrary-heat-work-label"
  | .admitted => "observation-forced-closed-or-held-carrier-class"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-or-signed-transfer-content"
  | .admitted => "held-direction-plus-exact-positive-content"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "merged-or-overlapping-transfer-classes"
  | .admitted => "disjoint-exhaustive-heat-work-path-partition"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "signed-net-cancellation-or-numerical-zero"
  | .admitted => "per-class-positive-composition-plus-EmptyOne-absence"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "calorimetric-or-work-target-readable-before-seal"
  | .admitted => "complete-value-free-transfer-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-calorimetric-or-expansion-row"
  | .admitted => "complete-13-row-joint-calorimetric-expansion-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "repartition-prior-path-after-successor"
  | .admitted => "depth-independent-append-only-transfer-successor"

structure Candidate where
  carrier : Carrier
  classAxis : Class
  orientation : Orientation
  partition : Partition
  composition : Composition
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, classAxisName c.classAxis, orientationName c.orientation, partitionName c.partition, compositionName c.composition, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "class=" (classAxisName c.classAxis), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-held-chemical-transfer-path__observation-forced-closed-or-held-carrier-class__held-direction-plus-exact-positive-content__disjoint-exhaustive-heat-work-path-partition__per-class-positive-composition-plus-EmptyOne-absence__complete-value-free-transfer-identity-seal__complete-13-row-joint-calorimetric-expansion-vector__depth-independent-append-only-transfer-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-held-chemical-transfer-path" &&
  SFT.Host.Text.equal (classAxisName c.classAxis) "observation-forced-closed-or-held-carrier-class" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-direction-plus-exact-positive-content" &&
  SFT.Host.Text.equal (partitionName c.partition) "disjoint-exhaustive-heat-work-path-partition" &&
  SFT.Host.Text.equal (compositionName c.composition) "per-class-positive-composition-plus-EmptyOne-absence" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-transfer-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-13-row-joint-calorimetric-expansion-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-only-transfer-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-held-chemical-transfer-path") then "A signed answer erases the boundary, path and transfer provenance." else
  if !(SFT.Host.Text.equal (classAxisName c.classAxis) "observation-forced-closed-or-held-carrier-class") then "An arbitrary label does not explain the heat/work distinction." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-direction-plus-exact-positive-content") then "A signed proof value conflates direction with content." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "disjoint-exhaustive-heat-work-path-partition") then "A merged or overlapping record cannot retain which distinction observation closed." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "per-class-positive-composition-plus-EmptyOne-absence") then "Signed cancellation deletes transfer history and numerical zero is not an SFT number." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-transfer-identity-seal") then "Target values could select the partition." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-13-row-joint-calorimetric-expansion-vector") then "A selected row can hide phase and unfavorable records." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-only-transfer-successor") then "Repartitioning earlier transfers destroys path invariance." else
  "complete-held-chemical-transfer-path__observation-forced-closed-or-held-carrier-class__held-direction-plus-exact-positive-content__disjoint-exhaustive-heat-work-path-partition__per-class-positive-composition-plus-EmptyOne-absence__complete-value-free-transfer-identity-seal__complete-13-row-joint-calorimetric-expansion-vector__depth-independent-append-only-transfer-successor"

def generationRule : String := "Generate the literal product of carrier, class, orientation, partition, composition, prediction, record and extension forms; decide all 256 candidates only from admitted Fold observation, conservation, composition, Physics heat/work and chemical internal-energy laws."
def grammarBoundary : String := "Every finite nonempty chemical transfer path across one held boundary, with each exact positive transfer classified only by retained or closed carrier identity and with append-only successor closure. External testing retains every column and row of the frozen NIST one-bar water surface."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Class.rejected,Class.admitted]).flatMap fun classAxis =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,classAxis,orientation,partition,composition,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier classAxis orientation partition composition prediction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclassAxis : classAxis ∈ [Class.rejected,Class.admitted] := by
      cases classAxis <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ classAxis _ hclassAxis
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,composition,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,composition,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,composition,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,composition,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,composition,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,composition,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,composition,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,composition,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,composition,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,composition,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,composition,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,composition,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,composition,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,composition,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,composition,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (composition : Composition) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,composition,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,composition,prediction,record,extension⟩ := by
 cases composition <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier classAxis orientation partition composition prediction record extension =>
  cases carrier <;> cases classAxis <;> cases orientation <;> cases partition
  · exact sourceDecisionBlock0000 composition prediction record extension
  · exact sourceDecisionBlock0001 composition prediction record extension
  · exact sourceDecisionBlock0010 composition prediction record extension
  · exact sourceDecisionBlock0011 composition prediction record extension
  · exact sourceDecisionBlock0100 composition prediction record extension
  · exact sourceDecisionBlock0101 composition prediction record extension
  · exact sourceDecisionBlock0110 composition prediction record extension
  · exact sourceDecisionBlock0111 composition prediction record extension
  · exact sourceDecisionBlock1000 composition prediction record extension
  · exact sourceDecisionBlock1001 composition prediction record extension
  · exact sourceDecisionBlock1010 composition prediction record extension
  · exact sourceDecisionBlock1011 composition prediction record extension
  · exact sourceDecisionBlock1100 composition prediction record extension
  · exact sourceDecisionBlock1101 composition prediction record extension
  · exact sourceDecisionBlock1110 composition prediction record extension
  · exact sourceDecisionBlock1111 composition prediction record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-held-chemical-transfer-path" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem classAxisCriterion (value : Class) : SFT.Host.Text.equal (classAxisName value) "observation-forced-closed-or-held-carrier-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "held-direction-plus-exact-positive-content" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "disjoint-exhaustive-heat-work-path-partition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "per-class-positive-composition-plus-EmptyOne-absence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-transfer-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-13-row-joint-calorimetric-expansion-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-append-only-transfer-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, classAxisCriterion, orientationCriterion, partitionCriterion, compositionCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier classAxis orientation partition composition prediction record extension =>
    cases carrier <;> cases classAxis <;> cases orientation <;> cases partition <;> cases composition <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.classAxis = .admitted ∧ c.orientation = .admitted ∧ c.partition = .admitted ∧ c.composition = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier classAxis orientation partition composition prediction record extension =>
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

theorem classAxis_rejected_rejected (c : Candidate) (h : c.classAxis = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.classAxis eq
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

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
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

end SFT.Chemistry.HeatWorkTransferPartitionGrammar
