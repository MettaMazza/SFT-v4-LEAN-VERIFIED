import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.EntropyMultiplicityCorrespondenceGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-or-completed-infinite-chemical-support"
  | .admitted => "complete-finite-chemical-microstate-support"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "overlapping-or-partial-macroclasses"
  | .admitted => "disjoint-exhaustive-chemical-observation-classes"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "fitted-probability-or-floating-weight"
  | .admitted => "exact-positive-class-count-and-whole-part"

inductive Entropy where
  | rejected | admitted

def entropyName : Entropy → String
  | .rejected => "logarithmic-or-irrational-scalar-proof"
  | .admitted => "complete-unresolved-distinction-ledger"

inductive Certainty where
  | rejected | admitted

def certaintyName : Certainty → String
  | .rejected => "numerical-zero-singleton-entropy"
  | .admitted => "structural-EmptyOne-singleton-certainty"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "entropy-or-phase-target-readable-before-seal"
  | .admitted => "complete-value-free-entropy-phase-identity-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-entropy-or-single-phase-row"
  | .admitted => "complete-13-row-entropy-phase-transition-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "resample-or-refit-after-new-microstate"
  | .admitted => "depth-independent-one-microstate-ledger-successor"

structure Candidate where
  support : Support
  partition : Partition
  multiplicity : Multiplicity
  entropy : Entropy
  certainty : Certainty
  prediction : Prediction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [supportName c.support, partitionName c.partition, multiplicityName c.multiplicity, entropyName c.entropy, certaintyName c.certainty, predictionName c.prediction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "entropy=" (entropyName c.entropy), SFT.Host.Text.append "certainty=" (certaintyName c.certainty), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-finite-chemical-microstate-support__disjoint-exhaustive-chemical-observation-classes__exact-positive-class-count-and-whole-part__complete-unresolved-distinction-ledger__structural-EmptyOne-singleton-certainty__complete-value-free-entropy-phase-identity-seal__complete-13-row-entropy-phase-transition-vector__depth-independent-one-microstate-ledger-successor"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-finite-chemical-microstate-support" &&
  SFT.Host.Text.equal (partitionName c.partition) "disjoint-exhaustive-chemical-observation-classes" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "exact-positive-class-count-and-whole-part" &&
  SFT.Host.Text.equal (entropyName c.entropy) "complete-unresolved-distinction-ledger" &&
  SFT.Host.Text.equal (certaintyName c.certainty) "structural-EmptyOne-singleton-certainty" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-entropy-phase-identity-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-13-row-entropy-phase-transition-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-one-microstate-ledger-successor"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-finite-chemical-microstate-support") then "A selected or completed-infinite support cannot establish complete multiplicity." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "disjoint-exhaustive-chemical-observation-classes") then "Overlap or omission destroys exact observation multiplicity." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "exact-positive-class-count-and-whole-part") then "A fit imports a distribution and precision choice." else
  if !(SFT.Host.Text.equal (entropyName c.entropy) "complete-unresolved-distinction-ledger") then "A logarithmic scalar imports forbidden irrational proof values and erases provenance." else
  if !(SFT.Host.Text.equal (certaintyName c.certainty) "structural-EmptyOne-singleton-certainty") then "Numerical zero is not an SFT proof value." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-entropy-phase-identity-seal") then "Observed entropy could select multiplicity or ordering." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-13-row-entropy-phase-transition-vector") then "A selected row can hide a phase transition or adverse orientation." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-one-microstate-ledger-successor") then "Resampling changes prior evidence and cannot prove every finite support." else
  "complete-finite-chemical-microstate-support__disjoint-exhaustive-chemical-observation-classes__exact-positive-class-count-and-whole-part__complete-unresolved-distinction-ledger__structural-EmptyOne-singleton-certainty__complete-value-free-entropy-phase-identity-seal__complete-13-row-entropy-phase-transition-vector__depth-independent-one-microstate-ledger-successor"

def generationRule : String := "Generate the literal product of support, partition, multiplicity, entropy, certainty, prediction, record and extension forms; decide all 256 candidates only from admitted exact information-support, observation, combinatorial and finite chemical microstate laws."
def grammarBoundary : String := "Every finite nonempty generated chemical microstate support and total macro-observation partition, with exact positive class counts, complete within-class pair ledgers and one-microstate successor closure. External testing retains every entropy and phase row of the frozen NIST one-bar water surface."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Entropy.rejected,Entropy.admitted]).flatMap fun entropy =>
  ([Certainty.rejected,Certainty.admitted]).flatMap fun certainty =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨support,partition,multiplicity,entropy,certainty,prediction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support partition multiplicity entropy certainty prediction record extension =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hentropy : entropy ∈ [Entropy.rejected,Entropy.admitted] := by
      cases entropy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcertainty : certainty ∈ [Certainty.rejected,Certainty.admitted] := by
      cases certainty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ entropy _ hentropy
    apply CommonRefinement.memFlatMap _ _ certainty _ hcertainty
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (certainty : Certainty) (prediction : Prediction) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,certainty,prediction,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,certainty,prediction,record,extension⟩ := by
 cases certainty <;> cases prediction <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk support partition multiplicity entropy certainty prediction record extension =>
  cases support <;> cases partition <;> cases multiplicity <;> cases entropy
  · exact sourceDecisionBlock0000 certainty prediction record extension
  · exact sourceDecisionBlock0001 certainty prediction record extension
  · exact sourceDecisionBlock0010 certainty prediction record extension
  · exact sourceDecisionBlock0011 certainty prediction record extension
  · exact sourceDecisionBlock0100 certainty prediction record extension
  · exact sourceDecisionBlock0101 certainty prediction record extension
  · exact sourceDecisionBlock0110 certainty prediction record extension
  · exact sourceDecisionBlock0111 certainty prediction record extension
  · exact sourceDecisionBlock1000 certainty prediction record extension
  · exact sourceDecisionBlock1001 certainty prediction record extension
  · exact sourceDecisionBlock1010 certainty prediction record extension
  · exact sourceDecisionBlock1011 certainty prediction record extension
  · exact sourceDecisionBlock1100 certainty prediction record extension
  · exact sourceDecisionBlock1101 certainty prediction record extension
  · exact sourceDecisionBlock1110 certainty prediction record extension
  · exact sourceDecisionBlock1111 certainty prediction record extension

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "complete-finite-chemical-microstate-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem partitionCriterion (value : Partition) : SFT.Host.Text.equal (partitionName value) "disjoint-exhaustive-chemical-observation-classes" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem multiplicityCriterion (value : Multiplicity) : SFT.Host.Text.equal (multiplicityName value) "exact-positive-class-count-and-whole-part" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem entropyCriterion (value : Entropy) : SFT.Host.Text.equal (entropyName value) "complete-unresolved-distinction-ledger" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem certaintyCriterion (value : Certainty) : SFT.Host.Text.equal (certaintyName value) "structural-EmptyOne-singleton-certainty" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-entropy-phase-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-13-row-entropy-phase-transition-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-one-microstate-ledger-successor" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [supportCriterion, partitionCriterion, multiplicityCriterion, entropyCriterion, certaintyCriterion, predictionCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk support partition multiplicity entropy certainty prediction record extension =>
    cases support <;> cases partition <;> cases multiplicity <;> cases entropy <;> cases certainty <;> cases prediction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.partition = .admitted ∧ c.multiplicity = .admitted ∧ c.entropy = .admitted ∧ c.certainty = .admitted ∧ c.prediction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support partition multiplicity entropy certainty prediction record extension =>
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

theorem entropy_rejected_rejected (c : Candidate) (h : c.entropy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.entropy eq
    rw [h] at field
    cases field

theorem certainty_rejected_rejected (c : Candidate) (h : c.certainty = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.certainty eq
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

end SFT.Chemistry.EntropyMultiplicityCorrespondenceGrammar
