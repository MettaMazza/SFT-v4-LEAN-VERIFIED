import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.InterfaceTransferGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Interface where
  | rejected | admitted

def interfaceName : Interface → String
  | .rejected => "one-phase-only"
  | .admitted => "two-phase-boundary"

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "anonymous-flux"
  | .admitted => "chemical-species-retained"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "unsigned-transfer-number"
  | .admitted => "held-donor-to-receiver-orientation"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "carrier-created-at-boundary"
  | .admitted => "mass-balance-preserved"

inductive Process where
  | rejected | admitted

def processName : Process → String
  | .rejected => "instantaneous-relabel"
  | .admitted => "boundary-crossing-transition"

inductive Rate where
  | rejected | admitted

def rateName : Rate → String
  | .rejected => "universal-transfer-value"
  | .admitted => "transfer-rate-condition-bounded"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "flux-answer-only"
  | .admitted => "complete-donor-interface-receiver-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-transfer-coefficient"
  | .admitted => "no-extra-rule"

structure Candidate where
  interface : Interface
  carrier : Carrier
  orientation : Orientation
  balance : Balance
  process : Process
  rate : Rate
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [interfaceName c.interface, carrierName c.carrier, orientationName c.orientation, balanceName c.balance, processName c.process, rateName c.rate, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "interface=" (interfaceName c.interface), SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "process=" (processName c.process), SFT.Host.Text.append "rate=" (rateName c.rate), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "two-phase-boundary__chemical-species-retained__held-donor-to-receiver-orientation__mass-balance-preserved__boundary-crossing-transition__transfer-rate-condition-bounded__complete-donor-interface-receiver-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (interfaceName c.interface) "two-phase-boundary" &&
  SFT.Host.Text.equal (carrierName c.carrier) "chemical-species-retained" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-donor-to-receiver-orientation" &&
  SFT.Host.Text.equal (balanceName c.balance) "mass-balance-preserved" &&
  SFT.Host.Text.equal (processName c.process) "boundary-crossing-transition" &&
  SFT.Host.Text.equal (rateName c.rate) "transfer-rate-condition-bounded" &&
  SFT.Host.Text.equal (recordName c.record) "complete-donor-interface-receiver-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (interfaceName c.interface) "two-phase-boundary") then "No crossing boundary exists." else
  if !(SFT.Host.Text.equal (carrierName c.carrier) "chemical-species-retained") then "Chemical identity is lost." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-donor-to-receiver-orientation") then "Direction is ambiguous." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "mass-balance-preserved") then "Conservation fails." else
  if !(SFT.Host.Text.equal (processName c.process) "boundary-crossing-transition") then "No transfer event is represented." else
  if !(SFT.Host.Text.equal (rateName c.rate) "transfer-rate-condition-bounded") then "Rate depends on context." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-donor-interface-receiver-trace") then "The crossing cannot be replayed." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fitted coefficient can select any value." else
  "two-phase-boundary__chemical-species-retained__held-donor-to-receiver-orientation__mass-balance-preserved__boundary-crossing-transition"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by carrier preservation, complete support, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite two-phase boundary with named donor, receiver and chemical carrier, paired crossing events, complete balance and source-bound rate conditions."

def candidates : List Candidate :=
  ([Interface.rejected,Interface.admitted]).flatMap fun interface =>
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Process.rejected,Process.admitted]).flatMap fun process =>
  ([Rate.rejected,Rate.admitted]).flatMap fun rate =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨interface,carrier,orientation,balance,process,rate,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk interface carrier orientation balance process rate record extra =>
    have hinterface : interface ∈ [Interface.rejected,Interface.admitted] := by
      cases interface <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprocess : process ∈ [Process.rejected,Process.admitted] := by
      cases process <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrate : rate ∈ [Rate.rejected,Rate.admitted] := by
      cases rate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ interface _ hinterface
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ process _ hprocess
    apply CommonRefinement.memFlatMap _ _ rate _ hrate
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk interface carrier orientation balance process rate record extra =>
    cases interface <;> cases carrier <;> cases orientation <;> cases balance <;> cases process <;> cases rate <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk interface carrier orientation balance process rate record extra =>
    cases interface <;> cases carrier <;> cases orientation <;> cases balance <;> cases process <;> cases rate <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.interface = .admitted ∧ c.carrier = .admitted ∧ c.orientation = .admitted ∧ c.balance = .admitted ∧ c.process = .admitted ∧ c.rate = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk interface carrier orientation balance process rate record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem interface_rejected_rejected (c : Candidate) (h : c.interface = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.interface eq
    rw [h] at field
    cases field

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

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
    rw [h] at field
    cases field

theorem process_rejected_rejected (c : Candidate) (h : c.process = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.process eq
    rw [h] at field
    cases field

theorem rate_rejected_rejected (c : Candidate) (h : c.rate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rate eq
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

end SFT.Chemistry.InterfaceTransferGrammar
