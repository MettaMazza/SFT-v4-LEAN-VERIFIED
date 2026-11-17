import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Biology.InsideOutsideGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "carrier-erased-or-answer-only"
  | .admitted => "oriented-boundary-carrier"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "relation-imported-fitted-or-erased"
  | .admitted => "opposed-side-label-relation"

inductive Organization where
  | rejected | admitted

def organizationName : Organization → String
  | .rejected => "organization-collapsed"
  | .admitted => "two-sides-never-merged"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "observation-boundary-unrecorded"
  | .admitted => "observer-orientation-declared"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "result-without-transition-record"
  | .admitted => "complete-state-transition-control-record"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "authority-target-or-prior-selected-law"
  | .admitted => "root-bound-forward-forcing"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "single-specimen-favorable-instance"
  | .admitted => "positive-finite-successor-and-adverse-closure"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-fit-exception-or-extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  relation : Relation
  organization : Organization
  observation : Observation
  record : Record
  provenance : Provenance
  generality : Generality
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, relationName c.relation, organizationName c.organization, observationName c.observation, recordName c.record, provenanceName c.provenance, generalityName c.generality, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "organization=" (organizationName c.organization), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "oriented-boundary-carrier__opposed-side-label-relation__two-sides-never-merged__observer-orientation-declared__complete-state-transition-control-record__root-bound-forward-forcing__positive-finite-successor-and-adverse-closure__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "oriented-boundary-carrier" &&
  SFT.Host.Text.equal (relationName c.relation) "opposed-side-label-relation" &&
  SFT.Host.Text.equal (organizationName c.organization) "two-sides-never-merged" &&
  SFT.Host.Text.equal (observationName c.observation) "observer-orientation-declared" &&
  SFT.Host.Text.equal (recordName c.record) "complete-state-transition-control-record" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "root-bound-forward-forcing" &&
  SFT.Host.Text.equal (generalityName c.generality) "positive-finite-successor-and-adverse-closure" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "oriented-boundary-carrier") then "Erasing the biological carrier prevents reconstruction of the claimed living distinction." else
  if !(SFT.Host.Text.equal (relationName c.relation) "opposed-side-label-relation") then "An imported, fitted or absent relation can select a familiar biological answer without forcing it." else
  if !(SFT.Host.Text.equal (organizationName c.organization) "two-sides-never-merged") then "Collapsing organization merges living states the question requires to remain distinct." else
  if !(SFT.Host.Text.equal (observationName c.observation) "observer-orientation-declared") then "An unrecorded organism, condition, assay, scale or interval cannot identify the biological observation class." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-state-transition-control-record") then "A biological label without initial state, transitions, controls and outcomes is not auditable." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "root-bound-forward-forcing") then "Authority, consensus, a prior SFT answer or target data may test but cannot select a Fold law." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "positive-finite-successor-and-adverse-closure") then "One favorable organism, specimen or experiment cannot close the generated biological class." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A free coefficient, fitted threshold, exception or opaque predictor can manufacture a desired answer." else
  "oriented-boundary-carrier__opposed-side-label-relation__two-sides-never-merged__observer-orientation-declared__complete-state-transition-control-record__root-bound-forward-forcing__positive-finite-successor-and-adverse-closure__no-extra-rule"

def generationRule : String := "Generate the Cartesian product of every registered binary preservation dimension; do not inspect external targets or prior answers."
def grammarBoundary : String := "Exactly eight binary dimensions and therefore 256 forms; the statement is conditional only on this explicit complete grammar."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Organization.rejected,Organization.admitted]).flatMap fun organization =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,relation,organization,observation,record,provenance,generality,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier relation organization observation record provenance generality extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horganization : organization ∈ [Organization.rejected,Organization.admitted] := by
      cases organization <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ organization _ horganization
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,record,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,record,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,record,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,record,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,record,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,record,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,record,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,record,provenance,generality,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,record,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,record,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,record,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,record,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,record,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,record,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,record,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (record : Record) (provenance : Provenance) (generality : Generality) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,record,provenance,generality,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,record,provenance,generality,extension⟩ := by
 cases record <;> cases provenance <;> cases generality <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier relation organization observation record provenance generality extension =>
  cases carrier <;> cases relation <;> cases organization <;> cases observation
  · exact sourceDecisionBlock0000 record provenance generality extension
  · exact sourceDecisionBlock0001 record provenance generality extension
  · exact sourceDecisionBlock0010 record provenance generality extension
  · exact sourceDecisionBlock0011 record provenance generality extension
  · exact sourceDecisionBlock0100 record provenance generality extension
  · exact sourceDecisionBlock0101 record provenance generality extension
  · exact sourceDecisionBlock0110 record provenance generality extension
  · exact sourceDecisionBlock0111 record provenance generality extension
  · exact sourceDecisionBlock1000 record provenance generality extension
  · exact sourceDecisionBlock1001 record provenance generality extension
  · exact sourceDecisionBlock1010 record provenance generality extension
  · exact sourceDecisionBlock1011 record provenance generality extension
  · exact sourceDecisionBlock1100 record provenance generality extension
  · exact sourceDecisionBlock1101 record provenance generality extension
  · exact sourceDecisionBlock1110 record provenance generality extension
  · exact sourceDecisionBlock1111 record provenance generality extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "oriented-boundary-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem relationCriterion (value : Relation) : SFT.Host.Text.equal (relationName value) "opposed-side-label-relation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem organizationCriterion (value : Organization) : SFT.Host.Text.equal (organizationName value) "two-sides-never-merged" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "observer-orientation-declared" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-state-transition-control-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem provenanceCriterion (value : Provenance) : SFT.Host.Text.equal (provenanceName value) "root-bound-forward-forcing" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem generalityCriterion (value : Generality) : SFT.Host.Text.equal (generalityName value) "positive-finite-successor-and-adverse-closure" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, relationCriterion, organizationCriterion, observationCriterion, recordCriterion, provenanceCriterion, generalityCriterion, extensionCriterion]
  cases c with
  | mk carrier relation organization observation record provenance generality extension =>
    cases carrier <;> cases relation <;> cases organization <;> cases observation <;> cases record <;> cases provenance <;> cases generality <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.relation = .admitted ∧ c.organization = .admitted ∧ c.observation = .admitted ∧ c.record = .admitted ∧ c.provenance = .admitted ∧ c.generality = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier relation organization observation record provenance generality extension =>
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

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem organization_rejected_rejected (c : Candidate) (h : c.organization = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.organization eq
    rw [h] at field
    cases field

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
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

end SFT.Biology.InsideOutsideGrammar
