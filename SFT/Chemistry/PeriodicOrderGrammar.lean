import SFT.Chemistry.PeriodicOrderTrace
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PeriodicOrderGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "names-without-element-records"
  | .admitted => "complete-element-class-support"

inductive Coordinate where
  | rejected | admitted

def coordinateName : Coordinate → String
  | .rejected => "layout-selected-coordinate"
  | .admitted => "atomic-number-coordinate"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "unordered-element-set"
  | .admitted => "positive-count-total-order"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "order-erases-isotopes"
  | .admitted => "element-identity-retained"

inductive Succession where
  | rejected | admitted

def successionName : Succession → String
  | .rejected => "free-table-rearrangement"
  | .admitted => "one-proton-successor"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "known-table-as-proof-premise"
  | .admitted => "post-seal-known-table-correspondence"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "atomic-number-only-list"
  | .admitted => "number-element-source-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-order-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  coordinate : Coordinate
  order : Order
  identity : Identity
  succession : Succession
  observation : Observation
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, coordinateName c.coordinate, orderName c.order, identityName c.identity, successionName c.succession, observationName c.observation, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "coordinate=" (coordinateName c.coordinate), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "succession=" (successionName c.succession), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-element-class-support__atomic-number-coordinate__positive-count-total-order__element-identity-retained__one-proton-successor__post-seal-known-table-correspondence__number-element-source-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-element-class-support" &&
  SFT.Host.Text.equal (coordinateName c.coordinate) "atomic-number-coordinate" &&
  SFT.Host.Text.equal (orderName c.order) "positive-count-total-order" &&
  SFT.Host.Text.equal (identityName c.identity) "element-identity-retained" &&
  SFT.Host.Text.equal (successionName c.succession) "one-proton-successor" &&
  SFT.Host.Text.equal (observationName c.observation) "post-seal-known-table-correspondence" &&
  SFT.Host.Text.equal (recordName c.record) "number-element-source-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-element-class-support") then "Names alone do not preserve the generated element classes." else
  if !(SFT.Host.Text.equal (coordinateName c.coordinate) "atomic-number-coordinate") then "A drawn location can be changed without changing nuclear identity." else
  if !(SFT.Host.Text.equal (orderName c.order) "positive-count-total-order") then "An unordered set cannot express successor structure." else
  if !(SFT.Host.Text.equal (identityName c.identity) "element-identity-retained") then "Ordering must not discard refinements of an element record." else
  if !(SFT.Host.Text.equal (successionName c.succession) "one-proton-successor") then "A discretionary rearrangement can select any pattern." else
  if !(SFT.Host.Text.equal (observationName c.observation) "post-seal-known-table-correspondence") then "The observed table cannot create the order law." else
  if !(SFT.Host.Text.equal (recordName c.record) "number-element-source-trace") then "A number list loses symbols, identities and source boundary." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception can silently permute successors." else
  "complete-element-class-support__atomic-number-coordinate__positive-count-total-order__element-identity-retained"

def generationRule : String := "Generate the literal product of the registered periodic-order carrier, coordinate, order, identity, succession, observation, record and extension choices."
def grammarBoundary : String := "Every positive-finite chemical-element class carrying its admitted atomic-number identity, ordered only by generated proton-count succession and retaining the complete element record at each coordinate."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Coordinate.rejected,Coordinate.admitted]).flatMap fun coordinate =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Succession.rejected,Succession.admitted]).flatMap fun succession =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,coordinate,order,identity,succession,observation,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier coordinate order identity succession observation record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoordinate : coordinate ∈ [Coordinate.rejected,Coordinate.admitted] := by
      cases coordinate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccession : succession ∈ [Succession.rejected,Succession.admitted] := by
      cases succession <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ coordinate _ hcoordinate
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ succession _ hsuccession
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier coordinate order identity succession observation record extension =>
    cases carrier <;> cases coordinate <;> cases order <;> cases identity <;> cases succession <;> cases observation <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier coordinate order identity succession observation record extension =>
    cases carrier <;> cases coordinate <;> cases order <;> cases identity <;> cases succession <;> cases observation <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.coordinate = .admitted ∧ c.order = .admitted ∧ c.identity = .admitted ∧ c.succession = .admitted ∧ c.observation = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier coordinate order identity succession observation record extension =>
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

theorem coordinate_rejected_rejected (c : Candidate) (h : c.coordinate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coordinate eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
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

theorem succession_rejected_rejected (c : Candidate) (h : c.succession = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.succession eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.PeriodicOrderGrammar
