import SFT.Materials.Lattice
import SFT.Materials.RotationClosure
import SFT.Host.Text
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Materials.RotationGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "carrier-erased-or-answer-only"
  | .admitted => "integer-lattice-action-carrier"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "relation-imported-fitted-or-erased"
  | .admitted => "finite-order-rotation-relation"

inductive Organization where
  | rejected | admitted

def organizationName : Organization → String
  | .rejected => "organization-collapsed"
  | .admitted => "translation-compatibility-retained"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "observation-boundary-unrecorded"
  | .admitted => "orders-one-two-three-four-six"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "result-without-state-transition-record"
  | .admitted => "complete-state-transition-boundary-trace"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "authority-or-target-selected-law"
  | .admitted => "root-bound-forward-forcing"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "single-specimen-or-instance-lookup"
  | .admitted => "positive-finite-successor-closure"

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
def survivorId : String := "integer-lattice-action-carrier__finite-order-rotation-relation__translation-compatibility-retained__orders-one-two-three-four-six__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "integer-lattice-action-carrier" &&
  SFT.Host.Text.equal (relationName c.relation) "finite-order-rotation-relation" &&
  SFT.Host.Text.equal (organizationName c.organization) "translation-compatibility-retained" &&
  SFT.Host.Text.equal (observationName c.observation) "orders-one-two-three-four-six" &&
  SFT.Host.Text.equal (recordName c.record) "complete-state-transition-boundary-trace" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "root-bound-forward-forcing" &&
  SFT.Host.Text.equal (generalityName c.generality) "positive-finite-successor-closure" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "integer-lattice-action-carrier") then "Erasing the material carrier prevents reconstruction of the observed distinction." else
  if !(SFT.Host.Text.equal (relationName c.relation) "finite-order-rotation-relation") then "An imported, fitted or absent relation can select a familiar answer without forcing it." else
  if !(SFT.Host.Text.equal (organizationName c.organization) "translation-compatibility-retained") then "Collapsing organization merges materials states that the question requires to remain distinct." else
  if !(SFT.Host.Text.equal (observationName c.observation) "orders-one-two-three-four-six") then "An unrecorded method, scale or condition cannot identify the Materials observation class." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-state-transition-boundary-trace") then "A result label without its state, transition and boundary trace is not auditable." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "root-bound-forward-forcing") then "Authority, consensus, a handbook or target data may test but cannot select a Fold law." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "positive-finite-successor-closure") then "One favorable specimen or instance does not close the generated class." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A free coefficient, fit, exception or added constitutive law can force a desired answer." else
  "integer-lattice-action-carrier__finite-order-rotation-relation__translation-compatibility-retained__orders-one-two-three-four-six__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"

def generationRule : String := "Generate the literal Cartesian product of the registered content-specific carrier, relation, organization and observation choices with record, provenance, generality and extension choices."
def grammarBoundary : String := "Every positive finite generated Materials carrier in the registered crystal_quasicrystal grammar that preserves integer-lattice-action-carrier, finite-order-rotation-relation, translation-compatibility-retained and orders-one-two-three-four-six."

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

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier relation organization observation record provenance generality extension =>
    cases carrier <;> cases relation <;> cases organization <;> cases observation <;> cases record <;> cases provenance <;> cases generality <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
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

end SFT.Materials.RotationGrammar
