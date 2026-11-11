import SFT.Chemistry.ElementIdentity
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ElementGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "substance-name-only"
  | .admitted => "atom-species-carrier"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "mass-selected-identity"
  | .admitted => "common-proton-count"

inductive Location where
  | rejected | admitted

def locationName : Location → String
  | .rejected => "protons-without-nuclear-carrier"
  | .admitted => "nuclear-identity"

inductive Membership where
  | rejected | admitted

def membershipName : Membership → String
  | .rejected => "sampled-atom-list"
  | .admitted => "all-generated-atoms-with-identity"

inductive Isotope where
  | rejected | admitted

def isotopeName : Isotope → String
  | .rejected => "one-mass-number-only"
  | .admitted => "mass-refinement-permitted"

inductive Substance where
  | rejected | admitted

def substanceName : Substance → String
  | .rejected => "species-substance-conflation"
  | .admitted => "substance-carrier-correspondence"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "element-label-only"
  | .admitted => "complete-nuclear-membership-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-element-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  identity : Identity
  location : Location
  membership : Membership
  isotope : Isotope
  substance : Substance
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, identityName c.identity, locationName c.location, membershipName c.membership, isotopeName c.isotope, substanceName c.substance, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "location=" (locationName c.location), SFT.Host.Text.append "membership=" (membershipName c.membership), SFT.Host.Text.append "isotope=" (isotopeName c.isotope), SFT.Host.Text.append "substance=" (substanceName c.substance), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "atom-species-carrier__common-proton-count__nuclear-identity__all-generated-atoms-with-identity__mass-refinement-permitted__substance-carrier-correspondence__complete-nuclear-membership-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "atom-species-carrier" &&
  SFT.Host.Text.equal (identityName c.identity) "common-proton-count" &&
  SFT.Host.Text.equal (locationName c.location) "nuclear-identity" &&
  SFT.Host.Text.equal (membershipName c.membership) "all-generated-atoms-with-identity" &&
  SFT.Host.Text.equal (isotopeName c.isotope) "mass-refinement-permitted" &&
  SFT.Host.Text.equal (substanceName c.substance) "substance-carrier-correspondence" &&
  SFT.Host.Text.equal (recordName c.record) "complete-nuclear-membership-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "atom-species-carrier") then "A substance name does not define the atom class." else
  if !(SFT.Host.Text.equal (identityName c.identity) "common-proton-count") then "Mass can vary between isotopes of one element." else
  if !(SFT.Host.Text.equal (locationName c.location) "nuclear-identity") then "An unlocated count does not preserve atomic constitution." else
  if !(SFT.Host.Text.equal (membershipName c.membership) "all-generated-atoms-with-identity") then "A sample cannot close the complete generated class." else
  if !(SFT.Host.Text.equal (isotopeName c.isotope) "mass-refinement-permitted") then "Restricting an element to one mass number erases its isotopes." else
  if !(SFT.Host.Text.equal (substanceName c.substance) "substance-carrier-correspondence") then "An atom species and a pure substance are related but not identical carriers." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-nuclear-membership-trace") then "A label alone cannot reproduce class membership." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A discretionary exception can split or merge element classes." else
  "atom-species-carrier__common-proton-count__nuclear-identity__substance-carrier-correspondence"

def generationRule : String := "Generate the literal product of the registered element carrier, identity, location, membership, isotope, substance, record and extension choices."
def grammarBoundary : String := "Every positive-finite atom-species class generated from one held nuclear proton-count identity, including all mass-number refinements and its separately recorded pure-substance correspondence."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Location.rejected,Location.admitted]).flatMap fun location =>
  ([Membership.rejected,Membership.admitted]).flatMap fun membership =>
  ([Isotope.rejected,Isotope.admitted]).flatMap fun isotope =>
  ([Substance.rejected,Substance.admitted]).flatMap fun substance =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,identity,location,membership,isotope,substance,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier identity location membership isotope substance record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlocation : location ∈ [Location.rejected,Location.admitted] := by
      cases location <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmembership : membership ∈ [Membership.rejected,Membership.admitted] := by
      cases membership <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hisotope : isotope ∈ [Isotope.rejected,Isotope.admitted] := by
      cases isotope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsubstance : substance ∈ [Substance.rejected,Substance.admitted] := by
      cases substance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ location _ hlocation
    apply CommonRefinement.memFlatMap _ _ membership _ hmembership
    apply CommonRefinement.memFlatMap _ _ isotope _ hisotope
    apply CommonRefinement.memFlatMap _ _ substance _ hsubstance
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier identity location membership isotope substance record extension =>
    cases carrier <;> cases identity <;> cases location <;> cases membership <;> cases isotope <;> cases substance <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier identity location membership isotope substance record extension =>
    cases carrier <;> cases identity <;> cases location <;> cases membership <;> cases isotope <;> cases substance <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.identity = .admitted ∧ c.location = .admitted ∧ c.membership = .admitted ∧ c.isotope = .admitted ∧ c.substance = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier identity location membership isotope substance record extension =>
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem location_rejected_rejected (c : Candidate) (h : c.location = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.location eq
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

theorem isotope_rejected_rejected (c : Candidate) (h : c.isotope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.isotope eq
    rw [h] at field
    cases field

theorem substance_rejected_rejected (c : Candidate) (h : c.substance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.substance eq
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

end SFT.Chemistry.ElementGrammar
