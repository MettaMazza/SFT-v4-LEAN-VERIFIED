import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PolymerChainGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unconnected-monomer-mixture"
  | .admitted => "connected-macromolecular-carrier"

inductive Repeat where
  | rejected | admitted

def repeatName : Repeat → String
  | .rejected => "anonymous-segments"
  | .admitted => "repeated-low-mass-unit-identity"

inductive Connection where
  | rejected | admitted

def connectionName : Connection → String
  | .rejected => "noncovalent-coincidence"
  | .admitted => "covalent-sequence-connections"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "occurrence-order-erased"
  | .admitted => "ordered-chain-incidence"

inductive Extent where
  | rejected | admitted

def extentName : Extent → String
  | .rejected => "fixed-universal-length"
  | .admitted => "positive-finite-repeat-count"

inductive Ends where
  | rejected | admitted

def endsName : Ends → String
  | .rejected => "infinite-chain-assumed"
  | .admitted => "chain-end-boundary-retained"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "polymer-name-only"
  | .admitted => "repeat-connection-end-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-polymer-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  repeatUnit : Repeat
  connection : Connection
  order : Order
  extent : Extent
  ends : Ends
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, repeatName c.repeatUnit, connectionName c.connection, orderName c.order, extentName c.extent, endsName c.ends, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "repeat=" (repeatName c.repeatUnit), SFT.Host.Text.append "connection=" (connectionName c.connection), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "extent=" (extentName c.extent), SFT.Host.Text.append "ends=" (endsName c.ends), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "connected-macromolecular-carrier__repeated-low-mass-unit-identity__covalent-sequence-connections__ordered-chain-incidence__positive-finite-repeat-count__chain-end-boundary-retained__repeat-connection-end-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "connected-macromolecular-carrier" &&
  SFT.Host.Text.equal (repeatName c.repeatUnit) "repeated-low-mass-unit-identity" &&
  SFT.Host.Text.equal (connectionName c.connection) "covalent-sequence-connections" &&
  SFT.Host.Text.equal (orderName c.order) "ordered-chain-incidence" &&
  SFT.Host.Text.equal (extentName c.extent) "positive-finite-repeat-count" &&
  SFT.Host.Text.equal (endsName c.ends) "chain-end-boundary-retained" &&
  SFT.Host.Text.equal (recordName c.record) "repeat-connection-end-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "connected-macromolecular-carrier") then "No chain exists." else
  if !(SFT.Host.Text.equal (repeatName c.repeatUnit) "repeated-low-mass-unit-identity") then "Repeat identity is lost." else
  if !(SFT.Host.Text.equal (connectionName c.connection) "covalent-sequence-connections") then "The sequence is not a polymer chain." else
  if !(SFT.Host.Text.equal (orderName c.order) "ordered-chain-incidence") then "Chain topology is lost." else
  if !(SFT.Host.Text.equal (extentName c.extent) "positive-finite-repeat-count") then "Length is population- and synthesis-bound." else
  if !(SFT.Host.Text.equal (endsName c.ends) "chain-end-boundary-retained") then "A finite carrier needs a boundary." else
  if !(SFT.Host.Text.equal (recordName c.record) "repeat-connection-end-trace") then "The chain cannot be reconstructed." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A threshold can arbitrarily select chains." else
  "connected-macromolecular-carrier__repeated-low-mass-unit-identity__covalent-sequence-connections__ordered-chain-incidence__positive-finite-repeat-count"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete carrier preservation, exact equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite connected molecular incidence path containing repeated complete low-mass unit traces, covalent connections and explicit terminal boundaries."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Repeat.rejected,Repeat.admitted]).flatMap fun repeatUnit =>
  ([Connection.rejected,Connection.admitted]).flatMap fun connection =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Extent.rejected,Extent.admitted]).flatMap fun extent =>
  ([Ends.rejected,Ends.admitted]).flatMap fun ends =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨carrier,repeatUnit,connection,order,extent,ends,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier repeatUnit connection order extent ends record extra =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrepeat : repeatUnit ∈ [Repeat.rejected,Repeat.admitted] := by
      cases repeatUnit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconnection : connection ∈ [Connection.rejected,Connection.admitted] := by
      cases connection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextent : extent ∈ [Extent.rejected,Extent.admitted] := by
      cases extent <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hends : ends ∈ [Ends.rejected,Ends.admitted] := by
      cases ends <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ repeatUnit _ hrepeat
    apply CommonRefinement.memFlatMap _ _ connection _ hconnection
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ extent _ hextent
    apply CommonRefinement.memFlatMap _ _ ends _ hends
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier repeatUnit connection order extent ends record extra =>
    cases carrier <;> cases repeatUnit <;> cases connection <;> cases order <;> cases extent <;> cases ends <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier repeatUnit connection order extent ends record extra =>
    cases carrier <;> cases repeatUnit <;> cases connection <;> cases order <;> cases extent <;> cases ends <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.repeatUnit = .admitted ∧ c.connection = .admitted ∧ c.order = .admitted ∧ c.extent = .admitted ∧ c.ends = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier repeatUnit connection order extent ends record extra =>
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

theorem repeat_rejected_rejected (c : Candidate) (h : c.repeatUnit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.repeatUnit eq
    rw [h] at field
    cases field

theorem connection_rejected_rejected (c : Candidate) (h : c.connection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.connection eq
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

theorem extent_rejected_rejected (c : Candidate) (h : c.extent = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extent eq
    rw [h] at field
    cases field

theorem ends_rejected_rejected (c : Candidate) (h : c.ends = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ends eq
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

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Chemistry.PolymerChainGrammar
