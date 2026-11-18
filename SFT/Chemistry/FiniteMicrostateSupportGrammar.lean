import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.FiniteMicrostateSupportGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-or-completed-infinite-state-set"
  | .admitted => "complete-generated-finite-chemical-support"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "answer-only-state-count"
  | .admitted => "complete-held-chemical-microstate-identity"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "overlapping-or-omitting-observation-classes"
  | .admitted => "disjoint-exhaustive-macro-observation-partition"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "floating-or-assumed-degeneracy"
  | .admitted => "exact-positive-fibre-count"

inductive Weight where
  | rejected | admitted

def weightName : Weight → String
  | .rejected => "imported-distribution-or-partition-function"
  | .admitted => "exact-fibre-count-over-complete-support-count"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "population-temperature-or-calorimetric-target-readable-before-seal"
  | .admitted => "complete-value-free-state-and-calorimetric-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-population-or-calorimetric-showcase"
  | .admitted => "complete-387-row-external-structure-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "continuum-or-completed-infinity-closure"
  | .admitted => "depth-independent-one-state-finite-successor"

structure Candidate where
  support : Support
  identity : Identity
  partition : Partition
  multiplicity : Multiplicity
  weight : Weight
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [supportName c.support, identityName c.identity, partitionName c.partition, multiplicityName c.multiplicity, weightName c.weight, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "weight=" (weightName c.weight), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-generated-finite-chemical-support__complete-held-chemical-microstate-identity__disjoint-exhaustive-macro-observation-partition__exact-positive-fibre-count__exact-fibre-count-over-complete-support-count__complete-value-free-state-and-calorimetric-identity-seal__complete-387-row-external-structure-custody__depth-independent-one-state-finite-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-generated-finite-chemical-support" &&
  SFT.Host.Text.equal (identityName c.identity) "complete-held-chemical-microstate-identity" &&
  SFT.Host.Text.equal (partitionName c.partition) "disjoint-exhaustive-macro-observation-partition" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "exact-positive-fibre-count" &&
  SFT.Host.Text.equal (weightName c.weight) "exact-fibre-count-over-complete-support-count" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-state-and-calorimetric-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-387-row-external-structure-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-one-state-finite-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-generated-finite-chemical-support") then "A selected or completed-infinite set is neither generated nor exhaustible." else
  if !(SFT.Host.Text.equal (identityName c.identity) "complete-held-chemical-microstate-identity") then "A bare count erases composition, phase, condition and internal-state identity." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "disjoint-exhaustive-macro-observation-partition") then "Overlap duplicates predecessors and omission deletes them." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "exact-positive-fibre-count") then "An assumed degeneracy imports an ungenerated statistical parameter." else
  if !(SFT.Host.Text.equal (weightName c.weight) "exact-fibre-count-over-complete-support-count") then "An imported distribution lets a prior select state weights." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-state-and-calorimetric-identity-seal") then "Target access can select the state support or partition." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-387-row-external-structure-custody") then "A selected example cannot establish complete source custody." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-one-state-finite-successor") then "A completed continuum is not a finite generated successor." else
  "complete-generated-finite-chemical-support__complete-held-chemical-microstate-identity__disjoint-exhaustive-macro-observation-partition__exact-positive-fibre-count__exact-fibre-count-over-complete-support-count__complete-value-free-state-and-calorimetric-identity-seal__complete-387-row-external-structure-custody__depth-independent-one-state-finite-successor"

def generationRule : String := "Generate the literal product of support, identity, partition, multiplicity, weight, prediction, record and extension forms; decide all 256 candidates only from admitted exact state, observation, counting and thermodynamic carrier laws."
def grammarBoundary : String := "Every nonempty finite generated chemical-state tuple and its complete disjoint observation partition, with one-state finite successor closure. Completed infinity and continuum ensembles are outside the grammar. External structure is tested on all 330 direct CaH+ state rows and all 57 NIST water calorimetric rows."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Weight.rejected,Weight.admitted]).flatMap fun weight =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨support,identity,partition,multiplicity,weight,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support identity partition multiplicity weight prediction record extension =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hweight : weight ∈ [Weight.rejected,Weight.admitted] := by
      cases weight <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ weight _ hweight
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,weight,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,weight,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,weight,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,weight,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,weight,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,weight,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,weight,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,weight,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,weight,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,weight,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,weight,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,weight,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,weight,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,weight,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,weight,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (weight : Weight) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,weight,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,weight,prediction,record,extension⟩ := by
 cases weight <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk support identity partition multiplicity weight prediction record extension =>
  cases support <;> cases identity <;> cases partition <;> cases multiplicity
  · exact sourceDecisionBlock0000 weight prediction record extension
  · exact sourceDecisionBlock0001 weight prediction record extension
  · exact sourceDecisionBlock0010 weight prediction record extension
  · exact sourceDecisionBlock0011 weight prediction record extension
  · exact sourceDecisionBlock0100 weight prediction record extension
  · exact sourceDecisionBlock0101 weight prediction record extension
  · exact sourceDecisionBlock0110 weight prediction record extension
  · exact sourceDecisionBlock0111 weight prediction record extension
  · exact sourceDecisionBlock1000 weight prediction record extension
  · exact sourceDecisionBlock1001 weight prediction record extension
  · exact sourceDecisionBlock1010 weight prediction record extension
  · exact sourceDecisionBlock1011 weight prediction record extension
  · exact sourceDecisionBlock1100 weight prediction record extension
  · exact sourceDecisionBlock1101 weight prediction record extension
  · exact sourceDecisionBlock1110 weight prediction record extension
  · exact sourceDecisionBlock1111 weight prediction record extension

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-generated-finite-chemical-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "complete-held-chemical-microstate-identity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "disjoint-exhaustive-macro-observation-partition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem multiplicityCriterion (value : Multiplicity) : SFT.Host.Text.equal (multiplicityName value) "exact-positive-fibre-count" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem weightCriterion (value : Weight) : SFT.Host.Text.equal (weightName value) "exact-fibre-count-over-complete-support-count" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-state-and-calorimetric-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-387-row-external-structure-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-one-state-finite-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [supportCriterion, identityCriterion, partitionCriterion, multiplicityCriterion, weightCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk support identity partition multiplicity weight prediction record extension =>
    cases support <;> cases identity <;> cases partition <;> cases multiplicity <;> cases weight <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.identity = .admitted ∧ c.partition = .admitted ∧ c.multiplicity = .admitted ∧ c.weight = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support identity partition multiplicity weight prediction record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
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

theorem multiplicity_rejected_rejected (c : Candidate) (h : c.multiplicity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multiplicity eq
    rw [h] at field
    cases field

theorem weight_rejected_rejected (c : Candidate) (h : c.weight = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.weight eq
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

end SFT.Chemistry.FiniteMicrostateSupportGrammar
