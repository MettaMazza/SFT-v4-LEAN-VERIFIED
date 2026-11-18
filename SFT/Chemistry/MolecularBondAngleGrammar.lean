import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularBondAngleGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-angle-scalar"
  | .admitted => "named-state-geometry-sector-carrier"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "unordered-ligand-cloud"
  | .admitted => "exact-generated-cyclic-order"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "unequal-or-fitted-sectors"
  | .admitted => "symmetry-forced-equal-sectors"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "continuum-trigonometric-angle"
  | .admitted => "positive-sector-separation-over-count"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "degree-target-in-prediction"
  | .admitted => "value-free-exact-turn-fraction"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "target-open-before-seal"
  | .admitted => "all-angle-values-open-post-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-species-or-angle-role"
  | .admitted => "complete-three-species-four-angle-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-correction-or-angle-exception"
  | .admitted => "one-law-no-extra-rule"

structure Candidate where
  carrier : Carrier
  order : Order
  partition : Partition
  relation : Relation
  prediction : Prediction
  measurement : Measurement
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, orderName c.order, partitionName c.partition, relationName c.relation, predictionName c.prediction, measurementName c.measurement, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "named-state-geometry-sector-carrier__exact-generated-cyclic-order__symmetry-forced-equal-sectors__positive-sector-separation-over-count__value-free-exact-turn-fraction__all-angle-values-open-post-seal__complete-three-species-four-angle-vector__one-law-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "named-state-geometry-sector-carrier" &&
  SFT.Host.Text.equal (orderName c.order) "exact-generated-cyclic-order" &&
  SFT.Host.Text.equal (partitionName c.partition) "symmetry-forced-equal-sectors" &&
  SFT.Host.Text.equal (relationName c.relation) "positive-sector-separation-over-count" &&
  SFT.Host.Text.equal (predictionName c.prediction) "value-free-exact-turn-fraction" &&
  SFT.Host.Text.equal (measurementName c.measurement) "all-angle-values-open-post-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-three-species-four-angle-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-law-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "named-state-geometry-sector-carrier") then "An answer-only scalar erases the molecular state, geometry and sector carrier." else
  if !(SFT.Host.Text.equal (orderName c.order) "exact-generated-cyclic-order") then "An unordered cloud cannot distinguish adjacent from opposite ligand paths." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "symmetry-forced-equal-sectors") then "Unequal sectors introduce an ungenerated distinction or fitted geometric parameter." else
  if !(SFT.Host.Text.equal (relationName c.relation) "positive-sector-separation-over-count") then "A continuum or irrational trigonometric construction is outside the exact Fold domain." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "value-free-exact-turn-fraction") then "A degree value readable before sealing could select the predicted result." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "all-angle-values-open-post-seal") then "An open target before sealing destroys empirical custody." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-three-species-four-angle-vector") then "Selecting one favorable geometry or omitting an opposite row cannot close the registered vector." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-law-no-extra-rule") then "A species correction or angle exception is a free rule." else
  "named-state-geometry-sector-carrier__exact-generated-cyclic-order__symmetry-forced-equal-sectors__positive-sector-separation-over-count__value-free-exact-turn-fraction__all-angle-values-open-post-seal__complete-three-species-four-angle-vector__one-law-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, cyclic order, sector partition, angle relation, prediction custody, measurement custody, record completeness and extension forms; decide all 256 using only admitted exact structure and the value-free registered target identities."
def grammarBoundary : String := "The complete registered symmetry-forced molecular-angle vector at the official source display resolution: BF3 trigonal-planar adjacent aFBF, XeF2 linear opposite aFXeF, and XeF4 square-planar adjacent and opposite aFXeF, retaining species, neutral state, geometry, angle role, coordinate, method/condition, source identity and source comment."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,order,partition,relation,prediction,measurement,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier order partition relation prediction measurement record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (prediction : Prediction) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,prediction,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,prediction,measurement,record,extension⟩ := by
 cases prediction <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier order partition relation prediction measurement record extension =>
  cases carrier <;> cases order <;> cases partition <;> cases relation
  · exact sourceDecisionBlock0000 prediction measurement record extension
  · exact sourceDecisionBlock0001 prediction measurement record extension
  · exact sourceDecisionBlock0010 prediction measurement record extension
  · exact sourceDecisionBlock0011 prediction measurement record extension
  · exact sourceDecisionBlock0100 prediction measurement record extension
  · exact sourceDecisionBlock0101 prediction measurement record extension
  · exact sourceDecisionBlock0110 prediction measurement record extension
  · exact sourceDecisionBlock0111 prediction measurement record extension
  · exact sourceDecisionBlock1000 prediction measurement record extension
  · exact sourceDecisionBlock1001 prediction measurement record extension
  · exact sourceDecisionBlock1010 prediction measurement record extension
  · exact sourceDecisionBlock1011 prediction measurement record extension
  · exact sourceDecisionBlock1100 prediction measurement record extension
  · exact sourceDecisionBlock1101 prediction measurement record extension
  · exact sourceDecisionBlock1110 prediction measurement record extension
  · exact sourceDecisionBlock1111 prediction measurement record extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "named-state-geometry-sector-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orderCriterion (value : Order) : SFT.Host.Text.equal (orderName value) "exact-generated-cyclic-order" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "symmetry-forced-equal-sectors" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "positive-sector-separation-over-count" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "value-free-exact-turn-fraction" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem measurementCriterion (value : Measurement) : SFT.Host.Text.equal (measurementName value) "all-angle-values-open-post-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-three-species-four-angle-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "one-law-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, orderCriterion, partitionCriterion, relationCriterion, predictionCriterion, measurementCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk carrier order partition relation prediction measurement record extension =>
    cases carrier <;> cases order <;> cases partition <;> cases relation <;> cases prediction <;> cases measurement <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.order = .admitted ∧ c.partition = .admitted ∧ c.relation = .admitted ∧ c.prediction = .admitted ∧ c.measurement = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier order partition relation prediction measurement record extension =>
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

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
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

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
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

theorem measurement_rejected_rejected (c : Candidate) (h : c.measurement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measurement eq
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

end SFT.Chemistry.MolecularBondAngleGrammar
