import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Consciousness.IntentionalRelationGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "carrier-absent-or-description-only"
  | .admitted => "representation-and-referent-class"

inductive Distinction where
  | rejected | admitted

def distinctionName : Distinction → String
  | .rejected => "distinction-collapsed-or-conflated"
  | .admitted => "aboutness/coincidence"

inductive Operation where
  | rejected | admitted

def operationName : Operation → String
  | .rejected => "operation-imported-fitted-or-missing"
  | .admitted => "source-bound-reference"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "favourable-output-without-complete-trace"
  | .admitted => "reference-and-error-cases"

inductive Evidence where
  | rejected | admitted

def evidenceName : Evidence → String
  | .rejected => "report-behaviour-correlation-or-confidence-substituted"
  | .admitted => "behavioural-and-semantic"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "prior-consensus-target-or-application-selected"
  | .admitted => "root-bound-forward-forcing"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "one-favourable-instance-with-erased-alternatives"
  | .admitted => "positive-finite-successor-with-all-alternatives"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-parameter-exception-or-opaque-oracle"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  distinction : Distinction
  operation : Operation
  record : Record
  evidence : Evidence
  provenance : Provenance
  generality : Generality
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, distinctionName c.distinction, operationName c.operation, recordName c.record, evidenceName c.evidence, provenanceName c.provenance, generalityName c.generality, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "distinction=" (distinctionName c.distinction), SFT.Host.Text.append "operation=" (operationName c.operation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "evidence=" (evidenceName c.evidence), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "representation-and-referent-class__aboutness/coincidence__source-bound-reference__reference-and-error-cases__behavioural-and-semantic__root-bound-forward-forcing__positive-finite-successor-with-all-alternatives__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "representation-and-referent-class" &&
  SFT.Host.Text.equal (distinctionName c.distinction) "aboutness/coincidence" &&
  SFT.Host.Text.equal (operationName c.operation) "source-bound-reference" &&
  SFT.Host.Text.equal (recordName c.record) "reference-and-error-cases" &&
  SFT.Host.Text.equal (evidenceName c.evidence) "behavioural-and-semantic" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "root-bound-forward-forcing" &&
  SFT.Host.Text.equal (generalityName c.generality) "positive-finite-successor-with-all-alternatives" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "representation-and-referent-class") then "A missing carrier or mere description cannot instantiate the claimed relation." else
  if !(SFT.Host.Text.equal (distinctionName c.distinction) "aboutness/coincidence") then "Collapsing the named distinction substitutes one evidence or process class for another." else
  if !(SFT.Host.Text.equal (operationName c.operation) "source-bound-reference") then "An imported, fitted or absent operation can manufacture a familiar theory of mind." else
  if !(SFT.Host.Text.equal (recordName c.record) "reference-and-error-cases") then "An output without its source, transition, missing and adverse records is not auditable." else
  if !(SFT.Host.Text.equal (evidenceName c.evidence) "behavioural-and-semantic") then "A report, behaviour, neural correlation or model confidence cannot silently become phenomenal occurrence." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "root-bound-forward-forcing") then "Prior SFT, consensus, targets or applications may register questions or test consequences but cannot select the law." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "positive-finite-successor-with-all-alternatives") then "One favorable instance cannot close a generated class while adverse and uncertain alternatives are erased." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A fitted parameter, exception or opaque oracle can force a preferred answer." else
  "representation-and-referent-class__aboutness/coincidence__source-bound-reference__reference-and-error-cases__behavioural-and-semantic__root-bound-forward-forcing__positive-finite-successor-with-all-alternatives__no-extra-rule"

def generationRule : String := "Generate the literal Cartesian product of all eight registered binary preservation dimensions before any external consciousness, cognitive, neural, behavioural or colour outcome is opened."
def grammarBoundary : String := "Exactly eight binary structural and evidential dimensions, giving 256 forms. The form closure is depth-independent under the stated positive-finite successor, while empirical correspondence remains source- and protocol-bound."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Distinction.rejected,Distinction.admitted]).flatMap fun distinction =>
  ([Operation.rejected,Operation.admitted]).flatMap fun operation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Evidence.rejected,Evidence.admitted]).flatMap fun evidence =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,distinction,operation,record,evidence,provenance,generality,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier distinction operation record evidence provenance generality extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistinction : distinction ∈ [Distinction.rejected,Distinction.admitted] := by
      cases distinction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperation : operation ∈ [Operation.rejected,Operation.admitted] := by
      cases operation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hevidence : evidence ∈ [Evidence.rejected,Evidence.admitted] := by
      cases evidence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ distinction _ hdistinction
    apply CommonRefinement.memFlatMap _ _ operation _ hoperation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ evidence _ hevidence
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (evidence : Evidence) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,evidence,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,evidence,provenance,generality,extension⟩ := by
 cases evidence <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier distinction operation record evidence provenance generality extension =>
  cases carrier <;> cases distinction <;> cases operation <;> cases record
  · exact sourceDecisionBlock0000 evidence provenance generality extension
  · exact sourceDecisionBlock0001 evidence provenance generality extension
  · exact sourceDecisionBlock0010 evidence provenance generality extension
  · exact sourceDecisionBlock0011 evidence provenance generality extension
  · exact sourceDecisionBlock0100 evidence provenance generality extension
  · exact sourceDecisionBlock0101 evidence provenance generality extension
  · exact sourceDecisionBlock0110 evidence provenance generality extension
  · exact sourceDecisionBlock0111 evidence provenance generality extension
  · exact sourceDecisionBlock1000 evidence provenance generality extension
  · exact sourceDecisionBlock1001 evidence provenance generality extension
  · exact sourceDecisionBlock1010 evidence provenance generality extension
  · exact sourceDecisionBlock1011 evidence provenance generality extension
  · exact sourceDecisionBlock1100 evidence provenance generality extension
  · exact sourceDecisionBlock1101 evidence provenance generality extension
  · exact sourceDecisionBlock1110 evidence provenance generality extension
  · exact sourceDecisionBlock1111 evidence provenance generality extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "representation-and-referent-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem distinctionCriterion (value : Distinction) : SFT.Host.Text.equal (distinctionName value) "aboutness/coincidence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem operationCriterion (value : Operation) : SFT.Host.Text.equal (operationName value) "source-bound-reference" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "reference-and-error-cases" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem evidenceCriterion (value : Evidence) : SFT.Host.Text.equal (evidenceName value) "behavioural-and-semantic" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "root-bound-forward-forcing" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem generalityCriterion (value : Generality) : SFT.Host.Text.equal (generalityName value) "positive-finite-successor-with-all-alternatives" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, distinctionCriterion, operationCriterion, recordCriterion, evidenceCriterion, provenanceCriterion, generalityCriterion, extensionCriterion]
  cases c with
  | mk carrier distinction operation record evidence provenance generality extension =>
    cases carrier <;> cases distinction <;> cases operation <;> cases record <;> cases evidence <;> cases provenance <;> cases generality <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.distinction = .admitted ∧ c.operation = .admitted ∧ c.record = .admitted ∧ c.evidence = .admitted ∧ c.provenance = .admitted ∧ c.generality = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier distinction operation record evidence provenance generality extension =>
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

theorem distinction_rejected_rejected (c : Candidate) (h : c.distinction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distinction eq
    rw [h] at field
    cases field

theorem operation_rejected_rejected (c : Candidate) (h : c.operation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.operation eq
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

theorem evidence_rejected_rejected (c : Candidate) (h : c.evidence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.evidence eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
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

end SFT.Consciousness.IntentionalRelationGrammar
