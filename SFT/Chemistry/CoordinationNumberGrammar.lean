import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CoordinationNumberGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "formula-or-central-name-only"
  | .admitted => "admitted-complete-coordination-entity"

inductive Membership where
  | rejected | admitted

def membershipName : Membership → String
  | .rejected => "nearby-or-selected-ligands"
  | .admitted => "every-distinct-direct-central-incidence"

inductive Quantity where
  | rejected | admitted

def quantityName : Quantity → String
  | .rejected => "imported-coordination-number-table"
  | .admitted => "positive-count-of-generated-incidence-traces"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "repeated-ligand-labels-merged"
  | .admitted => "occurrence-distinct-incidences-counted-once"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-or-negative-vacancy"
  | .admitted => "structural-EmptyOne-outside-positive-support"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "observed-counts-readable-before-seal"
  | .admitted => "complete-23-record-value-free-identity-seal"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "general-crystal-pi-and-sigma-senses-mixed"
  | .admitted => "direct-inorganic-incidence-sense-held"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "next-ligand-recounts-or-replaces-support"
  | .admitted => "next-incidence-preserves-prior-and-adds-one"

structure Candidate where
  carrier : Carrier
  membership : Membership
  quantity : Quantity
  identity : Identity
  absence : Absence
  observation : Observation
  boundary : Boundary
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, membershipName c.membership, quantityName c.quantity, identityName c.identity, absenceName c.absence, observationName c.observation, boundaryName c.boundary, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "membership=" (membershipName c.membership), SFT.Host.Text.append "quantity=" (quantityName c.quantity), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "admitted-complete-coordination-entity__every-distinct-direct-central-incidence__positive-count-of-generated-incidence-traces__occurrence-distinct-incidences-counted-once__structural-EmptyOne-outside-positive-support__complete-23-record-value-free-identity-seal__direct-inorganic-incidence-sense-held__next-incidence-preserves-prior-and-adds-one"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "admitted-complete-coordination-entity" &&
  SFT.Host.Text.equal (membershipName c.membership) "every-distinct-direct-central-incidence" &&
  SFT.Host.Text.equal (quantityName c.quantity) "positive-count-of-generated-incidence-traces" &&
  SFT.Host.Text.equal (identityName c.identity) "occurrence-distinct-incidences-counted-once" &&
  SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-outside-positive-support" &&
  SFT.Host.Text.equal (observationName c.observation) "complete-23-record-value-free-identity-seal" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "direct-inorganic-incidence-sense-held" &&
  SFT.Host.Text.equal (extensionName c.extension) "next-incidence-preserves-prior-and-adds-one"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "admitted-complete-coordination-entity") then "A name does not expose complete incident support." else
  if !(SFT.Host.Text.equal (membershipName c.membership) "every-distinct-direct-central-incidence") then "Proximity or selection does not retain the entity's direct incidence boundary." else
  if !(SFT.Host.Text.equal (quantityName c.quantity) "positive-count-of-generated-incidence-traces") then "A conventional table selects the answer." else
  if !(SFT.Host.Text.equal (identityName c.identity) "occurrence-distinct-incidences-counted-once") then "Merging equal group labels undercounts distinct occurrences." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-outside-positive-support") then "Numerical zero and signed vacancy are forbidden proof forms." else
  if !(SFT.Host.Text.equal (observationName c.observation) "complete-23-record-value-free-identity-seal") then "Observed 3, 4 or 5 could select a counting rule." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "direct-inorganic-incidence-sense-held") then "Mixing distinct source senses makes the count ambiguous." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "next-incidence-preserves-prior-and-adds-one") then "Replacement does not preserve the prior count proof." else
  "admitted-complete-coordination-entity__every-distinct-direct-central-incidence__positive-count-of-generated-incidence-traces__occurrence-distinct-incidences-counted-once__structural-EmptyOne-outside-positive-support__complete-23-record-value-free-identity-seal__direct-inorganic-incidence-sense-held__next-incidence-preserves-prior-and-adds-one"

def generationRule : String := "Generate the literal product of carrier, membership, quantity, identity, absence, observation, boundary and extension forms. Decide all 256 forms solely from admitted complete coordination identity, exact finite incidence and source-boundary laws."
def grammarBoundary : String := "Every admitted positive finite single-central coordination entity and its complete distinct direct-incidence support, tested after seal against all twenty-three registered IUPAC and NIST definition, structure, count and limitation records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Membership.rejected,Membership.admitted]).flatMap fun membership =>
  ([Quantity.rejected,Quantity.admitted]).flatMap fun quantity =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,membership,quantity,identity,absence,observation,boundary,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier membership quantity identity absence observation boundary extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmembership : membership ∈ [Membership.rejected,Membership.admitted] := by
      cases membership <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantity : quantity ∈ [Quantity.rejected,Quantity.admitted] := by
      cases quantity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ membership _ hmembership
    apply CommonRefinement.memFlatMap _ _ quantity _ hquantity
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (absence : Absence) (observation : Observation) (boundary : Boundary) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,absence,observation,boundary,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,absence,observation,boundary,extension⟩ := by
 cases absence <;> cases observation <;> cases boundary <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier membership quantity identity absence observation boundary extension =>
  cases carrier <;> cases membership <;> cases quantity <;> cases identity
  · exact sourceDecisionBlock0000 absence observation boundary extension
  · exact sourceDecisionBlock0001 absence observation boundary extension
  · exact sourceDecisionBlock0010 absence observation boundary extension
  · exact sourceDecisionBlock0011 absence observation boundary extension
  · exact sourceDecisionBlock0100 absence observation boundary extension
  · exact sourceDecisionBlock0101 absence observation boundary extension
  · exact sourceDecisionBlock0110 absence observation boundary extension
  · exact sourceDecisionBlock0111 absence observation boundary extension
  · exact sourceDecisionBlock1000 absence observation boundary extension
  · exact sourceDecisionBlock1001 absence observation boundary extension
  · exact sourceDecisionBlock1010 absence observation boundary extension
  · exact sourceDecisionBlock1011 absence observation boundary extension
  · exact sourceDecisionBlock1100 absence observation boundary extension
  · exact sourceDecisionBlock1101 absence observation boundary extension
  · exact sourceDecisionBlock1110 absence observation boundary extension
  · exact sourceDecisionBlock1111 absence observation boundary extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "admitted-complete-coordination-entity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem membershipCriterion (value : Membership) : SFT.Host.Text.equal (membershipName value) "every-distinct-direct-central-incidence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem quantityCriterion (value : Quantity) : SFT.Host.Text.equal (quantityName value) "positive-count-of-generated-incidence-traces" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "occurrence-distinct-incidences-counted-once" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "structural-EmptyOne-outside-positive-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "complete-23-record-value-free-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "direct-inorganic-incidence-sense-held" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "next-incidence-preserves-prior-and-adds-one" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, membershipCriterion, quantityCriterion, identityCriterion, absenceCriterion, observationCriterion, boundaryCriterion, extensionCriterion]
  cases c with
  | mk carrier membership quantity identity absence observation boundary extension =>
    cases carrier <;> cases membership <;> cases quantity <;> cases identity <;> cases absence <;> cases observation <;> cases boundary <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.membership = .admitted ∧ c.quantity = .admitted ∧ c.identity = .admitted ∧ c.absence = .admitted ∧ c.observation = .admitted ∧ c.boundary = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier membership quantity identity absence observation boundary extension =>
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

theorem membership_rejected_rejected (c : Candidate) (h : c.membership = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.membership eq
    rw [h] at field
    cases field

theorem quantity_rejected_rejected (c : Candidate) (h : c.quantity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.quantity eq
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

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
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

end SFT.Chemistry.CoordinationNumberGrammar
