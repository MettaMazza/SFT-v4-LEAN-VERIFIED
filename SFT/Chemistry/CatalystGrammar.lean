import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CatalystGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Role where
  | rejected | admitted

def roleName : Role → String
  | .rejected => "ordinary-reactant-only"
  | .admitted => "reaction-cycle-participant"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "carrier-identity-changed"
  | .admitted => "exact-catalyst-identity-returned"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "overall-reaction-only"
  | .admitted => "alternative-step-path-retained"

inductive Rate where
  | rejected | admitted

def rateName : Rate → String
  | .rejected => "rate-unchanged-by-cycle"
  | .admitted => "reaction-rate-increased"

inductive Net where
  | rejected | admitted

def netName : Net → String
  | .rejected => "catalyst-in-net-products"
  | .admitted => "net-reaction-unchanged"

inductive Direction where
  | rejected | admitted

def directionName : Direction → String
  | .rejected => "one-direction-rule"
  | .admitted => "both-directions-share-path"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "catalyst-name-only"
  | .admitted => "complete-cycle-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-catalytic-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  role : Role
  identity : Identity
  path : Path
  rate : Rate
  net : Net
  direction : Direction
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [roleName c.role, identityName c.identity, pathName c.path, rateName c.rate, netName c.net, directionName c.direction, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "role=" (roleName c.role), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "rate=" (rateName c.rate), SFT.Host.Text.append "net=" (netName c.net), SFT.Host.Text.append "direction=" (directionName c.direction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "reaction-cycle-participant__exact-catalyst-identity-returned__alternative-step-path-retained__reaction-rate-increased__net-reaction-unchanged__both-directions-share-path__complete-cycle-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (roleName c.role) "reaction-cycle-participant" &&
  SFT.Host.Text.equal (identityName c.identity) "exact-catalyst-identity-returned" &&
  SFT.Host.Text.equal (pathName c.path) "alternative-step-path-retained" &&
  SFT.Host.Text.equal (rateName c.rate) "reaction-rate-increased" &&
  SFT.Host.Text.equal (netName c.net) "net-reaction-unchanged" &&
  SFT.Host.Text.equal (directionName c.direction) "both-directions-share-path" &&
  SFT.Host.Text.equal (recordName c.record) "complete-cycle-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (roleName c.role) "reaction-cycle-participant") then "The carrier is consumed." else
  if !(SFT.Host.Text.equal (identityName c.identity) "exact-catalyst-identity-returned") then "It is not recovered." else
  if !(SFT.Host.Text.equal (pathName c.path) "alternative-step-path-retained") then "No catalytic path is distinguished." else
  if !(SFT.Host.Text.equal (rateName c.rate) "reaction-rate-increased") then "No catalytic action occurs." else
  if !(SFT.Host.Text.equal (netName c.net) "net-reaction-unchanged") then "The carrier was consumed or produced." else
  if !(SFT.Host.Text.equal (directionName c.direction) "both-directions-share-path") then "A reversible cycle is incomplete." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-cycle-trace") then "Identity return cannot be checked." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fit can select the result." else
  "reaction-cycle-participant__exact-catalyst-identity-returned__alternative-step-path-retained__reaction-rate-increased__net-reaction-unchanged"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by carrier preservation, complete support, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite source-bound reaction cycle whose catalyst entry, step occurrences, return identity, net endpoints and recurrence interval are completely recorded."

def candidates : List Candidate :=
  ([Role.rejected,Role.admitted]).flatMap fun role =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Rate.rejected,Rate.admitted]).flatMap fun rate =>
  ([Net.rejected,Net.admitted]).flatMap fun net =>
  ([Direction.rejected,Direction.admitted]).flatMap fun direction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨role,identity,path,rate,net,direction,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk role identity path rate net direction record extra =>
    have hrole : role ∈ [Role.rejected,Role.admitted] := by
      cases role <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrate : rate ∈ [Rate.rejected,Rate.admitted] := by
      cases rate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnet : net ∈ [Net.rejected,Net.admitted] := by
      cases net <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdirection : direction ∈ [Direction.rejected,Direction.admitted] := by
      cases direction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ role _ hrole
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ rate _ hrate
    apply CommonRefinement.memFlatMap _ _ net _ hnet
    apply CommonRefinement.memFlatMap _ _ direction _ hdirection
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk role identity path rate net direction record extra =>
    cases role <;> cases identity <;> cases path <;> cases rate <;> cases net <;> cases direction <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk role identity path rate net direction record extra =>
    cases role <;> cases identity <;> cases path <;> cases rate <;> cases net <;> cases direction <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.role = .admitted ∧ c.identity = .admitted ∧ c.path = .admitted ∧ c.rate = .admitted ∧ c.net = .admitted ∧ c.direction = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk role identity path rate net direction record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem role_rejected_rejected (c : Candidate) (h : c.role = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.role eq
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

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
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

theorem net_rejected_rejected (c : Candidate) (h : c.net = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.net eq
    rw [h] at field
    cases field

theorem direction_rejected_rejected (c : Candidate) (h : c.direction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.direction eq
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

end SFT.Chemistry.CatalystGrammar
