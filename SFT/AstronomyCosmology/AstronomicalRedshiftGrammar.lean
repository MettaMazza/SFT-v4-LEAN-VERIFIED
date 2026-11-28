import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.AstronomyCosmology.AstronomicalRedshiftGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "answer-only-or-unbounded-carrier"
  | .admitted => "emitted-observed-feature-carrier"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "frame-time-or-selection-erased"
  | .admitted => "redshift-cause-bounded"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "imported-fitted-or-missing-relation"
  | .admitted => "feature-displacement-relation"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "favourable-output-incomplete-record"
  | .admitted => "feature-identity-frame-motion-gravity-expansion-and-error-held"

inductive Evidence where
  | rejected | admitted

def evidenceName : Evidence → String
  | .rejected => "observation-model-forecast-conflated"
  | .admitted => "evidence-class-explicit"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "prior-answer-or-target-selected"
  | .admitted => "root-bound-forward-forcing"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "one-favourable-object-erases-population"
  | .admitted => "positive-finite-extension-retains-all-rows"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-parameter-exception-or-opaque-oracle"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  boundary : Boundary
  relation : Relation
  record : Record
  evidence : Evidence
  provenance : Provenance
  generality : Generality
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, boundaryName c.boundary, relationName c.relation, recordName c.record, evidenceName c.evidence, provenanceName c.provenance, generalityName c.generality, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "evidence=" (evidenceName c.evidence), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "emitted-observed-feature-carrier__redshift-cause-bounded__feature-displacement-relation__feature-identity-frame-motion-gravity-expansion-and-error-held__evidence-class-explicit__root-bound-forward-forcing__positive-finite-extension-retains-all-rows__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "emitted-observed-feature-carrier" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "redshift-cause-bounded" &&
  SFT.Host.Text.equal (relationName c.relation) "feature-displacement-relation" &&
  SFT.Host.Text.equal (recordName c.record) "feature-identity-frame-motion-gravity-expansion-and-error-held" &&
  SFT.Host.Text.equal (evidenceName c.evidence) "evidence-class-explicit" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "root-bound-forward-forcing" &&
  SFT.Host.Text.equal (generalityName c.generality) "positive-finite-extension-retains-all-rows" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "emitted-observed-feature-carrier") then "The astronomical carrier is erased." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "redshift-cause-bounded") then "Unbounded observations cannot be compared." else
  if !(SFT.Host.Text.equal (relationName c.relation) "feature-displacement-relation") then "A target or consensus model selects the result." else
  if !(SFT.Host.Text.equal (recordName c.record) "feature-identity-frame-motion-gravity-expansion-and-error-held") then "A favorable answer without source and adverse records is unreconstructible." else
  if !(SFT.Host.Text.equal (evidenceName c.evidence) "evidence-class-explicit") then "Evidence classes silently substitute for one another." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "root-bound-forward-forcing") then "Historical SFT or measurement selects the law." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "positive-finite-extension-retains-all-rows") then "One object cannot close a generated class." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An added choice manufactures the result." else
  "emitted-observed-feature-carrier__redshift-cause-bounded__feature-displacement-relation__feature-identity-frame-motion-gravity-expansion-and-error-held__evidence-class-explicit__root-bound-forward-forcing__positive-finite-extension-retains-all-rows__no-extra-rule"

def generationRule : String := "Generate the literal Cartesian product of eight preregistered binary carrier, boundary, relation, record, evidence, provenance, generality and extension dimensions before external source identities or outcomes are opened; filter only by the registered preservation properties."
def grammarBoundary : String := "Exactly eight binary dimensions: 256 forms. Closure is depth-independent for positive finite extension; empirical correspondence remains source, object, place, epoch, instrument and protocol bounded."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Evidence.rejected,Evidence.admitted]).flatMap fun evidence =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,boundary,relation,record,evidence,provenance,generality,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier boundary relation record evidence provenance generality extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
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
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
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
 | mk carrier boundary relation record evidence provenance generality extension =>
  cases carrier <;> cases boundary <;> cases relation <;> cases record
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

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "emitted-observed-feature-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "redshift-cause-bounded" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "feature-displacement-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "feature-identity-frame-motion-gravity-expansion-and-error-held" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem evidenceCriterion (value : Evidence) : SFT.Host.Text.equal (evidenceName value) "evidence-class-explicit" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "root-bound-forward-forcing" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem generalityCriterion (value : Generality) : SFT.Host.Text.equal (generalityName value) "positive-finite-extension-retains-all-rows" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, boundaryCriterion, relationCriterion, recordCriterion, evidenceCriterion, provenanceCriterion, generalityCriterion, extensionCriterion]
  cases c with
  | mk carrier boundary relation record evidence provenance generality extension =>
    cases carrier <;> cases boundary <;> cases relation <;> cases record <;> cases evidence <;> cases provenance <;> cases generality <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.boundary = .admitted ∧ c.relation = .admitted ∧ c.record = .admitted ∧ c.evidence = .admitted ∧ c.provenance = .admitted ∧ c.generality = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier boundary relation record evidence provenance generality extension =>
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

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
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

end SFT.AstronomyCosmology.AstronomicalRedshiftGrammar
