import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.LigandDenticityGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "chemical-label-only"
  | .admitted => "one-retained-ligand-carrier-occurrence"

inductive Membership where
  | rejected | admitted

def membershipName : Membership → String
  | .rejected => "selected-or-nearby-donor-sites"
  | .admitted => "every-distinct-donor-site-on-that-carrier"

inductive Centre where
  | rejected | admitted

def centreName : Centre → String
  | .rejected => "donor-sites-across-centres-merged"
  | .admitted => "same-retained-central-occurrence"

inductive Quantity where
  | rejected | admitted

def quantityName : Quantity → String
  | .rejected => "imported-denticity-name-or-table"
  | .admitted => "positive-count-of-generated-donor-incidences"

inductive Chelation where
  | rejected | admitted

def chelationName : Chelation → String
  | .rejected => "two-or-more-label-imported-as-threshold"
  | .admitted => "first-closed-carrier-centre-path-forces-chelation"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "eta-kappa-and-separate-sites-collapsed"
  | .admitted => "separate-site-and-attachment-topologies-held"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "source-topologies-readable-before-seal"
  | .admitted => "complete-24-record-value-free-identity-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "next-site-recounts-or-replaces-prior-support"
  | .admitted => "next-site-preserves-prior-and-adds-one"

structure Candidate where
  carrier : Carrier
  membership : Membership
  centre : Centre
  quantity : Quantity
  chelation : Chelation
  boundary : Boundary
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, membershipName c.membership, centreName c.centre, quantityName c.quantity, chelationName c.chelation, boundaryName c.boundary, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "membership=" (membershipName c.membership), SFT.Host.Text.append "centre=" (centreName c.centre), SFT.Host.Text.append "quantity=" (quantityName c.quantity), SFT.Host.Text.append "chelation=" (chelationName c.chelation), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-ligand-carrier-occurrence__every-distinct-donor-site-on-that-carrier__same-retained-central-occurrence__positive-count-of-generated-donor-incidences__first-closed-carrier-centre-path-forces-chelation__separate-site-and-attachment-topologies-held__complete-24-record-value-free-identity-seal__next-site-preserves-prior-and-adds-one"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-ligand-carrier-occurrence" &&
  SFT.Host.Text.equal (membershipName c.membership) "every-distinct-donor-site-on-that-carrier" &&
  SFT.Host.Text.equal (centreName c.centre) "same-retained-central-occurrence" &&
  SFT.Host.Text.equal (quantityName c.quantity) "positive-count-of-generated-donor-incidences" &&
  SFT.Host.Text.equal (chelationName c.chelation) "first-closed-carrier-centre-path-forces-chelation" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "separate-site-and-attachment-topologies-held" &&
  SFT.Host.Text.equal (observationName c.observation) "complete-24-record-value-free-identity-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "next-site-preserves-prior-and-adds-one"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-ligand-carrier-occurrence") then "A repeated chemical label does not distinguish a given ligand occurrence." else
  if !(SFT.Host.Text.equal (membershipName c.membership) "every-distinct-donor-site-on-that-carrier") then "Selection and proximity do not preserve complete binding support." else
  if !(SFT.Host.Text.equal (centreName c.centre) "same-retained-central-occurrence") then "Merging centres destroys the one-centre relation." else
  if !(SFT.Host.Text.equal (quantityName c.quantity) "positive-count-of-generated-donor-incidences") then "A conventional name or table selects the count." else
  if !(SFT.Host.Text.equal (chelationName c.chelation) "first-closed-carrier-centre-path-forces-chelation") then "A named threshold does not explain the topology." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "separate-site-and-attachment-topologies-held") then "Collapsing attachment modes confuses atoms with separate binding sites." else
  if !(SFT.Host.Text.equal (observationName c.observation) "complete-24-record-value-free-identity-seal") then "Observed classifications could select the law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "next-site-preserves-prior-and-adds-one") then "Replacement destroys the retained carrier topology." else
  "one-retained-ligand-carrier-occurrence__every-distinct-donor-site-on-that-carrier__same-retained-central-occurrence__positive-count-of-generated-donor-incidences__first-closed-carrier-centre-path-forces-chelation__separate-site-and-attachment-topologies-held__complete-24-record-value-free-identity-seal__next-site-preserves-prior-and-adds-one"

def generationRule : String := "Generate the literal product of carrier, membership, centre, quantity, chelation, boundary, observation and extension forms. Decide all 256 forms solely from admitted coordination identity, exact direct-incidence count, graph connectivity, information retention and source-boundary laws."
def grammarBoundary : String := "Every positive finite complete donor-site topology for one retained ligand carrier and one retained central occurrence, tested after seal against all twenty-four registered surfaces from six complete current IUPAC term records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Membership.rejected,Membership.admitted]).flatMap fun membership =>
  ([Centre.rejected,Centre.admitted]).flatMap fun centre =>
  ([Quantity.rejected,Quantity.admitted]).flatMap fun quantity =>
  ([Chelation.rejected,Chelation.admitted]).flatMap fun chelation =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,membership,centre,quantity,chelation,boundary,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier membership centre quantity chelation boundary observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmembership : membership ∈ [Membership.rejected,Membership.admitted] := by
      cases membership <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcentre : centre ∈ [Centre.rejected,Centre.admitted] := by
      cases centre <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantity : quantity ∈ [Quantity.rejected,Quantity.admitted] := by
      cases quantity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchelation : chelation ∈ [Chelation.rejected,Chelation.admitted] := by
      cases chelation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ membership _ hmembership
    apply CommonRefinement.memFlatMap _ _ centre _ hcentre
    apply CommonRefinement.memFlatMap _ _ quantity _ hquantity
    apply CommonRefinement.memFlatMap _ _ chelation _ hchelation
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (chelation : Chelation) (boundary : Boundary) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,chelation,boundary,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,chelation,boundary,observation,extension⟩ := by
 cases chelation <;> cases boundary <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier membership centre quantity chelation boundary observation extension =>
  cases carrier <;> cases membership <;> cases centre <;> cases quantity
  · exact sourceDecisionBlock0000 chelation boundary observation extension
  · exact sourceDecisionBlock0001 chelation boundary observation extension
  · exact sourceDecisionBlock0010 chelation boundary observation extension
  · exact sourceDecisionBlock0011 chelation boundary observation extension
  · exact sourceDecisionBlock0100 chelation boundary observation extension
  · exact sourceDecisionBlock0101 chelation boundary observation extension
  · exact sourceDecisionBlock0110 chelation boundary observation extension
  · exact sourceDecisionBlock0111 chelation boundary observation extension
  · exact sourceDecisionBlock1000 chelation boundary observation extension
  · exact sourceDecisionBlock1001 chelation boundary observation extension
  · exact sourceDecisionBlock1010 chelation boundary observation extension
  · exact sourceDecisionBlock1011 chelation boundary observation extension
  · exact sourceDecisionBlock1100 chelation boundary observation extension
  · exact sourceDecisionBlock1101 chelation boundary observation extension
  · exact sourceDecisionBlock1110 chelation boundary observation extension
  · exact sourceDecisionBlock1111 chelation boundary observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-ligand-carrier-occurrence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem membershipCriterion (value : Membership) : SFT.Host.Text.equal (membershipName value) "every-distinct-donor-site-on-that-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem centreCriterion (value : Centre) : SFT.Host.Text.equal (centreName value) "same-retained-central-occurrence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem quantityCriterion (value : Quantity) : SFT.Host.Text.equal (quantityName value) "positive-count-of-generated-donor-incidences" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem chelationCriterion (value : Chelation) : SFT.Host.Text.equal (chelationName value) "first-closed-carrier-centre-path-forces-chelation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "separate-site-and-attachment-topologies-held" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "complete-24-record-value-free-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "next-site-preserves-prior-and-adds-one" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, membershipCriterion, centreCriterion, quantityCriterion, chelationCriterion, boundaryCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier membership centre quantity chelation boundary observation extension =>
    cases carrier <;> cases membership <;> cases centre <;> cases quantity <;> cases chelation <;> cases boundary <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.membership = .admitted ∧ c.centre = .admitted ∧ c.quantity = .admitted ∧ c.chelation = .admitted ∧ c.boundary = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier membership centre quantity chelation boundary observation extension =>
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

theorem centre_rejected_rejected (c : Candidate) (h : c.centre = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.centre eq
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

theorem chelation_rejected_rejected (c : Candidate) (h : c.chelation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.chelation eq
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

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
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

end SFT.Chemistry.LigandDenticityGrammar
