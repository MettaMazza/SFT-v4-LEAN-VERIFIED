import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ConservationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "product-list-without-input"
  | .admitted => "complete-reaction-word"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-stoichiometric-scalars"
  | .admitted => "held-reactant-product-sides"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "mass-only-balance"
  | .admitted => "elemental-identities-retained"

inductive Count where
  | rejected | admitted

def countName : Count → String
  | .rejected => "approximate-decimal-balance"
  | .admitted => "exact-positive-multiplicity"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "selected-elements-only"
  | .admitted => "all-element-totals-paired"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "unrecorded-open-system"
  | .admitted => "named-boundary-carriers"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "balanced-label-only"
  | .admitted => "species-formula-total-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-balancing-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  orientation : Orientation
  identity : Identity
  count : Count
  closure : Closure
  boundary : Boundary
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, orientationName c.orientation, identityName c.identity, countName c.count, closureName c.closure, boundaryName c.boundary, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "count=" (countName c.count), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-reaction-word__held-reactant-product-sides__elemental-identities-retained__exact-positive-multiplicity__all-element-totals-paired__named-boundary-carriers__species-formula-total-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-reaction-word" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-reactant-product-sides" &&
  SFT.Host.Text.equal (identityName c.identity) "elemental-identities-retained" &&
  SFT.Host.Text.equal (countName c.count) "exact-positive-multiplicity" &&
  SFT.Host.Text.equal (closureName c.closure) "all-element-totals-paired" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "named-boundary-carriers" &&
  SFT.Host.Text.equal (recordName c.record) "species-formula-total-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-reaction-word") then "Products alone cannot demonstrate conservation." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-reactant-product-sides") then "Signed proof quantities violate the positive domain." else
  if !(SFT.Host.Text.equal (identityName c.identity) "elemental-identities-retained") then "Equal bulk mass can hide changed element labels." else
  if !(SFT.Host.Text.equal (countName c.count) "exact-positive-multiplicity") then "Approximation cannot prove equality of discrete carriers." else
  if !(SFT.Host.Text.equal (closureName c.closure) "all-element-totals-paired") then "Omitting an element can manufacture balance." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "named-boundary-carriers") then "Unrecorded boundary transfer can mimic loss or creation." else
  if !(SFT.Host.Text.equal (recordName c.record) "species-formula-total-trace") then "A label cannot reconstruct the equality." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception could excuse an unpaired carrier." else
  "complete-reaction-word__held-reactant-product-sides__elemental-identities-retained__all-element-totals-paired"

def generationRule : String := "Generate the literal product of the registered conservation carrier, orientation, identity, count, closure, boundary, record and extension choices."
def grammarBoundary : String := "Every finite chemical transition word whose reactant and product sides retain complete species formulae, positive multiplicities and equal per-element totals."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Count.rejected,Count.admitted]).flatMap fun count =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,orientation,identity,count,closure,boundary,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier orientation identity count closure boundary record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcount : count ∈ [Count.rejected,Count.admitted] := by
      cases count <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ count _ hcount
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier orientation identity count closure boundary record extension =>
    cases carrier <;> cases orientation <;> cases identity <;> cases count <;> cases closure <;> cases boundary <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier orientation identity count closure boundary record extension =>
    cases carrier <;> cases orientation <;> cases identity <;> cases count <;> cases closure <;> cases boundary <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.orientation = .admitted ∧ c.identity = .admitted ∧ c.count = .admitted ∧ c.closure = .admitted ∧ c.boundary = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier orientation identity count closure boundary record extension =>
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

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

theorem count_rejected_rejected (c : Candidate) (h : c.count = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.count eq
    rw [h] at field
    cases field

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
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

end SFT.Chemistry.ConservationGrammar
